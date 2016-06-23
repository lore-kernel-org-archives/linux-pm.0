From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 10:28:12 +0530
Message-ID: <576B6C64.6060206@linux.vnet.ibm.com>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com> <576B23EB.7080903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59414 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750785AbcFWE6a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 00:58:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5N4s5R3136113
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 00:58:29 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23q796gdap-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 00:58:29 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Thu, 23 Jun 2016 10:28:23 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id EF509E005B
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 10:32:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5N4wK1n45219936
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 10:28:20 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5N4wFuW019186
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 10:28:19 +0530
In-Reply-To: <576B23EB.7080903@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org



On 06/23/2016 05:18 AM, Balbir Singh wrote:
> 
> 
> On 23/06/16 05:36, Shreyas B. Prabhu wrote:
>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>> has a timeout so that if a cpu stays in snooze for more than target
>> residency of the next available idle state, then it would exit thereby
>> giving chance to the cpuidle governor to re-evaluate and
>> promote the cpu to a deeper idle state. Therefore whenever snooze exits
>> due to this timeout, its last_residency will be target_residency of next
>> deeper state.
>>
>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
>> changed the math around last_residency calculation. Specifically, while
>> converting last_residency value from nanoseconds to microseconds it does
>> right shift by 10. Due to this, in snooze timeout exit scenarios
>> last_residency calculated is roughly 2.3% less than target_residency of
>> next available state. This pattern is picked up get_typical_interval()
>> in the menu governor and therefore expected_interval in menu_select() is
>> frequently less than the target_residency of any state but snooze.
>>
>> Due to this we are entering snooze at a higher rate, thereby affecting
>> the single thread performance.
>> Since the math around last_residency is not meant to be precise, fix this
>> issue setting snooze timeout to 105% of target_residency of next
>> available idle state.
>>
>> This also adds comment around why snooze timeout is necessary.
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>>  drivers/cpuidle/cpuidle-powernv.c | 14 ++++++++++++++
>>  drivers/cpuidle/cpuidle-pseries.c | 13 +++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
>> index e12dc30..5835491 100644
>> --- a/drivers/cpuidle/cpuidle-powernv.c
>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>> @@ -268,10 +268,24 @@ static int powernv_idle_probe(void)
>>  		cpuidle_state_table = powernv_states;
>>  		/* Device tree can indicate more idle states */
>>  		max_idle_state = powernv_add_idle_states();
>> +
>> +		/*
>> +		 * Staying in snooze for a long period can degrade the
>> +		 * perfomance of the sibling cpus. Set timeout for snooze such
>> +		 * that if the cpu stays in snooze longer than target residency
>> +		 * of the next available idle state then exit from snooze. This
>> +		 * gives a chance to the cpuidle governor to re-evaluate and
>> +		 * promote it to deeper idle states.
>> +		 */
>>  		if (max_idle_state > 1) {
>>  			snooze_timeout_en = true;
>>  			snooze_timeout = powernv_states[1].target_residency *
>>  					 tb_ticks_per_usec;
>> +			/*
>> +			 * Give a 5% margin since target residency related math
>> +			 * is not precise in cpuidle core.
>> +			 */
> 
> Is this due to the microsecond conversion mentioned above? It would be nice to
> have it in the comment. Does
> 
> (powernv_states[1].target_residency + tb_ticks_per_usec) / tb_ticks_per_usec solve
> your rounding issues, assuming the issue is really rounding or maybe it is due
> to the shift by 10, could you please elaborate on what related math is not
> precise? That would explain to me why I missed understanding your changes.
> 
>> +			snooze_timeout += snooze_timeout / 20;
> 
> For now 5% is sufficient, but do you want to check to assert to check if
> 
> snooze_timeout (in microseconds) / tb_ticks_per_usec > powernv_states[i].target_residency?
> 

This is not a rounding issue. As I mentioned in the commit message, this
is because of the last_residency calculation in cpuidle.c.
To elaborate, last residency calculation is done in the following way
after commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with
local_clock()") -

cpuidle_enter_state()
{
	[...]
	time_start = local_clock();
	[enter idle state]
	time_end = local_clock();
	/*
         * local_clock() returns the time in nanosecond, let's shift
         * by 10 (divide by 1024) to have microsecond based time.
         */
        diff = (time_end - time_start) >> 10;
	[...]
	dev->last_residency = (int) diff;
}

Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%

In snooze timeout exit scenarios because of this, last_residency
calculated is 2.3% less than target_residency of next available state.
This affects get_typical_interval() in the menu governor and therefore
expected_interval in menu_select() is frequently less than the
target_residency of any state but snooze.


I'll expand the comments as you suggested.

Thanks,
Shreyas

