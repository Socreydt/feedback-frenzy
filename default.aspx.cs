using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Security;
using System.Web.Script.Serialization;
using UserData;
public partial class soak_default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated)
            {
                FormsIdentity id = (FormsIdentity)Page.User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                UserDataCookie userData = new JavaScriptSerializer().Deserialize<UserDataCookie>(ticket.UserData);
                litAccountName.Text = "<span id='intranet-id' data-authslug='" + userData.Slug + "' data-isauthenticated='True' data-authfullname='" + userData.FullName + "'>" + userData.FirstName + " " + userData.LastName + " " + userData.Suffix + "</span>";
                if (userData.CoverPhoto != null && userData.CoverPhoto != "")
                {
                    sidenavcover.ImageUrl = "/" + userData.CoverPhoto + "?w=360&h=200&mode=stretch";
                }
                litAccountEmail.Text = userData.Email;
            }
        }
    }
}