// Global
var _start = 0;
var _take = 10;
var _completedInitLoaded = false;
var _ffSendFeedbackInit = false;
var _ffRequestFeedbackInit = false;
var _currentId = "";
var showLoader;

// Global functions
function hideLoader() {
    $('#contentLoader').addClass('hide-loader');
    setTimeout(function () {
        $('#contentLoader').hide().removeClass('hide-loader');
    }, 600);
}
function infiniteLoad() {
    // Create JSON object
    var sendreq = {
        start: _start,
        take: _take
    };

    // Create AJAX request
    $.ajax({
        url: "/api/onthefly/infinite",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(sendreq),
        success: function (data) {
            var cards_template = $.templates('#ff-collection-list-tmpl');
            $('#ff-list-completed').append(cards_template.render(data));
            hideLoader();
            _completedInitLoaded = true;
            if (data.IsMore == true) {
                $('#btnGetMore').css('display', 'block');
            } else {
                $('#btnGetMore').hide();
            }
        },
        error: function (jqXHR, error, errorThrown) {
            console.log(jqXHR.responseText)
        }
    });
}

// feedback frenzy home
var ffHome = function () {
    _currentId = "";
    showLoader = setTimeout("$('#contentLoader').show()", 300);
    $.getJSON('/api/onthefly/pending', function (data) {
        var cards_template = $.templates('#ff-collection-cards-tmpl');
        $('#ff-body-home').empty().html(cards_template.render(data));
        $('#requestsCount').html(data.Total);
        if (data.UserType == 'Faculty') {
            $('#lnkSendFeedback').show();
            $('#lnkReqFeedback').remove();
        } else if (data.UserType == 'Resident') {
            $('#lnkReqFeedback').show();
            $('#lnkSendFeedback').remove();
        }
    }).done(function () {
        hideLoader();
        $('.ff-page').hide();
        $('#ff-page-home').show();

    });
};
var ffCompletedFeedback = function () {
    if (_completedInitLoaded == false) {
        $('#ff-list-completed').empty();
        showLoader = setTimeout("$('#contentLoader').show()", 300);
        infiniteLoad();
    }
}
var ffDetails = function (id) {
    _currentId = id;
    showLoader = setTimeout("$('#contentLoader').show()", 300);
    $.getJSON('/api/onthefly/request/' + id, function (data) {
        var request_template = $.templates('#ff-complete-request-tmpl');
        $('#ff-body-requestdetails').html(request_template.render(data.Request));

        var _type = data.UserType;
        var _status = data.Request.Status;
        if (_type == "Resident" && _status == "Pending") {
            $('#btnDeleteRequest').show();
        } else {
            $('#btnDeleteRequest').hide();
        }
    }).done(function () {
        hideLoader();
        $('.ff-page').hide();
        $('#ff-page-requestdetails').show();
        autosize($('textarea'));
    });
};
var ffSendFeedback = function () {
    _currentId = "";
    if (_ffSendFeedbackInit == false) {
        var tmog;
        showLoader = setTimeout("$('#contentLoader').show()", 300);
        $.getJSON('/api/onthefly/residents', function (data) {
            tmog = { SelectionList: data.Residents };
            var selection_template = $.templates('#ff-select-item-tmpl');
            $('#select-a-recipicant').html(selection_template.render(tmog));
        }).done(function () {
            hideLoader();
            _ffSendFeedbackInit = true;
            $('.ff-page').hide();
            $('#ff-page-sendfeedback').show();
            $('.mdl-layout__content', '#ff-page-sendfeedback').scrollTop(0);
        });
    } else {
        hideLoader();
        $('.ff-page').hide();
        $('#ff-page-sendfeedback').show();
        $('.ff-textarea__input').val('');
        $('.mdl-layout__content', '#ff-page-sendfeedback').scrollTop(0);
    }

};
var ffCompleteRequest = function (id) {
    _currentId = id;
    showLoader = setTimeout("$('#contentLoader').show()", 300);
    $.getJSON('/api/onthefly/request/' + id, function (data) {
        var complete_request_template = $.templates('#ff-complete-request-tmpl');
        $('#ff-body-completerequest').html(complete_request_template.render(data.Request));


        // Create progress bar
        var progressbar = document.createElement('div')
        progressbar.className = 'mdl-progress mdl-js-progress mdl-progress__indeterminate';
        progressbar.style.width = '100%';
        componentHandler.upgradeElement(progressbar);
        document.getElementById('loadingProgresBar').appendChild(progressbar);

        if (data.UserType == 'Faculty') {
            // Create button
            var feedbackbuttonNow = document.createElement('div');
            feedbackbuttonNow.className = 'mdl-button mdl-js-button mdl-js-ripple-effect ff-btn-mainaction';
            feedbackbuttonNow.id = 'btnSendFeedbackNow';
            feedbackbuttonNow.innerHTML = 'Send feedback';
            feedbackbuttonNow.dataset.reqid = id;
            componentHandler.upgradeElement(feedbackbuttonNow);
            document.getElementById('btnSendFeedbackContainer').appendChild(feedbackbuttonNow);
        }

        // <div class="mdl-button mdl-js-button mdl-js-ripple-effect" data-reqid="{{:RequestId}}" id="btnSendFeedbackNow" style="background-color: #2caa2c; color: #FFF; width: 60%; display: block; margin: 0 auto;padding:6px;">Send feedback</div>
    }).done(function () {
        hideLoader();
        $('.ff-page').hide();
        $('#ff-page-completerequest').show();
        autosize($('textarea'));
        $('.mdl-layout__content', '#ff-page-completerequest').scrollTop(0);
    });
};
var ffRequestFeedback = function () {
    _currentId = "";
    if (_ffRequestFeedbackInit == false) {
        var tmog;
        showLoader = setTimeout("$('#contentLoader').show()", 300);
        $.getJSON('/api/onthefly/attendings', function (data) {
            tmog = { SelectionList: data.Attendings };
            var selection_template = $.templates('#ff-select-item-tmpl');
            $('#select-a-faculty').html(selection_template.render(tmog));
        }).done(function () {
            hideLoader();
            _ffRequestFeedbackInit = true;
            $('.ff-page').hide();
            $('#ff-page-requestfeedback').show();
        });
    } else {
        hideLoader();
        $('.ff-page').hide();
        $('.ff-textarea__input').val('');
        $('#ff-page-requestfeedback').show();
    }
};
// end send feedback


var allroutes = function () {

};
var beforehit = function () {

};

// define the routing table.
var routes = {
    '/soak': {
        '/details/:id': ffDetails,
        '/request/:id': ffCompleteRequest,
        '/request-feedback': ffRequestFeedback,
        '/send-feedback': ffSendFeedback,
        '/': ffHome
    }
};

// instantiate the router.
var router = Router(routes);

// a global configuration setting.
router.configure({
    strict: false,
    html5history: true,
    convert_hash_in_init: true,
    //async: true,
    //recurse: 'forward',
    on: allroutes,
    before: beforehit
});
router.init();

// app.js
$(document).ready(function () {
    autosize($('textarea'));

    var $input = $('#feedback-date').pickadate({
        clear: '',
        close: 'Cancel',
        format: 'dddd, mmmm d, yyyy'
    });
    var picker = $input.pickadate('picker');
    picker.set('select', new Date());

    var $reqDate = $('#request-date').pickadate({
        clear: '',
        close: 'Cancel',
        format: 'dddd, mmmm d, yyyy'
    });

    var req_picker = $reqDate.pickadate('picker');
    req_picker.set('select', new Date());

    $('body').on('tap', '.btn-select-container', function (e) {
        e.preventDefault();
        $(this).toggleClass('active').next().slideToggle('fast');
        // $('#select-list').slideToggle('fast');
    });
    $('body').on('tap', '.recipicant-select-item', function (e) {
        e.preventDefault();
        var name = $(this).find('.selection-item-body').html();
        $('#btn-selection-made').html(name).parent().toggleClass('active');
        $('#select-recipicant-list').slideToggle('fast');

    });
    $('body').on('tap', '.topic-select-item', function (e) {
        e.preventDefault();
        var name = $(this).find('.selection-item-body').html();
        $('#subject-selection').html(name).parent().toggleClass('active');
        $('#subject-select-list').slideToggle('fast');
    });
    $('body').on('tap', '#completedTab', function (e) {
        ffCompletedFeedback();
    });
    $('body').on('tap', '#btnGetMore', function (e) {
        _start = _start + 10;
        $(this).hide();
        infiniteLoad();
    });
    $('body').on('tap', '.ff-route', function (e) {

        e.preventDefault();
        router.setRoute($(this).data('href'));
    });

    $('body').on('tap', '#btnSendFeedbackNow', function (e) {
        e.preventDefault();
        $(this).hide();
        $('#loadingContainer').show();
        var _strengths = $('#txtStrengthRequest').val();
        if (_strengths == "" || _strengths == null) {
            _strengths = null;
        }
        var _improvements = $('#txtImprovementRequest').val();
        if (_improvements == "" || _improvements == null) {
            _improvements = null;
        }
        var _answer = $('#txtAnswerRequest').val();
        if (_answer == "" || _answer == null) {
            _answer = null;
        }

        var _requestId = $(this).data('reqid');
        if (_requestId != null && _requestId != "") {

            // Create JSON object
            var sendreq = {
                RequestId: _requestId,
                Strengths: _strengths,
                Improvements: _improvements,
                Answer: _answer
            };

            // Create AJAX request
            $.ajax({
                url: "/api/onthefly/sendv2",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(sendreq),
                success: function (msg) {
                    router.setRoute('/soak/');
                    _completedInitLoaded = false;
                    $('#btnSendFeedbackNow').show();
                    $('#loadingContainer').hide();
                },
                error: function (jqXHR, error, errorThrown) {
                    console.log(jqXHR.responseText)
                }
            });

        }
    })

    $('body').on('tap', '#btnRequestFeedbackNow', function (e) {
        e.preventDefault();
        $(this).hide();
        $('#request-loadingContainer').show();

        var _selectedAttending = $('#select-a-faculty option:selected').val();

        if (_selectedAttending != null) {

            var _question = $('#txtRequestQuestion').val();
            var _topic = $('#select-a-general-topic option:selected').val();

            if (_question.trim() == "") {
                _question = null;
            }
            var sendreq = {
                FacultyId: _selectedAttending,
                Topic: _topic,
                Date: req_picker.get('select', 'mm/dd/yyyy'),
                Question: _question
            };

            $.ajax({
                url: "/api/onthefly/createv2",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(sendreq),
                success: function (msg) {
                    router.setRoute('/soak/');
                    $('#btnRequestFeedbackNow').show();
                    $('#request-loadingContainer').hide();
                },
                error: function (jqXHR, error, errorThrown) {
                    console.log(jqXHR.responseText)
                }
            });

        }
    });

    $('body').on('tap', '#btnDeleteRequest', function (e) {
        if (_currentId != null && _currentId != "") {

            // Create JSON object
            var sendreq = {
                id: _currentId
            };

            // Create AJAX request
            $.ajax({
                url: "/api/onthefly/removev2",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(sendreq),
                success: function (msg) {
                    router.setRoute('/soak/');
                    _completedInitLoaded = false;
                    $('#btnSendFeedbackNow').show();
                    $('#loadingContainer').hide();
                },
                error: function (jqXHR, error, errorThrown) {
                    console.log(jqXHR.responseText)
                }
            });
        }
    });
});