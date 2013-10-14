From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Mon, 14 Oct 2013 16:14:12 +0200
Message-ID: <525BFC34.6020300@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <20130913161654.GA5408@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130913161654.GA5408@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <Leif.Lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "jcm@redhat.com" <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, linux-arm-kernel@
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,
[...]
>> +       if (index == MV_CPU_DEEP_IDLE)
>> +               deepidle = true;
>> +
>> +       cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
>> +
>> +       cpu_init();
> 
> I do not think cpu_init() is needed. Either core resumes through
> cpu_resume, and there cpu_init() is called for you, or there is no
> reason to call cpu_init() since CPU was not shutdown.

You're right: I have removed it on the new version I have just sent.


[...]

>> @@ -0,0 +1,91 @@
>> +/*
>> + * CPU idle low level implementation for Marvell Armada 370 and Armada XP SoCs
>> + *
>> + * Copyright (C) 2013 Marvell
>> + *
>> + * Nadav Haklai <nadavh@marvell.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + */
>> +#include <linux/linkage.h>
>> +
>> +
>> +/*
>> +* armadaxp_cpu_suspend: enter cpu deepIdle state
>> +* input:
>> +*/
>> +ENTRY(armada_370_xp_cpu_suspend)
>> +/* Save ARM registers */
>> +       stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
>> +
>> +       bl armada_370_xp_pmsu_idle_prepare
>> +       /*
>> +        * Invalidate L1 data cache. Even though only invalidate is
>> +        * necessary exported flush API is used here. Doing clean
>> +        * on already clean cache would be almost NOP.
>> +        */
>> +       bl v7_flush_dcache_all
>> +
>> +       /*
>> +        * Clear the SCTLR.C bit to prevent further data cache
>> +        * allocation. Clearing SCTLR.C would make all the data accesses
>> +        * strongly ordered and would not hit the cache.
>> +        */
>> +       mrc     p15, 0, r0, c1, c0, 0
>> +       bic     r0, r0, #(1 << 2)       @ Disable the C bit
>> +       mcr     p15, 0, r0, c1, c0, 0
>> +       isb
>> +
>> +       bl v7_flush_dcache_all
>> +
> 
> This code looks familiar and the first cache flush is not needed.
> 
> look at arch/arm/mach-vexpress/tc2_pm.c -> tc2_pm_down()
> 
> I know that probably the SMP bit in ACTLR is managed differently in this
> architecture but still, cache flushing should still apply and the TC2
> sequence is the proper one, unless you explain to me why that does not
> work on this chipset.

Here we follow the advices you gave in your presentation at Linaro Connect
Q2-2012: "Idling ARMs in a Busy World: Linux Power Management for ARM
multi-cluster systems"
http://www.linaro.org/documents/download/84a5990d6f227c90e3d3a3ad2af0e22c4fd1d0bd4a6c7
at p21.

Quoting the author of the original version od the code :
"Since the second flush is almost NOPs, I preferred to keep them both in the same sequence."


> 
>> +       /* Data memory barrier and Data sync barrier */
>> +       dsb
>> +       dmb
>> +
>> +       bl armada_370_xp_disable_snoop_ena
>> +
>> +       dsb                             @ Data Synchronization Barrier
>> +
>> +/*
>> + * ===================================
>> + * == WFI instruction => Enter idle ==
>> + * ===================================
>> + */
>> +
>> +       wfi                             @ wait for interrupt
> 
> Here core is running out of coherency and I do not see any tlb invalidation in
> the resume path from non-OFF mode. Please can you elaborate on this ?
> 

The TLB invalidation should take place in /arch/arm/kernel/suspend.c  cpu_suspend( )
in case the return value is 0 caused by cpu_suspend_abort.
Did we missed something?

[...]
> 
> I have further comments on the set (in particular on the inner workings
> of coherency and how CPUs get in and out of idle - ie how this is
> managed by the power controller) but I will keep them for next version,
> when the first set of review comments is addressed.
> 

You can make your comments on the last version I have just sent.

Thanks for your review

Gregory
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
