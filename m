From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
Date: Fri, 30 Jan 2015 11:11:17 +0530
Message-ID: <54CB197D.2040809@linux.vnet.ibm.com>
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com> <1410764352.32643.2.camel@concordia> <5416A8B0.8040603@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:57882 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbA3Fl0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 00:41:26 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 29 Jan 2015 22:41:26 -0700
In-Reply-To: <5416A8B0.8040603@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>

On 09/15/2014 02:22 PM, Preeti U Murthy wrote:
> On 09/15/2014 12:29 PM, Michael Ellerman wrote:
>> On Fri, 2014-09-12 at 16:31 +0530, Preeti U Murthy wrote:
>>> Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
>>> entry into deep idle states beyond snooze. Check for the value of this
>>> parameter before entering fastsleep. We already do this check for nap in
>>> power7_idle().
>>>
>>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>> ---
>>>
>>>  drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>>> index a64be57..b8ba52e 100644
>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>> @@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>>>  	unsigned long old_lpcr = mfspr(SPRN_LPCR);
>>>  	unsigned long new_lpcr;
>>>  
>>> +	/*
>>> +	 * Verify if snooze is the only valid cpuidle state
>>> +	 */
>>> +	if (!(powersave_nap > 0))
>>> +		return index;
>>> +
>>>  	if (unlikely(system_state < SYSTEM_RUNNING))
>>>  		return index;
>>
>> Doesn't the above mean we are just going to keep trying to go into fastsleep
>> again and again? Or does the idle code work out that it didn't work based on
>> the fact that we didn't sleep for the right period?
> 
> Thats right. The idle code figures that its judgment to enter fastsleep
> was not correct and applies a correction factor to its future decisions
> . This correction factor is intended to influence the cpuidle governor's
> decision on choosing an idle state for the cpu based on the history of
> wakeups. Hence a shallower idle state will be chosen here on in the
> above circumstance.

On second thoughts, I feel that this is not the best way to disable deep
idle states. Going down this path means the governor should identify
that fastsleep is not being entered into and take corrective action from
then on. If the governor is buggy, we pointlessly enter and exit
fastsleep_loop() during long idle periods.

So a better way to disable fastsleep during runtime is through the
disable flag in sysfs. To disable deep idle states at bootup one could
use powersave=off kernel cmd line parameter.

The functionality provided by powersave_nap and smt_snooze_delay (to
quote another example) carried value during the days that powernv did
not have a cpuidle driver. We retain them so as to not break userspace,
although they do not carry value today. Any future users of these
parameters should be avoided IMO. Hence I retract this patch.

Regards
Preeti U Murthy

> 
>>
>> We were talking about getting rid of powersave_nap altogether, but I think we
>> decided we couldn't, I forget.
> 
> Isn't this a helpful knob to disable cpuidle at runtime? Currently we
> check the value of powersave_nap before entering both nap and fastsleep.
> 
> Regards
> Preeti U Murthy
>>
>> cheers
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

