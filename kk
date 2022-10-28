from web_functions import Web_Functions
from selenium.webdriver.common.action_chains import ActionChains

driver = Web_Functions.open_site('https://collegepulse.com/app/answer', user='peralta') 
Web_Functions.open_surveys_page(driver)
pulse = Web_Functions(user="peralta")

Web_Functions.wait_until_element_appears(driver, 'page-number ')
driver = pulse.open_site('https://collegepulse.com/app/answer') 
pulse.open_surveys_page()

pulse.wait_until_element_appears('page-number ')
page_numbers = driver.find_elements_by_class_name('page-number ')
print(f"SURVEY PAGES FOUND: {len(page_numbers)}\n")
time.sleep(5)

for i in range(1, len(page_numbers) + 1): 
    # click page_number
    Web_Functions.wait_until_element_appears(driver, str(i), By.ID)
    pulse.wait_until_element_appears(driver, str(i), By.ID)
    page_number = driver.find_element_by_id(str(i))
    print(f"... clicking page {page_number.text} button ...")
    Web_Functions.click(driver, page_number)
    pulse.click(page_number)

    time.sleep(3)
    surveys = Web_Functions.find_available_surveys(driver, type="all")
    surveys = pulse.find_available_surveys(type="all")
    web = surveys[0]
    mobile = surveys[1]
    web_stats = {"points": 0, "respondents": 0, "time": "00:00:00", "names": []}
@@ -33,14 +35,14 @@
        print(f"WEB: {survey_text}")
        web_stats["points"] += int(survey_text[0])
        web_stats["respondents"] += int(survey_text[3])
        web_stats["time"] = Web_Functions.add_times(web_stats['time'], survey_text[-1])
        web_stats["time"] = pulse.add_times(web_stats['time'], survey_text[-1])
        web_stats["names"].append(survey_text[2])
    for survey in mobile: 
        survey_text = survey.text.split('\n')
        print(f"MOBILE: {survey_text}")
        mobile_stats["points"] += int(survey_text[2])
        mobile_stats["respondents"] += int(survey_text[5])
        mobile_stats["time"] = Web_Functions.add_times(mobile_stats['time'], survey_text[-1])
        mobile_stats["time"] = pulse.add_times(mobile_stats['time'], survey_text[-1])
        mobile_stats["names"].append(survey_text[4])

        # write these stats to a file to keep track
@@ -53,9 +55,9 @@
    all_survey_stats["Mobile_Points_Available"] += mobile_stats["points"]
    all_survey_stats["Web_Points_Available"] += web_stats["points"]
    all_survey_stats["Total_Points_Available"] += mobile_stats["points"] + web_stats["points"]
    all_survey_stats["Web_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Web_Time_Expected"], web_stats['time'])
    all_survey_stats["Mobile_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Mobile_Time_Expected"], mobile_stats['time'])
    all_survey_stats["Total_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Web_Time_Expected"], all_survey_stats["Mobile_Time_Expected"])
    all_survey_stats["Web_Time_Expected"] = pulse.add_times(all_survey_stats["Web_Time_Expected"], web_stats['time'])
    all_survey_stats["Mobile_Time_Expected"] = pulse.add_times(all_survey_stats["Mobile_Time_Expected"], mobile_stats['time'])
    all_survey_stats["Total_Time_Expected"] = pulse.add_times(all_survey_stats["Web_Time_Expected"], all_survey_stats["Mobile_Time_Expected"])
    all_survey_stats["Web_Total_Respondents"] += web_stats["respondents"]
    all_survey_stats["Mobile_Total_Respondents"] += mobile_stats["respondents"]
    all_survey_stats["Total_Respondents"] += mobile_stats["respondents"] + web_stats["respondents"]
  26  
index_taken_surveys.py
@@ -6,25 +6,27 @@
from web_functions import Web_Functions
from selenium.webdriver.common.action_chains import ActionChains

driver = Web_Functions.open_site('https://collegepulse.com/app/analyze') 
pulse = Web_Functions(user="selenium")

Web_Functions.wait_until_element_appears(driver, 'page-number ')
driver = pulse.open_site('https://collegepulse.com/app/analyze') 

pulse.wait_until_element_appears('page-number ')
page_numbers = driver.find_elements_by_class_name('page-number ')
responses = Web_Functions.wait_until_element_appears(driver, 'responses', find_type = By.ID)
responses = pulse.wait_until_element_appears('responses', find_type = By.ID)
sort_by_responses_btn = driver.find_element_by_id('responses')
Web_Functions.click(driver, sort_by_responses_btn)
pulse.click(sort_by_responses_btn)
print(f"TAKEN SURVEY PAGES FOUND: {len(page_numbers)}\n")
time.sleep(5)

for i in range(1, len(page_numbers) + 1): 
    # click page_number
    Web_Functions.wait_until_element_appears(driver, str(i), By.ID)
    pulse.wait_until_element_appears(str(i), By.ID)
    page_number = driver.find_element_by_id(str(i))
    print(f"... clicking page {page_number.text} button ...")
    Web_Functions.click(driver, page_number)
    pulse.click(page_number)

    time.sleep(2.5)
    surveys = Web_Functions.find_available_surveys(driver, type="all")
    surveys = pulse.find_available_surveys(type="all")
    web = surveys[0]
    mobile = surveys[1]
    web_stats = {"questions": 0, "respondents": 0, "time": "00:00:00", "names": []}
@@ -35,14 +37,14 @@
        print(f"WEB: {survey_text}")
        web_stats["questions"] += int(survey_text[-2])
        web_stats["respondents"] += int(survey_text[2])
        web_stats["time"] = Web_Functions.add_times(web_stats['time'], survey_text[-1])
        web_stats["time"] = pulse.add_times(web_stats['time'], survey_text[-1])
        web_stats["names"].append(survey_text[1])
    for survey in mobile: 
        survey_text = survey.text.split('\n')
        print(f"MOBILE: {survey_text}")
        mobile_stats["questions"] += int(survey_text[-2])
        mobile_stats["respondents"] += int(survey_text[4])
        mobile_stats["time"] = Web_Functions.add_times(mobile_stats['time'], survey_text[-1])
        mobile_stats["time"] = pulse.add_times(mobile_stats['time'], survey_text[-1])
        mobile_stats["names"].append(survey_text[3])

    # write these stats to a file to keep track
@@ -55,9 +57,9 @@
    all_survey_stats["Mobile_Questions"] += mobile_stats["questions"]
    all_survey_stats["Web_Questions"] += web_stats["questions"]
    all_survey_stats["Total_Questions"] += mobile_stats["questions"] + web_stats["points"]
    all_survey_stats["Web_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Web_Time_Expected"], web_stats['time'])
    all_survey_stats["Mobile_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Mobile_Time_Expected"], mobile_stats['time'])
    all_survey_stats["Total_Time_Expected"] = Web_Functions.add_times(all_survey_stats["Web_Time_Expected"], all_survey_stats["Mobile_Time_Expected"])
    all_survey_stats["Web_Time_Expected"] = pulse.add_times(all_survey_stats["Web_Time_Expected"], web_stats['time'])
    all_survey_stats["Mobile_Time_Expected"] = pulse.add_times(all_survey_stats["Mobile_Time_Expected"], mobile_stats['time'])
    all_survey_stats["Total_Time_Expected"] = pulse.add_times(all_survey_stats["Web_Time_Expected"], all_survey_stats["Mobile_Time_Expected"])
    all_survey_stats["Web_Total_Respondents"] += web_stats["respondents"]
    all_survey_stats["Mobile_Total_Respondents"] += mobile_stats["respondents"]
    all_survey_stats["Total_Respondents"] += mobile_stats["respondents"] + web_stats["respondents"]
  18  
pulse_surveys.py
@@ -3,33 +3,35 @@
from selenium.webdriver.common.by import By
from web_functions import Web_Functions

driver = Web_Functions.open_site('https://collegepulse.com/app/answer', user='selenium') 
pulse = Web_Functions(user="selenium")

driver = pulse.open_site('https://collegepulse.com/app/answer') 

num_surveys = 300
surveys_completed = 0 
question_answers = Web_Functions.generate_answers(75)
question_answers = pulse.generate_answers(75)

while surveys_completed < num_surveys:

    # navigate to surveys page and sort by number of responses
    if not Web_Functions.open_surveys_page(driver): 
    if not pulse.open_surveys_page(): 
        print("No more surveys available! Quitting the bot")
        driver.quit()
        break

    # find all available web surveys, open the first available one 
    web_surveys = Web_Functions.find_available_surveys(driver)
    curr_survey = Web_Functions.open_survey(driver, web_surveys[0])
    web_surveys = pulse.find_available_surveys(driver)
    curr_survey = pulse.open_survey(web_surveys[0])
    start_time = time.time() # keep track of time survey started

    for question in curr_survey['question_btns']: 
        Web_Functions.answer_question(driver, question, question_answers)
        pulse.answer_question(question, question_answers)

    Web_Functions.submit_survey(driver)
    pulse.submit_survey()

    elapsed_time = time.time() - start_time # keep track of time bot took on survey

    Web_Functions.save_survey_stats(curr_survey['text'], elapsed_time)
    pulse.save_survey_stats(curr_survey['text'], elapsed_time)

    surveys_completed += 1
    print(f"\nSURVEY COMPLETED in {round(elapsed_time)} secs! surveys completed in this run: {surveys_completed}")
  10  
web_functions.py
@@ -16,12 +16,12 @@ class Web_Functions():
    Also designed for automated survey taking on the Pulse website 
    """

    def __init__(self, driver, user="selenium"):
    def __init__(self, user="selenium"):
        """
        Setup instance variables and class-level constants
        """
        self.STATS_FILE = r"tests\survey_stats\pulse_bot_stats.json"
        self.driver = driver
        self.driver = None # initialized to none, set in open_site
        self.user = user

    def click(self, element):
@@ -42,13 +42,13 @@ def open_site_new_session(self, url):
            r"C:\chromedriver_win32\chromedriver.exe", options=chrome_options)
        return self.redirect_to_page(url)

    def open_site(self, url, user="selenium"):
    def open_site(self, url):
        """ 
        Using a folder to save cookies, create a Chrome webdriver and open the website
        """
        # use a user-data-dir folder to save cookies and login info
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument(f"user-data-dir={user}")
        chrome_options.add_argument(f"user-data-dir={self.user}")

        # create a self.driver
        self.driver = webdriver.Chrome(
@@ -335,7 +335,7 @@ def submit_survey(self):
        self.click(final_submit_btn)
        self.check_if_too_fast()
        time.sleep(.5)
        

        # navigate back to the homepage to ensure we go back to survey answering page
        self.wait_until_element_appears('icon-container')
        pulse_logo_btn = self.driver.find_element_by_class_name(
