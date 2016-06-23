From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 19:28:37 +1000
Message-ID: <576BABC5.7020600@gmail.com>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36350 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcFWJ2q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 05:28:46 -0400
Received: by mail-pa0-f66.google.com with SMTP id av7so44084pac.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 02:28:45 -0700 (PDT)
In-Reply-To: <576B6C64.6060206@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org



On 23/06/16 14:58, Shreyas B Prabhu wrote:
> 
> 
> On 06/23/2016 05:18 AM, Balbir Singh wrote:
>>
>>
>> On 23/06/16 05:36, Shreyas B. Prabhu wrote:
>>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>>> has a timeout so that if a cpu stays in snooze for more than target
>>> residency of the next available idle state, then it would exit thereby
>>> giving chance to the cpuidle governor to re-evaluate and
>>> promote the cpu to a deeper idle state. Therefore whenever snooze exits
>>> due to this timeout, its last_residency will be target_residency of next
>>> deeper state.
>>>
>>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
>>> changed the math around last_residency calculation. Specifically, while
>>> converting last_residency value from nanoseconds to microseconds it does
>>> right shift by 10. Due to this, in snooze timeout exit scenarios
>>> last_residency calculated is roughly 2.3% less than target_residency of
>>> next available state. This pattern is picked up get_typical_interval()
>>> in the menu governor and therefore expected_interval in menu_select() is
>>> frequently less than the target_residency of any state but snooze.
>>>
>>> Due to this we are entering snooze at a higher rate, thereby affecting
>>> the single thread performance.
>>> Since the math around last_residency is not meant to be precise, fix this
>>> issue setting snooze timeout to 105% of target_residency of next
>>> available idle state.
>>>
>>> This also adds comment around why snooze timeout is necessary.
>>>
>>> Reported-by: Anton Blanchard <anton@samba.org>
>>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>>> ---
>>>  drivers/cpuidle/cpuidle-powernv.c | 14 ++++++++++++++
>>>  drivers/cpuidle/cpuidle-pseries.c | 13 +++++++++++++
>>>  2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>>> index e12dc30..5835491 100644
>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>> @@ -268,10 +268,24 @@ static int powernv_idle_probe(void)
>>>  		cpuidle_state_table = powernv_states;
>>>  		/* Device tree can indicate more idle states */
>>>  		max_idle_state = powernv_add_idle_states();
>>> +
>>> +		/*
>>> +		 * Staying in snooze for a long period can degrade the
>>> +		 * perfomance of the sibling cpus. Set timeout for snooze such
>>> +		 * that if the cpu stays in snooze longer than target residency
>>> +		 * of the next available idle state then exit from snooze. This
>>> +		 * gives a chance to the cpuidle governor to re-evaluate and
>>> +		 * promote it to deeper idle states.
>>> +		 */
>>>  		if (max_idle_state > 1) {
>>>  			snooze_timeout_en = true;
>>>  			snooze_timeout = powernv_states[1].target_residency *
>>>  					 tb_ticks_per_usec;
>>> +			/*
>>> +			 * Give a 5% margin since target residency related math
>>> +			 * is not precise in cpuidle core.
>>> +			 */
>>
>> Is this due to the microsecond conversion mentioned above? It would be nice to
>> have it in the comment. Does
>>
>> (powernv_states[1].target_residency + tb_ticks_per_usec) / tb_ticks_per_usec solve
>> your rounding issues, assuming the issue is really rounding or maybe it is due
>> to the shift by 10, could you please elaborate on what related math is not
>> precise? That would explain to me why I missed understanding your changes.
>>
>>> +			snooze_timeout += snooze_timeout / 20;
>>
>> For now 5% is sufficient, but do you want to check to assert to check if
>>
>> snooze_timeout (in microseconds) / tb_ticks_per_usec > powernv_states[i].target_residency?
>>
> 
> This is not a rounding issue. As I mentioned in the commit message, this
> is because of the last_residency calculation in cpuidle.c.
> To elaborate, last residency calculation is done in the following way
> after commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with
> local_clock()") -
> 
> cpuidle_enter_state()
> {
> 	[...]
> 	time_start = local_clock();
> 	[enter idle state]
> 	time_end = local_clock();
> 	/*
>          * local_clock() returns the time in nanosecond, let's shift
>          * by 10 (divide by 1024) to have microsecond based time.
>          */
>         diff = (time_end - time_start) >> 10;
> 	[...]
> 	dev->last_residency = (int) diff;
> }
> 
> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%


This is still a rounding error but at a different site. I see we saved
a division by doing a >> 10, but we added it right back by doing a /20
later in the platform code. Shouldn't the rounding affect other
platforms as well? Can't we fix it in cpuidle_enter_state(). Division
by 1000 can be optimized if required (but rather not add that complexity).
Thanks for patiently explaining this

Balbir
