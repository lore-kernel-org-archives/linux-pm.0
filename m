From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 19:02:09 +0000
Message-ID: <20160215190208.GM10826@n2100.arm.linux.org.uk>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 07:41:21PM +0100, Rafael J. Wysocki wrote:
> Since this is ARM, arch_send_call_function_single_ipi() looks like this:
> 
> void arch_send_call_function_single_ipi(int cpu)
> {
>          smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
> }
> 
> so I'm not sure how the NULL pointer deref is possible even.

smp_cross_call() is a function pointer, and the hint is:

> I need help from somebody who knows how this low-level stuff works on ARM.
> 
> > [    1.340000] pc : [<00000000>]    lr : [<c030de78>]    psr: 20000193

here that the PC is zero.  It's initialised via set_smp_cross_call(),
which should be happening in drivers/irqchip/irq-gic.c for SMP
capable systems.

However, looking at this, this is an OMAP34xx based Beagle board, which
is a single CPU SoC.  There are no other CPUs to send IPIs to.

> > [    1.340000] sp : cb05b7c0  ip : 00000000  fp : cb05b83c
> > [    1.340000] r10: cfb8c0c0  r9 : 00000000  r8 : cb18a4c0
> > [    1.340000] r7 : 00000005  r6 : 00000005  r5 : cb5c0334  r4 : 00000000
> > [    1.340000] r3 : 00000000  r2 : c0c06a7c  r1 : 00000003  r0 : c0c06a7c
> > [    1.340000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [    1.340000] Control: 10c5387d  Table: 80204059  DAC: 00000051
> > [    1.340000] Process swapper/0 (pid: 1, stack limit = 0xcb05a220)
> > [    1.340000] Stack: (0xcb05b7c0 to 0xcb05c000)
> > [    1.340000] b7c0: 00000000 c03b3350 4fdec700 00000000 00000005 c0959a84 ffffffff 00000000
> > [    1.340000] b7e0: ffffffff cb18a4c0 cfb8c0c0 c03732d8 4c4b4000 cb18a4c0 cfb8c0c0 cfb8c0c0
> > [    1.340000] b800: 0e979000 cb18a4c0 cfb8c0c0 00000005 0e979000 c12130c0 00000000 cfb8c0c0
> > [    1.340000] b820: cb05b83c c0360d28 00000000 cb18a4c0 cfb8c0c0 60000193 cb05b84c c0360fc0
> > [    1.340000] b840: cb18a4c0 cb18a8b4 cb05b87c c0361b74 cfb8c100 00000141 cb05b934 cb1c1cc0
> > [    1.340000] b860: 00000002 00000000 00000000 00000048 c1416d0c cb0096c0 00000001 c0381de0
> > [    1.340000] b880: c1416080 cfb8c100 00000400 cb0096c0 cb009720 00000000 00000038 cb003000
> > [    1.340000] b8a0: 00000000 cb05b9c4 00000a28 c0381ea4 cb0096c0 cb0096d0 00000000 c0385150
> > [    1.340000] b8c0: c03850ac c1211518 00000000 c038168c 00000155 c0381788 c0932830 20000013
> > [    1.340000] b8e0: ffffffff cb05b924 00000000 c030bad4 00000001 00000009 00000002 fa070024
> > [    1.340000] b900: cb127c10 00009401 cb05b9b8 c1302100 00000000 00000000 cb05b9c4 00000a28
> > [    1.340000] b920: 00000000 cb05b940 00009601 c0932830 20000013 ffffffff 00000051 c093261c
> > [    1.340000] b940: 00000014 cb127c58 00000002 00000001 000f4240 cb127c10 1443fd00 00000001
> > [    1.340000] b960: c1302100 cb127c58 cb05b9b8 00000002 c145d438 ffff16ac 00000001 c0928358
> > [    1.340000] b980: cb127c74 cb127c58 00000002 cb05b9b8 cb05ba97 00000001 cb05ba97 00000001
> > [    1.340000] b9a0: 00000001 c0928538 00000000 cb518000 cb513740 c07726c4 0000004b cfb80001
> > [    1.340000] b9c0: cb513740 0001004b 017d0001 cb05ba97 00000000 c076dc30 00000001 00000000
> > [    1.340000] b9e0: 00000004 000000b9 000000ba cb518000 000000ba 000000b9 00000001 c076dd70
> > [    1.340000] ba00: 00000000 00000000 cfb8c100 cb518000 000000ba 00000001 00000001 cb05ba97
> > [    1.340000] ba20: 00000001 000000b9 00000000 c076dfcc c099a208 cb59d048 00000001 c1336dd0
> > [    1.340000] ba40: a0000113 00000000 00000001 cb05ba97 0000005e 00000004 00000001 00000000
> > [    1.340000] ba60: 00000000 000ee098 000ee098 c077fd34 0000000d c09e51f0 c09e51d0 cb51f400
> > [    1.340000] ba80: ffffffff 000ee098 000ee098 c068cb48 00000000 c09c157c cb019180 c067887c
> > [    1.340000] baa0: cb51f400 c067a700 000ee098 c09c160c cb015780 00000000 3b9aca00 cb5bdcc0
> > [    1.340000] bac0: cb51f400 00000000 00000000 00000000 000ee098 c067ab5c 000ee098 000ee098
> > [    1.340000] bae0: cb5bdcc0 000ee098 000ee098 000ee098 cfb87050 00000000 000ee098 c067c614
> > [    1.340000] bb00: cb5bdcc0 000ee098 000ee098 c0765ad4 1dcd6500 cb5bdc80 00000000 07735940
> > [    1.340000] bb20: cb5bdc80 cfb87050 cb5bdcc0 00000000 000ee098 c076660c 000ee098 cb5c11d0
> > [    1.340000] bb40: cb05bb90 00124f80 00124f80 00124f80 07735940 1dcd6500 ffffffff cb5c1100
> > [    1.340000] bb60: 00000000 00000000 c145dc8c cb5c0280 00000000 00000001 cb05bb90 c0958e78
> > [    1.340000] bb80: cb05bb8c c13cb404 00000000 00000000 00000010 0007a120 0001e848 00000021
> > [    1.340000] bba0: ffffffff ee222d90 00000000 00000000 00000000 00000010 cfb8b598 c13cb310
> > [    1.340000] bbc0: c1302578 c095ca58 c1302578 00000000 cb5c1100 00000000 000927c0 cb5bdfc0
> > [    1.340000] bbe0: c120e300 00000000 ee32cf60 00000000 c13cb310 cb5c1100 00000000 cb5c0304
> > [    1.340000] bc00: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c095cd04 c145dc8c 00000001
> > [    1.340000] bc20: cb5c1100 cb5c1100 00000000 c145dc8c c1302578 00000003 cb5c1100 00000000
> > [    1.340000] bc40: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c0959c5c cb5c1100 00000000
> > [    1.340000] bc60: 00000000 c095a2dc c0c0df58 00000001 0000ffff 00000001 00000000 00000000
> > [    1.340000] bc80: cb5bdc00 000927c0 0001e848 000493e0 0001e848 000927c0 0007a120 00000000
> > [    1.340000] bca0: 00000000 00000000 00000000 c13cb310 00000000 00000000 00000000 00000000
> > [    1.340000] bcc0: 00000000 00000000 ffffffe0 cb5c1160 cb5c1160 c095abf4 0001e848 000927c0
> > [    1.340000] bce0: cb5c0280 c13cb0a8 c13cb0a8 cb5bdf00 cb5c1184 cb5c1184 cb11e600 00000000
> > [    1.340000] bd00: c13cb128 cb5bf460 00000001 00000003 00000000 00000000 cb5c11ac cb5c11ac
> > [    1.340000] bd20: ffff0001 cb5c11b8 cb5c11b8 00000000 00000000 cb060000 00000000 00000000
> > [    1.340000] bd40: 00000000 cb5c11d8 cb5c11d8 00000000 cb5bdf80 cb5bdec0 cb5c1100 c095a5f0
> > [    1.340000] bd60: 00000000 cb11e600 00000000 c1212594 60000013 00000001 00000000 c13cb110
> > [    1.340000] bd80: c13acc68 c13cb0a8 c13cb440 c13cb440 00000000 00000000 00000000 c075674c
> > [    1.340000] bda0: c13cb440 cb00cc5c cb169db4 00000000 c1334248 c13cb488 c145dc8c c0959764
> > [    1.340000] bdc0: ffffffed cfb87050 cb5e2600 c095d670 ffffffed cb5e2610 fffffdfb c0758e48
> > [    1.340000] bde0: c0758df8 cb5e2610 c1459090 c1459098 00000000 c07577b0 00000000 00000000
> > [    1.340000] be00: cb05be30 c0757a68 00000001 c145906c 00000000 c0755d3c cb00cb70 cb5938b8
> > [    1.340000] be20: cb5e2610 cb5e2644 c13aca58 c0757534 cb5e2610 00000001 00000000 cb5e2610
> > [    1.340000] be40: cb5e2610 c13aca58 c13acaa8 c0756bc0 cb5e2610 00000000 cb5e2618 c07550c0
> > [    1.340000] be60: 00000000 c0587884 cb05beb8 cb5e2600 00000000 cb5e2600 cb5e2610 c1419000
> > [    1.340000] be80: c110362c c11a183c 00000000 c0758fdc 00000000 cb05beb8 cb5e2600 cb5bdb00
> > [    1.340000] bea0: c1419000 c07597a8 c0ead2ac c1306788 c1306788 c1112510 00000000 00000000
> > [    1.340000] bec0: c0ead2ac 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.340000] bee0: 00000000 00000000 00000000 c110f828 c110fabc c110fac4 c110fabc c1103648
> > [    1.340000] bf00: c1306788 c0301d28 0000006f cb05bf28 c035a8bc c035a8cc 60000013 ffffffff
> > [    1.340000] bf20: 00000051 c058b428 c0ff5b24 c0c1da88 0000011a c035ab48 c11a183c c0ea7034
> > [    1.340000] bf40: c0ff451c 00000000 00000007 00000007 c1335704 cfb96300 c120de7c 00000007
> > [    1.340000] bf60: c11a1834 c1419000 0000011a c11a183c c1100598 c1100dc4 00000007 00000007
> > [    1.340000] bf80: 00000000 c1100598 00000000 c0b0bcfc 00000000 00000000 00000000 00000000
> > [    1.340000] bfa0: 00000000 c0b0bd04 00000000 c0307e78 00000000 00000000 00000000 00000000
> > [    1.340000] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.340000] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> > [    1.340000] [<c030de78>] (arch_send_call_function_single_ipi) from [<c03b3350>] (irq_work_queue_on+0x90/0x100)
> > [    1.340000] [<c03b3350>] (irq_work_queue_on) from [<c0959a84>] (cpufreq_update_util+0x40/0x4c)
> > [    1.340000] [<c0959a84>] (cpufreq_update_util) from [<c03732d8>] (enqueue_task_rt+0x28/0x26c)
> > [    1.340000] [<c03732d8>] (enqueue_task_rt) from [<c0360d28>] (activate_task+0x60/0x64)
> > [    1.340000] [<c0360d28>] (activate_task) from [<c0360fc0>] (ttwu_do_activate.constprop.13+0x34/0x68)
> > [    1.340000] [<c0360fc0>] (ttwu_do_activate.constprop.13) from [<c0361b74>] (try_to_wake_up+0x1a0/0x318)
> > [    1.340000] [<c0361b74>] (try_to_wake_up) from [<c0381de0>] (handle_irq_event_percpu+0xdc/0x15c)
> > [    1.340000] [<c0381de0>] (handle_irq_event_percpu) from [<c0381ea4>] (handle_irq_event+0x44/0x68)
> > [    1.340000] [<c0381ea4>] (handle_irq_event) from [<c0385150>] (handle_level_irq+0xa4/0x13c)
> > [    1.340000] [<c0385150>] (handle_level_irq) from [<c038168c>] (generic_handle_irq+0x18/0x28)
> > [    1.340000] [<c038168c>] (generic_handle_irq) from [<c0381788>] (__handle_domain_irq+0x54/0xb0)
> > [    1.340000] [<c0381788>] (__handle_domain_irq) from [<c030bad4>] (__irq_svc+0x54/0x70)
> > [    1.340000] [<c030bad4>] (__irq_svc) from [<c0932830>] (omap_i2c_xfer+0x320/0x5a0)
> 
> It looks like we got an interrupt in the middle of an i2c transaction
> changing the CPU OPP.  The handler of that tried to enqueue an RT task
> and that led to a cpufreq update that in turn triggered the crash.

I think the question here is around cpufreq_update_util() calling
irq_work_queue_on() for the same CPU... from an IRQ handler.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
