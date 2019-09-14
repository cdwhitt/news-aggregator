let generateArticle = () => {
  fetch('http://localhost:4567/random_article.json')
  .then(response => {
    if (response.ok) {
      return response;
    } else {
      let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
      throw(error);
    }
  })
  .then(response => response.json())
  .then(article => {
    let article_title = article["title"]
    let article_url = article["url"]
    let article_description = article["description"]
    document.getElementById("title").innerHTML = article_title
    document.getElementById("url").href = article_url
    document.getElementById("description").innerHTML = article_description
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`))
}

button = document.getElementById("random")
button.addEventListener("click", generateArticle)
