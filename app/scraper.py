from playwright.sync_api import sync_playwright

def get_article_text(url):
    with sync_playwright() as p:
        # Launch browser in headless mode
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        try:
            # Navigate to the URL
            page.goto(url)

            # Wait for the article container to load
            page.wait_for_selector("div[class*='caas-body'], div[class*='body']", timeout=60000)

            # Extract paragraphs within the article container
            paragraphs = page.query_selector_all("div[class*='caas-body'] p, div[class*='body'] p")
            
            # Combine the text from all paragraph elements, excluding hyperlinks
            article_text = []
            for para in paragraphs:
                # Get the raw text from the paragraph
                para_text = para.inner_text()

                # Remove any text from hyperlinks within the paragraph
                links = para.query_selector_all("a")
                for link in links:
                    link_text = link.inner_text()
                    para_text = para_text.replace(link_text, "")  # Exclude link text
                
                # Add cleaned paragraph text to the article content
                article_text.append(para_text.strip())
            
            # Join all paragraphs into a single string
            return '\n'.join(article_text)

        except Exception as e:
            print(f"Error extracting article content from {url}: {e}")
            return None

        finally:
            browser.close()
