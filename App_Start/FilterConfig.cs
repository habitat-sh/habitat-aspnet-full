using System.Web;
using System.Web.Mvc;

namespace habitat_aspnet_full
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
