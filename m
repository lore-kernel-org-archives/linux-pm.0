From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/8] PM / OPP: Separate out _generic_opp_set_rate()
Date: Wed, 26 Oct 2016 11:37:31 +0530
Message-ID: <20161026060731.GJ9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <219e9ed658b4cef58ffeed09ac36af20523c7a46.1476952750.git.viresh.kumar@linaro.org>
 <20161025185907.GU26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33081 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcJZGIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 02:08:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id 197so9569722pfu.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 23:07:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161025185907.GU26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 25-10-16, 11:59, Stephen Boyd wrote:
> On 10/20, Viresh Kumar wrote:
> > Later patches would add support for custom opp_set_rate callbacks. This
> 
> I know the OPP consumer function has "rate" in the name, but it
> makes more sense to call the callback set_opp instead because we
> could be doing a lot more than setting the opp rate.

Done.

> > patch separates out the code for generic opp_set_rate handler in order
> > to prepare for that.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index 45c70ce07864..96f04392daef 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -596,6 +596,73 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
> >  	return ret;
> >  }
> >  
> > +static inline int
> > +_generic_opp_set_rate_clk_only(struct device *dev, struct clk *clk,
> > +			       unsigned long old_freq, unsigned long freq)
> > +{
> > +	int ret;
> > +
> > +	/* Change frequency */
> > +	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
> > +		__func__, old_freq, freq);
> 
> Perhaps this should stay at the beginning of OPP transitions?
> Otherwise it can get confusing when multiple switching OPP
> messages appear on OPP transition failures.

Done.

> > +struct clk;
> 
> Is struct regulator also forward declared?

Done now.

> >  struct dev_pm_opp;
> >  struct device;
> >  
> > @@ -24,6 +25,36 @@ enum dev_pm_opp_event {
> >  	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
> >  };
> >  
> > +/**
> > + * struct dev_pm_opp_supply - Power supply voltage/current values
> > + * @u_volt:	Target voltage in microvolts corresponding to this OPP
> > + * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
> > + * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
> > + * @u_amp:	Maximum current drawn by the device in microamperes
> > + *
> > + * This structure stores the voltage/current values for a single power supply.
> > + */
> > +struct dev_pm_opp_supply {
> > +	unsigned long u_volt;
> > +	unsigned long u_volt_min;
> > +	unsigned long u_volt_max;
> > +	unsigned long u_amp;
> > +};
> 
> This structure moved during this series. Can we avoid that and
> already have it in the right place to begin with?

Done.

> > +
> > +struct dev_pm_opp_info {
> > +	unsigned long rate;
> > +	struct dev_pm_opp_supply *supplies;
> > +};
> > +
> > +struct dev_pm_set_rate_data {
> 
> dev_pm_set_opp_data?

Done.

> > +	struct dev_pm_opp_info old_opp;
> > +	struct dev_pm_opp_info new_opp;
> > +
> > +	struct regulator **regulators;
> > +	unsigned int regulator_count;
> > +	struct clk *clk;
> > +};
> 
> The above two structures don't get kernel doc?

Done.

-- 
viresh
