From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 6/7] arm, arm64: factorize common cpu capacity default code
Date: Thu, 19 Jan 2017 14:53:34 +0000
Message-ID: <20170119145333.GB27312@n2100.armlinux.org.uk>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170119143757.14537-7-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170119143757.14537-7-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, gregkh@linuxfoundation.org, sudeep.holla@arm.com, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 19, 2017 at 02:37:56PM +0000, Juri Lelli wrote:
> +extern unsigned long
> +arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> +extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);

These should be in a header file (please run your code through sparse).

> +extern bool cap_parsing_failed;
> +extern void normalize_cpu_capacity(void);
> +extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);

Same for these.

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> new file mode 100644
> index 000000000000..3faf89518892
> --- /dev/null
> +++ b/drivers/base/arch_topology.c
> @@ -0,0 +1,240 @@
> +/*
> + * driver/base/arch_topology.c - Arch specific cpu topology information
> + *
> + * Written by: Juri Lelli, ARM Ltd.
> + *
> + * Copyright (C) 2016, ARM Ltd.
> + *
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

The files that you've taken this code from are GPLv2, but you've thrown
a GPLv2+ header on a file that's merely a copy of the original code.
As some of the code you've moved to this new file is from Nicolas and
Vincent, you need to seek their approval to make this change of license
terms, or keep the original license terms.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
