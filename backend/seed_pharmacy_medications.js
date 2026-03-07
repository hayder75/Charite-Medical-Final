const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const medications = [
    // ANALGESICS (Pain Relief)
    { name: 'Paracetamol', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 5, unit: 'Strip' },
    { name: 'Paracetamol', dosageForm: 'Tablet', strength: '1000mg', category: 'TABLETS', price: 8, unit: 'Strip' },
    { name: 'Paracetamol', dosageForm: 'Syrup', strength: '120mg/5ml', category: 'SYRUPS', price: 45, unit: 'Bottle' },
    { name: 'Paracetamol', dosageForm: 'Syrup', strength: '250mg/5ml', category: 'SYRUPS', price: 60, unit: 'Bottle' },
    { name: 'Ibuprofen', dosageForm: 'Tablet', strength: '200mg', category: 'TABLETS', price: 8, unit: 'Strip' },
    { name: 'Ibuprofen', dosageForm: 'Tablet', strength: '400mg', category: 'TABLETS', price: 12, unit: 'Strip' },
    { name: 'Ibuprofen', dosageForm: 'Tablet', strength: '600mg', category: 'TABLETS', price: 18, unit: 'Strip' },
    { name: 'Ibuprofen', dosageForm: 'Syrup', strength: '100mg/5ml', category: 'SYRUPS', price: 55, unit: 'Bottle' },
    { name: 'Diclofenac', dosageForm: 'Tablet', strength: '50mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Diclofenac', dosageForm: 'Tablet', strength: '100mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Diclofenac', dosageForm: 'Gel', strength: '1%', category: 'OINTMENTS', price: 85, unit: 'Tube' },
    { name: 'Tramadol', dosageForm: 'Capsule', strength: '50mg', category: 'CAPSULES', price: 45, unit: 'Strip' },
    { name: 'Tramadol', dosageForm: 'Injection', strength: '50mg/ml', category: 'INJECTIONS', price: 65, unit: 'Ampoule' },
    { name: 'Morphine', dosageForm: 'Injection', strength: '10mg/ml', category: 'INJECTIONS', price: 120, unit: 'Ampoule' },
    { name: 'Aspirin', dosageForm: 'Tablet', strength: '75mg', category: 'TABLETS', price: 5, unit: 'Strip' },
    { name: 'Aspirin', dosageForm: 'Tablet', strength: '300mg', category: 'TABLETS', price: 10, unit: 'Strip' },

    // ANTIBIOTICS
    { name: 'Amoxicillin', dosageForm: 'Capsule', strength: '250mg', category: 'CAPSULES', price: 25, unit: 'Strip' },
    { name: 'Amoxicillin', dosageForm: 'Capsule', strength: '500mg', category: 'CAPSULES', price: 35, unit: 'Strip' },
    { name: 'Amoxicillin', dosageForm: 'Suspension', strength: '125mg/5ml', category: 'SYRUPS', price: 55, unit: 'Bottle' },
    { name: 'Amoxicillin', dosageForm: 'Suspension', strength: '250mg/5ml', category: 'SYRUPS', price: 75, unit: 'Bottle' },
    { name: 'Augmentin', dosageForm: 'Tablet', strength: '625mg', category: 'TABLETS', price: 250, unit: 'Strip' },
    { name: 'Augmentin', dosageForm: 'Tablet', strength: '1g', category: 'TABLETS', price: 350, unit: 'Strip' },
    { name: 'Azithromycin', dosageForm: 'Tablet', strength: '250mg', category: 'TABLETS', price: 120, unit: 'Strip' },
    { name: 'Azithromycin', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 150, unit: 'Strip' },
    { name: 'Ciprofloxacin', dosageForm: 'Tablet', strength: '250mg', category: 'TABLETS', price: 45, unit: 'Strip' },
    { name: 'Ciprofloxacin', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 65, unit: 'Strip' },
    { name: 'Ceftriaxone', dosageForm: 'Injection', strength: '500mg', category: 'INJECTIONS', price: 150, unit: 'Vial' },
    { name: 'Ceftriaxone', dosageForm: 'Injection', strength: '1g', category: 'INJECTIONS', price: 210, unit: 'Vial' },
    { name: 'Ceftriaxone', dosageForm: 'Injection', strength: '2g', category: 'INJECTIONS', price: 380, unit: 'Vial' },
    { name: 'Doxycycline', dosageForm: 'Capsule', strength: '100mg', category: 'CAPSULES', price: 45, unit: 'Strip' },
    { name: 'Metronidazole', dosageForm: 'Tablet', strength: '200mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Metronidazole', dosageForm: 'Tablet', strength: '400mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Metronidazole', dosageForm: 'Infusion', strength: '500mg/100ml', category: 'INFUSIONS', price: 120, unit: 'Bottle' },
    { name: 'Clarithromycin', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 280, unit: 'Strip' },
    { name: 'Erythromycin', dosageForm: 'Tablet', strength: '250mg', category: 'TABLETS', price: 85, unit: 'Strip' },
    { name: 'Nitrofurantoin', dosageForm: 'Capsule', strength: '100mg', category: 'CAPSULES', price: 110, unit: 'Strip' },

    // CARDIOVASCULAR
    { name: 'Amlodipine', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 10, unit: 'Strip' },
    { name: 'Amlodipine', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 18, unit: 'Strip' },
    { name: 'Atenolol', dosageForm: 'Tablet', strength: '25mg', category: 'TABLETS', price: 12, unit: 'Strip' },
    { name: 'Atenolol', dosageForm: 'Tablet', strength: '50mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Atenolol', dosageForm: 'Tablet', strength: '100mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Atorvastatin', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Atorvastatin', dosageForm: 'Tablet', strength: '20mg', category: 'TABLETS', price: 45, unit: 'Strip' },
    { name: 'Atorvastatin', dosageForm: 'Tablet', strength: '40mg', category: 'TABLETS', price: 80, unit: 'Strip' },
    { name: 'Losartan', dosageForm: 'Tablet', strength: '25mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Losartan', dosageForm: 'Tablet', strength: '50mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Losartan', dosageForm: 'Tablet', strength: '100mg', category: 'TABLETS', price: 60, unit: 'Strip' },
    { name: 'Enalapril', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Enalapril', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 20, unit: 'Strip' },
    { name: 'Enalapril', dosageForm: 'Tablet', strength: '20mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Furosemide', dosageForm: 'Tablet', strength: '40mg', category: 'TABLETS', price: 10, unit: 'Strip' },
    { name: 'Furosemide', dosageForm: 'Injection', strength: '20mg/2ml', category: 'INJECTIONS', price: 25, unit: 'Ampoule' },
    { name: 'Metoprolol', dosageForm: 'Tablet', strength: '25mg', category: 'TABLETS', price: 30, unit: 'Strip' },
    { name: 'Metoprolol', dosageForm: 'Tablet', strength: '50mg', category: 'TABLETS', price: 45, unit: 'Strip' },
    { name: 'Lisinopril', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Lisinopril', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Simvastatin', dosageForm: 'Tablet', strength: '20mg', category: 'TABLETS', price: 40, unit: 'Strip' },
    { name: 'Warfarin', dosageForm: 'Tablet', strength: '1mg', category: 'TABLETS', price: 20, unit: 'Strip' },
    { name: 'Warfarin', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Bisoprolol', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 45, unit: 'Strip' },
    { name: 'Telmisartan', dosageForm: 'Tablet', strength: '40mg', category: 'TABLETS', price: 55, unit: 'Strip' },

    // DIABETES
    { name: 'Metformin', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 12, unit: 'Strip' },
    { name: 'Metformin', dosageForm: 'Tablet', strength: '850mg', category: 'TABLETS', price: 18, unit: 'Strip' },
    { name: 'Metformin', dosageForm: 'Tablet', strength: '1000mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Gliclazide', dosageForm: 'Tablet', strength: '40mg', category: 'TABLETS', price: 20, unit: 'Strip' },
    { name: 'Gliclazide', dosageForm: 'Tablet', strength: '80mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Glimepiride', dosageForm: 'Tablet', strength: '2mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Insulin Glargine', dosageForm: 'Injection', strength: '100U/ml', category: 'INJECTIONS', price: 450, unit: 'Vial' },

    // GASTROINTESTINAL
    { name: 'Omeprazole', dosageForm: 'Capsule', strength: '20mg', category: 'CAPSULES', price: 20, unit: 'Strip' },
    { name: 'Omeprazole', dosageForm: 'Capsule', strength: '40mg', category: 'CAPSULES', price: 35, unit: 'Strip' },
    { name: 'Pantoprazole', dosageForm: 'Tablet', strength: '20mg', category: 'TABLETS', price: 25, unit: 'Strip' },
    { name: 'Pantoprazole', dosageForm: 'Tablet', strength: '40mg', category: 'TABLETS', price: 35, unit: 'Strip' },
    { name: 'Esomeprazole', dosageForm: 'Capsule', strength: '40mg', category: 'CAPSULES', price: 65, unit: 'Strip' },
    { name: 'Ranitidine', dosageForm: 'Tablet', strength: '150mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Antacid', dosageForm: 'Suspension', strength: '150ml', category: 'SYRUPS', price: 65, unit: 'Bottle' },

    // RESPIRATORY
    { name: 'Salbutamol', dosageForm: 'Inhaler', strength: '100mcg', category: 'INHALERS', price: 180, unit: 'Device' },
    { name: 'Cetirizine', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Loratadine', dosageForm: 'Tablet', strength: '10mg', category: 'TABLETS', price: 20, unit: 'Strip' },

    // VITAMINS
    { name: 'Vitamin C', dosageForm: 'Tablet', strength: '500mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Multivitamin', dosageForm: 'Capsule', strength: 'Various', category: 'CAPSULES', price: 30, unit: 'Strip' },
    { name: 'Folic Acid', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 10, unit: 'Strip' },

    // OTHERS
    { name: 'Dexamethasone', dosageForm: 'Tablet', strength: '4mg', category: 'TABLETS', price: 15, unit: 'Strip' },
    { name: 'Prednisolone', dosageForm: 'Tablet', strength: '5mg', category: 'TABLETS', price: 12, unit: 'Strip' },
    { name: 'Gentamicin', dosageForm: 'Eye/Ear Drops', strength: '0.3%', category: 'DROPS', price: 45, unit: 'Bottle' },
    { name: 'Latanoprost', dosageForm: 'Eye Drops', strength: '0.005%', category: 'DROPS', price: 320, unit: 'Bottle' },
];

const additionalGenericNames = [
    'Abacavir', 'Acetazolamide', 'Acetylcysteine', 'Acitretin', 'Albendazole', 'Allopurinol', 'Alprazolam',
    'Amantadine', 'Amikacin', 'Amiloride', 'Aminophylline', 'Amiodarone', 'Amitriptyline', 'Amoxapine',
    'Amphotericin', 'Ampicillin', 'Azathioprine', 'Aztreonam', 'Baclofen', 'Beclometasone', 'Benzatropine',
    'Benzylpenicillin', 'Betahistine', 'Bismuth', 'Bleomycin', 'Budesonide', 'Bupivacaine', 'Buprenorphine',
    'Bupropion', 'Buspirone', 'Busulfan', 'Calamine', 'Calcitriol', 'Calcium Gluconate', 'Candesartan',
    'Capecitabine', 'Captopril', 'Carbamazepine', 'Carbidopa', 'Carbimazole', 'Carboplatin', 'Carvedilol',
    'Cefaclor', 'Cefadroxil', 'Cefalexin', 'Cefazolin', 'Cefixime', 'Cefotaxime', 'Cefuroxime', 'Celecoxib',
    'Chloramphenicol', 'Chlordiazepoxide', 'Chloroquine', 'Chlorpromazine', 'Cimetidine', 'Cisplatin',
    'Citalopram', 'Clarithromycin', 'Clindamycin', 'Clobetasol', 'Clomipramine', 'Clonazepam', 'Clonidine',
    'Clopidogrel', 'Clozapine', 'Codeine', 'Colchicine', 'Cyclophosphamide', 'Cycloserine', 'Cyproheptadine',
    'Dabigatran', 'Dapsone', 'Daptomycin', 'Darunavir', 'Daunorubicin', 'Deferasirox', 'Desmopressin',
    'Dexamethasone', 'Diazepam', 'Digoxin', 'Diltiazem', 'Dobie', 'Dobutamine', 'Docetaxel', 'Domperidone',
    'Dopamine', 'Doxorubicin', 'Doxycycline', 'Duloxetine', 'Efavirenz', 'Eltrombopag', 'Emtricitabine',
    'Enalapril', 'Enoxaparin', 'Entecavir', 'Epinephrine', 'Epoetin', 'Erlotinib', 'Erythromycin',
    'Escitalopram', 'Esomeprazole', 'Ethambutol', 'Ethinylestradiol', 'Etoposide', 'Etravirine', 'Everolimus',
    'Exemestane', 'Ezetimibe', 'Famotidine', 'Febuxostat', 'Felodipine', 'Fenofibrate', 'Fentanyl',
    'Ferrous Fumarate', 'Filgrastim', 'Finasteride', 'Fluconazole', 'Fludarabine', 'Fludrocortisone',
    'Fluorouracil', 'Fluoxetine', 'Fluphenazine', 'Flutamide', 'Fluticasone', 'Fluvoxamine', 'Fondaparinux',
    'Fosfomycin', 'Fosphenytoin', 'Fulvestrant', 'Ganciclovir', 'Gefitinib', 'Gemcitabine', 'Gentamicin',
    'Gliclazide', 'Glimepiride', 'Glipizide', 'Glucagon', 'Glyceryl Trinitrate', 'Griseofulvin', 'Haloperidol',
    'Heparin', 'Hydralazine', 'Hydrochlorothiazide', 'Hydrocortisone', 'Hydromorphone', 'Hydroxychloroquine',
    'Hydroxyurea', 'Hydroxyzine', 'Hyoscine', 'Hypromellose', 'Ibandronate', 'Ibrutinib', 'Ibuprofen',
    'Idarubicin', 'Ifosfamide', 'Imatinib', 'Imipenem', 'Imipramine', 'Imiquimod', 'Indapamide', 'Indomethacin',
    'Infliximab', 'Ipratropium', 'Irbesartan', 'Irinotecan', 'Isoniazid', 'Isosorbide', 'Isotretinoin',
    'Itraconazole', 'Ivermectin', 'Kanamycin', 'Ketamine', 'Ketoconazole', 'Labetalol', 'Lactulose',
    'Lamivudine', 'Lamotrigine', 'Lansoprazole', 'Latanoprost', 'Leflunomide', 'Letrozole', 'Leuprorelin',
    'Levamisole', 'Levetiracetam', 'Levocetirizine', 'Levodopa', 'Levofloxacin', 'Levothyroxine',
    'Lidocaine', 'Linezolid', 'Liothyronine', 'Lisinopril', 'Lithium', 'Loperamide', 'Lopinavir', 'Loratadine',
    'Lorazepam', 'Losartan', 'Lovastatin', 'Magnesium Sulfate', 'Mannitol', 'Mebendazole', 'Mebeverine',
    'Medroxyprogesterone', 'Mefloquine', 'Megestrol', 'Meloxicam', 'Melphalan', 'Memantine', 'Mercaptopurine',
    'Meropenem', 'Mesalazine', 'Mesna', 'Metformin', 'Methadone', 'Methotrexate', 'Methyldopa',
    'Methylprednisolone', 'Metoclopramide', 'Metolazone', 'Metoprolol', 'Metronidazole', 'Miconazole',
    'Midazolam', 'Minocycline', 'Minoxidil', 'Mirtazapine', 'Misoprostol', 'Mitomycin', 'Modafinil',
    'Mometasone', 'Montelukast', 'Morphine', 'Moxifloxacin', 'Mupirocin', 'Mycophenolate', 'Naloxone',
    'Naproxen', 'Naratriptan', 'Natalizumab', 'Nateglinide', 'Nebivolol', 'Neomycin', 'Neostigmine',
    'Nevirapine', 'Nicardipine', 'Nicotine', 'Nifedipine', 'Nilotinib', 'Nimodipine', 'Nitrofurantoin',
    'Nitroglycerin', 'Nitroprusside', 'Norepinephrine', 'Norethisterone', 'Norfloxacin', 'Nortriptyline',
    'Nystatin', 'Octreotide', 'Ofloxacin', 'Olanzapine', 'Olmesartan', 'Olopatadine', 'Omalizumab',
    'Omeprazole', 'Ondansetron', 'Oseltamivir', 'Oxaliplatin', 'Oxazepam', 'Oxcarbazepine', 'Oxybutynin',
    'Oxycodone', 'Oxymetazoline', 'Oxytocin', 'Paclitaxel', 'Paliperidone', 'Pamidronate', 'Pancreatin',
    'Pancuronium', 'Pantoprazole', 'Paracetamol', 'Paritaprevir', 'Paroxetine', 'Pazopanib', 'Pegfilgrastim',
    'Pemetrexed', 'Penicillamine', 'Pentobarbital', 'Pentoxifylline', 'Permethrin', 'Pethidine', 'Phenobarbital',
    'Phenoxymethylpenicillin', 'Phenytoin', 'Phytomenadione', 'Pilocarpine', 'Pioglitazone', 'Piperacillin',
    'Piroxicam', 'Poliomyelitis Vaccine', 'Polymyxin B', 'Potassium Chloride', 'Pramipexole', 'Prasugrel',
    'Pravastatin', 'Praziquantel', 'Prazosin', 'Prednisolone', 'Prednisone', 'Pregabalin', 'Prilocaine',
    'Primaquine', 'Primidone', 'Probenecid', 'Procainamide', 'Procarbazine', 'Prochlorperazine', 'Progesterone',
    'Promethazine', 'Propofol', 'Propranolol', 'Propylthiouracil', 'Pyrazinamide', 'Pyridostigmine',
    'Pyridoxine', 'Pyrimethamine', 'Quetiapine', 'Quinapril', 'Quinine', 'Rabeprazole', 'Raloxifene',
    'Raltegravir', 'Ramipril', 'Ranitidine', 'Rasagiline', 'Remifentanil', 'Repaglinide', 'Ribavirin',
    'Rifampicin', 'Rifabutin', 'Riluzole', 'Rimantadine', 'Risedronate', 'Risperidone', 'Ritonavir',
    'Rituximab', 'Rivaroxaban', 'Rivastigmine', 'Rizatriptan', 'Rocuronium', 'Ropinirole', 'Rosiglitazone',
    'Rosuvastatin', 'Salbutamol', 'Salmeterol', 'Sertraline', 'Sevelamer', 'Sildenafil', 'Simvastatin',
    'Sirolimus', 'Sitagliptin', 'Sodium Bicarbonate', 'Sodium Chloride', 'Sodium Nitroprusside',
    'Sodium Valproate', 'Solifenacin', 'Somalat', 'Sunitinib', 'Tacrolimus', 'Tadalafil', 'Tamoxifen',
    'Tamsulosin', 'Telmisartan', 'Temazepam', 'Temozolomide', 'Tenofovir', 'Terazosin', 'Terbinafine',
    'Terbutaline', 'Teriparatide', 'Testosterone', 'Tetracycline', 'Thalidomide', 'Theophylline',
    'Thiamine', 'Tiagabine', 'Ticagrelor', 'Ticlopidine', 'Tigecycline', 'Timolol', 'Tinidazole',
    'Tiotropium', 'Tipranavir', 'Tizanidine', 'Tobramycin', 'Tocilizumab', 'Tolrit', 'Tolterodine',
    'Topiramate', 'Torasemide', 'Tramadol', 'Trandolapril', 'Tranexamic Acid', 'Tranylcypromine',
    'Trastuzumab', 'Trazodone', 'Tretinoin', 'Triamcinolone', 'Triamterene', 'Triazolam', 'Trifluoperazine',
    'Trimebutine', 'Trimethoprim', 'Trimetazidine', 'Trimipramine', 'Tropicamide', 'Trospium', 'Troxerutin',
    'Tulobuterol', 'Typhoid Vaccine', 'Umeclidinium', 'Urofollitropin', 'Ursodeoxycholic Acid', 'Valaciclovir',
    'Valganciclovir', 'Valproate', 'Valsartan', 'Varenicline', 'Venlafaxine', 'Verapamil', 'Vigabatrin',
    'Vildagliptin', 'Vinblastine', 'Vincristine', 'Vinorelbine', 'Vitamin A', 'Vitamin B1', 'Vitamin B6',
    'Vitamin B12', 'Vitamin C', 'Vitamin D', 'Vitamin E', 'Vitamin K', 'Voriconazole', 'Warfarin', 'Xylometazoline',
    'Zafirlukast', 'Zaleplon', 'Zidovudine', 'Ziprasidone', 'Zolmitriptan', 'Zolpidem', 'Zonisamide', 'Zopiclone'
];

const subDosageForms = ['Tablet', 'Capsule', 'Syrup', 'Injection', 'Ointment', 'Drops', 'Inhaler', 'Infusion'];
const subCategories = ['TABLETS', 'CAPSULES', 'SYRUPS', 'INJECTIONS', 'OINTMENTS', 'DROPS', 'INHALERS', 'INFUSIONS'];
const subUnits = ['Strip', 'Strip', 'Bottle', 'Vial', 'Tube', 'Bottle', 'Device', 'Bottle'];
const subStrengths = ['5mg', '10mg', '20mg', '50mg', '100mg', '250mg', '500mg', '1g'];

additionalGenericNames.forEach(name => {
    const exists = medications.some(m => m.name.toLowerCase() === name.toLowerCase());
    if (!exists) {
        const idx = Math.floor(Math.random() * subDosageForms.length);
        const strengthIdx = Math.floor(Math.random() * subStrengths.length);
        medications.push({
            name: name,
            dosageForm: subDosageForms[idx],
            strength: subStrengths[strengthIdx],
            category: subCategories[idx],
            price: Math.floor(Math.random() * 400) + 10,
            unit: subUnits[idx]
        });
    }
});

async function main() {
    console.log('🚀 Starting intensive medication seeding...');
    let count = 0;
    for (const med of medications) {
        try {
            await prisma.medicationCatalog.upsert({
                where: {
                    name_dosageForm_strength: {
                        name: med.name,
                        dosageForm: med.dosageForm,
                        strength: med.strength
                    }
                },
                update: {
                    availableQuantity: 10000,
                    unitPrice: med.price,
                    category: med.category
                },
                create: {
                    name: med.name,
                    dosageForm: med.dosageForm,
                    strength: med.strength,
                    category: med.category,
                    unitPrice: med.price,
                    availableQuantity: 10000,
                    minimumStock: 100,
                    unit: med.unit || 'Strip',
                    description: `Stocked ${med.name} ${med.strength} ${med.dosageForm}`
                }
            });
            count++;
            if (count % 50 === 0) console.log(`📦 Seeded ${count} medications...`);
        } catch (error) {
            // console.error(`❌ Failed to seed ${med.name}:`, error.message);
        }
    }
    console.log(`✅ Successfully seeded/updated total ${count} medications with quantity 10,000.`);
}

main()
    .catch(e => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
