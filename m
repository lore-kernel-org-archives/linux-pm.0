From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/8] PM / OPP: Don't use OPP structure outside of rcu
 protected section
Date: Tue, 25 Oct 2016 09:07:36 +0530
Message-ID: <20161025033736.GA9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <7a0754e64236db2a977c6a6402c222fea6dc866d.1476952750.git.viresh.kumar@linaro.org>
 <20161024225238.GR26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35757 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbcJYDhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 23:37:40 -0400
Received: by mail-pf0-f177.google.com with SMTP id s8so110524600pfj.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 20:37:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161024225238.GR26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 24-10-16, 15:52, Stephen Boyd wrote:
> On 10/20, Viresh Kumar wrote:
> > The OPP structure must not be used out of the rcu protected section.
> > Cache the values to be used in separate variables instead.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Was this found by visual inspection or through some static
> checker? Just curious.

Visual inspection :)

> > @@ -633,6 +634,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  		return ret;
> >  	}
> >  
> > +	if (IS_ERR(old_opp)) {
> > +		old_u_volt = 0;
> > +	} else {
> > +		old_u_volt = old_opp->u_volt;
> > +		old_u_volt_min = old_opp->u_volt_min;
> > +		old_u_volt_max = old_opp->u_volt_max;
> > +	}
> > +
> >  	u_volt = opp->u_volt;
> >  	u_volt_min = opp->u_volt_min;
> >  	u_volt_max = opp->u_volt_max;
> > @@ -677,9 +686,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  			__func__, old_freq);
> >  restore_voltage:
> >  	/* This shouldn't harm even if the voltages weren't updated earlier */
> > -	if (!IS_ERR(old_opp))
> > -		_set_opp_voltage(dev, reg, old_opp->u_volt,
> > -				 old_opp->u_volt_min, old_opp->u_volt_max);
> > +	if (old_u_volt) {
> 
> What if old_u_volt == 0 is valid?

How can that be valid ?

> We could have another variable
> like 'valid' or something that we use to figure out if we should
> set values instead. Then this isn't a potential pitfall.

I can do that but just wanted to know if we need that or not.

-- 
viresh
