<%@ Page Language="C#" EnableViewState="false" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="soak_default" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <title>Soak - Mobile Intranet</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="ROBOTS" content="NOINDEX, NOFOLLOW, NOARCHIVE, NOSNIPPET">
    <meta name="description" content="Soak - Mobile Intranet">
    <link rel="icon" href="/account/favicon/intranet_icon.png" type="image/png" />
    <link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css' />
    <%: System.Web.Optimization.Styles.Render("~/account/css/spc") %>
</head>
<body>
    <div class="preloader" id="contentLoader">
        <div class="mdl-spinner mdl-js-spinner is-active"></div>
    </div>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--fixed-tabs ff-page" id="ff-page-home">
        <header class="mdl-layout__header mdl-layout--fixed-header">
            <div class="mdl-layout__header-row">
                <span class="mdl-layout-title">Feedback Frenzy</span>
                <div class="mdl-layout-spacer"></div>
                <a class="mdl-button mdl-js-button mdl-button--icon mdl-js-ripple-effect" href="/soak/">
                    <i class="material-icons">refresh</i>
                </a>
            </div>
            <div class="mdl-layout__tab-bar mdl-js-ripple-effect">
                <a href="#fixed-tab-1" class="mdl-layout__tab is-active" id="reqTab">Requests (<span id="requestsCount"></span>)</a>
                <a href="#fixed-tab-2" class="mdl-layout__tab" id="completedTab">Completed <span id="completedCount"></span></a>
            </div>
        </header>
        <div class="mdl-layout__drawer">
            <div class="side-nav-profile">
                <div class="side-nav-user">
                    <div class="side-nav-username"><asp:Literal runat="server" ID="litAccountName" ClientIDMode="Static" Text="" /></div>
                    <div class="side-nav-useremail"><asp:Literal runat="server" ID="litAccountEmail" ClientIDMode="Static" Text="" /></div>
                </div>
                <div class="side-nav-portrait">
                    <img src="/account/img/unnamed.png?w=64&h=64&mode=stretch" data-src="/account/img/unnamed.png?w=64&h=64&mode=stretch" width="64" height="64" class="side-nav-imgportrait unv" alt="" />
                </div>
                <div class="side-nav-coverphoto">
                    <div class="side-nav-backdrop"></div>
                    <div class="side-nav-backimg">
                        <asp:Image runat="server" ID="sidenavcover" AlternateText="" Width="360" Height="200" CssClass="unv" ImageUrl="/account/img/sea_of_fog.jpg?w=360&h=200&mode=stretch" ClientIDMode="Static" />
                    </div>
                </div>
            </div>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link" href="/m/">
                    <div class="mdl-navigation__icon"><i class="material-icons">home</i></div>
                    <div class="mdl-navigation__label">Home</div>
                </a>
                <a class="mdl-navigation__link" href="/m/directory">
                    <div class="mdl-navigation__icon"><i class="material-icons">people</i></div>
                    <div class="mdl-navigation__label">Directory</div>
                </a>
                <a class="mdl-navigation__link" href="/m/feedbackfrenzy">
                    <div class="mdl-navigation__icon"><i class="material-icons">whatshot</i></div>
                    <div class="mdl-navigation__label">Feedback Frenzy</div>
                </a>
                <div style="height: 1px;background-color: #e5e5e5;    margin: 6px 0;"></div>
                <a class="mdl-navigation__link" href="/account/servicelogout" target="_self">
                    <div class="mdl-navigation__icon"><i class="material-icons">vpn_key</i></div>
                    <div class="mdl-navigation__label">Sign out</div>
                </a>
            </nav>
        </div>

        <div class="mdl-layout__content">
            <section class="mdl-layout__tab-panel is-active" id="fixed-tab-1" >
                <div class="page-content" id="ff-body-home">

                </div>
            </section>
            <section class="mdl-layout__tab-panel" id="fixed-tab-2">
                <div class="page-content" id="ff-body-completed">
                    <div id="ff-list-completed">

                    </div>
                    <div id="btnGetMore" class="mdl-button mdl-js-button mdl-button--raised">Get more</div>
                </div>
            </section>
        </div>
        <div id="lnkReqFeedback" data-href="/soak/request-feedback" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored ff-route tap-link">
            <i class="material-icons">add</i>
        </div>
    </div>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header ff-page" id="ff-page-sendfeedback" style="display: none;">
        <header class="mdl-layout__header mdl-layout__header--waterfall">
            <div class="mdl-layout__header-row">
                <a href="#" data-href="/soak/" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon ff-route">
                    <i class="material-icons">arrow_back</i>
                </a>
                <span class="mdl-layout-title">Send Feedback</span>
                <div class="mdl-layout-spacer"></div>
                
            </div>
        </header>
        <div class="mdl-layout__content">
            <div class="page-content" id="ff-body-sendfeedback">
                <div class="master-container-field">
                    <div class="master-container-label">Send feedback for:</div>
                    <select class="master-select-container master-select-input" id="select-a-recipicant">

                    </select>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">Select a topic:</div>
                    <select class="master-select-container master-select-input" id="select-a-topic">
                        <option value="OR">OR</option>
                        <option value="Clinic">Clinic</option>
                        <option value="L&D">L&D</option>
                        <option value="ED">ED</option>
                        <option value="Inpatient">Inpatient</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">Date of feedback on</div>
                    <div class="master-select-container select-datepicker">
                        <input type="date" class="datepicker date-picker-box" id="feedback-date" />
                    </div>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">1. Strengths of performance:</div>
                    <div class="container-item">
                        <div class="mdl-textfield mdl-js-textfield">
                            <textarea class="mdl-textfield__input ff-textarea__input" rows="4" id="txtStrength" placeholder="Begin typing here"></textarea>
                        </div>
                    </div>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">2. Areas of improvement:</div>
                    <div class="container-item">
                        <div class="mdl-textfield mdl-js-textfield">
                            <textarea class="mdl-textfield__input ff-textarea__input" rows="4" id="txtImprovement"  placeholder="Begin typing here"></textarea>

                        </div>
                    </div>
                </div>
                <div class="master-container-field">
                    <div class="mdl-button mdl-js-button mdl-js-ripple-effect">Send feedback</div>
                </div>
                <div class="master-container-field">
                    <p>Once you have completed the feedback, the resident will recieve a notification of the feedback.</p>
                    <p>The Education Committee and Residents thanks you for your participation!</p>
                </div>
            </div>
        </div>
    </div>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header ff-page" id="ff-page-requestfeedback" style="display: none;">
        <header class="mdl-layout__header mdl-layout__header--waterfall">
            <div class="mdl-layout__header-row">
                <a href="#" data-href="/soak/" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon ff-route">
                    <i class="material-icons">arrow_back</i>
                </a>
                <span class="mdl-layout-title">Request Feedback</span>
                <div class="mdl-layout-spacer"></div>
            </div>
        </header>
        <div class="mdl-layout__content">
            <div class="page-content" id="ff-body-requestfeedback">
                <div class="master-container-field">
                    <div class="master-container-label">Request feedback from:</div>
                    <select class="master-select-container master-select-input" id="select-a-faculty">

                    </select>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">Select a topic:</div>
                    <select class="master-select-container master-select-input" id="select-a-general-topic">
                        <option value="OR">OR</option>
                        <option value="Clinic">Clinic</option>
                        <option value="L&D">L&D</option>
                        <option value="ED">ED</option>
                        <option value="Inpatient">Inpatient</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="master-container-field">
                    <div class="master-container-label">Select a date:</div>
                    <div class="master-select-container select-datepicker">
                        <input type="date" class="datepicker date-picker-box" id="request-date" />
                    </div>
                </div>
                <div class="master-container-field">
                    <p>The following feedback will be provided:</p>
                    <ol>
                        <li>Strength of today's performance</li>
                        <li>Areas of improvement</li>
                    </ol>
                    <div class="master-container-label">You may request additional feedback on (optional):</div>
                    <div class="container-item">
                        <div class="mdl-textfield mdl-js-textfield" style="width: 100%; display: block; padding: 0;">
                            <textarea class="mdl-textfield__input ff-textarea__input" rows="4" id="txtRequestQuestion"  placeholder="Begin typing here"></textarea>
                        </div>
                    </div>
                </div>
                <div class="master-container-field">
                    <div id="request-loadingContainer">
                        <div class="request-ProcesingLabel">Processing...</div>
                        <div class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
                    </div>
                    <div id="btnRequestFeedbackNow" class="mdl-button mdl-js-button mdl-js-ripple-effect">Request feedback</div>
                </div>
                <div class="master-container-field">
                    <p>Once you have requested feedback, the selected attending will recieve a notification of your request. Once they complete it, you will recieve a notification and the feedback.</p>
                    <p>The Education Committee thanks you for your participation!</p>
                </div>
            </div>
        </div>
    </div>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header ff-page" id="ff-page-completerequest" style="display: none;">
        <header class="mdl-layout__header mdl-layout__header--waterfall">
            <div class="mdl-layout__header-row">
                <a href="#" data-href="/soak/" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon ff-route">
                    <i class="material-icons">arrow_back</i>
                </a>
                <span class="mdl-layout-title">Complete request</span>
                <div class="mdl-layout-spacer"></div>
            </div>
        </header>
        <div class="mdl-layout__content">
            <div class="page-content" id="ff-body-completerequest">

            </div>
        </div>
    </div>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header ff-page" id="ff-page-requestdetails" style="display: none;">
        <header class="mdl-layout__header mdl-layout__header--waterfall">
            <div class="mdl-layout__header-row">
                <a href="#" data-href="/soak/" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon ff-route">
                    <i class="material-icons">arrow_back</i>
                </a>
                <span class="mdl-layout-title">Feedback Frenzy</span>
                <div class="mdl-layout-spacer"></div>
                <div id="btnDeleteRequest" class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--icon">
                    <i class="material-icons">delete</i>
                </div>
            </div>
        </header>
        <div class="mdl-layout__content">
            <div class="page-content" id="ff-body-requestdetails">

            </div>
        </div>
    </div>
    <%: System.Web.Optimization.Scripts.Render("~/account/js/spj") %>
    
</body>
</html>
