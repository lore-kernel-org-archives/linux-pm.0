From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs
 disabled during hibernate
Date: Thu, 07 Jul 2016 09:29:36 +0100
Message-ID: <577E12F0.9040403@arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-2-git-send-email-james.morse@arm.com>
 <54369969.i5TPzUzNII@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54369969.i5TPzUzNII@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chen Yu C <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 06/07/16 01:38, Rafael J. Wysocki wrote:
> On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleeping
>> CPUs into a deeper power-saving state, or influencing which CPU resume
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to
>> calling disable_nonboot_cpus() if undefined. Architectures that
>> need to do extra work around these calls can use this to influence
>> the CPU down calls.
>> The macros should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.

>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index fca9254280ee..855a3a2374c8 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -31,8 +31,16 @@
>>  #include <linux/ktime.h>
>>  #include <trace/events/power.h>
>>  
>> +#ifdef CONFIG_ARCH_HIBERNATION_CPU_HOOKS
>> +/* Arch definition of the arch_hibernation_disable_cpus() macros? */
>> +#include <asm/suspend.h>
>> +#endif
>> +
>>  #include "power.h"
>>  
>> +#ifndef arch_hibernation_disable_cpus
>> +#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()
>> +#endif
>>  
>>  static int nocompress;
>>  static int noresume;
>> @@ -279,7 +287,7 @@ static int create_image(int platform_mode)
>>  	if (error || hibernation_test(TEST_PLATFORM))
>>  		goto Platform_finish;
>>  
>> -	error = disable_nonboot_cpus();
>> +	error = arch_hibernation_disable_cpus(true);
>>  	if (error || hibernation_test(TEST_CPUS))
>>  		goto Enable_cpus;
>>  
>> @@ -433,7 +441,7 @@ static int resume_target_kernel(bool platform_mode)
>>  	if (error)
>>  		goto Cleanup;
>>  
>> -	error = disable_nonboot_cpus();
>> +	error = arch_hibernation_disable_cpus(false);
> 
> Why "false"?

To indicate whether this is suspend or resume. On suspend we just call
disable_nonboot_cpus(), this ensures frozen_cpus and the potential races with
userspace are covered properly. At this point we don't care which CPU it picks.

On resume we know which CPU we want, so cpu_down() all the others. I thought the
frozen_cpus and user-space race wouldn't be a problem here, but Lorenzo
suggested it may confuse some device drivers to receive a CPU_DOWN_PREPARE etc
followed by CPU_UP_PREPARE_FROZEN etc.

I haven't found any drivers in the tree where this would be a problem (~95% of
notifiers either mask out the frozen bits, or fall-through in those cases). But
I'm still going through the list...


> 
>>  	if (error)
>>  		goto Enable_cpus;
>>  
>> @@ -551,7 +559,7 @@ int hibernation_platform_enter(void)
>>  	if (error)
>>  		goto Platform_finish;
>>  
>> -	error = disable_nonboot_cpus();
>> +	error = arch_hibernation_disable_cpus(true);
> 
> I have the same question about this hunk I had before.
> 
> Is it really necessary to do the arch thing here?

Ah, sorry I didn't understand what this did before. This is used when ACPI
drives hibernate/resume instead of swsusp_arch_suspend().

No, its not needed.


> It shouldn't really matter AFAICS.
> 
>>  	if (error)
>>  		goto Enable_cpus;

Thanks,

James
