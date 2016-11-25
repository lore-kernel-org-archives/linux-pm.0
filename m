From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev
 list
Date: Fri, 25 Nov 2016 16:28:51 +0900
Message-ID: <5837E833.20007@samsung.com>
References: <CGME20161125065330epcas1p23c3bc3b47fde680f84d3b7c3252ad9ed@epcas1p2.samsung.com>
 <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56582 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbcKYH21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 02:28:27 -0500
In-reply-to: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>

On 11/25/2016 03:53 PM, Viresh Kumar wrote:
> Joonyoung Shim reported an interesting problem on his ARM octa-core
> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> was failing for a struct device for which dev_pm_opp_set_regulator() is
> called earlier.
> 
> This happened because an earlier call to
> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> removed all the entries from opp_table->dev_list apart from the last CPU
> device in the cpumask of CPUs sharing the OPP.
> 
> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> routines get CPU device for the first CPU in the cpumask. And so the OPP
> core failed to find the OPP table for the struct device.
> 
> This patch attempts to fix this problem by adding another field in the
> struct opp_device: inactive.
> 
> Instead of removing the entries from the list during
> dev_pm_opp_of_cpumask_remove_table() function call, we mark them as
> inactive. Such inactive devices will not be used by the core in most of
> the cases, like before, but will be used only at special places which
> need to take inactive devices into account.
> 
> All the devices are removed from the list together now and that happens
> only when the opp_table gets destroyed.
> 
> This patch is tested on Dual A15, Exynos5250 platform by compiling the
> cpufreq-dt driver as a module. The module is inserted/removed multiple
> times with combinations of CPU offline/online steps.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

It's working well during system suspend/resume on my Odroid-XU3 board.

Tested-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.
