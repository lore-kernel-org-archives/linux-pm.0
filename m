From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 12/14] arm64: kernel: add cpu_{suspend}/{resume}
 build infrastructure
Date: Fri, 30 Aug 2013 18:32:30 +0100
Message-ID: <20130830173230.GL4650@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-13-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:53915 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753708Ab3H3RdT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2013 13:33:19 -0400
Content-Disposition: inline
In-Reply-To: <1377689766-17642-13-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dave P Martin <Dave.Martin@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On Wed, Aug 28, 2013 at 12:36:04PM +0100, Lorenzo Pieralisi wrote:
> To enable the suspend infrastructure for the ARM64 kernel the
> corresponding Kconfig and Makefile entries must be updated.
> 
> This patch adds a menu entry for power management options and
> entries to enable newly added suspend/resume implementation.
> 
> Makefile changes add appropriate entries to include corresponding
> files in the kernel image.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/Kconfig         | 12 ++++++++++++
>  arch/arm64/kernel/Makefile |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5855519..827d95e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -272,6 +272,18 @@ config SYSVIPC_COMPAT
>  
>  endmenu
>  
> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +config ARCH_SUSPEND_POSSIBLE
> +	def_bool y
> +
> +config ARM_CPU_SUSPEND
> +	def_bool y

I think we should call this ARM64_CPU_SUSPEND. The cpuidle drivers need
to be modified anyway since things like set_cr(), scu_power_mode() etc.
no longer apply. If a driver supports both, that's great, it can select
both ARM and ARM64.

Longer term, I would like a generic cpuidle driver for PSCI with DT
bindings for describing the sleep states, target residency (not sure how
this would look like yet).

-- 
Catalin
