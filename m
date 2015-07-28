From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] cpufreq/opp: Turbo/boost mode support
Date: Tue, 28 Jul 2015 17:48:43 +0530
Message-ID: <20150728121843.GA23710@linux>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <2445844.9YDNy0YEZL@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34461 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbbG1MSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 08:18:51 -0400
Received: by pdbbh15 with SMTP id bh15so70076544pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 05:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2445844.9YDNy0YEZL@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org

On 28-07-15, 13:55, Bartlomiej Zolnierkiewicz wrote:
> Could you please tell me first how do you want me to fix the issue
> with setting boost_supported flag in cpufreq driver structure?
> 
> For exynos-cpufreq driver we currently have:
> 
> #ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
> 	.boost_supported = true,
> #endif
> 
> With my original patches the config option stayed the same and
> the flag was enabled if necessary in Exynos platform code and
> passed through platform data to cpufreq-dt driver.  This is no
> longer possible with your changes.
> 
> Should I enable it unconditionally in cpufreq-dt driver or add new
> config option for cpufreq-dt driver (CONFIG_CPUFREQ_DT_BOOST_SW?)
> for enabling boost_supported flag if necessary?

Look at my implementation, last two patches are already doing that.
You don't need another change to get this working for you, neither are
those config options required. Get rid of them :)

-- 
viresh
