From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/5] PM / OPP: add a function to get the voltage for
 disabled OPPs
Date: Sat, 15 Aug 2015 11:29:25 +0530
Message-ID: <20150815055925.GJ1162@linux>
References: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
 <1439575020-3447-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34118 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbbHOF7a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 01:59:30 -0400
Received: by paccq16 with SMTP id cq16so29311965pac.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 22:59:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439575020-3447-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 14-08-15, 18:56, Javi Merino wrote:
> The OPP library is now used for power models to calculate the power
> that a device would consume at a specific OPP.  To do that, we use a
> simple power model which takes frequency and voltage as inputs.  We get
> the voltage and frequency from the OPP library.
> 
> The devfreq cooling device for the thermal framework controls temperature
> by disabling OPPs.  The power model needs to calculate the power that
> would be consumed if we reenabled the OPP.  dev_pm_opp_get_voltage()
> doesn't work for disabled OPPs.
> 
> Add a dev_pm_opp_get_voltage_always() that works both for enabled and
> disabled OPPs to be used by the power model.  The documentation for this
> function clearly states that you should use dev_pm_opp_get_voltage()
> instead unless you know what you're doing.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/base/power/opp.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h   |  7 +++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 677fb2843553..b1a4216c7ec3 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -182,6 +182,43 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>  
>  /**
> + * dev_pm_opp_get_voltage_always() - Gets the voltage corresponding to an opp
> + * @opp:	opp for which voltage has to be returned for
> + *
> + * This function is similar to dev_pm_opp_get_voltage() except that it
> + * works for disabled opps as well.  In most cases, you want to
> + * operate only on available opps so you should use
> + * dev_pm_opp_get_voltage() instead.
> + *
> + * Return: voltage in micro volt corresponding to the opp, else
> + * return 0
> + *
> + * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> + * protected pointer. This means that opp which could have been fetched by
> + * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
> + * under RCU lock. The pointer returned by the opp_find_freq family must be
> + * used in the same section as the usage of this function with the pointer
> + * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
> + * pointer.
> + */
> +unsigned long dev_pm_opp_get_voltage_always(struct dev_pm_opp *opp)
> +{
> +	struct dev_pm_opp *tmp_opp;
> +	unsigned long v = 0;
> +
> +	opp_rcu_lockdep_assert();
> +
> +	tmp_opp = rcu_dereference(opp);
> +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)))
> +		pr_err("%s: Invalid parameters\n", __func__);
> +	else
> +		v = tmp_opp->u_volt;
> +
> +	return v;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_always);

I will rather update dev_pm_opp_get_voltage() and remove the
'available' check. There is no need for that.

-- 
viresh
