From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
Date: Mon, 12 Sep 2016 14:55:15 -0700
Message-ID: <20160912215515.GF7243@codeaurora.org>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
 <20160829060801.GB5094@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50345 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbcILVzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 17:55:19 -0400
Content-Disposition: inline
In-Reply-To: <20160829060801.GB5094@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Finlye Xiao <finley.xiao@rock-chips.com>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, heiko@sntech.de, robh+dt@kernel.org, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, mark.rutland@arm.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, jay.xu@rock-chips.com, rocky.hao@rock-chips.com, tim.chen@rock-chips.com, tony.xie@rock-chips.com, ulysses.huang@rock-chips.com, lin.huang@rock-chips.com

On 08/29, Viresh Kumar wrote:
> On 18-08-16, 16:52, Finlye Xiao wrote:
> > +static int rockchip_adjust_opp_table(struct device *cpu_dev,
> > +				     struct cpufreq_frequency_table *table,
> > +				     int volt)
> > +{
> > +	struct opp_table *opp_table;
> > +	struct cpufreq_frequency_table *pos;
> > +	struct dev_pm_opp *opp;
> > +
> > +	if (!volt)
> > +		return 0;
> > +
> > +	rcu_read_lock();
> > +
> > +	opp_table = _find_opp_table(cpu_dev);
> > +	if (IS_ERR(opp_table)) {
> > +		rcu_read_unlock();
> > +		return PTR_ERR(opp_table);
> > +	}
> > +
> > +	cpufreq_for_each_valid_entry(pos, table) {
> > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * 1000,
> > +						 true);
> > +		if (IS_ERR(opp))
> > +			continue;
> > +
> > +		opp->u_volt += volt;
> > +		opp->u_volt_min += volt;
> > +		opp->u_volt_max += volt;
> > +	}
> > +
> > +	rcu_read_unlock();
> > +
> > +	return 0;
> > +}
> 
> I wouldn't prefer altering the opp tables from individual drivers at all. At the
> least, it should be done via some helpers exposed by the core.
> 
> But before that I would like to hear from Stephen a bit as I recall he was also
> working on something similar.
> 

I had a patch to modify the voltage at runtime for the "current"
OPP. Now that we have regulator and clk control inside OPP that
became a little easier to do without having to do some notifier
from the OPP layer to the consumers. I haven't had time to revive
those patches though. Should we do that? Does this need to modify
anything besides the OPP the device is currently running at?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
