From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: avoid maybe-uninitialized warning
Date: Fri, 16 Sep 2016 08:19:51 +0530
Message-ID: <20160916024950.GA6313@vireshk-i7>
References: <20160915153917.3001855-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34379 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcIPCtz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 22:49:55 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so22666513pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2016 19:49:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160915153917.3001855-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-09-16, 17:38, Arnd Bergmann wrote:
> When CONFIG_OPTIMIZE_INLINING is set and we are building with -Wmaybe-uninitialized
> enabled, we can get a warning for the opp core driver:
> 
> drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':
> drivers/base/power/opp/core.c:560:8: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This has only now appeared as a result of commit 797da5598f3a ("PM / devfreq:
> Add COMPILE_TEST for build coverage"), which makes the driver visible in
> some configurations that didn't have it before.
> 
> The warning is a false positive that I got with gcc-6.1.1, but there is
> a simple workaround in removing the local variables that we get warnings
> for (all three are affected depending on the configuration). This also
> makes the code easier to read.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/base/power/opp/core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index df0c70963d9e..4c7c6da7a989 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -584,7 +584,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	struct clk *clk;
>  	unsigned long freq, old_freq;
>  	unsigned long u_volt, u_volt_min, u_volt_max;
> -	unsigned long ou_volt, ou_volt_min, ou_volt_max;
>  	int ret;
>  
>  	if (unlikely(!target_freq)) {
> @@ -620,11 +619,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	}
>  
>  	old_opp = _find_freq_ceil(opp_table, &old_freq);
> -	if (!IS_ERR(old_opp)) {
> -		ou_volt = old_opp->u_volt;
> -		ou_volt_min = old_opp->u_volt_min;
> -		ou_volt_max = old_opp->u_volt_max;
> -	} else {
> +	if (IS_ERR(old_opp)) {
>  		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
>  			__func__, old_freq, PTR_ERR(old_opp));
>  	}
> @@ -683,7 +678,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  restore_voltage:
>  	/* This shouldn't harm even if the voltages weren't updated earlier */
>  	if (!IS_ERR(old_opp))
> -		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
> +		_set_opp_voltage(dev, reg, old_opp->u_volt,
> +				 old_opp->u_volt_min, old_opp->u_volt_max);
>  
>  	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
