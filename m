From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Mon, 25 Jan 2016 16:03:16 +0530
Message-ID: <20160125103316.GA9155@vireshk>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
 <20160112022022.GV22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35918 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbcAYKdT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 05:33:19 -0500
Received: by mail-pf0-f182.google.com with SMTP id n128so80057930pfn.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2016 02:33:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112022022.GV22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 18:20, Stephen Boyd wrote:
> > @@ -241,9 +234,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	}
> >  
> >  	priv->cpu_dev = cpu_dev;
> > -	priv->cpu_reg = cpu_reg;
> >  	policy->driver_data = priv;
> > -
> >  	policy->clk = cpu_clk;
> 
> Maybe we can have an dev_pm_opp_get_rate() API and a
> cpufreq_generic_opp_get() so we can get rid of policy->clk usage
> in this driver?

I thought about this today and couldn't get to a sane solution.
If we implement dev_pm_opp_get_rate(), then it should return the
cached value of the currently programmed OPP. If the OPP isn't set
yet, it can call clk_get_rate() and return that instead. But it
doesn't make any sense to always call clk_get_rate() from
dev_pm_opp_get_rate(), as that doesn't match its name.

OTOH, cpufreq really really needs a clk_get_rate() to happen, there
can be cases where the clk is changed by some other entity, specially
during suspend/resume and there are special checks in cpufreq about
that.

We can surely add a patch later if we get answer to this, but for now,
I will keep this patch as is.

-- 
viresh
