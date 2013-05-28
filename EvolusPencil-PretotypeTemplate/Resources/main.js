(function() {
    function onCloseBtnClick() {
        this.parent().removeClass('visible');
    }

    function onOpenBtnClick() {
        this.parent().addClass('visible');
    }

    $('.open').on('click', onOpenBtnClick);
    $('.close').on('click', onCloseBtnClick);

    Path.map("#/page/:page_id").to(function(){
        var page_id = this.params['page_id'];
        $('.page').hide();
        $('#'+page_id).show();
    });

    Path.root("#/page/start");

    Path.listen();
}());