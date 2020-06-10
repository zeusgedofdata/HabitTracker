import Fit
import Daylio

fit = Fit.GoogleFitImporter()
daily = Daylio.DaylioImporter()


fit.import_fit_data()
daily.ingest_data()

