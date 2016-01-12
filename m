From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Tue, 12 Jan 2016 13:04:26 +0530
Message-ID: <20160112073426.GP1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
 <20160112022022.GV22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33820 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750AbcALHea (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 02:34:30 -0500
Received: by mail-pf0-f182.google.com with SMTP id q63so60251286pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 23:34:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112022022.GV22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 18:20, Stephen Boyd wrote:
> On 12/22, Viresh Kumar wrote:
> > OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
> > still need to check for availability of resources for deferred probing.
> 
> Why? It seems cleaner to let OPP layer return an error indicating
> probe defer or failure when we try to initialize it. That way we
> aren't duplicating the same logic in two places to figure out if
> a regulator or clock is ready.

cpufreq driver's ->init() callback doesn't return the error value
properly to the probe() function, and so it was done this way in the
first place. The problem is in subsys framework. I tried to fix it but
it was rejected and we need to fix it some other way:

http://marc.info/?l=linux-kernel&m=143530948918819&w=2

> >  	policy->clk = cpu_clk;
> 
> Maybe we can have an dev_pm_opp_get_rate() API and a
> cpufreq_generic_opp_get() so we can get rid of policy->clk usage
> in this driver?

Okay, will do.

-- 
viresh
