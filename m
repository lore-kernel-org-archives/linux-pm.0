From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/17] PM / OPP: Add dev_pm_opp_set_rate()
Date: Wed, 13 Jan 2016 11:21:57 +0530
Message-ID: <20160113055157.GE6050@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
 <20160112014010.GM22188@codeaurora.org>
 <20160112065832.GN1084@ubuntu>
 <20160113004936.GE22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33693 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcAMFwA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 00:52:00 -0500
Received: by mail-pf0-f175.google.com with SMTP id e65so75613370pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 21:52:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113004936.GE22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12-01-16, 16:49, Stephen Boyd wrote:
> Having a single mutex around the clock and voltage setting
> makes cpu frequency switching scalability drop to zero for
> devices that have independent clock and voltage supplies for each
> CPU. We need to get the voltage and frequency settings under rcu
> and then release rcu and change the hardware. This is already how
> cpufreq-dt is doing it anyway, so I'm lost how it can't be copied
> here into OPP framework.

Hmm. So what should we do about the clk/regulator issue I mentioned in
the other thread? How do we guarantee that the OPP doesn't get freed?

Should we implement a get/put regulator and clk within the OPP layer
using some sort of refcount ?

-- 
viresh
