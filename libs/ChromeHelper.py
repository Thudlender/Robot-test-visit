from selenium import webdriver
from selenium.webdriver.chrome.options import Options


class ChromeHelper:

    def get_chrome_options_with_binary(self, binary_path):
        options = Options()
        options.binary_location = binary_path
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        # Anti-bot detection options
        options.add_argument("--disable-blink-features=AutomationControlled")
        options.add_experimental_option("excludeSwitches", ["enable-automation"])
        options.add_experimental_option("useAutomationExtension", False)
        # User agent to mimic real browser
        options.add_argument(
            "--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        )
        return options