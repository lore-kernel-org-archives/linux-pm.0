From: Mason <mpeg.blue@free.fr>
Subject: RFC on cpufreq implementation
Date: Thu, 15 Jan 2015 18:24:29 +0100
Message-ID: <54B7F7CD.7030903@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030405040903080604020101"
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405040903080604020101
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a follow-up to my previous thread.
"How many frequencies would cpufreq optimally like to manage?"
http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669

As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
based SoC (namely Tango4 from Sigma Designs). I'd like to get
some feedback on the cpufreq driver I wrote for that platform.

I decided to expose only a small subset of frequencies (namely
{999,500,333,111} MHz) because, in my tests, the ondemand gov
chose mostly min and max, and the intermediate frequencies not
so much; so I figured "2 intermediate freqs" is good enough.
(I'm ready to hear otherwise.)

I tried to use as much generic framework as possible, but I've
read about the clk framework, and it looks to be an even greater
generalization. Are new platforms encouraged to use that, rather
than provide a cpufreq driver? Does it work when voltage scaling
comes in play? (This SoC doesn't have it, but the next will.)

I'm also wondering how cpufreq and cpuidle interact? Is one a
subset of the other? Are they orthogonal?

Regards.

--------------030405040903080604020101
Content-Type: text/x-csrc;
 name="cpufreq.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cpufreq.c"

/*
 * Copyright 2014 Sigma Designs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */
#include <linux/module.h>
#include <linux/cpufreq.h>
#include <mach/tango4_gbus.h> /* gbus_read, gbus_write */
#include "temp.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Sigma Designs");
MODULE_DESCRIPTION("cpufreq driver for Tangox 87xx");

static struct cpufreq_frequency_table freq_table[] = {
	{ .driver_data = 1 },
	{ .driver_data = 2 },
	{ .driver_data = 3 },
	{ .driver_data = 9 },
	{ .frequency = CPUFREQ_TABLE_END },
};

static unsigned int tangox_get_freq(unsigned int cpu)
{
	union SYS_clkgen_pll pll;
	union SYS_clk_div_ctrl div;

	pll.val = gbus_read_reg32(SYS_clkgen0_pll);
	if (pll.f.Isel != 1 || pll.f.M != 0)
		return 0;

	div.val = gbus_read_reg32(SYS_cpuclk_div_ctrl);
	if (div.f.BP != 0 || div.f.F != 0)
		return 0;

	return TANGOX_XTAL_FREQ * (pll.f.N + 1) / div.f.I >> pll.f.K;
}

static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
{
	while (gbus_read_reg32(SYS_cpuclk_div_ctrl) >> 31)
		cpu_relax();
	gbus_write_reg32(SYS_cpuclk_div_ctrl, freq_table[index].driver_data);
	return 0;
}

static int tangox_cpu_init(struct cpufreq_policy *policy)
{
	struct cpufreq_frequency_table *p;
	unsigned int freq = tangox_get_freq(0);
	unsigned int transition_latency_ns = freq / SYS_FAST_RAMP_SPEED;

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

--------------030405040903080604020101
Content-Type: text/x-chdr;
 name="temp.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="temp.h"

#define SYS_clkgen0_pll     0x10000
#define SYS_cpuclk_div_ctrl 0x10024
#define TANGOX_XTAL_FREQ 27000

#define REG(name, ...) union name { struct { u32 __VA_ARGS__; } f; u32 val; }

REG(SYS_clkgen_pll, N:7, :6, K:3, M:3, :5, Isel:3, :3, T:1, B:1);
REG(SYS_clk_div_ctrl, F:4, :4, I:8, :4, RS:1, RE:2, BP:1, :7, BZ:1);

#define SYS_FAST_RAMP 1
#define SYS_FAST_RAMP_SPEED 15 /* in kHz per nanosecond */
#define SYS_CLK_DIV_CTRL(DI) {{ .I = DI, .RE = SYS_FAST_RAMP }}

--------------030405040903080604020101--
