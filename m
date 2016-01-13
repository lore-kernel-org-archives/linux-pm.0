From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/17] PM / OPP: Parse clock-latency and
 voltage-tolerance for v1 bindings
Date: Wed, 13 Jan 2016 11:05:34 +0530
Message-ID: <20160113053534.GC6050@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
 <20160112012905.GK22188@codeaurora.org>
 <20160112051413.GK1084@ubuntu>
 <20160113003650.GC22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33612 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbcAMFfj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 00:35:39 -0500
Received: by mail-pf0-f181.google.com with SMTP id e65so75387458pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 21:35:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113003650.GC22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12-01-16, 16:36, Stephen Boyd wrote:
> On 01/12, Viresh Kumar wrote:
> > On 11-01-16, 17:29, Stephen Boyd wrote:
> > > On 12/22, Viresh Kumar wrote:
> > > > @@ -580,6 +581,21 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
> > > >  		return NULL;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * Only required for backward compatibility with v1 bindings, but isn't
> > > > +	 * harmful for other cases. And so we do it unconditionally.
> > > > +	 */
> > > > +	np = of_node_get(dev->of_node);
> > > > +	if (np) {
> > > > +		u32 val;
> > > > +
> > > > +		if (!of_property_read_u32(np, "clock-latency", &val))
> > > > +			dev_opp->clock_latency_ns_max = val;
> > 
> > This is u64 type variable, but we are reading a 32 bit value from DT
> > and so wrote it that way.
> > 
> > > > +		of_property_read_u32(np, "voltage-tolerance",
> > > > +				     &dev_opp->voltage_tolerance_v1);
> > 
> > And this is u32 type.
> > 
> > > Why do we conditionalize the assignment for clock latency but not
> > > for voltage tolerance?
> > 
> > Nothing more than what I described earlier.
> > 
> 
> Ok.

Should I consider that an Reviewed-by ?

-- 
viresh
