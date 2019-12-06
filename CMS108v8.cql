library VenousThromboembolismProphylaxis version '8.2.000'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include TJC_Overall version '4.0.000' called TJC
include MATGlobalCommonFunctions version '4.0.000' called Global

codesystem "LOINC": 'urn:oid:2.16.840.1.113883.6.1'

valueset "Atrial Fibrillation/Flutter": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.202'
valueset "Comfort Measures": 'urn:oid:1.3.6.1.4.1.33895.1.3.0.45'
valueset "Direct Thrombin Inhibitor": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.205'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "General or Neuraxial Anesthesia": 'urn:oid:2.16.840.1.113883.3.666.5.1743'
valueset "General Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.255'
valueset "Glycoprotein IIb/IIIa Inhibitors": 'urn:oid:2.16.840.1.113762.1.4.1045.41'
valueset "Graduated compression stockings (GCS)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.256'
valueset "Gynecological Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.257'
valueset "Hemorrhagic Stroke": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.212'
valueset "Hip Fracture Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.258'
valueset "Hip Replacement Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.259'
valueset "Injectable Factor Xa Inhibitor for VTE Prophylaxis": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.211'
valueset "INR": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.213'
valueset "Intensive Care Unit": 'urn:oid:2.16.840.1.113762.1.4.1029.206'
valueset "Intermittent pneumatic compression devices (IPC)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.214'
valueset "Intracranial Neurosurgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.260'
valueset "Intravenous route": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.222'
valueset "Ischemic Stroke": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.247'
valueset "Knee Replacement Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.261'
valueset "Low Dose Unfractionated Heparin for VTE Prophylaxis": 'urn:oid:2.16.840.1.113762.1.4.1045.39'
valueset "Low Molecular Weight Heparin for VTE Prophylaxis": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.219'
valueset "Low Risk": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.400'
valueset "Medical Reason": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.473'
valueset "Mental Health Diagnoses": 'urn:oid:2.16.840.1.113883.3.464.1003.105.12.1004'
valueset "Obstetrics": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.263'
valueset "Obstetrics VTE": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.264'
valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.134'
valueset "Patient Refusal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.93'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Principal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.14'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Subcutaneous route": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.223'
valueset "Unfractionated Heparin": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.218'
valueset "Urological Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.272'
valueset "Venous foot pumps (VFP)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.230'
valueset "Venous Thromboembolism": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.279'
valueset "Warfarin": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.232'

code "Birth date": '21112-8' from "LOINC" display 'Birth date'
code "Risk for venous thromboembolism": '72136-5' from "LOINC" display 'Risk for venous thromboembolism'

context Patient

define "Denominator":
	"Initial Population"

define "Initial Population":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions"

define "No VTE Prophylaxis Device Applied or Ordered":
([Procedure: "Intermittent pneumatic compression devices (IPC)"]P where P.status='not-done')
		union ([Procedure: "Venous foot pumps (VFP)"]P where P.status='not-done')
		union ([Procedure: "Graduated compression stockings (GCS)"]P where P.status='not-done')
		union ([ServiceRequest: "Intermittent pneumatic compression devices (IPC)"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)
		union ([ServiceRequest: "Venous foot pumps (VFP)"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)
		union ([ServiceRequest: "Graduated compression stockings (GCS)"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)

define "No VTE Prophylaxis Medication Administered or Ordered":
([MedicationAdministration: "Low Dose Unfractionated Heparin for VTE Prophylaxis"]P where P.status='not-done')
		union ([MedicationAdministration: "Low Molecular Weight Heparin for VTE Prophylaxis"]P where P.status='not-done')
		union ([MedicationAdministration: "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]P where P.status='not-done')
		union ([MedicationAdministration: "Warfarin"]P where P.status='not-done')
		union ([MedicationRequest: "Low Dose Unfractionated Heparin for VTE Prophylaxis"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)
		union ([MedicationRequest: "Low Molecular Weight Heparin for VTE Prophylaxis"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)
		union ([MedicationRequest: "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)
		union ([MedicationRequest: "Warfarin"]SR where SR.intent!='order' and FHIRHelpers.ToBoolean(SR.doNotPerform) = true)

define "Encounter Less Than 2 Days":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where Global."LengthInDays"(QualifyingEncounter.period)< 2

define "Intervention Comfort Measures":
([ServiceRequest: "Comfort Measures"]SR where SR.intent='order')
		union ([Procedure: "Comfort Measures"]P where P.status='completed')

define "VTE Prophylaxis by Medication Administered or Device Applied":
	( [MedicationAdministration: "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
			where VTEMedication.dosage.route in "Subcutaneous route"
	)
		union [MedicationAdministration: "Low Molecular Weight Heparin for VTE Prophylaxis"]
		union [MedicationAdministration: "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
		union [MedicationAdministration: "Warfarin"]
		union ([Procedure: "Intermittent pneumatic compression devices (IPC)"]P where P.status='completed')
		union ([Procedure: "Venous foot pumps (VFP)"]P where P.status='completed')
		union ([Procedure: "Graduated compression stockings (GCS)"]P where P.status='completed')

define "Encounter With Principal Diagnosis of Mental Disorder or Stroke":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where Global.PrincipalDiagnosis(QualifyingEncounter).code in "Mental Health Diagnoses"
			or Global.PrincipalDiagnosis(QualifyingEncounter).code in "Hemorrhagic Stroke"
			or Global.PrincipalDiagnosis(QualifyingEncounter).code in "Ischemic Stroke"

define "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with ( [Procedure: "Hip Replacement Surgery"]
			union [Procedure: "Knee Replacement Surgery"] ) HipKneeProcedure
			such that HipKneeProcedure.status='completed'
        and (HipKneeProcedure.performed as Period) starts on or before end of QualifyingEncounter.period

define "No VTE Prophylaxis Medication or Device Due to Patient Refusal":
	( "No VTE Prophylaxis Medication Administered or Ordered"
		union "No VTE Prophylaxis Device Applied or Ordered" ) NoVTEProphylaxis
		where NoVTEProphylaxis.statusReason in "Patient Refusal"

define "Admission Without VTE or Obstetrical Conditions":
	Global."Inpatient Encounter" InpatientEncounter
		where not ( "EncounterDiagnosis"(InpatientEncounter)
		)

define "Encounter With ICU Location Stay 1 Day or More":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where "EncounterLocation"(QualifyingEncounter)

define "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE":
	( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
			with [Condition: "Atrial Fibrillation/Flutter"] AtrialFibrillation
				such that AtrialFibrillation.clinicalStatus.coding[0].code='active'
			and Interval[FHIRHelpers.ToDateTime(AtrialFibrillation.onset),FHIRHelpers.ToDateTime(AtrialFibrillation.abatement)] starts on or before
				end of QualifyingEncounter.period
	)
		union ( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
				where "EncounterCondition2"(QualifyingEncounter)
		)
		union ( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
				with [Condition: "Venous Thromboembolism"] VTEDiagnosis
					such that VTEDiagnosis.clinicalStatus.coding[0].code='active'
			and Interval[FHIRHelpers.ToDateTime(VTEDiagnosis.onset),FHIRHelpers.ToDateTime(VTEDiagnosis.abatement)] starts before start of QualifyingEncounter.period
		)

define "Is In Low Risk for VTE or On Anticoagulant":
	( [Observation: "Risk for venous thromboembolism"] VTERiskAssessment
			where VTERiskAssessment.status in {'final', 'amended','corrected'} and VTERiskAssessment.value in "Low Risk"
	)
	union "INR test performed"
	union "Other MedicationAdministration"

define "INR test performed":
	[Observation: "INR"] INRLabTest where FHIRHelpers.ToInteger(INRLabTest.value) > 3
		//return Observation { id: INRLabTest.id, issued: FHIRHelpers.ToDateTime(INRLabTest.issued) }

define "Other MedicationAdministration":
	( ( ( [MedicationAdministration: "Unfractionated Heparin"] UnfractionatedHeparin
			where UnfractionatedHeparin.dosage.route in "Intravenous route")
		union [MedicationAdministration: "Direct Thrombin Inhibitor"]
		union [MedicationAdministration: "Glycoprotein IIb/IIIa Inhibitors"] ) AnticoagulantMedication
		//return Observation { id: AnticoagulantMedication.id, effective: start of (AnticoagulantMedication.effective as Period) }
		)

define "No VTE Prophylaxis Device Due to Medical Reason From Day of Start of Hospitalization To Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
			such that NoVTEDevice.statusReason in "Medical Reason"
				and FHIRHelpers.ToDateTime(NoVTEDevice.authoredOn) during "FromDayOfStartOfHospitalizationToDayAfterAdmission"(QualifyingEncounter)

define "No VTE Prophylaxis Due to Patient Refusal From Day of Start of Hospitalization To Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
			such that FHIRHelpers.ToDateTime(PatientRefusal.effective) during "FromDayOfStartOfHospitalizationToDayAfterAdmission"(QualifyingEncounter)

define "Encounter With Low Risk for VTE or Anticoagulant Administered":
	"Low Risk for VTE or Anticoagulant Administered From Day of Start of Hospitalization To Day After Admission"
		union "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure"

define "Encounter With No VTE Prophylaxis Due to Patient Refusal":
	"No VTE Prophylaxis Due to Patient Refusal From Day of Start of Hospitalization To Day After Admission"
		union "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure"

define "Encounter With No VTE Prophylaxis Due to Medical Reason":
	( "No VTE Prophylaxis Medication Due to Medical Reason From Day of Start of Hospitalization To Day After Admission"
			intersect "No VTE Prophylaxis Device Due to Medical Reason From Day of Start of Hospitalization To Day After Admission"
	)
		union ( "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure"
				intersect "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure"
		)

define "Numerator":
	"Encounter With VTE Prophylaxis Received on Day of or Day After Admission or Procedure"
		union ( "Encounter With Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure"
				intersect ( "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE"
						union "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery"
				)
		)
		union "Encounter With Low Risk for VTE or Anticoagulant Administered"
		union "Encounter With No VTE Prophylaxis Due to Medical Reason"
		union "Encounter With No VTE Prophylaxis Due to Patient Refusal"

define "Low Risk for VTE or Anticoagulant Administered From Day of Start of Hospitalization To Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "Is In Low Risk for VTE or On Anticoagulant" LowRiskForVTE
			such that FHIRHelpers.ToDateTime(LowRiskForVTE.issued) during "FromDayOfStartOfHospitalizationToDayAfterAdmission"(QualifyingEncounter)

define "Encounter With Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure":
	( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
			with [MedicationAdministration: "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
				such that (FactorXaMedication.effective as Period) starts during TJC."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.period)
	)
		union ( from
				"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
				[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
				[MedicationAdministration: "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
				where AnesthesiaProcedure.status='completed' and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
					and (FactorXaMedication.effective as Period) starts during TJC."CalendarDayOfOrDayAfter"(
						end of (AnesthesiaProcedure.performed as Period)
					)
				return QualifyingEncounter
		)

define "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where AnesthesiaProcedure.status='completed' and NoVTEDevice.statusReason in "Medical Reason"
			and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
			and FHIRHelpers.ToDateTime(NoVTEDevice.authoredOn) during TJC."CalendarDayOfOrDayAfter"(
				end of (AnesthesiaProcedure.performed as Period)
			)
		return QualifyingEncounter

define "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
		where (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
			and FHIRHelpers.ToDateTime(PatientRefusal.authoredOn) during TJC."CalendarDayOfOrDayAfter"(
				end of (AnesthesiaProcedure.performed as Period)
			)
		return QualifyingEncounter

define "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where AnesthesiaProcedure.status='completed' and NoVTEMedication.statusReason in "Medical Reason"
			and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
			and FHIRHelpers.ToDateTime(NoVTEMedication.authoredOn) during TJC."CalendarDayOfOrDayAfter"(
				end of (AnesthesiaProcedure.performed as Period)
			)
		return QualifyingEncounter

define "Encounter With VTE Prophylaxis Received on Day of or Day After Admission or Procedure":
	( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
			with "VTE Prophylaxis by Medication Administered or Device Applied" VTEProphylaxis
				such that (VTEProphylaxis.effective as Period) starts during TJC."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.period)
	)
		union ( from
				"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
				[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
				"VTE Prophylaxis by Medication Administered or Device Applied" VTEProphylaxis
				where AnesthesiaProcedure.status='completed' and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
					and (VTEProphylaxis.effective as Period) starts during TJC."CalendarDayOfOrDayAfter"(
						end of (AnesthesiaProcedure.performed as Period)
					)
				return QualifyingEncounter
		)

define "Encounter With Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "Intervention Comfort Measures" ComfortMeasures
			such that Coalesce(start of (ComfortMeasures.occurrence as Period), FHIRHelpers.ToDateTime(ComfortMeasures.authoredOn))during "FromDayOfStartOfHospitalizationToDayAfterAdmission"(QualifyingEncounter)

define "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions":
	( Global."Inpatient Encounter" InpatientEncounter
			where AgeInYearsAt(start of InpatientEncounter.period)>= 18
	)
		intersect "Admission Without VTE or Obstetrical Conditions"

define "Encounter With Intervention Comfort Measures on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"Intervention Comfort Measures" ComfortMeasures
		where AnesthesiaProcedure.status='completed' and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
			and Coalesce(start of (ComfortMeasures.occurrence as Period), FHIRHelpers.ToDateTime(ComfortMeasures.authoredOn))during TJC."CalendarDayOfOrDayAfter"(
				end of (AnesthesiaProcedure.performed as Period)
			)
		return QualifyingEncounter

define "Denominator Exclusions":
	"Encounter Less Than 2 Days"
		union "Encounter With ICU Location Stay 1 Day or More"
		union "Encounter With Principal Diagnosis of Mental Disorder or Stroke"
		union "Encounter With Principal Procedure of SCIP VTE Selected Surgery"
		union "Encounter With Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission"
		union "Encounter With Intervention Comfort Measures on Day of or Day After Procedure"

define "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		[Procedure: "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"Is In Low Risk for VTE or On Anticoagulant" LowRiskForVTE
		where AnesthesiaProcedure.status='completed' and (AnesthesiaProcedure.performed as Period) ends 1 day after day of start of QualifyingEncounter.period
			and FHIRHelpers.ToDateTime(LowRiskForVTE.issued) during TJC."CalendarDayOfOrDayAfter"(
				end of (AnesthesiaProcedure.performed as Period)
			)
		return QualifyingEncounter

define "No VTE Prophylaxis Medication Due to Medical Reason From Day of Start of Hospitalization To Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
			such that NoVTEMedication.statusReason in "Medical Reason"
				and FHIRHelpers.ToDateTime(NoVTEMedication.authoredOn) during "FromDayOfStartOfHospitalizationToDayAfterAdmission"(QualifyingEncounter)

define "SCIP VTE Selected Surgery":
	//'SCIP' stands for surgical care improvement Project
([Procedure: "General Surgery"]
		union [Procedure: "Gynecological Surgery"]
		union [Procedure: "Hip Fracture Surgery"]
		union [Procedure: "Hip Replacement Surgery"]
		union [Procedure: "Intracranial Neurosurgery"]
		union [Procedure: "Knee Replacement Surgery"]
		union [Procedure: "Urological Surgery"])P where P.status='completed'

define "Encounter With Principal Procedure of SCIP VTE Selected Surgery":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with ( "SCIP VTE Selected Surgery" Procedure
//			where Procedure.ordinality in "Principal"
		) SelectedSCIPProcedure
			such that (SelectedSCIPProcedure.performed as Period) during QualifyingEncounter.period

define function "FromDayOfStartOfHospitalizationToDayAfterAdmission"(Enc Encounter):
	Interval[Global."ToDate"(start of Global."HospitalizationWithObservation"(Enc)), Global."ToDate"(start of Enc.period + 2 days))

define function "EncounterDiagnosis"(ValidEncounter Encounter):
	exists(singleton from (ValidEncounter.diagnosis EncounterDiagnosis
				where exists(EncounterDiagnosis.condition c where (c.reference.value='Condition/'+("GetCondition1").id.value
						or c.reference.value='Condition/'+("GetCondition2").id.value
						or c.reference.value='Condition/'+("GetCondition3").id.value
				)
			)
	))

define "GetCondition1":
	if exists([Condition:"Obstetrics"]C where C.clinicalStatus.coding[0].code = 'active') then singleton from([Condition:"Obstetrics"]) else null

define "GetCondition2":
  if exists([Condition:"Venous Thromboembolism"]C where C.clinicalStatus.coding[0].code = 'active') then singleton from([Condition:"Venous Thromboembolism"]) else null

define "GetCondition3":
  if exists([Condition:"Obstetrics VTE"]C where C.clinicalStatus.coding[0].code = 'active') then singleton from([Condition:"Obstetrics VTE"]) else null


define function "EncounterLocation"(QualifyingEncounter Encounter):
	exists(QualifyingEncounter.location loc
				where exists(loc.location c where (c.reference.value='Location/'+("GetLocation".id.value))
					and Global."LengthInDays"(loc.period)>= 1
					and loc.period starts during Interval[start of QualifyingEncounter.period, Global."ToDate"(start of QualifyingEncounter.period + 2 days)]
	))

define function "EncounterCondition2"(QualifyingEncounter Encounter):
	exists(singleton from (QualifyingEncounter.diagnosis EncounterDiagnosis
				where exists(EncounterDiagnosis.condition c where (c.reference.value='Condition/'+("Atrial Fibrillation/Flutter Condition").id.value
				)
			)
	))

define "Atrial Fibrillation/Flutter Condition":
	singleton from ([Condition: "Atrial Fibrillation/Flutter"] AtrialFibrillation
				where AtrialFibrillation.clinicalStatus.coding[0].code='active')
define "GetLocation":
		singleton from([Location:"Intensive Care Unit"] )