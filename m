From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] POWERPC: pseries: cpuidle: use time keeping flag
Date: Thu, 04 Apr 2013 16:31:35 +0530
Message-ID: <515D5D8F.7010906@linux.vnet.ibm.com>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <1364991322-20585-9-git-send-email-daniel.lezcano@linaro.org> <515C3BF2.7040609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:52208 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3DDLDU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 07:03:20 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 20:58:36 +1000
In-Reply-To: <515C3BF2.7040609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, patches@linaro.org, linux-pm@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 04/03/2013 07:55 PM, Daniel Lezcano wrote:
> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
>> The current code computes the idle time but that can be handled
>> by the cpuidle framework if we enable the .en_core_tk_irqen flag.
>>
>> Set the flag and remove the code related to the time computation.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
>> ---
> 
> Rafael,
> 
> Deepthi took the patch, did a fix and tested it, this is why there is
> its signed-off.
> 
> Deepthi, could you ack the patch for Rafael also ?
> 
> Thanks
> -- Daniel


Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

>>  arch/powerpc/platforms/pseries/processor_idle.c |   35 ++++++++++-------------
>>  1 file changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
>> index 4d806b4..a197120 100644
>> --- a/arch/powerpc/platforms/pseries/processor_idle.c
>> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
>> @@ -23,8 +23,9 @@
>>  #include "pseries.h"
>>  
>>  struct cpuidle_driver pseries_idle_driver = {
>> -	.name =		"pseries_idle",
>> -	.owner =	THIS_MODULE,
>> +	.name             = "pseries_idle",
>> +	.owner            = THIS_MODULE,
>> +	.en_core_tk_irqen = 1,
>>  };
>>  
>>  #define MAX_IDLE_STATE_COUNT	2
>> @@ -33,10 +34,8 @@ static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
>>  static struct cpuidle_device __percpu *pseries_cpuidle_devices;
>>  static struct cpuidle_state *cpuidle_state_table;
>>  
>> -static inline void idle_loop_prolog(unsigned long *in_purr, ktime_t *kt_before)
>> +static inline void idle_loop_prolog(unsigned long *in_purr)
>>  {
>> -
>> -	*kt_before = ktime_get();
>>  	*in_purr = mfspr(SPRN_PURR);
>>  	/*
>>  	 * Indicate to the HV that we are idle. Now would be
>> @@ -45,12 +44,10 @@ static inline void idle_loop_prolog(unsigned long *in_purr, ktime_t *kt_before)
>>  	get_lppaca()->idle = 1;
>>  }
>>  
>> -static inline  s64 idle_loop_epilog(unsigned long in_purr, ktime_t kt_before)
>> +static inline void idle_loop_epilog(unsigned long in_purr)
>>  {
>>  	get_lppaca()->wait_state_cycles += mfspr(SPRN_PURR) - in_purr;
>>  	get_lppaca()->idle = 0;
>> -
>> -	return ktime_to_us(ktime_sub(ktime_get(), kt_before));
>>  }
>>  
>>  static int snooze_loop(struct cpuidle_device *dev,
>> @@ -58,10 +55,9 @@ static int snooze_loop(struct cpuidle_device *dev,
>>  			int index)
>>  {
>>  	unsigned long in_purr;
>> -	ktime_t kt_before;
>>  	int cpu = dev->cpu;
>>  
>> -	idle_loop_prolog(&in_purr, &kt_before);
>> +	idle_loop_prolog(&in_purr);
>>  	local_irq_enable();
>>  	set_thread_flag(TIF_POLLING_NRFLAG);
>>  
>> @@ -75,8 +71,8 @@ static int snooze_loop(struct cpuidle_device *dev,
>>  	clear_thread_flag(TIF_POLLING_NRFLAG);
>>  	smp_mb();
>>  
>> -	dev->last_residency =
>> -		(int)idle_loop_epilog(in_purr, kt_before);
>> +	idle_loop_epilog(in_purr);
>> +
>>  	return index;
>>  }
>>  
>> @@ -102,9 +98,8 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
>>  				int index)
>>  {
>>  	unsigned long in_purr;
>> -	ktime_t kt_before;
>>  
>> -	idle_loop_prolog(&in_purr, &kt_before);
>> +	idle_loop_prolog(&in_purr);
>>  	get_lppaca()->donate_dedicated_cpu = 1;
>>  
>>  	ppc64_runlatch_off();
>> @@ -112,8 +107,9 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
>>  	check_and_cede_processor();
>>  
>>  	get_lppaca()->donate_dedicated_cpu = 0;
>> -	dev->last_residency =
>> -		(int)idle_loop_epilog(in_purr, kt_before);
>> +
>> +	idle_loop_epilog(in_purr);
>> +
>>  	return index;
>>  }
>>  
>> @@ -122,9 +118,8 @@ static int shared_cede_loop(struct cpuidle_device *dev,
>>  			int index)
>>  {
>>  	unsigned long in_purr;
>> -	ktime_t kt_before;
>>  
>> -	idle_loop_prolog(&in_purr, &kt_before);
>> +	idle_loop_prolog(&in_purr);
>>  
>>  	/*
>>  	 * Yield the processor to the hypervisor.  We return if
>> @@ -135,8 +130,8 @@ static int shared_cede_loop(struct cpuidle_device *dev,
>>  	 */
>>  	check_and_cede_processor();
>>  
>> -	dev->last_residency =
>> -		(int)idle_loop_epilog(in_purr, kt_before);
>> +	idle_loop_epilog(in_purr);
>> +
>>  	return index;
>>  }
>>  
> 
> 

