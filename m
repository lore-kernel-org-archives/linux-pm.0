From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/5] PM / OPP: get the voltage for all OPPs
Date: Thu, 27 Aug 2015 16:28:11 +0530
Message-ID: <20150827105811.GV8784@linux>
References: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
 <1440672951-7002-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35793 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbH0K6Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 06:58:16 -0400
Received: by pacdd16 with SMTP id dd16so22118093pac.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2015 03:58:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440672951-7002-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, edubezval@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 27-08-15, 11:55, Javi Merino wrote:
> The OPP library is now used for power models to calculate the power
> that a device would consume at a specific OPP.  To do that, we use a
> simple power model which takes frequency and voltage as inputs.  We get
> the voltage and frequency from the OPP library.
> 
> The devfreq cooling device for the thermal framework controls
> temperature by disabling OPPs.  The power model needs to calculate the
> power that would be consumed if we reenabled the OPP.  Therefore, let
> dev_pm_opp_get_voltage() work for disabled OPPs.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/base/power/opp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 677fb2843553..3e5f7ae29ef9 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -150,7 +150,7 @@ static struct device_opp *_find_device_opp(struct device *dev)
>  }
>  
>  /**
> - * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an available opp
> + * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
>   * @opp:	opp for which voltage has to be returned for
>   *
>   * Return: voltage in micro volt corresponding to the opp, else
> @@ -172,7 +172,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  	opp_rcu_lockdep_assert();
>  
>  	tmp_opp = rcu_dereference(opp);
> -	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
> +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)))
>  		pr_err("%s: Invalid parameters\n", __func__);
>  	else
>  		v = tmp_opp->u_volt;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
