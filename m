From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Thu, 29 Jan 2015 17:43:19 +0100
Message-ID: <54CA6327.5070707@free.fr>
References: <54B7F7CD.7030903@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020703030303040803070404"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:63739 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbbA2QnZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 11:43:25 -0500
In-Reply-To: <54B7F7CD.7030903@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

This is a multi-part message in MIME format.
--------------020703030303040803070404
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2015 18:24, Mason wrote:

> This is a follow-up to my previous thread.
> "How many frequencies would cpufreq optimally like to manage?"
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669

OK, so this is my TAKE 2 on the cpufreq driver, trying to remove
some dependencies on machine-specific definitions by getting the
virtual address at init via ioremap. (Is -EFAULT the right error
to return if ioremap fails?)

I'm not sure where machine-specific information is supposed to
be stored though? Such as register definitions, or the physical
addresses/offsets. What if they need to be shared among several
source files? I can't just duplicate them... (I've tentatively
called it temp.h for the time being.)

Regards.


--------------020703030303040803070404
Content-Type: text/x-csrc;
 name="cpufreq.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cpufreq.c"

/*
 * Copyright 2015 Sigma Designs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */
#include <linux/module.h>
#include <linux/cpufreq.h>
#include <linux/io.h>
#include "temp.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Sigma Designs");
MODULE_DESCRIPTION("cpufreq driver for Tangox 87xx");

#define TANGOX_XTAL_FREQ	27000 /* in kHz */
#define CLKGEN_BASE		0x10000
#define SYS_clkgen0_pll		(clkgen_base + 0x00)
#define SYS_cpuclk_div_ctrl	(clkgen_base + 0x24)

static void __iomem *clkgen_base;

static struct cpufreq_frequency_table freq_table[] = {
	{ .driver_data = 1 },
	{ .driver_data = 2 },
	{ .driver_data = 3 },
	{ .driver_data = 5 },
	{ .driver_data = 9 },
	{ .frequency = CPUFREQ_TABLE_END },
};

static unsigned int tangox_get_freq(unsigned int cpu)
{
	union SYS_clkgen_pll pll;
	union SYS_clk_div_ctrl div;

	pll.val = readl_relaxed(SYS_clkgen0_pll);
	if (pll.f.Isel != 1 || pll.f.M != 0) return 0;

	div.val = readl_relaxed(SYS_cpuclk_div_ctrl);
	if (div.f.BP != 0 || div.f.F != 0) return 0;

	return TANGOX_XTAL_FREQ * (pll.f.N + 1) / div.f.I >> pll.f.K;
}

static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
{
	while (readl_relaxed(SYS_cpuclk_div_ctrl) >> 31) cpu_relax();
	writel_relaxed(freq_table[index].driver_data, SYS_cpuclk_div_ctrl);
	return 0;
}

static int tangox_cpu_init(struct cpufreq_policy *policy)
{
	struct cpufreq_frequency_table *p;
	unsigned int freq = tangox_get_freq(0);
	unsigned int transition_latency_ns = freq / SYS_FAST_RAMP_SPEED;
	if ((clkgen_base = ioremap(CLKGEN_BASE, 0x40)) == NULL) return -EFAULT;

	for (p = freq_table; p->frequency != CPUFREQ_TABLE_END; ++p) {
		unsigned int I = p->driver_data;
		union SYS_clk_div_ctrl div = SYS_CLK_DIV_CTRL(I);
		p->driver_data = div.val;
		p->frequency = freq / I;
	}

	return cpufreq_generic_init(policy, freq_table, transition_latency_ns);
}

static struct cpufreq_driver tangox_cpufreq_driver = {
	.name		= "tangox-cpufreq",
	.init		= tangox_cpu_init,
	.verify		= cpufreq_generic_frequency_table_verify,
	.target_index	= tangox_target,
	.get		= tangox_get_freq,
	.exit		= cpufreq_generic_exit,
	.attr		= cpufreq_generic_attr,
};

static int __init tangox_cpufreq_init(void)
{
	return cpufreq_register_driver(&tangox_cpufreq_driver);
}

static void __exit tangox_cpufreq_exit(void)
{
	cpufreq_unregister_driver(&tangox_cpufreq_driver);
}

module_init(tangox_cpufreq_init);
module_exit(tangox_cpufreq_exit);

--------------020703030303040803070404--
