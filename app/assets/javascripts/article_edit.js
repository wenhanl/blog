$(function () {

    /**
     * Register ckeditor
     */
    CKEDITOR.replace("article_text", {
        filebrowserUploadUrl: '/uploader',
        imageBrowser_listUrl: "/uploads/image_list.json",
        codeSnippet_theme: 'monokai_sublime'
    });

    /**
     * Register click event handler to refresh cover image choices included in text area
     */
    $("#img-refresh").click(function () {
        var images = $(".cke_wysiwyg_frame").contents().find("img");
        var index = 1;
        $.each(images, function () {
            var newChoice = "<li>";
            newChoice += "<input type=\"radio\" name=\"article[img]\" value=\"" + this.src + "\" id=\"radio_" + index + "\" />";
            newChoice += "<label for=\"radio_" + index + "\"> <img src=\"" + this.src + "\" height=\"100\"/></label>";
            newChoice += "</li>";

            $("#cover-image").prepend(newChoice);
        });

        var defaultChoice = "<li><input type=\"radio\" name=\"article[img]\" value=\"null\" id=\"radio_" + index + "\" />";
        defaultChoice += "<label for=\"radio_" + index + "\"> Null</label></li>";
        $("#cover-image").append(defaultChoice);
    });

    $("#img-refresh").click();
});