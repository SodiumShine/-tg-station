// Cold

/datum/disease/advance/cold/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Cold"
		symptoms = list(new/datum/symptom/sneeze)
	..(process, D, copy)


// Flu

/datum/disease/advance/flu/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Flu"
		symptoms = list(new/datum/symptom/cough)
	..(process, D, copy)


// Voice Changing

/datum/disease/advance/voice_change/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Epiglottis Mutation"
		symptoms = list(new/datum/symptom/voice_change)
	..(process, D, copy)


// Toxin Filter

/datum/disease/advance/heal/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Liver Enhancer"
		symptoms = list(new/datum/symptom/heal)
	..(process, D, copy)


// Hullucigen

/datum/disease/advance/hullucigen/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Reality Impairment"
		symptoms = list(new/datum/symptom/hallucigen)
	..(process, D, copy)


	// Rash
/datum/disease/advance/rash/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Rash"
		symptoms = list(new/datum/symptom/itching)
	..(process, D, copy)

	// dizzy
/datum/disease/advance/migraine/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Space brain"
		symptoms = list(new/datum/symptom/headache, new/datum/symptom/dizzy)
	..(process, D, copy)

// DORF VIRUS
/datum/disease/advance/dorf/New(var/process = 1, var/datum/disease/advance/D, var/copy = 0)
	if(!D)
		name = "Ambradorf Syndrome"
		symptoms = list(new/datum/symptom/cough, new/datum/symptom/beard, new/datum/symptom/choking)
	..(process, D, copy)