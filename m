From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Fix parsing of opp-microvolt and opp-microamp
 properties
Date: Thu, 17 Dec 2015 07:31:33 +0530
Message-ID: <20151217020133.GD3496@ubuntu>
References: <18360458.m71vGHrTb9@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <18360458.m71vGHrTb9@amdc1976>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-12-15, 16:41, Bartlomiej Zolnierkiewicz wrote:
> Commit 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name>'
> bindings") broke support for parsing standard opp-microvolt and
> opp-microamp properties.  Fix it by setting 'name' string to
> proper value for !dev_opp->prop_name cases.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name> 'bindings")
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This fixes Exynos4x12 cpufreq-dt support regression present in
> linux-pm/linux-next tree.  Rafael, please apply.  Thank you.
> 
>  drivers/base/power/opp/core.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: b/drivers/base/power/opp/core.c
> ===================================================================
> --- a/drivers/base/power/opp/core.c	2015-12-16 16:10:13.509171420 +0100
> +++ b/drivers/base/power/opp/core.c	2015-12-16 16:21:18.385183902 +0100
> @@ -806,11 +806,11 @@ static int opp_parse_supplies(struct dev
>  	struct property *prop = NULL;
>  	char name[NAME_MAX];
>  
> +	sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> +
>  	/* Search for "opp-microvolt-<name>" */
> -	if (dev_opp->prop_name) {
> -		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> +	if (dev_opp->prop_name)
>  		prop = of_find_property(opp->np, name, NULL);
> -	}
>  
>  	if (!prop) {
>  		/* Search for "opp-microvolt" */
> @@ -848,10 +848,10 @@ static int opp_parse_supplies(struct dev
>  
>  	/* Search for "opp-microamp-<name>" */
>  	prop = NULL;
> -	if (dev_opp->prop_name) {
> -		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
> +	sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
> +
> +	if (dev_opp->prop_name)
>  		prop = of_find_property(opp->np, name, NULL);
> -	}
>  
>  	if (!prop) {
>  		/* Search for "opp-microamp" */

Sorry about this. And I am disliking the solution suggested by Stephen
more and more now. Please resend this patch with following changes
instead:

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6c6856e426f0..a96df5cda303 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -816,7 +816,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
        if (!prop) {
                /* Search for "opp-microvolt" */
-               name[13] = '\0';
+               sprintf(name, "opp-microvolt");
                prop = of_find_property(opp->np, name, NULL);
 
                /* Missing property isn't a problem, but an invalid entry is */
@@ -857,7 +857,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
        if (!prop) {
                /* Search for "opp-microamp" */
-               name[12] = '\0';
+               sprintf(name, "opp-microamp");
                prop = of_find_property(opp->np, name, NULL);
        }

-- 
viresh
