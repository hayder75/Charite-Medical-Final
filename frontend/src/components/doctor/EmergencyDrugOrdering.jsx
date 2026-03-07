import React, { useState, useEffect } from 'react';
import { AlertTriangle, Pill, CheckCircle, Clock, Plus, Printer, Trash2 } from 'lucide-react';
import api from '../../services/api';
import toast from 'react-hot-toast';
import { formatMedicationName, formatEmergencyInstruction } from '../../utils/medicalStandards';

const EmergencyDrugOrdering = ({ visit, onOrdersPlaced }) => {
  const [services, setServices] = useState([]);
  const [selectedServices, setSelectedServices] = useState([]);
  const [quantities, setQuantities] = useState({});
  const [instructions, setInstructions] = useState('');
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [fetchingData, setFetchingData] = useState(true);
  const [existingOrders, setExistingOrders] = useState([]);
  const [medDetails, setMedDetails] = useState({});
  const [printing, setPrinting] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [editingOrder, setEditingOrder] = useState(null);
  const [deleteLoading, setDeleteLoading] = useState(null);

  useEffect(() => {
    fetchServices();
    fetchExistingOrders();
  }, [visit?.id]);

  const fetchServices = async () => {
    try {
      setFetchingData(true);
      const response = await api.get('/doctors/services?category=EMERGENCY_DRUG');
      const emergencyDrugs = (response.data.services || []).filter(
        service => service.category === 'EMERGENCY_DRUG' && service.isActive
      );
      setServices(emergencyDrugs);
    } catch (error) {
      console.error('Error fetching emergency drugs:', error);
      toast.error('Failed to fetch emergency drugs');
    } finally {
      setFetchingData(false);
    }
  };

  const fetchExistingOrders = async () => {
    if (!visit?.id) return;
    try {
      const response = await api.get(`/emergency/drugs?visitId=${visit.id}`);
      setExistingOrders(response.data.orders || []);
    } catch (error) {
      console.error('Error fetching existing orders:', error);
    }
  };

  const toggleService = (service) => {
    setSelectedServices(prev => {
      const exists = prev.find(s => s.id === service.id);
      if (exists) {
        const newQuantities = { ...quantities };
        const newDetails = { ...medDetails };
        delete newQuantities[service.id];
        delete newDetails[service.id];
        setQuantities(newQuantities);
        setMedDetails(newDetails);
        return prev.filter(s => s.id !== service.id);
      } else {
        setQuantities({ ...quantities, [service.id]: 1 });
        setMedDetails({
          ...medDetails,
          [service.id]: {
            dosageForm: 'Injection',
            strength: '',
            frequency: '',
            frequencyPeriod: '',
            duration: '',
            durationPeriod: 'days',
            route: '',
            instructions: ''
          }
        });
        return [...prev, service];
      }
    });
  };

  const updateQuantity = (serviceId, quantity) => {
    setQuantities({ ...quantities, [serviceId]: Math.max(1, parseInt(quantity) || 1) });
  };

  const updateMedDetail = (serviceId, field, value) => {
    setMedDetails({
      ...medDetails,
      [serviceId]: {
        ...medDetails[serviceId],
        [field]: value
      }
    });
  };

  const calculateTotal = () => {
    return selectedServices.reduce((sum, service) => {
      const qty = quantities[service.id] || 1;
      return sum + (service.price * qty);
    }, 0);
  };

  const handleDeleteOrder = async (orderId) => {
    if (!window.confirm('Are you sure you want to delete this emergency drug order?')) return;
    try {
      setDeleteLoading(orderId);
      await api.delete(`/emergency/drug-order/${orderId}`);
      toast.success('Emergency drug order deleted');
      await fetchExistingOrders();
      if (onOrdersPlaced) onOrdersPlaced();
    } catch (error) {
      console.error('Error deleting emergency drug order:', error);
      toast.error(error.response?.data?.error || 'Failed to delete order');
    } finally {
      setDeleteLoading(null);
    }
  };

  const handleUpdateOrder = async (e) => {
    e.preventDefault();
    try {
      await api.patch(`/emergency/drug-order/${editingOrder.id}`, editingOrder);
      toast.success('Emergency drug order updated');
      setEditingOrder(null);
      await fetchExistingOrders();
      if (onOrdersPlaced) onOrdersPlaced();
    } catch (error) {
      console.error('Error updating emergency drug order:', error);
      toast.error(error.response?.data?.error || 'Failed to update order');
    }
  };

  const handleSubmitOrder = async () => {
    if (selectedServices.length === 0) {
      toast.error('Please select at least one emergency drug');
      return;
    }
    setLoading(true);
    try {
      const orders = [];
      for (const service of selectedServices) {
        const qty = quantities[service.id] || 1;
        const details = medDetails[service.id] || {};
        const orderData = {
          visitId: visit?.id || null,
          patientId: visit?.patient?.id,
          serviceId: service.id,
          quantity: qty,
          instructions: details.instructions || instructions,
          notes,
          dosageForm: details.dosageForm,
          strength: details.strength,
          frequency: details.frequency,
          frequencyPeriod: details.frequencyPeriod,
          duration: details.duration,
          durationPeriod: details.durationPeriod,
          route: details.route
        };
        const response = await api.post('/emergency/drugs', orderData);
        orders.push(response.data);
      }
      toast.success(`${orders.length} emergency drug order(s) created successfully!`);
      setSelectedServices([]);
      setQuantities({});
      setMedDetails({});
      setInstructions('');
      setNotes('');
      await fetchExistingOrders();
      if (onOrdersPlaced) onOrdersPlaced();
    } catch (error) {
      console.error('Error creating emergency drug orders:', error);
      toast.error(error.response?.data?.error || 'Failed to create emergency drug orders');
    } finally {
      setLoading(false);
    }
  };

  const calculateAge = (dob) => {
    if (!dob) return 'N/A';
    const birthDate = new Date(dob);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  const printPrescription = async () => {
    const ordersToPrint = existingOrders.length > 0 ? existingOrders : selectedServices.map(s => ({
      ...medDetails[s.id],
      service: s,
      quantity: quantities[s.id],
      doctor: visit?.doctor
    }));

    if (ordersToPrint.length === 0) {
      toast.error('No emergency drugs to print.');
      return;
    }

    try {
      setPrinting(true);
      const patientName = visit?.patient?.name || 'N/A';
      const patientAge = visit?.patient?.dob ? calculateAge(visit.patient.dob) : 'N/A';
      const patientGender = visit?.patient?.gender || 'N/A';
      const patientCardNumber = visit?.patient?.id || 'N/A';
      const firstOrder = ordersToPrint[0];
      const doctorName = firstOrder?.doctor?.fullname || 'Dr. Unknown';
      const doctorQualification = firstOrder?.doctor?.qualifications?.join(', ') || 'Medical Doctor';
      const currentDate = new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
      const currentTime = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });

      const printWindow = window.open('', '_blank');
      if (!printWindow) {
        toast.error('Popup blocked!');
        return;
      }

      const visitUid = visit?.visitUid || visit?.id?.toString().substring(0, 8) || 'EMR';

      const prescriptionContent = `
      <!DOCTYPE html>
      <html>
        <head>
          <title>Prescription - ${patientName}</title>
          <style>
            @media print {
              @page { size: A6; margin: 0 !important; }
              html, body { 
                margin: 0 !important; 
                padding: 0 !important; 
                background: white !important;
                visibility: visible !important;
                display: flex !important;
                flex-direction: column !important;
                align-items: center !important;
                overflow: visible !important;
              }
              * { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; color: black !important; }
              .no-print { display: none !important; }
              .prescription-container { 
                width: 105mm !important; 
                min-height: 148mm !important; 
                margin: 0 auto !important; 
                padding: 8mm !important; 
                border: none !important; 
                box-shadow: none !important; 
                background: white !important;
                display: block !important;
                position: relative !important;
                overflow: hidden !important;
                box-sizing: border-box !important;
                visibility: visible !important;
              }
            }
            body { 
              font-family: 'Segoe UI', Tahoma, sans-serif; 
              margin: 0; 
              padding: 20px; 
              color: #333; 
              line-height: 1.3; 
              background: #f3f4f6; 
              display: flex;
              flex-direction: column;
              align-items: center;
              min-height: 100vh;
            }
            .no-print { padding: 10px; background: #fff; margin-bottom: 20px; border-radius: 8px; width: 100%; max-width: 300px; text-align: center; }
            .no-print button { background: #2563eb; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-weight: 600; }
            .prescription-container { width: 105mm; min-height: 148mm; background: white; padding: 8mm; box-shadow: 0 10px 25px rgba(0,0,0,0.1); position: relative; box-sizing: border-box; display: block; margin: 0 auto; }
            .header { display: flex; align-items: center; justify-content: space-between; padding-bottom: 8px; margin-bottom: 12px; border-bottom: 2px solid #2563eb; }
            .header-left { display: flex; align-items: center; gap: 8px; }
            .logo { width: 40px; height: 40px; object-fit: contain; }
            .clinic-name { font-size: 13px; font-weight: 700; margin: 0; color: #1e40af; text-transform: uppercase; }
            .clinic-tagline { font-size: 9px; color: #64748b; margin: 0; font-style: italic; }
            .report-title { font-size: 14px; font-weight: 700; color: #0f172a; text-transform: uppercase; }
            .report-info { font-size: 9px; color: #64748b; margin-top: 1px; text-align: right; }
            .patient-section { margin-bottom: 12px; padding: 8px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 4px; display: grid; grid-template-columns: 1fr 1fr; gap: 4px; font-size: 11px; }
            .info-label { font-weight: 700; color: #64748b; }
            .medications-section h3 { font-size: 11px; font-weight: 700; color: #64748b; text-transform: uppercase; margin-bottom: 6px; border-bottom: 1px solid #e2e8f0; padding-bottom: 2px; }
            .medication-item { margin-bottom: 8px; padding-bottom: 6px; border-bottom: 1px dashed #e2e8f0; width: 100%; }
            .medication-name { font-weight: 700; font-size: 12px; color: #0f172a; margin-bottom: 2px; }
            .medication-details { font-size: 11px; color: #334155; font-weight: 500; }
            .checkmark { color: #2563eb; font-weight: bold; margin-right: 4px; }
            .footer { margin-top: auto; padding-top: 10px; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: flex-end; font-size: 10px; }
            .doctor-name { font-weight: 700; color: #1e293b; font-size: 11px; }
            .signature-box { width: 100px; border-top: 1px solid #334155; padding-top: 4px; text-align: center; font-size: 8px; color: #64748b; }
          </style>
        </head>
        <body>
          <div class="no-print"><button onclick="window.print()">Print Prescription</button></div>
          <div class="prescription-container">
            <div class="header">
              <div class="header-left">
                <img src="/clinic-logo.jpg" alt="Clinic Logo" class="logo" onerror="this.style.display='none'">
                <div class="clinic-info">
                  <h1 class="clinic-name">Charite Medium Clinic</h1>
                  <p class="clinic-tagline">Quality Healthcare You Can Trust</p>
                </div>
              </div>
              <div class="header-right">
                <h2 class="report-title">Emergency Orders</h2>
                <div class="report-info">
                  Date: ${currentDate}<br>
                  Time: ${currentTime}
                </div>
              </div>
            </div>
            <div class="patient-section">
              <div><span class="info-label">Patient:</span> ${patientName?.toUpperCase()}</div>
              <div><span class="info-label">Card No:</span> #${patientCardNumber}</div>
              <div><span class="info-label">Age/Sex:</span> ${patientAge}Y / ${patientGender}</div>
              <div style="text-align: right;"><span class="info-label">Visit ID:</span> #${visitUid}</div>
            </div>
            <div class="medications-section">
              <h3>Drug Orders</h3>
              ${ordersToPrint.map((order, idx) => {
        const medName = order.service?.name || order.name || 'Unknown Medicine';
        const cleanedName = formatMedicationName(medName);
        const details = formatEmergencyInstruction(order);

        return `
                   <div class="medication-item">
                    <div class="medication-name"># ${idx + 1}. ${cleanedName}</div>
                    <div class="medication-details" style="padding-left: 25px;">
                      <div>${details.instruction}</div>
                      ${details.special ? `<div style="font-size: 11px; margin-top: 3px; color: #64748b; font-style: italic;">${details.special}</div>` : ''}
                    </div>
                  </div>
                `;
      }).join('')}
            </div>
            <div class="footer">
              <div>
                Prescribed by: <span class="doctor-name">${doctorName}</span><br>
                <div style="font-size: 8px; color: #64748b;">${doctorQualification}</div>
              </div>
              <div class="signature-box">Doctor's Signature & Stamp</div>
            </div>
          </div>
        </body>
      </html>`;
      printWindow.document.write(prescriptionContent);
      printWindow.document.close();
      setTimeout(() => { printWindow.print(); setPrinting(false); }, 800);
    } catch (error) {
      console.error('Print error:', error);
      setPrinting(false);
      toast.error('Failed to print prescription');
    }
  };

  if (fetchingData) {
    return (
      <div className="flex items-center justify-center py-12 bg-white rounded-xl border border-gray-100">
        <div className="text-center">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-red-600 mx-auto mb-3"></div>
          <p className="text-gray-500 text-sm font-medium">Loading emergency medicine list...</p>
        </div>
      </div>
    );
  }

  const filteredServices = services.filter(service =>
    service.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    (service.code && service.code.toLowerCase().includes(searchTerm.toLowerCase()))
  );


  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* Step 1: Selection Area - List all admin-defined emergency meds */}
      <div className="bg-white p-4 border rounded-xl" style={{ borderColor: '#E5E7EB' }}>
        <div className="mb-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <h4 className="font-semibold text-lg text-gray-900">Available Emergency Medications</h4>
            <p className="text-sm text-gray-500">Select medications from the system list below</p>
          </div>
          <div className="relative flex-1 max-w-md">
            <input
              type="text"
              placeholder="Search emergency drugs..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-3 text-base border border-gray-300 rounded-lg outline-none focus:ring-2 focus:ring-red-500 transition-all"
            />
            <svg className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </div>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-3">
          {filteredServices.length === 0 ? (
            <div className="col-span-full py-10 text-center bg-gray-50 rounded-xl border border-dashed border-gray-200">
              <Pill className="h-8 w-8 text-gray-300 mx-auto mb-2" />
              <p className="text-gray-500 text-sm">No matching medications found.</p>
            </div>
          ) : (
            filteredServices.map((service) => {
              const isSelected = selectedServices.some(s => s.id === service.id);
              return (
                <div
                  key={service.id}
                  onClick={() => toggleService(service)}
                  className={`p-3 rounded-lg border cursor-pointer transition-all duration-200 flex flex-col justify-between group active:scale-95 ${isSelected
                    ? 'border-blue-600 bg-blue-50 ring-1 ring-blue-100'
                    : 'border-gray-200 bg-white hover:border-blue-300 hover:bg-gray-50'
                    }`}
                >
                  <div className="mb-2">
                    <div className={`text-[10px] uppercase mb-0.5 tracking-wider ${isSelected ? 'text-blue-600' : 'text-gray-400'}`}>
                      {service.code || 'Med'}
                    </div>
                    <h5 className={`font-medium text-sm leading-tight transition-colors ${isSelected ? 'text-blue-800' : 'text-gray-700'}`}>
                      {service.name}
                    </h5>
                  </div>

                  <div className="flex justify-between items-center pt-2 border-t border-gray-100 mt-auto">
                    <span className={`text-xs font-medium ${isSelected ? 'text-blue-600' : 'text-gray-500'}`}>
                      {service.price?.toFixed(2)} ETB
                    </span>
                    {isSelected ? (
                      <CheckCircle className="h-4 w-4 text-blue-600" />
                    ) : (
                      <Plus className="h-4 w-4 text-gray-300 group-hover:text-blue-500" />
                    )}
                  </div>
                </div>
              );
            })
          )}
        </div>
      </div>

      {/* Step 2: Prescription Section - Detail inputs for selected items */}
      {selectedServices.length > 0 && (
        <div className="space-y-4">
          <h4 className="font-semibold" style={{ color: '#0C0E0B' }}>Emergency Prescription ({selectedServices.length} items)</h4>
          <div className="space-y-4">
            {selectedServices.map((service, index) => (
              <div key={service.id} className="bg-white border border-gray-200 rounded-lg p-4 shadow-sm">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h5 className="font-medium text-gray-900">{index + 1}. {service.name}</h5>
                    <p className="text-sm text-gray-500">{service.code || 'System Emergency Med'}</p>
                    {/* Price calculation display */}
                    <div className="mt-1 flex items-center gap-2">
                      <span className="text-xs text-gray-500">
                        {service.price?.toFixed(2)} ETB × {quantities[service.id] || 1}
                      </span>
                      <span className="text-xs text-gray-400">=</span>
                      <span className="text-xs font-semibold text-blue-600">
                        {(service.price * (quantities[service.id] || 1)).toFixed(2)} ETB
                      </span>
                    </div>
                  </div>
                  <button
                    onClick={() => toggleService(service)}
                    className="text-red-500 hover:text-red-700 p-1 rounded-full hover:bg-red-50 transition-colors"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Strength</label>
                    <input
                      type="text"
                      value={medDetails[service.id]?.strength || ''}
                      onChange={(e) => updateMedDetail(service.id, 'strength', e.target.value)}
                      placeholder="e.g. 500mg"
                      className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Dosage Form</label>
                    <select
                      value={medDetails[service.id]?.dosageForm || 'Injection'}
                      onChange={(e) => updateMedDetail(service.id, 'dosageForm', e.target.value)}
                      className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                    >
                      <option value="Injection">Injection</option>
                      <option value="Infusion">Infusion</option>
                      <option value="Syrup">Syrup</option>
                      <option value="Tablet">Tablet</option>
                      <option value="Capsule">Capsule</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Frequency *</label>
                    <div className="flex gap-2">
                      <div className="flex-1">
                        <label className="block text-[10px] text-gray-500 mb-0.5 uppercase">Amount</label>
                        <input
                          type="text"
                          value={medDetails[service.id]?.frequency || ''}
                          onChange={(e) => updateMedDetail(service.id, 'frequency', e.target.value)}
                          placeholder="2"
                          className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                        />
                      </div>
                      <div className="w-1/2">
                        <label className="block text-[10px] text-gray-500 mb-0.5 uppercase">Period</label>
                        <select
                          value={medDetails[service.id]?.frequencyPeriod || ''}
                          onChange={(e) => updateMedDetail(service.id, 'frequencyPeriod', e.target.value)}
                          className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                        >
                          <option value="">-</option>
                          <option value="OD">OD</option>
                          <option value="BD">BD</option>
                          <option value="TID">TID</option>
                          <option value="QID">QID</option>
                          <option value="Stat">Stat</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Duration</label>
                    <div className="flex gap-2">
                      <input
                        type="text"
                        value={medDetails[service.id]?.duration || ''}
                        onChange={(e) => updateMedDetail(service.id, 'duration', e.target.value)}
                        placeholder="7"
                        className="flex-1 px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                      />
                      <select
                        value={medDetails[service.id]?.durationPeriod || 'days'}
                        onChange={(e) => updateMedDetail(service.id, 'durationPeriod', e.target.value)}
                        className="w-20 px-2 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                      >
                        <option value="days">Days</option>
                        <option value="weeks">Weeks</option>
                      </select>
                    </div>
                  </div>
                </div>

                <div className="mt-4 grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
                    <input
                      type="number"
                      min="1"
                      value={quantities[service.id] || 1}
                      onChange={(e) => updateQuantity(service.id, e.target.value)}
                      className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 text-center font-medium"
                      placeholder="1"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Route</label>
                    <select
                      value={medDetails[service.id]?.route || ''}
                      onChange={(e) => updateMedDetail(service.id, 'route', e.target.value)}
                      className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                    >
                      <option value="">Select Route</option>
                      <option value="IV">IV (Intravenous)</option>
                      <option value="IM">IM (Intramuscular)</option>
                      <option value="SC">SC (Subcutaneous)</option>
                      <option value="PO">PO (Oral)</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Special Instructions</label>
                    <input
                      type="text"
                      value={medDetails[service.id]?.instructions || ''}
                      onChange={(e) => updateMedDetail(service.id, 'instructions', e.target.value)}
                      placeholder="e.g. STAT then BD"
                      className="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>

          <div className="mt-6 flex flex-col md:flex-row justify-between items-center bg-white p-4 border rounded-xl shadow-sm gap-4">
            <div className="text-lg font-bold text-gray-900">
              Total Order Value: <span className="text-blue-600">{calculateTotal().toFixed(2)} ETB</span>
            </div>
            <button
              onClick={handleSubmitOrder}
              disabled={loading}
              className="w-full md:w-auto bg-blue-600 hover:bg-blue-700 text-white font-medium py-2.5 px-8 rounded-lg shadow-md flex items-center justify-center gap-2 transition-all active:scale-95 disabled:opacity-50"
            >
              {loading ? (
                <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent" />
              ) : (
                <>
                  <Pill className="h-4 w-4" />
                  SUBMIT EMERGENCY PRESCRIPTION
                </>
              )}
            </button>
          </div>
        </div>
      )}

      {/* Existing Orders History */}
      {existingOrders.length > 0 && (
        <div className="bg-white border border-gray-200 rounded-xl p-4">
          <div className="flex justify-between items-center mb-4">
            <h4 className="font-semibold text-gray-900 flex items-center gap-2">
              <Clock className="h-4 w-4 text-blue-500" />
              Prescribed Emergency Meds (Visit)
            </h4>
            <button
              onClick={printPrescription}
              className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-700 text-white font-medium rounded-lg text-sm transition-all shadow-md"
            >
              <Printer className="h-4 w-4" />
              Print Prescription
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {existingOrders.map((order) => (
              <div key={order.id} className="p-4 bg-gray-50 border border-gray-200 rounded-lg flex justify-between items-center">
                <div className="flex flex-col">
                  <span className="font-medium text-sm text-gray-900">{order.service?.name}</span>
                  <span className="text-xs text-gray-500 mt-1">
                    {order.dosageForm} {order.strength} • {order.frequency} {order.frequencyPeriod}
                  </span>
                  <span className="text-[10px] text-gray-400 mt-1 uppercase font-semibold">Qty: {order.quantity}</span>
                </div>
                <div className="flex items-center gap-3">
                  <div className="flex flex-col items-end">
                    <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold uppercase ${order.status === 'PAID' ? 'bg-green-100 text-green-700' :
                      order.status === 'COMPLETED' ? 'bg-blue-100 text-blue-700' :
                        'bg-yellow-100 text-yellow-700'
                      }`}>
                      {order.status}
                    </span>
                  </div>
                  {order.status === 'UNPAID' && (
                    <div className="flex gap-1">
                      <button
                        onClick={() => setEditingOrder(order)}
                        className="p-1.5 text-blue-600 hover:bg-blue-100 rounded-md transition-colors"
                        title="Edit Order"
                      >
                        <svg className="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M11 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-5M16.5 3.5a2.121 2.121 0 113 3L7 19l-4 1 1-4L16.5 3.5z" />
                        </svg>
                      </button>
                      <button
                        onClick={() => handleDeleteOrder(order.id)}
                        disabled={deleteLoading === order.id}
                        className="p-1.5 text-red-600 hover:bg-red-100 rounded-md transition-colors disabled:opacity-50"
                        title="Delete Order"
                      >
                        {deleteLoading === order.id ? (
                          <div className="h-4 w-4 animate-spin rounded-full border-2 border-red-500 border-t-transparent" />
                        ) : (
                          <Trash2 className="h-4 w-4" />
                        )}
                      </button>
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Edit Emergency Drug Modal */}
      {editingOrder && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 p-4">
          <div className="bg-white rounded-xl shadow-xl w-full max-w-2xl overflow-hidden">
            <div className="px-6 py-4 border-b flex justify-between items-center">
              <h3 className="text-lg font-bold">Edit Emergency Medicine Order</h3>
              <button onClick={() => setEditingOrder(null)} className="text-gray-400 hover:text-gray-600">
                <Plus className="h-6 w-6 transform rotate-45" />
              </button>
            </div>
            <form onSubmit={handleUpdateOrder} className="p-6">
              <div className="bg-blue-50 border border-blue-100 rounded-lg p-3 mb-4">
                <p className="text-sm font-medium text-blue-800">{editingOrder.service?.name}</p>
                <p className="text-xs text-blue-600">Original service price: {editingOrder.service?.price?.toFixed(2)} ETB</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
                  <input
                    type="number"
                    min="1"
                    value={editingOrder.quantity}
                    onChange={(e) => setEditingOrder({ ...editingOrder, quantity: parseInt(e.target.value) || 1 })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Strength</label>
                  <input
                    type="text"
                    value={editingOrder.strength || ''}
                    onChange={(e) => setEditingOrder({ ...editingOrder, strength: e.target.value })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Dosage Form</label>
                  <select
                    value={editingOrder.dosageForm || 'Injection'}
                    onChange={(e) => setEditingOrder({ ...editingOrder, dosageForm: e.target.value })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="Injection">Injection</option>
                    <option value="Infusion">Infusion</option>
                    <option value="Syrup">Syrup</option>
                    <option value="Tablet">Tablet</option>
                    <option value="Capsule">Capsule</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Frequency Period</label>
                  <select
                    value={editingOrder.frequencyPeriod || ''}
                    onChange={(e) => setEditingOrder({ ...editingOrder, frequencyPeriod: e.target.value })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">-</option>
                    <option value="OD">OD</option>
                    <option value="BD">BD</option>
                    <option value="TID">TID</option>
                    <option value="QID">QID</option>
                    <option value="Stat">Stat</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Route</label>
                  <select
                    value={editingOrder.route || ''}
                    onChange={(e) => setEditingOrder({ ...editingOrder, route: e.target.value })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Select Route</option>
                    <option value="IV">IV</option>
                    <option value="IM">IM</option>
                    <option value="SC">SC</option>
                    <option value="PO">PO</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Instructions</label>
                  <input
                    type="text"
                    value={editingOrder.instructions || ''}
                    onChange={(e) => setEditingOrder({ ...editingOrder, instructions: e.target.value })}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t">
                <button
                  type="button"
                  onClick={() => setEditingOrder(null)}
                  className="px-4 py-2 border rounded-lg text-gray-600 hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium shadow-md"
                >
                  Update Order
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default EmergencyDrugOrdering;
