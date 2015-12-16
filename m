From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management
 code to drivers/firmware
Date: Wed, 16 Dec 2015 21:57:45 +0100
Message-ID: <5671D049.1090802@linaro.org>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38824 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216AbbLPU5n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 15:57:43 -0500
Received: by mail-wm0-f50.google.com with SMTP id l126so56148104wml.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 12:57:43 -0800 (PST)
In-Reply-To: <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On 10/16/2015 06:02 PM, Lorenzo Pieralisi wrote:
> ARM64 PSCI kernel interfaces that initialize idle states and implemen=
t
> the suspend API to enter them are generic and can be shared with the
> ARM architecture.
>
> To achieve that goal, this patch moves ARM64 PSCI idle management
> code to drivers/firmware, so that the interface to initialize and
> enter idle states can actually be shared by ARM and ARM64 arches
> back-ends.
>
> The ARM generic CPUidle implementation also requires the definition o=
f
> a cpuidle_ops section entry for the kernel to initialize the CPUidle
> operations at boot based on the enable-method (ie ARM64 has the
> statically initialized cpu_ops counterparts for that purpose); theref=
ore
> this patch also adds the required section entry on CONFIG_ARM for PSC=
I so
> that the kernel can initialize the PSCI CPUidle back-end when PSCI is
> the probed enable-method.
>
> On ARM64 this patch provides no functional change.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arch/arm64]
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Jisheng Zhang <jszhang@marvell.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jisheng Zhang <jszhang@marvell.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

