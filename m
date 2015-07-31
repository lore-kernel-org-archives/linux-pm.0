From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V3 00/16] OPP: Add code to support operating-points-v2
 bindings
Date: Fri, 31 Jul 2015 20:55:13 +0200
Message-ID: <26644874.9clcJiszPI@amdc1976>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45762 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbGaS4A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 14:56:00 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSD00XGB8LALUA0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Sat, 01 Aug 2015 03:55:58 +0900 (KST)
In-reply-to: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Wednesday, July 29, 2015 04:22:55 PM Viresh Kumar wrote:
> Hi Guys,
> 
> Resending this again because:
> - opp-hz is now 64 bit long and so that required a binding update.
> - There is another 4 patch series that as updating turbo OPP support,
>   along with updates to cpufreq core and cpufreq-dt driver.
> - A minor bug-fix in V2 4/11, which caused false positive for duplicate
>   OPPs in some cases.
> 
> Tested this on dual-core exynos board with the driver inbuilt as well as
> a module. Tried multiple insertion/removals of the module. Have tested
> cpufreq-dt driver with both old and new bindings.

I have tested these patches (including boost support) together with my
cpufreq-dt conversion patches for Exynos4x12 platforms on Odroid-U3 and
Trats2 boards.

Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

