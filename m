From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Tue, 01 Mar 2016 18:59:41 +0200
Message-ID: <87fuwarv5u.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
	<20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi>
	<20160229201946.0bdcc48e@annuminas.surriel.com>
	<87twkqllst.fsf@kirika.int.wmdata.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:34471 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbcCAQ7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 11:59:55 -0500
In-Reply-To: <87twkqllst.fsf@kirika.int.wmdata.fi> (Arto Jantunen's message of
	"Tue, 01 Mar 2016 09:06:10 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Arto Jantunen <viiru@iki.fi> writes:

> Rik van Riel <riel@redhat.com> writes:
>>> commit a9ceb78bc75ca47972096372ff3d48648b16317a
>>> Author: Rik van Riel <riel@redhat.com>
>>> Date:   Tue Nov 3 17:34:18 2015 -0500
>>> 
>>>     cpuidle,menu: use interactivity_req to disable polling
>>
>> I could see that patch being a little aggressive on some CPUs,
>> due to interactivity_req being corrected by the load on the
>> CPU.  Does using data->predicted_us help?
>
> I'll test this tonight and get back to you.
>
>> ---8<---
>>
>> Subject: cpuidle: use predicted_us not interactivity_req to consider polling
>>
>> The interactivity_req variable is the expected sleep time, divided
>> by the CPU load. This can be too aggressive a factor in deciding
>> whether or not to consider polling in the cpuidle state selection.
>>
>> Use the (not corrected for load) predicted_us instead.
>>
>> Signed-off-by: Rik van Riel <riel@redhat.com>
>> ---
>>  drivers/cpuidle/governors/menu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index 0742b3296673..97022ae01d2e 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>  		 * We want to default to C1 (hlt), not to busy polling
>>  		 * unless the timer is happening really really soon.
>>  		 */
>> -		if (interactivity_req > 20 &&
>> +		if (data->predicted_us > 20 &&
>>  		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>>  			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
>>  			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
>>

This patch has no effect on the symptoms I'm seeing.

-- 
Arto Jantunen
