From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] cpufreq: dt: Identify cpu-sharing for platforms
 without operating-points-v2
Date: Mon, 25 Apr 2016 15:06:50 +0530
Message-ID: <20160425093650.GG32183@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <e42f0fdd6b67461a631ca9d966a52357bbc6cc75.1461228504.git.viresh.kumar@linaro.org>
 <20160422222736.GU13149@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422222736.GU13149@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-04-16, 15:27, Stephen Boyd wrote:
> On 04/21, Viresh Kumar wrote:
> > @@ -167,14 +167,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	/* Get OPP-sharing information from "operating-points-v2" bindings */
> >  	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
> >  	if (ret) {
> > +		if (ret != -ENOENT)
> > +			goto out_put_clk;
> > +
> >  		/*
> >  		 * operating-points-v2 not supported, fallback to old method of
> > -		 * finding shared-OPPs for backward compatibility.
> > +		 * finding shared-OPPs for backward compatibility if the
> > +		 * platform hasn't set sharing CPUs.
> >  		 */
> > -		if (ret == -ENOENT)
> > -			opp_v1 = true;
> > -		else
> > -			goto out_put_clk;
> > +		if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
> > +			fallback = true;
> 
> I'm sort of lost, we make the same call twice here. Why would the
> return value change between the first time and the second?

Two different APIs, which look similar :)

The first one tries to find the sharing-cpus relation from DT, the
other one is for v1 bindings and finds it due to platform code
dev_pm_opp_set_sharing_cpus() call.

-- 
viresh
