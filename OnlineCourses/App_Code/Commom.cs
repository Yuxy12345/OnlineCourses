using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

/// <summary>
/// Commom 的摘要说明
/// </summary>
public class Commom
{
    public void ShowErrorPage(HttpResponse response, string errMsg, string errPos, bool hasTitleBar)
    {
        string url = "~/Error.aspx?ErrorMsg={0}&ErrorPos={1}&HasTitleBar={2}";
        url = string.Format(url, errMsg, errPos, hasTitleBar.ToString());
        response.Redirect(url);
    }
    
}