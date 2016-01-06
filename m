From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Wed, 6 Jan 2016 21:44:39 +0000
Message-ID: <20160106214439.GB19062@n2100.arm.linux.org.uk>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160105105900.GT19062@n2100.arm.linux.org.uk>
 <20160105123134.GA1821@red-moon>
 <20160105125142.GV19062@n2100.arm.linux.org.uk>
 <20160105132701.GA17214@red-moon>
 <20160105133447.GW19062@n2100.arm.linux.org.uk>
 <20160106165545.GA19886@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45084 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbcAFVoz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 16:44:55 -0500
Content-Disposition: inline
In-Reply-To: <20160106165545.GA19886@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On Wed, Jan 06, 2016 at 04:55:45PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 05, 2016 at 01:34:47PM +0000, Russell King - ARM Linux wrote:
> > That immediately worries me, because it bypasses the CPU dependencies
> > for ARM_CPU_SUSPEND implicitly applied via ARCH_SUSPEND_POSSIBLE.  I'd
> > prefer instead:
> > 
> > config ARM_PSCI_CPU_IDLE
> > 	def_bool ARM_PSCI_FW && CPU_IDLE && (!ARM || ARM_CPU_SUSPEND)
> 
> If you are not against it, I could make ARM_PSCI select ARM_CPU_SUSPEND,
> the CPU dependency would be taken into account (ie CPU_V7) and this
> would mirror what's done for the eg BL_SWITCHER.

If you're proposing to always build the code in psci.c when ARM_PSCI_FW
is enabled, I'd rather do this:

config ARM_CPU_SUSPEND
        def_bool PM_SLEEP || BL_SWITCHER || ARM_PSCI_FW
	depends on ARCH_SUSPEND_POSSIBLE

rather than have stuff select this option.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
