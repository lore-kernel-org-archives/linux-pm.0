From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Tue, 12 May 2015 18:14:21 +0200
Message-ID: <555226DD.6050508@free.fr>
References: <55520F0F.5010906@free.fr> <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com> <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070209020201070407040905"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:41436 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbbELQOb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 12:14:31 -0400
In-Reply-To: <20150512155004.GP2067@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070209020201070407040905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/05/2015 17:50, Russell King - ARM Linux wrote:
> On Tue, May 12, 2015 at 05:14:15PM +0200, Mason wrote:
>> This ties in to another thread I started in LAKML:
>> ("High-resolution timers not supported when using smp_twd on Cortex A9")
>>
>> $ git show 5388a6b2 arch/arm/kernel/smp_twd.c
>> commit 5388a6b266e9c3357353332ba0cd5549082887f1
>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>> Date:   Mon Jul 26 13:19:43 2010 +0100
>>
>>     ARM: SMP: Always enable clock event broadcast support
>>     
>>     The TWD local timers are unable to wake up the CPU when it is placed
>>     into a low power mode, eg. C3.  Therefore, we need to adapt things
>>     such that the TWD code can cope with this.
>>     
>>     We do this by always providing a broadcast tick function, and marking
>>     the fact that the TWD local timer will stop in low power modes.  This
>>     means that when the CPU is placed into a low power mode, the core
>>     timer code marks this fact, and allows an IPI to be given to the core.
>>
>> This mentions a "broadcast tick function" (of which I know nothing).
>> Is this what you're referring to?
> 
> No.  This has nothing to do with low power modes.
> 
> How this works depends on how your kernel is configured, but essentially
> it's something like this:
> 
> * The CPU which will be idling sets its local timer to wake up after N
>   counter cycles, where N is calculated from the timer frequency.
> 
> * When the local timer fires, the CPU is kicked out of the idle loop, and
>   it reads the current system time.  If the current system time indicates
>   that the software timer set in schedule_timeout() has fired, that
>   software timer fires.
> 
> If the local timer changes frequency without the idling CPU being woken
> up, then the problem you're referring to can happen.
> 
> As you're not giving much information about your system (including
> indicating where we might see some source code) we're not able to help
> more than providing above descriptions.  Maybe if you posted your
> patches so far to support the project you're working on, we could
> provide better answers.

Hello Russell,

I am using as much generic code as I can.

I've attached my clock registration code and cpufreq platform
driver to this message.

I plan to set up a github repo in order to share my progress
while I try to mainline the port.

Regards.


--------------070209020201070407040905
Content-Type: text/x-csrc;
 name="clock-tangox.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clock-tangox.c"

#include <linux/clocksource.h>	/* clocksource_register_khz	*/
#include <linux/sched_clock.h>	/* sched_clock_register		*/
#include <linux/clk-provider.h>	/* clk_register_fixed_rate	*/
#include <linux/clkdev.h>	/* clk_register_clkdev		*/
#include <linux/delay.h>	/* register_current_timer_delay	*/
#include <asm/smp_twd.h>	/* twd_local_timer_register	*/
#include <asm/smp_scu.h>	/* scu_a9_get_base		*/

#define FAST_RAMP		1
#define XTAL_FREQ		27000000 /* in Hz */
#define CLKGEN_BASE		0x10000
#define SYS_clkgen0_pll		(clkgen_base + 0x00)
#define SYS_cpuclk_div_ctrl	(clkgen_base + 0x24)
#define SYS_xtal_in_cnt		(clkgen_base + 0x48)

static void __iomem *clkgen_base;

static unsigned long read_xtal_counter(void)
{
	return readl_relaxed(SYS_xtal_in_cnt);
}

static u64 read_sched_clock(void)
{
	return read_xtal_counter();
}

static cycle_t read_clocksource(struct clocksource *cs)
{
	return read_xtal_counter();
}

static struct clocksource tangox_xtal = {
	.name	= "tangox_xtal",
	.rating	= 300,
	.read	= read_clocksource,
	.mask	= CLOCKSOURCE_MASK(32),
	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
};

static struct delay_timer delay_timer = { read_xtal_counter, XTAL_FREQ };

#define pi_alert(format, ...) do {				\
	static char fmt[] __initdata = KERN_ALERT format;	\
	printk(fmt, ## __VA_ARGS__);				\
} while (0)

static int __init wrap_local_timer_register(void)
{
	unsigned long twd_base = scu_a9_get_base() + 0x600;
	struct twd_local_timer tangox_twd = {{
		DEFINE_RES_MEM(twd_base, 16), DEFINE_RES_IRQ(29)
	}};
	return twd_local_timer_register(&tangox_twd);
}

#define REG(name, ...) union name { struct { u32 __VA_ARGS__; }; u32 val; }

REG(SYS_clkgen_pll, N:7, :6, K:3, M:3, :5, Isel:3, :3, T:1, B:1);
/*
 * CG0, CG1, CG2, CG3 PLL Control:
 * -------------------------------
 *
 * |    Byte 3     |    Byte 2     |    Byte 1     |    Byte 0     |
 * |3 3 2 2 2 2 2 2|2 2 2 2 1 1 1 1|1 1 1 1 1 1    |               |
 * |1 0 9 8 7 6 5 4|3 2 1 0 9 8 7 6|5 4 3 2 1 0 9 8|7 6 5 4 3 2 1 0|
 * |-|-|-----|-----|---------|-----|-----|---------|-|-------------|
 * |B|T|xxxxx|Isel |xxxxxxxxx|  M  |  K  |xxxxxxxxx|x|      N      |
 * |-|-|-----|-----|---------|-----|-----|---------|-|-------------|
 *
 * These registers are used to configure the PLL parameters:
 *
 * Bits  6 to  0: N[6:0]. Default = 29
 * Bits 15 to 13: K[2:0]. Default = 1
 * Bit  18 to 16: M[2:0]. Default = 0
 * Bits 26 to 24: Isel[2:0] (PLL Input Select). Default = 1
 * Bits 30      : T (PLL Test). Default = 0
 * Bits 31      : B (PLL Bypass). Default = 0
 *
 * PLL0 : Out = In * (N+1) / (M+1) / 2^K
 * PLL1 : Same as PLL0
 * PLL2 : Same as PLL0
 * Default values : All PLLs configured to output 405MHz.
 */
static void __init tangox_clock_tree_register(void)
{
	struct clk *clk;
	unsigned int mul, div;
	union SYS_clkgen_pll pll;

	pll.val = readl_relaxed(SYS_clkgen0_pll);
	mul = pll.N + 1; div = (pll.M + 1) << pll.K;
	if (pll.Isel != 1) pi_alert("PLL0 source is not XTAL_IN!\n");

	clk = clk_register_fixed_rate(0, "XTAL", 0, CLK_IS_ROOT, XTAL_FREQ);
	if (!clk) pi_alert("Failed to register %s clk!\n", "XTAL");

	clk = clk_register_fixed_factor(0, "PLL0", "XTAL", 0, mul, div);
	if (!clk) pi_alert("Failed to register %s clk!\n", "PLL0");

	clk = clk_register_divider(0, "CPU_CLK", "PLL0", 0, SYS_cpuclk_div_ctrl, 8, 8, CLK_DIVIDER_ONE_BASED, 0);
	if (!clk) pi_alert("Failed to register %s clk!\n", "CPU_CLK");
	clk_register_clkdev(clk, NULL, "cpu_clk");

	clk = clk_register_fixed_factor(0, "PERIPHCLK", "CPU_CLK", 0, 1, 2);
	if (!clk) pi_alert("Failed to register %s clk!\n", "PERIPHCLK");
	clk_register_clkdev(clk, NULL, "smp_twd");

	writel_relaxed(FAST_RAMP << 21 | 1 << 8, SYS_cpuclk_div_ctrl);
}

void __init tangox_timer_init(void)
{
	int err;

	clkgen_base = ioremap(CLKGEN_BASE, 0x100);
	if (clkgen_base == NULL) return;

	register_current_timer_delay(&delay_timer);
	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);

	err = clocksource_register_hz(&tangox_xtal, XTAL_FREQ);
	if (err) pi_alert("Failed to register tangox_xtal clocksource!\n");

	tangox_clock_tree_register();

	err = wrap_local_timer_register();
	if (err) pi_alert("Failed to register local timer!\n");
}

--------------070209020201070407040905
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
 */
#include <linux/module.h>
#include <linux/cpufreq.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Sigma Designs");
MODULE_DESCRIPTION("cpufreq driver for Tangox");

static struct cpufreq_frequency_table freq_table[] = {
	{ .driver_data = 1 },
	{ .driver_data = 2 },
	{ .driver_data = 3 },
	{ .driver_data = 5 },
	{ .driver_data = 9 },
	{ .driver_data = 54 },
	{ .frequency = CPUFREQ_TABLE_END }
};

static int tangox_target(struct cpufreq_policy *policy, unsigned int idx)
{
	// TODO: MUST CHECK FOR IDLE BEFORE CALLING clk_set_rate()
	return clk_set_rate(policy->clk, freq_table[idx].frequency * 1000);
}

#define FAST_RAMP_SPEED 15 /* in kHz per nanosecond */

static int tangox_cpu_init(struct cpufreq_policy *policy)
{
	struct cpufreq_frequency_table *p;
	unsigned int freq, transition_latency;

	policy->clk = clk_get_sys("cpu_clk", NULL);
	freq = clk_get_rate(policy->clk) / 1000;
	transition_latency = freq / FAST_RAMP_SPEED;

	for (p = freq_table; p->frequency != CPUFREQ_TABLE_END; ++p) {
		p->frequency = freq / p->driver_data;
	}

	return cpufreq_generic_init(policy, freq_table, transition_latency);
}

static struct cpufreq_driver tangox_cpufreq_driver = {
	.name		= "tangox-cpufreq",
	.init		= tangox_cpu_init,
	.verify		= cpufreq_generic_frequency_table_verify,
	.target_index	= tangox_target,
	.get		= cpufreq_generic_get,
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

--------------070209020201070407040905--
