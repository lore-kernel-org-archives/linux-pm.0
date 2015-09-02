From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/3] cpufreq: dt: Tolerance applies on both sides of
 target voltage
Date: Wed, 02 Sep 2015 11:39:45 +0200
Message-ID: <1441186785.3137.2.camel@pengutronix.de>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
	 <4166ff63e1992adefd757cd3774e841e137024f9.1441184706.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59980 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbIBJjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 05:39:47 -0400
In-Reply-To: <4166ff63e1992adefd757cd3774e841e137024f9.1441184706.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

Am Mittwoch, den 02.09.2015, 14:36 +0530 schrieb Viresh Kumar:
> Tolerance applies on both sides of the target voltage, i.e. both min and
> max sides.

While I'm not really comfortable with the above, it is exactly how OPPv1
and the voltage tolerance property are specified.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> But while checking if a voltage is supported by the regulator
> or not, we haven't taken care of tolerance on the lower side. Fix that.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Fixes: 045ee45c4ff2 ("cpufreq: cpufreq-dt: disable unsupported OPPs")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index b1131cf89757..3b64c203bf99 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -303,7 +303,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  			rcu_read_unlock();
>  
>  			tol_uV = opp_uV * priv->voltage_tolerance / 100;
> -			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
> +			if (regulator_is_supported_voltage(cpu_reg,
> +							   opp_uV - tol_uV,
>  							   opp_uV + tol_uV)) {
>  				if (opp_uV < min_uV)
>  					min_uV = opp_uV;

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

