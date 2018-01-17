From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Wed, 17 Jan 2018 10:27:46 +0000
Message-ID: <20180117102746.GE23988@e108498-lin.cambridge.arm.com>
References: <20180116165119.15168-1-quentin.perret@arm.com>
 <20180116165119.15168-2-quentin.perret@arm.com>
 <20180117053724.GL22978@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeAQK1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 05:27:51 -0500
Content-Disposition: inline
In-Reply-To: <20180117053724.GL22978@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com

Hi Viresh,

Thanks for the feedback !

On Wednesday 17 Jan 2018 at 11:07:24 (+0530), Viresh Kumar wrote:
> On 16-01-18, 16:51, Quentin Perret wrote:
> > +/**
> > + * dev_pm_opp_has_power() - Get the status of power values for OPPs
> > + * @cpu_dev:	CPU device for which we do this operation
> > + *
> > + * Return: True if the OPPs hold power estimates for the CPU
> > + */
> > +bool dev_pm_opp_has_power(struct device *cpu_dev)
> > +{
> > +	struct opp_table *opp_table;
> > +	bool has_power;
> > +
> > +	opp_table = _find_opp_table(cpu_dev);
> > +	if (IS_ERR(opp_table))
> > +		return false;
> > +
> > +	has_power = opp_table->capacitance;
> > +
> > +	dev_pm_opp_put_opp_table(opp_table);
> > +
> > +	return has_power;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_has_power);
> 
> I am not sure about the worthiness of this routine right now. Users
> can just ask for the power and that will be 0 if it is not available.
> 
> For the thermal stuff we can just check if the right property is
> present or not for the device (like we used to do), if we want to
> avoid running extra code there.
> 
> The point is I am not sure if this will be useful to multiple users of
> the power numbers or not and would like to wait to see more users
> before adding this API.

Right, I see your point. I'm happy to remove this but I'm just not sure
about calling of_find_property() in the thermal subsystem. The point of
this series is to make the thermal subsystem use a more abstract API so
checking if dynamic-power-coefficient is present is kind of against the
idea.

What I suggest is to call __cpufreq_cooling_register() with
has_power=true in of_cpufreq_cooling_register() and bail out from
update_freq_table() cleanly whenever dev_pm_opp_get_power() returns 0
(and in this case we fallback on the has_power=false path). Does that
make sense ?

> >  /**
> >   * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
> >   * @dev:	device for which we do this operation
> > @@ -1112,6 +1153,8 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> >  		goto free_opp;
> >  	}
> >  
> > +	_opp_estimate_power(new_opp);
> > +
> 
> Call this from _opp_add(), right after the call to ->get_pstate().

Ok.

> >  	/*
> >  	 * Notify the changes in the availability of the operable
> >  	 * frequency/voltage list.
> > @@ -1728,6 +1771,26 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
> >  	return r;
> >  }
> >  
> > +/**
> > + * _opp_estimate_power() -- helper to estimate power of an OPP
> > + * @opp:	OPP for which we want to do this
> > + *
> > + * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
> > + * capacitance, V the OPP's voltage and f the OPP's frequency.
> > + */
> 
> Don't need doc style comments for internal routines.

Some of them do have doc style comments (_opp_set_availaility() above
this function for ex) so I just wanted to stay consistent.

> > +void _opp_estimate_power(struct dev_pm_opp *opp)
> > +{
> > +	unsigned long capacitance = opp->opp_table->capacitance;
> > +	unsigned long mV, KHz, uW;
> > +
> > +	if (capacitance) {
> 
> Maybe just remove the if block, the result will anyway be zero here
> and that may be better than having an additional conditional
> statement.

Ok.

> 
> > +		mV = opp->supplies[0].u_volt / 1000;
> > +		KHz = opp->rate / 1000;
> > +		uW = capacitance * mV * mV * KHz / 1000000000;
> > +		opp->power_estimate_uw = uW;
> > +	}
> > +}
> > +
> >  /**
> >   * dev_pm_opp_enable() - Enable a specific OPP
> >   * @dev:	device for which we do this operation
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index cb716aa2f44b..607566c4fc9a 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -55,14 +55,17 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
> >  {
> >  	struct device_node *np;
> >  
> > -	/*
> > -	 * Only required for backward compatibility with v1 bindings, but isn't
> > -	 * harmful for other cases. And so we do it unconditionally.
> > -	 */
> >  	np = of_node_get(dev->of_node);
> >  	if (np) {
> >  		u32 val;
> >  
> > +		of_property_read_u32(np, "dynamic-power-coefficient",
> > +				     &opp_table->capacitance);
> > +
> > +		/*
> > +		 * Required for backward compatibility with v1 bindings, but
> > +		 * isn't harmful for other cases so we do it unconditionally.
> > +		 */
> >  		if (!of_property_read_u32(np, "clock-latency", &val))
> >  			opp_table->clock_latency_ns_max = val;
> >  		of_property_read_u32(np, "voltage-tolerance",
> > @@ -336,6 +339,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
> >  		goto free_opp;
> >  	}
> >  
> > +	_opp_estimate_power(new_opp);
> > +
> 
> This wouldn't be required after you move it to _opp_add().
> 
> >  	/* OPP to select on device suspend */
> >  	if (of_property_read_bool(np, "opp-suspend")) {
> >  		if (opp_table->suspend_opp) {
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index 4d00061648a3..cb331f9a565b 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -84,6 +84,8 @@ struct dev_pm_opp {
> >  
> >  	unsigned long clock_latency_ns;
> >  
> > +	unsigned long power_estimate_uw;
> > +
> >  	struct opp_table *opp_table;
> >  
> >  	struct device_node *np;
> > @@ -165,6 +167,8 @@ struct opp_table {
> >  	/* For backward compatibility with v1 bindings */
> >  	unsigned int voltage_tolerance_v1;
> >  
> > +	unsigned int capacitance;
> > +
> >  	enum opp_table_access shared_opp;
> >  	struct dev_pm_opp *suspend_opp;
> 
> There is documentation above the structure that you need to update.

Right, I will update it.

Thank you very much,
Quentin
