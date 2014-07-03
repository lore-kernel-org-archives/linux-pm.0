From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 15/16] ARM: mvebu: Add CPU idle support for Armada 38x
Date: Thu, 03 Jul 2014 17:29:57 +0200
Message-ID: <53B576F5.6080508@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-16-git-send-email-gregory.clement@free-electrons.com> <20140630170741.73256ba0@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52540 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752244AbaGCPaF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 11:30:05 -0400
In-Reply-To: <20140630170741.73256ba0@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,


>> Unlike the Armada XP and the Armada 370, this SoC uses a Cortex A9
>> core.
> 
> Isn't there some more details missing in this sentence? When I read it,
> at the end of the sentence, I'm wondering "and so what? what does this
> implies in terms of cpuidle support?".

Humm, actually, it the next sentence was wrongly formulate. Using a
Cortex A9 implies(or at least encourage) the use of ARM L2 cache and of
the SCU.

> 
>> Beside this, the main difference for the cpu idle is the way to
>> handle the L2 cache and the use of SCU.


[...]

>>  		pr_err("unable to request region\n");
>>  		ret = -EBUSY;
>> +
> 
> This change.
> 
>>  		goto out;
>>  	}
>>  
>> @@ -163,7 +181,6 @@ static int __init mvebu_v7_pmsu_init(void)
>>  		ret = -ENOMEM;
>>  		goto out;
>>  	}
>> -
> 
> And this one look like spurious changes not related to the patch.

yes of course.

> 
>>   out:
>>  	of_node_put(np);
>>  	return ret;
>> @@ -260,6 +277,27 @@ static int armada_xp_370_cpu_suspend(unsigned long deepidle)
>>  	return cpu_suspend(deepidle, do_armada_xp_370_cpu_suspend);
>>  }
>>  
>> +static noinline int do_armada_38x_cpu_suspend(unsigned long deepidle)
>> +{
>> +	mvebu_v7_pmsu_idle_prepare(deepidle, false);
>> +	/*
>> +	 * Already flushed cache, but do it again as the outer cache
>> +	 * functions dirty the cache with spinlocks
>> +	 */
>> +	v7_exit_coherency_flush(louis);
>> +
>> +	scu_power_mode(scu_base, SCU_PM_POWEROFF);
>> +
>> +	cpu_do_idle();
> 
> I see cpu_do_idle() does dsb() and wfi(), so why don't we use in the
> do_armada_370_xp_cpu_suspend() function ?

We can use cpu_do_idle() in do_armada_370_xp_cpu_suspend() too.

> 
>> +
>> +	return 1;
> 
> You return 1 here, but in the do_armada_370_xp_cpu_suspend() function
> you return zero. Is the return value being used? Why use 0 in one case
> and 1 in the other?

return 1 means error. But I think it was a nasty trick to not enter in the
CPU_PM_EXIT case. I forgot to go back on this, once the cpu idle was working
on Armada 38x. I will take care of it in the next series.

[...]

>> +{
>> +	struct device_node *np;
>> +	void __iomem *mpsoc_base;
>> +	u32 reg;
>> +
>> +	np = of_find_compatible_node(NULL, NULL,
>> +				"marvell,armada-380-coherency-fabric");
>> +	if (!np)
>> +		return false;
> 
> 		return -ENODEV;
> 
>> +	of_node_put(np);
>> +
>> +	np = of_find_compatible_node(NULL, NULL,
>> +				"marvell,armada-380-mpcore-soc-ctrl");
>> +	if (!np)
>> +		return false;
> 
> 		return -ENODEV;
> 
>> +	mpsoc_base = of_iomap(np, 0);
>> +	WARN_ON(!mpsoc_base);
> 
> WARN_ON() seems a bit weak for something that will make the next line
> crash the kernel. What about:
> 
> 	if (!mpsoc_base)
> 		return -ENOMEM;
> 
> I think the of_node_put(np) should be here.

OK


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
