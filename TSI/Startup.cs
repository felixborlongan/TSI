using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TSI.Startup))]
namespace TSI
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
