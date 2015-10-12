From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Mon, 12 Oct 2015 16:37:39 +0100
Message-ID: <20151012153738.GD6320@e104818-lin.cambridge.arm.com>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1444648628-24790-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48110 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbbJLPhn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 Oct 2015 11:37:43 -0400
Content-Disposition: inline
In-Reply-To: <1444648628-24790-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

On Mon, Oct 12, 2015 at 12:17:08PM +0100, Lorenzo Pieralisi wrote:
> ARM64 PSCI kernel interfaces that initialize idle states and implement
> the suspend API to enter them are generic and can be shared with the
> ARM architecture.
> 
> To achieve that goal, this patch moves ARM64 PSCI idle management
> code to drivers/firmware by creating a file that contains PSCI
> helper functions implementing the common kernel interface required
> by ARM and ARM64 to share the PSCI idle management code.
> 
> The ARM generic CPUidle implementation also requires the definition of
> a cpuidle_ops section entry for the kernel to initialize the CPUidle
> operations at boot based on the enable-method (ie ARM64 has the
> statically initialized cpu_ops counterparts for that purpose); therefore
> this patch also adds the required section entry on CONFIG_ARM for PSCI so
> that the kernel can initialize the PSCI CPUidle back-end when PSCI is
> the probed enable-method.
> 
> On ARM64 this patch provides no functional change.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/kernel/psci.c       |  99 +-----------------------------
>  drivers/firmware/Makefile      |   2 +-
>  drivers/firmware/psci_cpuops.c | 133 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/psci.h           |   3 +

For the arch/arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
