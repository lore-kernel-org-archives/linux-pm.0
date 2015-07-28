From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/4] cpufreq/opp: Turbo/boost mode support
Date: Tue, 28 Jul 2015 15:38:47 +0200
Message-ID: <2234559.Zs4Lk1DPT6@amdc1976>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <2445844.9YDNy0YEZL@amdc1976> <20150728121843.GA23710@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39254 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbG1Nj0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 09:39:26 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS702FJK9XOO110@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 28 Jul 2015 22:39:24 +0900 (KST)
In-reply-to: <20150728121843.GA23710@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org

On Tuesday, July 28, 2015 05:48:43 PM Viresh Kumar wrote:
> On 28-07-15, 13:55, Bartlomiej Zolnierkiewicz wrote:
> > Could you please tell me first how do you want me to fix the issue
> > with setting boost_supported flag in cpufreq driver structure?
> > 
> > For exynos-cpufreq driver we currently have:
> > 
> > #ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
> > 	.boost_supported = true,
> > #endif
> > 
> > With my original patches the config option stayed the same and
> > the flag was enabled if necessary in Exynos platform code and
> > passed through platform data to cpufreq-dt driver.  This is no
> > longer possible with your changes.
> > 
> > Should I enable it unconditionally in cpufreq-dt driver or add new
> > config option for cpufreq-dt driver (CONFIG_CPUFREQ_DT_BOOST_SW?)
> > for enabling boost_supported flag if necessary?
> 
> Look at my implementation, last two patches are already doing that.
> You don't need another change to get this working for you, neither are

I did look a them and they are lacking enabling of boost support flag
in cpufreq_dt driver structure.

There is also CONFIG_CPU_FREQ_BOOST_SW which needs to be enabled to
have boost frequencies in sysfs (code for that is in freq_table.c).

> those config options required. Get rid of them :)

Do you mean that we should now depend only on dts info for enabling
boost support and that CONFIG_CPU_FREQ_BOOST_SW should be removed
(together with CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

