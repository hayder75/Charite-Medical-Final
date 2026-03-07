import React, { useState, useEffect } from 'react';
import { Plus, Trash2, Printer, Save, Beaker, AlertCircle, Search, Clock, Edit, X } from 'lucide-react';
import toast from 'react-hot-toast';
import api from '../../services/api';

const FORMULATION_TYPES = [
  { value: 'CREAM', label: 'Cream' },
  { value: 'OINTMENT', label: 'Ointment' },
  { value: 'GEL', label: 'Gel' },
  { value: 'LOTION', label: 'Lotion' },
  { value: 'FOAM', label: 'Foam' },
  { value: 'SOLUTION', label: 'Solution' }
];

const BASE_TYPES = [
  { value: 'CREAM_BASE', label: 'Cream Base' },
  { value: 'OINTMENT_BASE', label: 'Ointment Base' },
  { value: 'PETROLATUM', label: 'Petrolatum' },
  { value: 'CUSTOM', label: 'Custom Base' }
];

const STRENGTH_UNITS = [
  { value: '%', label: '%' },
  { value: 'MG/G', label: 'mg/g' },
  { value: 'MG/ML', label: 'mg/ml' }
];

const FREQUENCY_TYPES = [
  { value: 'ONCE_DAILY', label: 'Once Daily' },
  { value: 'TWICE_DAILY', label: 'Twice Daily' },
  { value: 'THREE_TIMES_DAILY', label: 'Three Times Daily' },
  { value: 'FOUR_TIMES_DAILY', label: 'Four Times Daily' },
  { value: 'AS_NEEDED', label: 'As Needed (PRN)' },
  { value: 'NIGHT_ONLY', label: 'Night Only' },
  { value: 'CUSTOM', label: 'Custom' }
];

const DURATION_UNITS = [
  { value: 'DAYS', label: 'Days' },
  { value: 'WEEKS', label: 'Weeks' },
  { value: 'MONTHS', label: 'Months' }
];

const QUANTITY_UNITS = [
  { value: 'G', label: 'g' },
  { value: 'ML', label: 'ml' }
];

const STORAGE_OPTIONS = [
  { value: 'ROOM_TEMP', label: 'Store at Room Temperature (below 25°C)' },
  { value: 'COOL', label: 'Store in Cool Place (2-8°C)' },
  { value: 'REFRIGERATE', label: 'Refrigerate (2-8°C)' },
  { value: 'PROTECT_LIGHT', label: 'Protect from Light' },
  { value: 'DRY_PLACE', label: 'Store in Dry Place' }
];

const CompoundPrescriptionBuilder = ({ visit, onSaved, onClose }) => {
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [existingPrescriptions, setExistingPrescriptions] = useState([]);
  const [showNewForm, setShowNewForm] = useState(false);
  const [medications, setMedications] = useState([]);
  const [medicationSearch, setMedicationSearch] = useState('');
  const [searching, setSearching] = useState(false);

  // Ingredient search state
  const [ingredientSearch, setIngredientSearch] = useState('');
  const [ingredientResults, setIngredientResults] = useState([]);
  const [searchingIngredient, setSearchingIngredient] = useState(false);
  const [activeIngredientIndex, setActiveIngredientIndex] = useState(null);
  const [editingPrescription, setEditingPrescription] = useState(null);

  const [formData, setFormData] = useState({
    formulationType: 'CREAM',
    baseType: '',
    customBase: '',
    quantity: 30,
    quantityUnit: 'G',
    frequencyType: 'TWICE_DAILY',
    frequencyValue: '',
    durationValue: '',
    durationUnit: 'WEEKS',
    instructions: '',
    storageInstructions: '',
    warnings: '',
    pharmacyNotes: '',
    ingredients: [
      { ingredientName: '', strength: '', unit: '%', isManualEntry: true, sortOrder: 0 }
    ]
  });

  useEffect(() => {
    if (visit?.id) {
      fetchExistingPrescriptions();
    }
    searchMedications('');
  }, [visit]);

  const fetchExistingPrescriptions = async () => {
    try {
      setLoading(true);
      const response = await api.get(`/compound-prescriptions/visit/${visit.id}`);
      setExistingPrescriptions(response.data.compoundPrescriptions || []);
    } catch (error) {
      console.error('Error fetching prescriptions:', error);
    } finally {
      setLoading(false);
    }
  };

  const searchMedications = async (query) => {
    try {
      setSearching(true);
      const response = await api.get('/medications/search', {
        params: { search: query, limit: 20 }
      });
      setMedications(response.data.medications || []);
    } catch (error) {
      console.error('Error searching medications:', error);
    } finally {
      setSearching(false);
    }
  };

  const searchIngredients = async (query) => {
    if (!query || query.length < 1) {
      setIngredientResults([]);
      return;
    }
    try {
      setSearchingIngredient(true);
      const response = await api.get('/medications/search', {
        params: { search: query, limit: 10 }
      });
      setIngredientResults(response.data.medications || []);
    } catch (error) {
      console.error('Error searching ingredients:', error);
    } finally {
      setSearchingIngredient(false);
    }
  };

  const handleIngredientSearchChange = (index, value) => {
    setIngredientSearch(value);
    setActiveIngredientIndex(index);
    searchIngredients(value);

    // Update formData immediately so it's not empty if they don't select from drop down
    setFormData(prev => {
      const newIngredients = [...prev.ingredients];
      newIngredients[index] = { ...newIngredients[index], ingredientName: value };
      return { ...prev, ingredients: newIngredients };
    });
  };

  const selectIngredient = (index, medication) => {
    setFormData(prev => {
      const newIngredients = [...prev.ingredients];
      newIngredients[index] = {
        ...newIngredients[index],
        ingredientName: medication.name,
        isManualEntry: false
      };
      return { ...prev, ingredients: newIngredients };
    });
    setIngredientSearch('');
    setIngredientResults([]);
    setActiveIngredientIndex(null);
  };

  const handleIngredientChange = (index, field, value) => {
    setFormData(prev => {
      const newIngredients = [...prev.ingredients];
      newIngredients[index] = { ...newIngredients[index], [field]: value };
      return { ...prev, ingredients: newIngredients };
    });
  };

  const addIngredient = () => {
    setFormData({
      ...formData,
      ingredients: [
        ...formData.ingredients,
        { ingredientName: '', strength: '', unit: '%', isManualEntry: true, sortOrder: formData.ingredients.length }
      ]
    });
  };

  const removeIngredient = (index) => {
    if (formData.ingredients.length === 1) {
      toast.error('At least one ingredient is required');
      return;
    }
    const newIngredients = formData.ingredients.filter((_, i) => i !== index);
    setFormData({ ...formData, ingredients: newIngredients });
  };

  const selectMedication = (index, medication) => {
    const newIngredients = [...formData.ingredients];
    newIngredients[index] = {
      ...newIngredients[index],
      ingredientName: medication.name,
      isManualEntry: false,
      sortOrder: index
    };
    setFormData({ ...formData, ingredients: newIngredients });
    setMedicationSearch('');
  };

  const validateForm = () => {
    if (!formData.formulationType) {
      toast.error('Please select a formulation type');
      return false;
    }
    if (!formData.quantity || formData.quantity <= 0) {
      toast.error('Please enter a valid quantity');
      return false;
    }
    const validIngredients = formData.ingredients.filter(ing => ing.ingredientName.trim() && ing.strength);
    if (validIngredients.length === 0) {
      toast.error('Please add at least one ingredient with name and strength');
      return false;
    }
    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validateForm()) return;

    try {
      setSaving(true);

      const payload = {
        visitId: visit.id,
        patientId: visit.patient.id,
        formulationType: formData.formulationType,
        baseType: formData.baseType || undefined,
        customBase: formData.customBase || undefined,
        quantity: parseInt(formData.quantity),
        quantityUnit: formData.quantityUnit,
        frequencyType: formData.frequencyType || undefined,
        frequencyValue: formData.frequencyValue || undefined,
        durationValue: formData.durationValue ? parseFloat(formData.durationValue) : undefined,
        durationUnit: formData.durationUnit || undefined,
        instructions: formData.instructions || undefined,
        storageInstructions: formData.storageInstructions || undefined,
        warnings: formData.warnings || undefined,
        pharmacyNotes: formData.pharmacyNotes || undefined,
        ingredients: formData.ingredients
          .filter(ing => ing.ingredientName.trim() && ing.strength)
          .map((ing, index) => ({
            ingredientName: ing.ingredientName,
            strength: parseFloat(ing.strength),
            unit: ing.unit,
            isManualEntry: ing.isManualEntry,
            sortOrder: index
          }))
      };

      if (editingPrescription) {
        await api.put(`/compound-prescriptions/${editingPrescription.id}`, payload);
        toast.success('Prescription updated successfully');
      } else {
        await api.post('/compound-prescriptions', payload);
        toast.success('Compound prescription created successfully');
      }

      setShowNewForm(false);
      setEditingPrescription(null);
      setFormData({
        formulationType: 'CREAM',
        baseType: '',
        customBase: '',
        quantity: 30,
        quantityUnit: 'G',
        frequencyType: 'TWICE_DAILY',
        frequencyValue: '',
        durationValue: '',
        durationUnit: 'WEEKS',
        instructions: '',
        storageInstructions: '',
        warnings: '',
        pharmacyNotes: '',
        ingredients: [{ ingredientName: '', strength: '', unit: '%', isManualEntry: true, sortOrder: 0 }]
      });
      fetchExistingPrescriptions();
      if (onSaved) onSaved();
    } catch (error) {
      console.error('Error saving prescription:', error);
      toast.error(error.response?.data?.error || 'Failed to save prescription');
    } finally {
      setSaving(false);
    }
  };

  const formatDirections = (prescription) => {
    const parts = [];
    const freqLabel = FREQUENCY_TYPES.find(f => f.value === prescription.frequencyType)?.label;
    if (freqLabel) parts.push(freqLabel);
    if (prescription.durationValue) {
      const durLabel = DURATION_UNITS.find(d => d.value === prescription.durationUnit)?.label;
      parts.push(`for ${prescription.durationValue} ${durLabel}`);
    }
    return parts.join(' - ');
  };

  const handleEdit = (prescription) => {
    setFormData({
      formulationType: prescription.formulationType,
      baseType: prescription.baseType || '',
      customBase: prescription.customBase || '',
      quantity: prescription.quantity,
      quantityUnit: prescription.quantityUnit,
      frequencyType: prescription.frequencyType || 'TWICE_DAILY',
      frequencyValue: prescription.frequencyValue || '',
      durationValue: prescription.durationValue || '',
      durationUnit: prescription.durationUnit || 'WEEKS',
      instructions: prescription.instructions || '',
      storageInstructions: prescription.storageInstructions || '',
      warnings: prescription.warnings || '',
      pharmacyNotes: prescription.pharmacyNotes || '',
      ingredients: prescription.ingredients.map((ing, idx) => ({
        ingredientName: ing.ingredientName,
        strength: ing.strength.toString(),
        unit: ing.unit,
        isManualEntry: ing.isManualEntry,
        sortOrder: idx
      }))
    });
    setEditingPrescription(prescription);
    setShowNewForm(true);
  };

  const handleDelete = async (prescriptionId) => {
    if (!window.confirm('Are you sure you want to delete this prescription?')) return;
    try {
      await api.delete(`/compound-prescriptions/${prescriptionId}`);
      toast.success('Prescription deleted successfully');
      fetchExistingPrescriptions();
      if (onSaved) onSaved();
    } catch (error) {
      console.error('Error deleting prescription:', error);
      toast.error(error.response?.data?.error || 'Failed to delete prescription');
    }
  };

  const printAllPrescriptions = async () => {
    if (existingPrescriptions.length === 0) return;

    try {
      let patientData = visit?.patient;
      let doctorData = visit?.doctor;

      const patientName = patientData?.name || 'N/A';
      const patientCardNumber = patientData?.id || 'N/A';
      const patientGender = (patientData?.gender?.charAt(0) || 'N/A').toUpperCase();
      const patientAge = patientData?.dob ? Math.floor((new Date() - new Date(patientData.dob)) / (365.25 * 24 * 60 * 60 * 1000)) : 'N/A';
      const doctorName = doctorData?.fullname || 'Dr. Unknown';
      const doctorQualification = doctorData?.qualifications?.join(', ') || 'Dermatology';

      const currentDate = new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
      const currentTime = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });

      const printWindow = window.open('', '_blank');
      if (!printWindow) {
        toast.error('Popup blocked! Please allow popups for this site.');
        return;
      }

      const prescriptionsHtml = existingPrescriptions.map((prescription, idx) => {
        const formulationLabel = FORMULATION_TYPES.find(f => f.value === prescription.formulationType)?.label || prescription.formulationType;
        const baseLabel = prescription.baseType === 'CUSTOM' ? prescription.customBase : BASE_TYPES.find(b => b.value === prescription.baseType)?.label || '';
        const directions = formatDirections(prescription);

        return `
          <div style="margin-bottom: 15px; padding: 10px; border: 1px solid #e2e8f0; border-radius: 4px; page-break-inside: avoid;">
            <div style="font-weight: bold; font-size: 12px; margin-bottom: 5px; color: #1e40af;">
              #${idx + 1}. ${formulationLabel} - ${prescription.quantity}${prescription.quantityUnit} (${prescription.referenceNumber})
            </div>
            <div style="font-size: 11px; margin-bottom: 3px;">
              <strong>Ingredients:</strong> ${prescription.ingredients.map(ing => `${ing.ingredientName} ${ing.strength}${ing.unit}`).join(', ')}
            </div>
            ${baseLabel ? `<div style="font-size: 11px; margin-bottom: 3px;"><strong>Base:</strong> ${baseLabel}</div>` : ''}
            <div style="font-size: 11px;">
              <strong>Sig:</strong> ${directions}${prescription.instructions ? ` - ${prescription.instructions}` : ''}
            </div>
          </div>
        `;
      }).join('');

      const content = `
        <!DOCTYPE html>
        <html>
          <head>
            <title>Compound Prescriptions</title>
            <style>
              @media print {
                @page { size: A5; margin: 10mm; }
                html, body { margin: 0 !important; padding: 0 !important; background: white !important; }
                .no-print { display: none !important; }
              }
              body { font-family: 'Segoe UI', Tahoma, sans-serif; margin: 0; padding: 20px; color: #333; line-height: 1.3; }
              .no-print { padding: 10px; background: #fff; margin-bottom: 20px; text-align: center; }
              .no-print button { background: #2563eb; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-weight: 600; }
              .header { text-align: center; padding-bottom: 10px; margin-bottom: 15px; border-bottom: 2px solid #2563eb; }
              .clinic-name { font-size: 16px; font-weight: 700; color: #1e40af; text-transform: uppercase; }
              .clinic-tagline { font-size: 10px; color: #64748b; font-style: italic; }
              .patient-info { display: grid; grid-template-columns: 1fr 1fr; gap: 5px; font-size: 11px; margin-bottom: 15px; padding: 8px; background: #f8fafc; border-radius: 4px; }
              .patient-info span { color: #64748b; font-weight: 600; }
              .external-warning { background: #fee2e2; border: 1px solid #fecaca; color: #991b1b; padding: 6px; border-radius: 4px; font-size: 11px; font-weight: bold; text-align: center; margin-bottom: 15px; }
              .footer { margin-top: 20px; padding-top: 10px; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; font-size: 10px; }
              .signature-line { text-align: center; }
              .signature-line .line { border-top: 1px solid #333; width: 120px; margin: 30px auto 3px; }
              .signature-line .label { font-size: 9px; color: #666; }
            </style>
          </head>
          <body>
            <div class="no-print"><button onclick="window.print()">Print</button></div>
            <div class="header">
              <div class="clinic-name">Charite Medium Clinic</div>
              <div class="clinic-tagline">Compound Prescriptions</div>
              <div style="font-size: 10px; color: #64748b;">${currentDate} | ${currentTime}</div>
            </div>
            
            <div class="patient-info">
              <div><span>Patient:</span> ${patientName}</div>
              <div><span>Card No:</span> #${patientCardNumber}</div>
              <div><span>Age/Sex:</span> ${patientAge}Y / ${patientGender}</div>
              <div><span>Prescriptions:</span> ${existingPrescriptions.length}</div>
            </div>

            <div class="external-warning">
              ⚠ FOR EXTERNAL USE ONLY
            </div>

            ${prescriptionsHtml}

            <div class="footer">
              <div>
                <div style="font-weight: 600;">${doctorName}</div>
                <div style="font-size: 9px; color: #64748b;">${doctorQualification}</div>
              </div>
              <div class="signature-line">
                <div class="line"></div>
                <div class="label">Doctor's Signature</div>
              </div>
            </div>
          </body>
        </html>`;

      printWindow.document.write(content);
      printWindow.document.close();
      setTimeout(() => {
        printWindow.print();
      }, 500);
    } catch (error) {
      console.error('Print error:', error);
      toast.error('Failed to print prescriptions');
    }
  };

  const printPrescription = async (prescription) => {
    try {
      let patientData = prescription.patient;
      let doctorData = prescription.doctor;

      if (!patientData && visit?.patient) {
        patientData = visit.patient;
        doctorData = visit.doctor;
      }

      const patientName = patientData?.name || 'N/A';
      const patientCardNumber = patientData?.id || 'N/A';
      const patientGender = (patientData?.gender?.charAt(0) || 'N/A').toUpperCase();
      const patientAge = patientData?.dob ? Math.floor((new Date() - new Date(patientData.dob)) / (365.25 * 24 * 60 * 60 * 1000)) : 'N/A';
      const doctorName = doctorData?.fullname || prescription.doctor?.fullname || 'Dr. Unknown';
      const doctorQualification = doctorData?.qualifications?.join(', ') || prescription.doctor?.qualifications?.join(', ') || 'Dermatology';

      const currentDate = new Date(prescription.createdAt).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
      const currentTime = new Date(prescription.createdAt).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });

      const printWindow = window.open('', '_blank');
      if (!printWindow) {
        toast.error('Popup blocked! Please allow popups for this site.');
        return;
      }

      const formulationLabel = FORMULATION_TYPES.find(f => f.value === prescription.formulationType)?.label || prescription.formulationType;
      const baseLabel = prescription.baseType === 'CUSTOM' ? prescription.customBase : BASE_TYPES.find(b => b.value === prescription.baseType)?.label || '';
      const directions = formatDirections(prescription);

      const content = `
        <!DOCTYPE html>
        <html>
          <head>
            <title>Prescription - ${patientName}</title>
            <style>
              @media print {
                @page { size: A6; margin: 0 !important; }
                html, body { margin: 0 !important; padding: 0 !important; background: white !important; visibility: visible !important; display: flex !important; flex-direction: column !important; align-items: center !important; overflow: visible !important; }
                * { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; color: black !important; }
                .no-print { display: none !important; }
                .prescription-container { width: 105mm !important; min-height: 148mm !important; margin: 0 auto !important; padding: 8mm !important; border: none !important; box-shadow: none !important; background: white !important; display: block !important; position: relative !important; overflow: hidden !important; box-sizing: border-box !important; visibility: visible !important; }
              }
              body { font-family: 'Segoe UI', Tahoma, sans-serif; margin: 0; padding: 20px; color: #333; line-height: 1.3; background: #f3f4f6; display: flex; flex-direction: column; align-items: center; min-height: 100vh; }
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
              .footer { margin-top: auto; padding-top: 10px; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: flex-end; font-size: 10px; }
              .doctor-name { font-weight: 700; color: #1e293b; font-size: 11px; }
              .signature-box { width: 100px; border-top: 1px solid #334155; padding-top: 4px; text-align: center; font-size: 8px; color: #64748b; }
              .compound-info { background: #fef3c7; border: 1px solid #fcd34d; border-radius: 4px; padding: 8px; margin-bottom: 10px; font-size: 11px; }
              .compound-info strong { color: #92400e; }
              .external-warning { background: #fee2e2; border: 1px solid #fecaca; color: #991b1b; padding: 6px 10px; border-radius: 4px; font-size: 10px; font-weight: bold; text-align: center; margin-bottom: 10px; }
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
                  <h2 class="report-title">Prescription</h2>
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
                <div style="text-align: right;"><span class="info-label">Rx No:</span> ${prescription.referenceNumber}</div>
              </div>

              <div class="external-warning">
                ⚠ FOR EXTERNAL USE ONLY
              </div>

              <div class="compound-info">
                <strong>Compound Preparation:</strong> ${formulationLabel}${baseLabel ? ` - ${baseLabel}` : ''} | Qty: ${prescription.quantity}${prescription.quantityUnit}
              </div>

              <div class="medications-section">
                <h3>Active Ingredients</h3>
                ${prescription.ingredients.map((ing, idx) => `
                  <div class="medication-item">
                    <div class="medication-name"># ${idx + 1}. ${ing.ingredientName} ${ing.strength}${ing.unit}</div>
                  </div>
                `).join('')}
              </div>

              <div class="medications-section">
                <h3>Directions</h3>
                <div class="medication-item">
                  <div class="medication-details">${directions}</div>
                  ${prescription.instructions ? `<div style="font-size: 11px; margin-top: 3px; color: #64748b; font-style: italic;">${prescription.instructions}</div>` : ''}
                  ${prescription.storageInstructions ? `<div style="font-size: 10px; margin-top: 3px; color: #64748b;">Storage: ${STORAGE_OPTIONS.find(s => s.value === prescription.storageInstructions)?.label || prescription.storageInstructions}</div>` : ''}
                </div>
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

      printWindow.document.write(content);
      printWindow.document.close();
      setTimeout(() => {
        printWindow.print();
      }, 500);
    } catch (error) {
      console.error('Print error:', error);
      toast.error('Failed to print prescription');
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h3 className="text-lg font-semibold" style={{ color: '#0C0E0B' }}>
            Compound Prescriptions
          </h3>
          <p className="text-sm text-gray-600">
            Create compounded topical preparations for dermatology
          </p>
        </div>
        {!showNewForm && (
          <button
            onClick={() => setShowNewForm(true)}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center space-x-2"
          >
            <Plus className="h-4 w-4" />
            <span>New Compound Prescription</span>
          </button>
        )}
      </div>

      {showNewForm && (
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Section A: Formulation Type */}
          <div className="card p-4">
            <h4 className="font-semibold mb-4 flex items-center">
              <Beaker className="h-5 w-5 mr-2 text-blue-600" />
              Formulation Type
            </h4>
            <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
              {FORMULATION_TYPES.map(type => (
                <label
                  key={type.value}
                  className={`p-3 border-2 rounded-lg cursor-pointer text-center transition-all ${formData.formulationType === type.value
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300'
                    }`}
                >
                  <input
                    type="radio"
                    name="formulationType"
                    value={type.value}
                    checked={formData.formulationType === type.value}
                    onChange={(e) => setFormData({ ...formData, formulationType: e.target.value })}
                    className="sr-only"
                  />
                  <span className="text-sm font-medium">{type.label}</span>
                </label>
              ))}
            </div>
          </div>

          {/* Section B: Active Ingredients */}
          <div className="card p-4">
            <div className="flex justify-between items-center mb-4">
              <h4 className="font-semibold flex items-center">
                <Plus className="h-5 w-5 mr-2 text-green-600" />
                Active Ingredients
              </h4>
              <button
                type="button"
                onClick={addIngredient}
                className="text-sm text-blue-600 hover:text-blue-700 flex items-center"
              >
                <Plus className="h-4 w-4 mr-1" />
                Add Ingredient
              </button>
            </div>

            <div className="space-y-3">
              {formData.ingredients.map((ingredient, index) => (
                <div key={index} className="relative flex items-start gap-3 p-3 bg-gray-50 rounded-lg">
                  <div className="flex-1">
                    <label className="text-xs text-gray-600 mb-1 block">Ingredient Name</label>
                    <div className="relative">
                      <input
                        type="text"
                        value={activeIngredientIndex === index ? ingredientSearch : ingredient.ingredientName}
                        onChange={(e) => handleIngredientSearchChange(index, e.target.value)}
                        onFocus={() => {
                          setActiveIngredientIndex(index);
                          setIngredientSearch(ingredient.ingredientName || '');
                          if (ingredient.ingredientName) searchIngredients(ingredient.ingredientName);
                        }}
                        onBlur={() => setTimeout(() => {
                          if (activeIngredientIndex === index) {
                            setActiveIngredientIndex(null);
                            setIngredientResults([]);
                          }
                        }, 200)}
                        placeholder="Search or enter ingredient"
                        className="input w-full"
                      />
                      {searchingIngredient && activeIngredientIndex === index && (
                        <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-blue-600"></div>
                        </div>
                      )}
                      {activeIngredientIndex === index && ingredientResults.length > 0 && (
                        <div className="absolute z-10 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg max-h-48 overflow-y-auto">
                          {ingredientResults.map((med) => (
                            <button
                              key={med.id}
                              type="button"
                              onClick={() => selectIngredient(index, med)}
                              className="w-full text-left px-3 py-2 hover:bg-blue-50 border-b border-gray-100 last:border-b-0"
                            >
                              <div className="font-medium text-sm">{med.name}</div>
                              <div className="text-xs text-gray-500">{med.strength} {med.dosageForm}</div>
                            </button>
                          ))}
                        </div>
                      )}
                    </div>
                    {ingredient.ingredientName && !ingredient.isManualEntry && (
                      <span className="text-xs text-green-600">From catalog</span>
                    )}
                    {ingredient.ingredientName && ingredient.isManualEntry && (
                      <span className="text-xs text-gray-500">Custom entry</span>
                    )}
                  </div>
                  <div className="w-24">
                    <label className="text-xs text-gray-600 mb-1 block">Strength</label>
                    <input
                      type="number"
                      step="0.01"
                      value={ingredient.strength}
                      onChange={(e) => handleIngredientChange(index, 'strength', e.target.value)}
                      placeholder="0"
                      className="input w-full"
                    />
                  </div>
                  <div className="w-20">
                    <label className="text-xs text-gray-600 mb-1 block">Unit</label>
                    <select
                      value={ingredient.unit}
                      onChange={(e) => handleIngredientChange(index, 'unit', e.target.value)}
                      className="input w-full"
                    >
                      {STRENGTH_UNITS.map(unit => (
                        <option key={unit.value} value={unit.value}>{unit.label}</option>
                      ))}
                    </select>
                  </div>
                  <div className="pt-6">
                    <button
                      type="button"
                      onClick={() => removeIngredient(index)}
                      className="p-2 text-red-600 hover:bg-red-50 rounded"
                      disabled={formData.ingredients.length === 1}
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
            {formData.ingredients.length === 0 && (
              <p className="text-red-500 text-sm mt-2">At least one ingredient is required</p>
            )}
          </div>

          {/* Section C: Base / Vehicle */}
          <div className="card p-4">
            <h4 className="font-semibold mb-4">Base / Vehicle</h4>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-3">
              {BASE_TYPES.map(base => (
                <label
                  key={base.value}
                  className={`p-3 border-2 rounded-lg cursor-pointer text-center transition-all ${formData.baseType === base.value
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300'
                    }`}
                >
                  <input
                    type="radio"
                    name="baseType"
                    value={base.value}
                    checked={formData.baseType === base.value}
                    onChange={(e) => setFormData({ ...formData, baseType: e.target.value })}
                    className="sr-only"
                  />
                  <span className="text-sm font-medium">{base.label}</span>
                </label>
              ))}
            </div>
            {formData.baseType === 'CUSTOM' && (
              <input
                type="text"
                value={formData.customBase}
                onChange={(e) => setFormData({ ...formData, customBase: e.target.value })}
                placeholder="Enter custom base description"
                className="input"
              />
            )}
          </div>

          {/* Section D: Total Quantity */}
          <div className="card p-4">
            <h4 className="font-semibold mb-4">Total Quantity</h4>
            <div className="flex items-center gap-3">
              <div className="w-32">
                <input
                  type="number"
                  value={formData.quantity}
                  onChange={(e) => setFormData({ ...formData, quantity: e.target.value })}
                  className="input"
                  min="1"
                />
              </div>
              <select
                value={formData.quantityUnit}
                onChange={(e) => setFormData({ ...formData, quantityUnit: e.target.value })}
                className="input w-24"
              >
                {QUANTITY_UNITS.map(unit => (
                  <option key={unit.value} value={unit.value}>{unit.label}</option>
                ))}
              </select>
            </div>
          </div>

          {/* Section E: Directions */}
          <div className="card p-4">
            <h4 className="font-semibold mb-4">Directions for Use</h4>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label className="label">Frequency</label>
                <select
                  value={formData.frequencyType}
                  onChange={(e) => setFormData({ ...formData, frequencyType: e.target.value })}
                  className="input"
                >
                  {FREQUENCY_TYPES.map(freq => (
                    <option key={freq.value} value={freq.value}>{freq.label}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="label">Duration</label>
                <div className="flex">
                  <input
                    type="number"
                    value={formData.durationValue}
                    onChange={(e) => setFormData({ ...formData, durationValue: e.target.value })}
                    placeholder="4"
                    className="input rounded-r-none"
                    min="1"
                  />
                  <select
                    value={formData.durationUnit}
                    onChange={(e) => setFormData({ ...formData, durationUnit: e.target.value })}
                    className="input rounded-l-none border-l-0"
                  >
                    {DURATION_UNITS.map(unit => (
                      <option key={unit.value} value={unit.value}>{unit.label}</option>
                    ))}
                  </select>
                </div>
              </div>
              <div>
                <label className="label">Storage Instructions</label>
                <select
                  value={formData.storageInstructions}
                  onChange={(e) => setFormData({ ...formData, storageInstructions: e.target.value })}
                  className="input"
                >
                  <option value="">Select...</option>
                  {STORAGE_OPTIONS.map(opt => (
                    <option key={opt.value} value={opt.value}>{opt.label}</option>
                  ))}
                </select>
              </div>
            </div>
            <div className="mt-4">
              <label className="label">Additional Instructions</label>
              <textarea
                value={formData.instructions}
                onChange={(e) => setFormData({ ...formData, instructions: e.target.value })}
                placeholder="Apply thin layer to affected area..."
                className="input"
                rows={2}
              />
            </div>
            <div className="mt-4">
              <label className="label">Warnings (Optional)</label>
              <textarea
                value={formData.warnings}
                onChange={(e) => setFormData({ ...formData, warnings: e.target.value })}
                placeholder="Any special warnings..."
                className="input"
                rows={2}
              />
            </div>
          </div>

          {/* Action Buttons */}
          <div className="flex justify-end space-x-3">
            <button
              type="button"
              onClick={() => {
                setShowNewForm(false);
                setEditingPrescription(null);
              }}
              className="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={saving}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center space-x-2"
            >
              {saving ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent"></div>
                  <span>Saving...</span>
                </>
              ) : (
                <>
                  <Save className="h-4 w-4" />
                  <span>Save Prescription</span>
                </>
              )}
            </button>
          </div>
        </form>
      )}

      {/* Existing Prescriptions */}
      {!showNewForm && (
        <div className="space-y-4">
          {loading ? (
            <div className="text-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
              <p className="text-gray-500 mt-2">Loading prescriptions...</p>
            </div>
          ) : existingPrescriptions.length === 0 ? (
            <div className="card p-8 text-center">
              <Beaker className="h-12 w-12 text-gray-400 mx-auto mb-3" />
              <p className="text-gray-600">No compound prescriptions for this visit</p>
              <p className="text-sm text-gray-500 mt-1">Click "New Compound Prescription" to create one</p>
            </div>
          ) : (
            <>
              <div className="flex justify-end mb-4">
                <button
                  onClick={printAllPrescriptions}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center space-x-2"
                >
                  <Printer className="h-4 w-4" />
                  <span>Print All ({existingPrescriptions.length})</span>
                </button>
              </div>
              {existingPrescriptions.map((prescription, idx) => (
                <div key={prescription.id} className="border border-gray-200 rounded-lg p-3 mb-2">
                  <div className="flex justify-between items-start">
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <span className="font-semibold text-blue-700">#{idx + 1}</span>
                        <span className="font-medium">{FORMULATION_TYPES.find(f => f.value === prescription.formulationType)?.label}</span>
                        <span className="text-gray-600">- {prescription.quantity}{prescription.quantityUnit}</span>
                        <span className="text-xs text-gray-400">({prescription.referenceNumber})</span>
                      </div>
                      <div className="text-sm text-gray-600 mt-1">
                        {prescription.ingredients.map(ing => ing.ingredientName).join(' + ')} {prescription.ingredients.length > 0 ? `(${prescription.ingredients.map(ing => `${ing.strength}${ing.unit}`).join(', ')})` : ''}
                      </div>
                      <div className="text-sm text-gray-500 mt-1">
                        Sig: {FREQUENCY_TYPES.find(f => f.value === prescription.frequencyType)?.label}{prescription.durationValue ? ` x ${prescription.durationValue} ${DURATION_UNITS.find(d => d.value === prescription.durationUnit)?.label}` : ''}
                        {prescription.instructions && ` - ${prescription.instructions}`}
                      </div>
                    </div>
                    <div className="flex space-x-1">
                      <button
                        onClick={() => handleEdit(prescription)}
                        className="p-1.5 text-blue-600 hover:bg-blue-50 rounded"
                        title="Edit"
                      >
                        <Edit className="h-4 w-4" />
                      </button>
                      <button
                        onClick={() => handleDelete(prescription.id)}
                        className="p-1.5 text-red-600 hover:bg-red-50 rounded"
                        title="Delete"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                      <button
                        onClick={() => printPrescription(prescription)}
                        className="p-1.5 text-gray-600 hover:bg-gray-100 rounded"
                        title="Print"
                      >
                        <Printer className="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </>
          )}
        </div>
      )}
    </div>
  );
};

export default CompoundPrescriptionBuilder;
