From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 17 Dec 2014 14:04:04 +0000
Message-ID: <20141217140404.GB11998@red-moon>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2519415.GklIQeMgWR@wuerfel>
 <54903DC6.8010308@linaro.org>
 <2663853.2Q3kHisMT7@wuerfel>
 <549181F0.3010408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51168 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaLQOD7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 09:03:59 -0500
Content-Disposition: inline
In-Reply-To: <549181F0.3010408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lina Iyer <lina.iyer@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Dec 17, 2014 at 01:15:28PM +0000, Daniel Lezcano wrote:

[...]

> > I would assume that the same can be done for most other platforms.
> >
> > There are probably cases where the same piece of hardware is responsible
> > for both cpuidle and cpufreq, but what that means is really that you
> > should have a single driver for it that does both things. Same for
> > SMP support: if you have one register block that does both the SMP
> > bringup and the cpuidle stuff, then have *one* driver for this block
> > that does it all. There are currently a few dependencies that require
> > doing SMP bringup early during boot, but we decided years ago that those
> > are all artificial dependencies and we should be able to boot secondary
> > CPUs much later than we currently do.
> 
> I agree with this point and given the number of drivers, the easiest way 
> to do that is to create cpu pm ops as I gave in the previous email and 
> reuse them for cpu hotplug/bringup. And I believe that is possible if we 
> continue our approach by splitting the low level pm code from the 
> cpuidle driver.
> 
> What about doing something simple ? Like creating a struct 
> arm_cpu_pm_ops variable visible from everywhere and filled by the 
> different platform ?

I agree with this approach, which by the way consists in defining
cpu operations as ARM64 does and use those from cpuidle, suspend and
hotplug code. The MCPM interface does that already, probably we should
enhance/rename it since people think it must be used for multicluster
power management whereas it is a pretty generic [drivers -> mach] code
interface (I am talking about the API, not the synchronization scheme),
and can certainly be extended/refactored according to new platforms need.

Thanks,
Lorenzo
