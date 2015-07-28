From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] cpufreq/opp: Turbo/boost mode support
Date: Tue, 28 Jul 2015 19:17:31 +0530
Message-ID: <20150728134731.GA12877@linux>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <2445844.9YDNy0YEZL@amdc1976>
 <20150728121843.GA23710@linux>
 <2234559.Zs4Lk1DPT6@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35042 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbbG1Nrh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 09:47:37 -0400
Received: by pdrg1 with SMTP id g1so71224989pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 06:47:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2234559.Zs4Lk1DPT6@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org

On 28-07-15, 15:38, Bartlomiej Zolnierkiewicz wrote:
> I did look a them and they are lacking enabling of boost support flag
> in cpufreq_dt driver structure.

That's insulting now, I forgot to add this:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 217928de2f0e..db4390ca5243 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2495,6 +2495,8 @@ int cpufreq_enable_boost_support(void)
 	if (cpufreq_boost_supported())
 		return 0;
 
+	cpufreq_driver->boost_supported = true;
+
 	/* This will get removed on driver unregister */
 	return create_boost_sysfs_file();
 }

So that is done from the above routine now.

> There is also CONFIG_CPU_FREQ_BOOST_SW which needs to be enabled to
> have boost frequencies in sysfs (code for that is in freq_table.c).

Yeah, we should get rid of that as well..

> > those config options required. Get rid of them :)
> 
> Do you mean that we should now depend only on dts info for enabling
> boost support and that CONFIG_CPU_FREQ_BOOST_SW should be removed
> (together with CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW)?

Yes.

-- 
viresh
