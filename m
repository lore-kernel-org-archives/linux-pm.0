From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU
 hotplug during hibernate
Date: Mon, 04 Jul 2016 10:04:26 +0100
Message-ID: <577A269A.6060307@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com> <1467125510-18758-6-git-send-email-james.morse@arm.com> <7811260.OWJXivZiAP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46105 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbcGDJGr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Jul 2016 05:06:47 -0400
In-Reply-To: <7811260.OWJXivZiAP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>, linux-pm@vger.kernel.org

Hi Rafael,

On 29/06/16 01:10, Rafael J. Wysocki wrote:
> On Tuesday, June 28, 2016 03:51:48 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleeping
>> CPUs into a deeper power-saving state, or influencing which CPU resume
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to calling
>> disable_nonboot_cpus() if undefined. Architectures that need to do extra
>> work around these calls can use this to influence disable_nonboot_cpus()
>> behaviour. The macro should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPUHP should be added to Kconfig.

> As you noted, this could be used to address the x86 issue that Yu is working on,
> so I'd like it to go in as the first patch in the series and through the PM tree.

Sure, I will split the series here, and group the later patches so there are no
dependencies.


> 
>> ---
>> Changes since v2:
>>  * Added CONFIG_ARCH_HIBERNATION_CPUHP include guard allowing
> 
> What about calling it CONFIG_ARCH_HIBERNATION_CPU_OFFLINE?  It's not
> hotplug really.

Even with the enable calls added? CONFIG_ARCH_HIBERNATION_CPU_HOOKS?


>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index fca9254280ee..338745e78f7e 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -31,8 +31,16 @@
>>  #include <linux/ktime.h>
>>  #include <trace/events/power.h>
>>  
>> +#ifdef CONFIG_ARCH_HIBERNATION_CPUHP
>> +/* Arch definition of the arch_hibernation_disable_cpus() macro? */
>> +#include <asm/suspend.h>
>> +#endif
>> +
>>  #include "power.h"
>>  
>> +#ifndef arch_hibernation_disable_cpus
>> +#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()
> 
> For the x86 case we'll also need the complementary "enable", so why don't
> you add it here and then use it instead of the enable_nonboot_cpus()?

Done. I've added the 'in_suspend' argument so that it's symmetrical, this may be
slightly different to the behaviour of your 'in_resume_hibernate' flag.


> 
>> +#endif
>>  
>>  static int nocompress;
>>  static int noresume;


>> @@ -551,7 +559,7 @@ int hibernation_platform_enter(void)
>>  	if (error)
>>  		goto Platform_finish;
>>  
>> -	error = disable_nonboot_cpus();
>> +	error = arch_hibernation_disable_cpus(true);
> 
> Does this one here actually matter?

I added it for completeness/symmetry (but not the enable call because it
wouldn't have any users). I assume its something to do with acpi...



Thanks,

James

