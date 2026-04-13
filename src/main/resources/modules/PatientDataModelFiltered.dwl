%dw 2.0
output application/json
---
vars.role match {
	case "patient" -> vars.patientDataModel update {
		case .medicalRecord.history -> $ map (consultation) -> (consultation -- [ //Remove the clinicalNotes, bloodPressure and temperature fields for the patient
	        "clinicalNotes",
	        "bloodPressure",
	        "temperature"
	    ])
		case .laboratoryResults -> $ map (result) -> result - "technician" //Remove the technician field for the patient
		case .radiologyResults -> $ map (result) -> (result -- [ //Remove the urgency and radiologist fields for the patient
			"urgency",
			"radiologist"
		])
	}
	else -> vars.patientDataModel
}
