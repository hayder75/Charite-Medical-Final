import React, { useState, forwardRef, useImperativeHandle, useMemo, useEffect } from 'react';
import api from '../../services/api';
import toast from 'react-hot-toast';
import { Save, X, Eye, EyeOff, Zap, Plus, Settings, AlertCircle, ShieldCheck } from 'lucide-react';
import ToothDetailPanel from './ToothDetailPanel';

// FDI tooth numbering system - defined outside component to prevent re-creation
const TOOTH_NUMBERS = [
  // Upper jaw (right to left) - Patient's perspective
  18, 17, 16, 15, 14, 13, 12, 11,
  21, 22, 23, 24, 25, 26, 27, 28,
  // Lower jaw (left to right) - Patient's perspective  
  38, 37, 36, 35, 34, 33, 32, 31,
  41, 42, 43, 44, 45, 46, 47, 48
];

const TOOTH_CONDITIONS = {
  HEALTHY: { color: '#10B981', label: 'Healthy', glow: '#10B98120' },
  CARIES: { color: '#EF4444', label: 'Caries (Decay)', glow: '#EF444420' },
  FILLED: { color: '#3B82F6', label: 'Filled / Restored', glow: '#3B82F620' },
  ROOT_CANAL: { color: '#8B5CF6', label: 'Root Canal Therapy', glow: '#8B5CF620' },
  CROWN: { color: '#EC4899', label: 'Crown / Bridge', glow: '#EC489920' },
  FRACTURED: { color: '#F97316', label: 'Fractured', glow: '#F9731620' },
  MISSING: { color: '#6B7280', label: 'Missing', glow: '#6B728020' },
  IMPACTED: { color: '#F59E0B', label: 'Impacted', glow: '#F59E0B20' },
  EXTRACTED: { color: '#DC2626', label: 'Extracted', glow: '#DC262620' }
};

// Clean Tooth Component
const ToothComponent = ({ toothNumber, data = {}, hasPain, onClick, isUpper, position }) => {
  const isCentral = position === 7 || position === 8; // Central incisors

  // Logical Indicators
  // 1. Diagnosis (Active Issue) => Red Border
  const hasDiagnosis = data.diagnosis?.length > 0;

  // 2. Restoration (Existing Treatment) => Blue Dot/Background tint
  const hasRestoration = data.restoration?.length > 0;

  // 3. Treatment Planned => Orange Border/Dot
  const hasTreatmentPlan = data.treatmentPlan?.length > 0;

  // 4. Completed (Extraction specifically) => Dark Red
  const isExtracted = data.completedTreatments?.some(t => t.treatment === 'Extraction' || t.treatment === 'Extraction completed');

  // 5. Periodontal => Purple indicator 
  const hasPerio = data.periodontal?.pocketDepth >= 4 || data.periodontal?.bleeding;

  return (
    <div className="relative group">
      <div
        className="relative cursor-pointer transition-all duration-300 transform hover:scale-105"
        onClick={onClick}
        style={{
          width: isCentral ? '50px' : '40px',
          height: isCentral ? '50px' : '40px',
        }}
      >
        {/* Tooth Shape - Replaces rainbow with structural indicators */}
        <div
          className={`w-full h-full rounded-lg border-2 flex items-center justify-center relative overflow-hidden transition-colors ${isExtracted ? 'opacity-30 border-dashed' : 'shadow-sm hover:shadow-md'}`}
          style={{
            backgroundColor: hasRestoration ? '#EFF6FF' : '#FFFFFF', // Blue tint if restored
            borderColor: hasDiagnosis ? '#EF4444' : (hasTreatmentPlan ? '#F97316' : '#E5E7EB'), // Red if bad, Orange if plan, Grey if healthy
            borderStyle: isExtracted ? 'dashed' : 'solid',
            borderWidth: hasDiagnosis || hasTreatmentPlan ? '3px' : '2px'
          }}
        >
          {/* Tooth Number */}
          <span
            className={`font-bold drop-shadow-sm ${hasDiagnosis ? 'text-red-700' : (hasRestoration ? 'text-blue-700' : 'text-gray-700')}`}
            style={{ fontSize: isCentral ? '14px' : '12px' }}
          >
            {toothNumber}
          </span>

          {/* Indicators layer */}
          <div className="absolute inset-x-1 bottom-1 flex justify-center space-x-1">
            {hasRestoration && <div className="w-1.5 h-1.5 rounded-full bg-blue-500" title="Restoration Present"></div>}
            {hasPerio && <div className="w-1.5 h-1.5 rounded-full bg-purple-500" title="Periodontal Issue"></div>}
            {hasTreatmentPlan && <div className="w-1.5 h-1.5 rounded-full bg-orange-500" title="Treatment Planned"></div>}
          </div>

          {/* Pain Indicator */}
          {hasPain && (
            <div className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full border-2 border-white animate-pulse flex items-center justify-center">
              <Zap className="w-2 h-2 text-white" />
            </div>
          )}

          {/* Hover Overlay */}
          <div className="absolute inset-0 rounded-lg opacity-0 group-hover:opacity-10 transition-opacity duration-300 bg-gray-900 pointer-events-none"></div>
        </div>

        {/* Clean Tooltip */}
        <div className="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-3 px-3 py-2 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-all duration-300 whitespace-nowrap z-20 pointer-events-none shadow-lg">
          <div className="font-bold border-b border-gray-700 pb-1 mb-1">Tooth {toothNumber}</div>
          {isExtracted && <div className="text-red-400">Extracted</div>}
          {hasDiagnosis && <div className="text-red-300 mt-1">Diagnosis: {data.diagnosis.join(', ')}</div>}
          {hasRestoration && <div className="text-blue-300 mt-1">Restoration: {data.restoration.join(', ')}</div>}
          {hasTreatmentPlan && <div className="text-orange-300 mt-1">Plan: {data.treatmentPlan.join(', ')}</div>}
          {hasPerio && <div className="text-purple-300 mt-1">Periodontal Warning</div>}
          {!hasDiagnosis && !hasRestoration && !hasTreatmentPlan && !isExtracted && <div className="text-green-400">Healthy</div>}
          <div className="absolute top-full left-1/2 transform -translate-x-1/2 w-0 h-0 border-l-4 border-r-4 border-t-4 border-transparent border-t-gray-900"></div>
        </div>
      </div>
    </div>
  );
};

const DentalChart = forwardRef(({ patientId, visitId, onSave, initialData }, ref) => {
  // Create stable initial state that never changes
  const initialToothChart = useMemo(() => {
    const chart = {};
    TOOTH_NUMBERS.forEach(tooth => {
      chart[tooth] = {
        diagnosis: [],
        restoration: [],
        treatmentPlan: [],
        completedTreatments: [],
        periodontal: {},
        generalNotes: [],
        notes: '',
        surfaces: []
      };
    });
    return chart;
  }, []);

  const [toothChart, setToothChart] = useState(initialToothChart);
  const [painFlags, setPainFlags] = useState({});
  const [gumCondition, setGumCondition] = useState('');
  const [oralHygiene, setOralHygiene] = useState('');
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [showStatusModal, setShowStatusModal] = useState(false);
  const [currentTooth, setCurrentTooth] = useState(null);

  // Load existing dental record data when initialData changes
  useEffect(() => {
    if (initialData) {
      console.log('🔍 Loading existing dental record data:', initialData);

      // Load tooth chart data
      if (initialData.toothChart) {
        console.log('📊 Loading tooth chart data:', Object.keys(initialData.toothChart).length, 'teeth');
        setToothChart(prev => ({
          ...prev,
          ...initialData.toothChart
        }));
      }

      // Load other dental data
      if (initialData.painFlags) {
        console.log('📊 Loading pain flags:', Object.keys(initialData.painFlags).length, 'teeth');
        setPainFlags(initialData.painFlags);
      }
      if (initialData.gumCondition) {
        console.log('📊 Loading gum condition:', initialData.gumCondition);
        setGumCondition(initialData.gumCondition);
      }
      if (initialData.oralHygiene) {
        console.log('📊 Loading oral hygiene:', initialData.oralHygiene);
        setOralHygiene(initialData.oralHygiene);
      }
      if (initialData.notes) {
        console.log('📊 Loading notes:', initialData.notes);
        setNotes(initialData.notes);
      }

      console.log('✅ Dental record data loaded successfully');
    } else {
      console.log('ℹ️ No initial data provided, using default values');
    }
  }, [initialData]);

  // Debug: trace renders and key state changes
  useEffect(() => {
    // eslint-disable-next-line no-console
    console.debug('[DentalChart] render', { visitId, patientId, chartKeys: Object.keys(toothChart).length });
  });

  useEffect(() => {
    if (showStatusModal) {
      // eslint-disable-next-line no-console
      console.debug('[DentalChart] open status modal for tooth', currentTooth);
    }
  }, [showStatusModal, currentTooth]);

  // Expose methods to parent component
  useImperativeHandle(ref, () => ({
    getCurrentData: () => ({
      toothChart,
      painFlags,
      gumCondition,
      oralHygiene,
      notes
    })
  }));

  const handleToothClick = (toothNumber) => {
    // eslint-disable-next-line no-console
    console.debug('[DentalChart] click tooth', toothNumber);
    setCurrentTooth(toothNumber);
    setShowStatusModal(true);
  };

  const handleSaveToothPanel = (toothNumber, updatedData) => {
    setToothChart(prev => ({
      ...prev,
      [toothNumber]: {
        ...prev[toothNumber],
        ...updatedData
      }
    }));
    setShowStatusModal(false);
  };

  const handlePainFlagToggle = (toothNumber) => {
    // eslint-disable-next-line no-console
    console.debug('[DentalChart] toggle pain', toothNumber);
    setPainFlags(prev => ({
      ...prev,
      [toothNumber]: !prev[toothNumber]
    }));
  };

  const handleSave = async () => {
    // eslint-disable-next-line no-console
    console.debug('[DentalChart] save', { patientId, visitId });
    setLoading(true);
    try {
      const dentalData = {
        patientId,
        visitId: parseInt(visitId), // Convert string to number
        toothChart,
        painFlags,
        gumCondition,
        oralHygiene,
        notes
      };

      const response = await api.post('/dental/records', dentalData);
      // Don't show toast here - let the parent component handle it to avoid double popup
      onSave(response.data.dentalRecord);
    } catch (error) {
      console.error('Error saving dental chart:', error);
      toast.error('Failed to save dental chart.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg border border-gray-200">
      {/* Clean Header */}
      <div className="p-6 border-b border-gray-200">
        <div className="flex justify-between items-center">
          <div className="flex items-center space-x-4">
            <div className="w-12 h-12 rounded-full bg-blue-600 flex items-center justify-center">
              <span className="text-white font-bold text-lg">🦷</span>
            </div>
            <div>
              <h4 className="text-2xl font-bold text-gray-800">Digital Dental Chart</h4>
              <p className="text-sm text-gray-600">Interactive FDI Tooth Mapping System</p>
            </div>
          </div>
          <button
            onClick={handleSave}
            disabled={loading}
            className="px-6 py-3 rounded-lg font-medium transition-all duration-300 flex items-center space-x-2 transform hover:scale-105 bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50"
          >
            <Save className="h-5 w-5" />
            <span>{loading ? 'Saving...' : 'Save Chart'}</span>
          </button>
        </div>
      </div>

      {/* Clean Legend */}
      <div className="p-6 border-b border-gray-200 bg-gray-50">
        <div className="flex flex-wrap gap-4 items-center justify-center">
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg bg-white border border-gray-200 shadow-sm">
            <div className="w-6 h-6 rounded border-[3px] border-red-500 bg-white"></div>
            <span className="text-sm font-medium text-gray-700">Diagnosis (Active)</span>
          </div>
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg bg-[#EFF6FF] border border-blue-200 shadow-sm">
            <div className="w-6 h-6 rounded border-2 border-gray-200 bg-[#EFF6FF] flex items-center justify-center">
              <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
            </div>
            <span className="text-sm font-medium text-gray-700">Restoration (Existing)</span>
          </div>
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg bg-white border border-gray-200 shadow-sm">
            <div className="w-6 h-6 rounded border-[3px] border-orange-500 bg-white flex items-center justify-center">
              <div className="w-2 h-2 bg-orange-500 rounded-full"></div>
            </div>
            <span className="text-sm font-medium text-gray-700">Treatment Planned</span>
          </div>
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg border border-gray-200 shadow-sm opacity-50 border-dashed">
            <span className="text-sm font-medium text-gray-700">Extracted / Missing</span>
          </div>
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg bg-white border border-gray-200 shadow-sm">
            <div className="w-3 h-3 bg-purple-500 rounded-full"></div>
            <span className="text-sm font-medium text-gray-700">Perio Warning</span>
          </div>
          <div className="flex items-center space-x-2 px-3 py-2 rounded-lg bg-white border border-gray-200 shadow-sm">
            <div className="w-4 h-4 rounded-full bg-red-500 animate-pulse border-2 border-white shadow-md"></div>
            <span className="text-sm font-medium text-gray-700">Pain Flag</span>
          </div>
        </div>
      </div>

      {/* Clean Dental Chart */}
      <div className="p-8">
        <div className="relative max-w-4xl mx-auto">
          {/* Upper Jaw */}
          <div className="mb-8">
            <div className="text-center mb-6">
              <h5 className="text-lg font-semibold text-gray-700">Maxillary Arch (Upper Jaw)</h5>
              <div className="w-24 h-px mx-auto mt-2 bg-gray-300"></div>
            </div>
            <div className="flex justify-center">
              <div className="flex space-x-2">
                {TOOTH_NUMBERS.slice(0, 16).map((toothNumber, index) => (
                  <ToothComponent
                    key={toothNumber}
                    toothNumber={toothNumber}
                    data={toothChart[toothNumber] || {}}
                    hasPain={painFlags[toothNumber]}
                    onClick={() => handleToothClick(toothNumber)}
                    isUpper={true}
                    position={index}
                  />
                ))}
              </div>
            </div>
          </div>

          {/* Central Divider */}
          <div className="flex justify-center mb-8">
            <div className="w-px h-8 bg-gray-300"></div>
          </div>

          {/* Lower Jaw */}
          <div>
            <div className="text-center mb-6">
              <h5 className="text-lg font-semibold text-gray-700">Mandibular Arch (Lower Jaw)</h5>
              <div className="w-24 h-px mx-auto mt-2 bg-gray-300"></div>
            </div>
            <div className="flex justify-center">
              <div className="flex space-x-2">
                {TOOTH_NUMBERS.slice(16, 32).map((toothNumber, index) => (
                  <ToothComponent
                    key={toothNumber}
                    toothNumber={toothNumber}
                    data={toothChart[toothNumber] || {}}
                    hasPain={painFlags[toothNumber]}
                    onClick={() => handleToothClick(toothNumber)}
                    isUpper={false}
                    position={index}
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Status Modal */}
      {showStatusModal && currentTooth && (
        <ToothDetailPanel
          toothNumber={currentTooth}
          initialData={toothChart[currentTooth] || {}}
          onSave={handleSaveToothPanel}
          onClose={() => setShowStatusModal(false)}
        />
      )}

      {/* General Dental Notes */}
      <div className="p-6 border-t border-gray-200 bg-gray-50">
        <h5 className="font-semibold mb-4 text-gray-800">General Oral Health Assessment</h5>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Gum Condition</label>
            <select
              value={gumCondition}
              onChange={(e) => setGumCondition(e.target.value)}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white text-gray-700"
            >
              <option value="">Select condition</option>
              <option value="healthy">Healthy</option>
              <option value="gingivitis">Gingivitis</option>
              <option value="periodontitis">Periodontitis</option>
              <option value="recession">Recession</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Oral Hygiene</label>
            <select
              value={oralHygiene}
              onChange={(e) => setOralHygiene(e.target.value)}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white text-gray-700"
            >
              <option value="">Select hygiene level</option>
              <option value="excellent">Excellent</option>
              <option value="good">Good</option>
              <option value="fair">Fair</option>
              <option value="poor">Poor</option>
            </select>
          </div>
        </div>
        <div className="mt-6">
          <label className="block text-sm font-medium text-gray-700 mb-2">Additional Notes</label>
          <textarea
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            rows="4"
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white text-gray-700 resize-none"
            placeholder="Add general dental notes and observations..."
          />
        </div>
      </div>
    </div>
  );
});

export default DentalChart;