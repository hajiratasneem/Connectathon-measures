library DischargedonAntithromboticTherapy version '8.1.000'

using FHIR version '4.0.0'

include MATGlobalCommonFunctions version '4.0.000' called Global
include FHIRHelpers version '4.0.0' called FHIRHelpers
include TJC_Overall version '4.0.000' called TJC

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Antithrombotic Therapy": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.201'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Medical Reason": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.473'
valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Patient Refusal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.93'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'

context Patient

define "Antithrombotic Therapy at Discharge":
	[MedicationRequest: "Antithrombotic Therapy"]MR where MR.category.coding[0].code='discharge'

define "Denominator":
	TJC."Ischemic Stroke Encounter"

define "Numerator":
	TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
		with "Antithrombotic Therapy at Discharge" DischargeAntithrombotic
			such that FHIRHelpers.ToDateTime(DischargeAntithrombotic.authoredOn) during IschemicStrokeEncounter.period

define "Antithrombotic Not Given at Discharge":
	[MedicationRequest: "Antithrombotic Therapy"] NoAntithromboticDischarge
		where NoAntithromboticDischarge.category.coding[0].code='discharge'
      and FHIRHelpers.ToBoolean(NoAntithromboticDischarge.doNotPerform) = true
      and (NoAntithromboticDischarge.reasonCode in "Medical Reason"
			  or NoAntithromboticDischarge.reasonCode in "Patient Refusal")

define "Initial Population":
	TJC."Encounter with Principal Diagnosis and Age"

define "Denominator Exclusions":
	TJC."Ischemic Stroke Encounters with Discharge Disposition"
		union TJC."Comfort Measures during Hospitalization"

define "Encounter With No Antithrombotic At Discharge":
	TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
		with "Antithrombotic Not Given at Discharge" NoDischargeAntithrombotic
			such that FHIRHelpers.ToDateTime(NoDischargeAntithrombotic.authoredOn) during IschemicStrokeEncounter.period

define "Encounter With Ticagrelor During Hospitalization":
	TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
		with [MedicationAdministration: TJC."Ticagrelor Therapy"] Ticagrelor
			such that (Ticagrelor.effective as Period) starts during Global."HospitalizationWithObservation"(IschemicStrokeEncounter)

define "Denominator Exceptions":
	"Encounter With No Antithrombotic At Discharge"
		union "Encounter With Ticagrelor During Hospitalization"
