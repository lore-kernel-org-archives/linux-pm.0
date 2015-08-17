From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v4 2/5] PM / OPP: add a function to get the voltage for
 disabled OPPs
Date: Mon, 17 Aug 2015 10:05:48 +0100
Message-ID: <20150817090548.GA2762@e104805>
References: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
 <1439575020-3447-3-git-send-email-javi.merino@arm.com>
 <20150815055925.GJ1162@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:55849 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753631AbbHQJGY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 05:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20150815055925.GJ1162@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "rufus.hamade@imgtec.com" <rufus.hamade@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Sat, Aug 15, 2015 at 06:59:25AM +0100, Viresh Kumar wrote:
> On 14-08-15, 18:56, Javi Merino wrote:
> > The OPP library is now used for power models to calculate the power
> > that a device would consume at a specific OPP.  To do that, we use a
> > simple power model which takes frequency and voltage as inputs.  We get
> > the voltage and frequency from the OPP library.
> > 
> > The devfreq cooling device for the thermal framework controls temperature
> > by disabling OPPs.  The power model needs to calculate the power that
> > would be consumed if we reenabled the OPP.  dev_pm_opp_get_voltage()
> > doesn't work for disabled OPPs.
> > 
> > Add a dev_pm_opp_get_voltage_always() that works both for enabled and
> > disabled OPPs to be used by the power model.  The documentation for this
> > function clearly states that you should use dev_pm_opp_get_voltage()
> > instead unless you know what you're doing.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/base/power/opp.c | 37 +++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h   |  7 +++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index 677fb2843553..b1a4216c7ec3 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -182,6 +182,43 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
> >  
> >  /**
> > + * dev_pm_opp_get_voltage_always() - Gets the voltage corresponding to an opp
> > + * @opp:	opp for which voltage has to be returned for
> > + *
> > + * This function is similar to dev_pm_opp_get_voltage() except that it
> > + * works for disabled opps as well.  In most cases, you want to
> > + * operate only on available opps so you should use
> > + * dev_pm_opp_get_voltage() instead.
> > + *
> > + * Return: voltage in micro volt corresponding to the opp, else
> > + * return 0
> > + *
> > + * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> > + * protected pointer. This means that opp which could have been fetched by
> > + * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
> > + * under RCU lock. The pointer returned by the opp_find_freq family must be
> > + * used in the same section as the usage of this function with the pointer
> > + * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
> > + * pointer.
> > + */
> > +unsigned long dev_pm_opp_get_voltage_always(struct dev_pm_opp *opp)
> > +{
> > +	struct dev_pm_opp *tmp_opp;
> > +	unsigned long v = 0;
> > +
> > +	opp_rcu_lockdep_assert();
> > +
> > +	tmp_opp = rcu_dereference(opp);
> > +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)))
> > +		pr_err("%s: Invalid parameters\n", __func__);
> > +	else
> > +		v = tmp_opp->u_volt;
> > +
> > +	return v;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_always);
> 
> I will rather update dev_pm_opp_get_voltage() and remove the
> 'available' check. There is no need for that.

Even better, I'll do that for the next version.

Cheers,
Javi
