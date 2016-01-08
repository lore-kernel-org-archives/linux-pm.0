From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Use snprintf() instead of sprintf()
Date: Fri, 08 Jan 2016 01:48:39 +0100
Message-ID: <2522366.K4uaEZAV5b@vostro.rjw.lan>
References: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53458 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753000AbcAHARz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 19:17:55 -0500
In-Reply-To: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>

On Tuesday, January 05, 2016 04:15:54 PM Viresh Kumar wrote:
> sprintf() can access memory outside of the range of the character array,
> and is risky in some situations. The driver specified prop_name string
> can be longer than NAME_MAX here (only an attacker will do that though)
> and so blindly copying it into the character array of size NAME_MAX
> isn't safe. Instead we must use snprintf() here.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

> ---
>  drivers/base/power/opp/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index cd230c63aee6..cf351d3dab1c 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -808,7 +808,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  
>  	/* Search for "opp-microvolt-<name>" */
>  	if (dev_opp->prop_name) {
> -		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> +		snprintf(name, sizeof(name), "opp-microvolt-%s",
> +			 dev_opp->prop_name);
>  		prop = of_find_property(opp->np, name, NULL);
>  	}
>  
> @@ -849,7 +850,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  	/* Search for "opp-microamp-<name>" */
>  	prop = NULL;
>  	if (dev_opp->prop_name) {
> -		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
> +		snprintf(name, sizeof(name), "opp-microamp-%s",
> +			 dev_opp->prop_name);
>  		prop = of_find_property(opp->np, name, NULL);
>  	}
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
