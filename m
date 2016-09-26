From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
Date: Mon, 26 Sep 2016 09:25:11 +0530
Message-ID: <20160926035511.GG17336@vireshk-i7>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
 <20160829060801.GB5094@vireshk-i7>
 <20160912215515.GF7243@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160912215515.GF7243-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 12-09-16, 14:55, Stephen Boyd wrote:
> On 08/29, Viresh Kumar wrote:
> > On 18-08-16, 16:52, Finlye Xiao wrote:
> > > +static int rockchip_adjust_opp_table(struct device *cpu_dev,
> > > +				     struct cpufreq_frequency_table *table,
> > > +				     int volt)
> > > +{
> > > +	struct opp_table *opp_table;
> > > +	struct cpufreq_frequency_table *pos;
> > > +	struct dev_pm_opp *opp;
> > > +
> > > +	if (!volt)
> > > +		return 0;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	opp_table = _find_opp_table(cpu_dev);
> > > +	if (IS_ERR(opp_table)) {
> > > +		rcu_read_unlock();
> > > +		return PTR_ERR(opp_table);
> > > +	}
> > > +
> > > +	cpufreq_for_each_valid_entry(pos, table) {
> > > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * 1000,
> > > +						 true);
> > > +		if (IS_ERR(opp))
> > > +			continue;
> > > +
> > > +		opp->u_volt += volt;
> > > +		opp->u_volt_min += volt;
> > > +		opp->u_volt_max += volt;
> > > +	}
> > > +
> > > +	rcu_read_unlock();
> > > +
> > > +	return 0;
> > > +}
> > 
> > I wouldn't prefer altering the opp tables from individual drivers at all. At the
> > least, it should be done via some helpers exposed by the core.
> > 
> > But before that I would like to hear from Stephen a bit as I recall he was also
> > working on something similar.
> > 
> 
> I had a patch to modify the voltage at runtime for the "current"
> OPP. Now that we have regulator and clk control inside OPP that
> became a little easier to do without having to do some notifier
> from the OPP layer to the consumers. I haven't had time to revive
> those patches though. Should we do that?

Perhaps yes, we should have a common place for doing all that.

> Does this need to modify
> anything besides the OPP the device is currently running at?

Finlye, can you please answer this ?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
