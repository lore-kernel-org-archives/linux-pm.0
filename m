From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/4] mvebu: Dove: Instantiate cpufreq driver.
Date: Mon, 21 Oct 2013 17:26:36 +0200
Message-ID: <20131021152636.GA23593@lunn.ch>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-3-git-send-email-andrew@lunn.ch>
 <52650644.9010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42887 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab3JUPbO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Oct 2013 11:31:14 -0400
Content-Disposition: inline
In-Reply-To: <52650644.9010208@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 21, 2013 at 11:47:32AM +0100, Sebastian Hesselbarth wrote:
> On 10/19/2013 01:37 PM, Andrew Lunn wrote:
> >Add a platform driver definition to instantiate the dove cpufreq
> >driver. Also indicate the ARCH has cpufreq support, so allowing the
> >cpufreq framework to be enabled.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> >  arch/arm/Kconfig                       |  1 +
> >  arch/arm/mach-dove/board-dt.c          |  2 ++
> >  arch/arm/mach-dove/common.c            | 36 ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-dove/common.h            |  1 +
> >  arch/arm/mach-dove/include/mach/dove.h |  1 +
> >  5 files changed, 41 insertions(+)
> >
> >diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >index 1ad6fb6..7744415 100644
> >--- a/arch/arm/Kconfig
> >+++ b/arch/arm/Kconfig
> >@@ -495,6 +495,7 @@ config ARCH_IXP4XX
> >
> >  config ARCH_DOVE
> >  	bool "Marvell Dove"
> >+	select ARCH_HAS_CPUFREQ
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select CPU_PJ4
> >  	select GENERIC_CLOCKEVENTS
> >diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
> >index 49f72a8..98202de 100644
> >--- a/arch/arm/mach-dove/board-dt.c
> >+++ b/arch/arm/mach-dove/board-dt.c
> >@@ -70,6 +70,8 @@ static void __init dove_dt_init(void)
> >  	/* Setup clocks for legacy devices */
> >  	dove_legacy_clk_init();
> >
> >+	dove_cpufreq_init();
> >+
> 
> What ever the outcome of "DT: blessing or curse" discussion at ELCE will
> be, are there any plans to probe the cpufreq/cpuidle drivers directly
> from DT? Someday, we want to get rid of .machine_init.

Hi Sebastian

This has already been discussed once for cpufreq drivers. I triggered
it with the kirkwood cpufreq driver. The outcome was that not
everything needs to the DT, platform drivers are still OK for things
which are not really devices. But as you say, the outcome from
Edinburgh might repeal that decision.

> >+	[1] = {
> >+		.start  = DOVE_PMU_PHYS_BASE + 0x8000,
> >+		.end    = DOVE_PMU_PHYS_BASE + 0x8004,
> 
> BASE + 0x8004 - 1 ?

Ah, yes, was thinking DT.

See you soon,

    Andrew
