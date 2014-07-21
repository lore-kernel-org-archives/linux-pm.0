From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 3/7] arm64: kernel: introduce cpu_init_idle CPU operation
Date: Mon, 21 Jul 2014 15:55:15 -0700
Message-ID: <53CD9A53.5070001@codeaurora.org>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com> <1405958786-17243-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:48086 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaGUWzR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 18:55:17 -0400
In-Reply-To: <1405958786-17243-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>, Geoff Levand <geoff@infradead.>

On 07/21/14 09:06, Lorenzo Pieralisi wrote:
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> new file mode 100644
> index 0000000..46eb3ea
> --- /dev/null
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -0,0 +1,27 @@
> +/*
> + * ARM64 CPU idle arch support
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <asm/cpu_ops.h>
> +
> +int cpu_init_idle(unsigned int cpu)

sparse will probably complain here unless we include <asm/cpuidle.h> right?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

