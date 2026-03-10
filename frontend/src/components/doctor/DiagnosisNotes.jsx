import React, { useState, useEffect, useRef } from 'react';
import { FileText, ChevronDown, ChevronUp, CheckCircle, Plus, X, AlertTriangle } from 'lucide-react';
import AsyncSelect from 'react-select/async';
import toast from 'react-hot-toast';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
import api from '../../services/api';

const DiagnosisNotes = ({ visitId, patientId, patientName, onSave }) => {
  // --- Structured Diagnosis State ---
  const [diagnoses, setDiagnoses] = useState([]);
  const [selectedDisease, setSelectedDisease] = useState(null);
  const [diagnosisType, setDiagnosisType] = useState('CLINICAL'); // CLINICAL, CONFIRMED, SUSPECTED
  const [diagnosisStatus, setDiagnosisStatus] = useState('ACTIVE');
  const [diagnosisNotes, setDiagnosisNotes] = useState('');
  const [visitOutcome, setVisitOutcome] = useState('');
  const [diseaseSearchInput, setDiseaseSearchInput] = useState('');
  const [isAddingDiagnosis, setIsAddingDiagnosis] = useState(false);
  const [isDeletingDiagnosisId, setIsDeletingDiagnosisId] = useState(null);

  const diseaseSelectStyles = {
    control: (base, state) => ({
      ...base,
      minHeight: 42,
      borderColor: state.isFocused ? '#3B82F6' : '#D1D5DB',
      boxShadow: state.isFocused ? '0 0 0 1px #3B82F6' : 'none',
      backgroundColor: '#FFFFFF'
    }),
    singleValue: (base) => ({
      ...base,
      color: '#111827',
      fontWeight: 500
    }),
    input: (base) => ({
      ...base,
      color: '#111827'
    }),
    placeholder: (base) => ({
      ...base,
      color: '#6B7280'
    }),
    menu: (base) => ({
      ...base,
      zIndex: 30
    })
  };

  // --- Clinical Notes State ---
  const [notes, setNotes] = useState({
    chiefComplaint: '',
    historyOfPresentIllness: '',
    pastMedicalHistory: '',
    allergicHistory: '',
    physicalExamination: '',
    investigationFindings: '',
    assessmentAndDiagnosis: '', // We keep this for backward compatibility/summary
    treatmentPlan: '',
    treatmentGiven: '',
    medicationIssued: '',
    additional: '',
    prognosis: ''
  });

  const [expandedFields, setExpandedFields] = useState({});
  const [isSaving, setIsSaving] = useState(false);
  const [hasUnsavedChanges, setHasUnsavedChanges] = useState(false);
  const [isInitialLoad, setIsInitialLoad] = useState(true);
  const contentEditableRefs = useRef({});

  // --- Effects ---

  // Load existing data
  useEffect(() => {
    if (visitId) {
      loadExistingNotes();
      fetchDiagnoses();
    }
  }, [visitId]);

  // Auto-save logic for textual notes
  useEffect(() => {
    if (!hasUnsavedChanges || isInitialLoad) return;
    const saveTimer = setTimeout(() => {
      saveNotes();
    }, 2000);
    return () => clearTimeout(saveTimer);
  }, [notes, hasUnsavedChanges, isInitialLoad]);

  // --- API Calls ---

  const fetchDiagnoses = async () => {
    try {
      const response = await api.get(`/diseases/diagnosis/${visitId}`);
      setDiagnoses(response.data);
    } catch (error) {
      console.error('Error fetching diagnoses:', error);
    }
  };

  const loadExistingNotes = async () => {
    try {
      setIsSaving(true);
      const response = await api.get(`/doctors/visits/${visitId}/diagnosis-notes`);
      const serverNotes = response.data?.notes;
      const diagnosisFields = Object.keys(notes);

      if (serverNotes && (serverNotes.id || serverNotes.createdAt)) {
        const sanitizedNotes = diagnosisFields.reduce((acc, field) => {
          acc[field] = serverNotes[field] || '';
          return acc;
        }, {});
        setNotes(sanitizedNotes);
        setHasUnsavedChanges(false);
        setIsInitialLoad(false);
      } else {
        // Apply templates if empty
        applyTemplatesSilently();
      }

      // Also load visit outcome if available in the notes or visit
      // (This part depends on backend delivering outcome in notes response or separate call)
    } catch (error) {
      console.error('Error loading notes:', error);
      applyTemplatesSilently();
    } finally {
      setIsSaving(false);
    }
  };

  const applyTemplatesSilently = async () => {
    // ... (Use existing template logic, simplified for brevity in this rewrite)
    const newNotes = {};
    Object.keys(notes).forEach(key => newNotes[key] = ''); // Or your template logic
    setNotes(newNotes);
    setIsInitialLoad(false);
  };

  const saveNotes = async () => {
    try {
      setIsSaving(true);
      const response = await api.post(`/doctors/visits/${visitId}/diagnosis-notes`, { notes });
      setHasUnsavedChanges(false);
      if (onSave) onSave(response.data);
    } catch (error) {
      console.error('Error saving notes:', error);
    } finally {
      setIsSaving(false);
    }
  };

  // --- Structured Diagnosis Handlers ---

  const loadDiseaseOptions = (inputValue) => {
    if (!inputValue) return Promise.resolve([]);
    return api.get(`/diseases/search?query=${inputValue}`)
      .then(res => res.data.map(d => ({
        label: `${d.name} (${d.code})`,
        value: d.id,
        ...d
      })));
  };

  const handleDiseaseSelection = (option) => {
    setSelectedDisease(option);
    setDiseaseSearchInput(option?.label || '');
  };

  const resolveDiseaseId = async () => {
    if (!selectedDisease) return null;

    return selectedDisease.value;
  };

  const handleAddDiagnosis = async () => {
    if (!selectedDisease) {
      toast.error('Please select or add a disease');
      return;
    }

    try {
      setIsAddingDiagnosis(true);
      const diseaseId = await resolveDiseaseId();

      await api.post('/diseases/diagnosis', {
        visitId,
        patientId,
        diseaseId,
        type: diagnosisType,
        status: diagnosisStatus,
        notes: diagnosisNotes,
        outcome: visitOutcome || undefined
      });

      toast.success('Diagnosis added');
      fetchDiagnoses();

      // Reset form
      setSelectedDisease(null);
      setDiagnosisNotes('');
      setDiseaseSearchInput('');
    } catch (error) {
      console.error('Error adding diagnosis:', error);
      toast.error('Failed to add diagnosis');
    } finally {
      setIsAddingDiagnosis(false);
    }
  };

  const handleDeleteDiagnosis = async (diagnosisId) => {
    if (!diagnosisId) return;

    try {
      setIsDeletingDiagnosisId(diagnosisId);
      await api.delete(`/diseases/diagnosis/${diagnosisId}`);
      toast.success('Diagnosis removed');
      fetchDiagnoses();
    } catch (error) {
      console.error('Error deleting diagnosis:', error);
      toast.error('Failed to delete diagnosis');
    } finally {
      setIsDeletingDiagnosisId(null);
    }
  };

  // --- Text Note Handlers ---

  const handleNoteChange = (field, value) => {
    setNotes(prev => ({ ...prev, [field]: value }));
    setHasUnsavedChanges(true);
  };

  const handleFieldExpand = (field) => {
    setExpandedFields(prev => ({ ...prev, [field]: !prev[field] }));
  };

  // --- Render ---

  return (
    <div className="space-y-6">
      {/* 1. Structured Diagnosis Section */}
      <div className="bg-white rounded-lg border border-gray-200 p-6 shadow-sm">
        <h3 className="text-lg font-semibold text-gray-800 mb-4 flex items-center">
          <CheckCircle className="h-5 w-5 text-green-600 mr-2" />
          Structured Diagnosis & Assessment
        </h3>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
          <div className="col-span-2">
            <label className="block text-sm font-medium text-gray-700 mb-1">Search Disease (ICD/WHO)</label>
            <div className="flex gap-2">
              <div className="flex-1">
                <AsyncSelect
                  cacheOptions
                  loadOptions={loadDiseaseOptions}
                  defaultOptions={false}
                  styles={diseaseSelectStyles}
                  value={selectedDisease}
                  onChange={handleDiseaseSelection}
                  inputValue={diseaseSearchInput}
                  openMenuOnClick={false}
                  openMenuOnFocus={false}
                  components={{ DropdownIndicator: null, IndicatorSeparator: null }}
                  noOptionsMessage={() => (diseaseSearchInput ? 'No disease found' : 'Type to search diseases')}
                  onInputChange={(value, actionMeta) => {
                    if (actionMeta.action === 'input-change') {
                      setDiseaseSearchInput(value);
                    }
                    return value;
                  }}
                  placeholder="Type disease name/code (e.g. Malaria, A00)..."
                  className="react-select-container"
                  classNamePrefix="react-select"
                />
              </div>
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Type</label>
            <select
              value={diagnosisType}
              onChange={e => setDiagnosisType(e.target.value)}
              className="w-full border-gray-300 rounded-md shadow-sm focus:border-blue-500 focus:ring-blue-500"
            >
              <option value="CLINICAL">Clinical (Based on Symptoms)</option>
              <option value="CONFIRMED">Confirmed (Lab/Radiology)</option>
              <option value="SUSPECTED">Suspected</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
            <select
              value={diagnosisStatus}
              onChange={e => setDiagnosisStatus(e.target.value)}
              className="w-full border-gray-300 rounded-md shadow-sm focus:border-blue-500 focus:ring-blue-500"
            >
              <option value="ACTIVE">Active</option>
              <option value="RESOLVED">Resolved</option>
              <option value="RULED_OUT">Ruled Out</option>
            </select>
          </div>

          <div className="col-span-2">
            <label className="block text-sm font-medium text-gray-700 mb-1">Clinical Notes for this Diagnosis</label>
            <input
              type="text"
              value={diagnosisNotes}
              onChange={e => setDiagnosisNotes(e.target.value)}
              className="w-full border-gray-300 rounded-md shadow-sm focus:border-blue-500 focus:ring-blue-500"
              placeholder="Specific notes (e.g. Severity, Stage)..."
            />
          </div>
        </div>

        <div className="flex justify-end">
          <button
            onClick={handleAddDiagnosis}
            disabled={isAddingDiagnosis || !selectedDisease}
            className="flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50"
          >
            <Plus className="h-4 w-4 mr-2" />
            Add Diagnosis
          </button>
        </div>

        {/* List of Added Diagnoses */}
        {diagnoses.length > 0 && (
          <div className="mt-6 border-t pt-4">
            <h4 className="text-sm font-medium text-gray-700 mb-2">Current Diagnoses:</h4>
            <div className="space-y-2">
              {diagnoses.map((d) => (
                <div key={d.id} className="flex items-center justify-between p-3 bg-blue-50 rounded-md border border-blue-100">
                  <div>
                    <p className="font-medium text-blue-900">{d.disease.name} <span className="text-xs text-blue-600">({d.type})</span></p>
                    {d.notes && <p className="text-sm text-blue-700">{d.notes}</p>}
                  </div>
                  <div className="flex items-center">
                    <button
                      type="button"
                      onClick={() => handleDeleteDiagnosis(d.id)}
                      disabled={isDeletingDiagnosisId === d.id}
                      className="mr-2 inline-flex items-center px-2 py-1 text-xs font-medium rounded bg-red-100 text-red-700 hover:bg-red-200 disabled:opacity-60"
                    >
                      <X className="h-3 w-3 mr-1" />
                      Delete
                    </button>
                    <span className={`px-2 py-0.5 rounded-full text-xs ${d.status === 'ACTIVE' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}`}>
                      {d.status}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* 2. Clinical Notes (Detailed Findings) */}
      <div className="bg-white rounded-lg border border-gray-200 p-6 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-lg font-semibold text-gray-800 flex items-center">
            <FileText className="h-5 w-5 text-blue-600 mr-2" />
            Detailed Clinical Findings & Notes
          </h3>
          <div className="text-xs text-gray-500">
            {hasUnsavedChanges ? 'Saving...' : 'All changes saved'}
          </div>
        </div>

        <div className="space-y-4">
          {/* Button Group / Tabs */}
          <div className="flex flex-wrap gap-2">
            {Object.keys(notes).map((key) => {
              const label = key.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase());
              const isActiveField = Object.keys(expandedFields).find(k => expandedFields[k]) === key || (!Object.keys(expandedFields).some(k => expandedFields[k]) && key === 'chiefComplaint');

              return (
                <button
                  key={key}
                  onClick={() => {
                    const newExpanded = {};
                    newExpanded[key] = true;
                    setExpandedFields(newExpanded);
                  }}
                  className={`px-4 py-2 text-sm font-medium rounded-lg transition-colors border ${isActiveField
                    ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
                    : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'
                    }`}
                >
                  {label}
                  {notes[key] && !isActiveField && (
                    <span className="ml-2 inline-flex h-2 w-2 rounded-full bg-blue-400"></span>
                  )}
                </button>
              );
            })}
          </div>

          {/* Active Textarea Content */}
          <div className="mt-4 p-4 bg-gray-50 rounded-lg border border-gray-200">
            {Object.keys(notes).map((key) => {
              const label = key.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase());
              const isActiveField = Object.keys(expandedFields).find(k => expandedFields[k]) === key || (!Object.keys(expandedFields).some(k => expandedFields[k]) && key === 'chiefComplaint');

              if (!isActiveField) return null;

              return (
                <div key={key} className="animate-in fade-in duration-200">
                  <div className="flex items-center justify-between mb-2">
                    <label className="block text-base font-semibold text-gray-800">
                      {label}
                    </label>
                  </div>
                  <div className="bg-white rounded-md">
                    <ReactQuill
                      theme="snow"
                      value={notes[key]}
                      onChange={(content) => handleNoteChange(key, content)}
                      placeholder={`Enter ${label.toLowerCase()} details here...`}
                      modules={{
                        toolbar: [
                          ['bold', 'italic', 'underline'],
                          [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                          ['clean']
                        ],
                      }}
                      className="h-48 mb-12"
                      style={{ fontSize: '16px' }}
                    />
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
};

export default DiagnosisNotes;
