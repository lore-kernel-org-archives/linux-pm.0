From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 12/13] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Tue, 25 Mar 2014 23:57:11 +0100
Message-ID: <533209C7.6060302@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com> <1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com> <20140214170046.GA32564@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50012 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755351AbaCYW62 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 18:58:28 -0400
In-Reply-To: <20140214170046.GA32564@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 14/02/2014 18:00, Lorenzo Pieralisi wrote:
> On Thu, Feb 13, 2014 at 05:33:35PM +0000, Gregory CLEMENT wrote:
> 
> [...]
> 
>> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
>> new file mode 100644
>> index 000000000000..57c69812e79d
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
>> @@ -0,0 +1,120 @@
>> +/*
>> + * Marvell Armada 370 and Armada XP SoC cpuidle driver
>> + *
>> + * Copyright (C) 2013 Marvell
>> + *
>> + * Nadav Haklai <nadavh@marvell.com>
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + */
>> +
>> +#include <linux/cpu_pm.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/suspend.h>
>> +#include <asm/suspend.h>
>> +#include <linux/smp.h>
>> +#include <asm/cpuidle.h>
>> +#include <asm/smp_plat.h>
>> +#include <linux/platform_device.h>
>> +#include <asm/cp15.h>
>> +#include <asm/cacheflush.h>
> 
> You should order them <linux/...>, then <asm/...>

OK done in v5

> 
>> +
>> +#define ARMADA_370_XP_MAX_STATES	3
> 
> Is this macro really needed ?

Well most of the other driver use it. And instead of having
this number directly written in the state_count field I prefer
to using a name for this value. But I think it is more a matter
of taste here.

> 
>> +#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
>> +extern void armada_370_xp_pmsu_idle_prepare(bool deepidle);
>> +extern void ll_clear_cpu_coherent(void);
>> +extern void ll_set_cpu_coherent(void);
>> +
>> +noinline static int armada_370_xp_cpu_suspend(unsigned long deepidle)
>> +{
>> +	armada_370_xp_pmsu_idle_prepare(deepidle);
>> +
>> +	v7_exit_coherency_flush(all);
> 
> The macro above clears the C bit in SCTLR and exit coherency (clears SMP
> bit in SCTLR), let's keep this in mind, see below.
> 
>> +	ll_clear_cpu_coherent();
> 
> And the macro above uses ldr/str exclusives, and this is done with MMU
> on and off (on cold-boot before jumping to secondary_startup and also
> before jumping to cpu_resume in armada_370_xp_cpu_resume).
> 
> Can you explain to me how load/store exclusives work on this platform ?
> 
> ARM ARM A3.4.5
> 
> "It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
> performed to a memory region with the Device or Strongly-ordered memory
> attribute. Unless the implementation documentation explicitly states that
> LDREX and STREX operations to a memory region with the Device or
> Strongly-ordered attribute are permitted, the effect of such operations is
> UNPREDICTABLE."
> 

Armada XP has an exclusive monitor that can track transactions to Device and/or
SO and as such also when MMU is disabled the exclusive transactions will be
functional.

> At least code must be commented and an explanation on why this works has
> to be given.

I have added this information in comment for the v5.
> 
>> +
>> +	dsb();
>> +
>> +	wfi();
>> +
>> +	ll_set_cpu_coherent();
>> +
>> +	asm volatile(
>> +	"mrc	p15, 0, %0, c1, c0, 0 \n\t"
>> +	"tst	%0, #(1 << 2) \n\t"
>> +	"orreq	r0, %0, #(1 << 2) \n\t"
>> +	"mcreq	p15, 0, %0, c1, c0, 0 \n\t"
>> +	"isb	"
>> +	: : "r" (0));
> 
> First of all, complex code like this must be commented.
> 
> Moreover, this sequence is wrong. If wfi completes the kernel would explode.
> 
> 1) where is the SMP bit in SCTLR restored ?
It is restored in this uncommeted piece of code. I added comment
now in the v5.

> 2) where are tlbs flushed (ie processors run out of coherency for _some_
>    time, so tlbs might be stale) ?

Right it was missing, I added it.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv,
>> +				int index)
>> +{
>> +	bool deepidle = false;
>> +	cpu_pm_enter();
>> +
>> +	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
>> +		deepidle = true;
>> +
>> +	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
>> +
>> +	cpu_pm_exit();
>> +
>> +	return index;
> 
> You should check the cpu_suspend return value and demote the idle state
> accordingly, if it failed.

Done in v5.

> 
> Thanks,
> Lorenzo
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
