From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 10 Jan 2018 10:20:44 +0000
Message-ID: <20180110102044.GA25543@e108498-lin.cambridge.arm.com>
References: <20180109110252.13557-1-quentin.perret@arm.com>
 <20180109110252.13557-2-quentin.perret@arm.com>
 <20180110043625.GD3335@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeAJKUx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 05:20:53 -0500
Content-Disposition: inline
In-Reply-To: <20180110043625.GD3335@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

Hi Viresh,

On Wednesday 10 Jan 2018 at 10:06:25 (+0530), Viresh Kumar wrote:
> > +/**
> > + * dev_pm_opp_get_power() - Gets the estimated power corresponding to an opp
> > + * @opp:	opp for which power has to be returned for
> > + *
> > + * Return: estimated power in mirco-watts corresponding to the opp, else
> > + * return 0
> > + */
> > +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
> > +{
> > +	if (IS_ERR_OR_NULL(opp) || !opp->available) {
> 
> Drop the available check here.

Sure.

> > +/**
> > + * dev_pm_opp_of_estimate_power() - Estimates the power dissipated by @cpu_dev
> > + *                                  at each OPP.
> > + * @cpu_dev:	CPU device for which we do this estimation
> > + *
> > + * This estimates the active power consumed by a CPU at each OPP using:
> > + *                         P = C * V^2 * f
> > + * with P the power, C the CPU's capacitance, V the OPP's voltage and f the
> > + * OPP's frequency. V and f are assumed to be known by the time this function
> > + * is called and C is read from DT.
> > + *
> > + * Returns -EINVAL if the CPU's capacitance cannot be read from DT.
> > + */
> > +int dev_pm_opp_of_estimate_power(struct device *cpu_dev)
> 
> I wouldn't add this special function, but rather fill
> power_estimate_uW while creating the OPPs for the first time.

So that was actually my first idea as well but I struggled to come up
with a clean implementation TBH ...

My concern was mainly to get the dynamic-power-coefficient cleanly. With
the approach you proposed, there are cases (for platforms using
dev_pm_opp_add() such as Juno for ex) where I don't see how we can avoid
to re-read the capacitance from the DT for each and every OPP that's being
added. Or we have to rely on the driver to give it to us but that's against
changes that you pushed recently I think.

Do you think reading the "dynamic-power-coefficient" value from the DT
directly in dev_pm_add_opp() (and other places to support the v2 bindings)
would be acceptable ? Did you have something different in mind ?

Thanks,
Quentin
