From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] tick, broadcast: Prevent false alarm when force mask
 contains offline cpus
Date: Wed, 26 Mar 2014 18:52:03 +0530
Message-ID: <5332D47B.3010809@linux.vnet.ibm.com>
References: <20140326035648.21736.85740.stgit@preeti.in.ibm.com> <5332B833.2030701@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5332B833.2030701@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, paulmck@linux.vnet.ibm.com, davem@davemloft.net
List-Id: linux-pm@vger.kernel.org

On 03/26/2014 04:51 PM, Srivatsa S. Bhat wrote:
> On 03/26/2014 09:26 AM, Preeti U Murthy wrote:
>> Its possible that the tick_broadcast_force_mask contains cpus which are not
>> in cpu_online_mask when a broadcast tick occurs. This could happen under the
>> following circumstance assuming CPU1 is among the CPUs waiting for broadcast.
>>
>> CPU0					CPU1
>>
>> Run CPU_DOWN_PREPARE notifiers
>>
>> Start stop_machine			Gets woken up by IPI to run
>> 					stop_machine, sets itself in
>> 					tick_broadcast_force_mask if the
>> 					time of broadcast interrupt is around
>> 					the same time as this IPI.
>>
>> 					Start stop_machine
>> 					  set_cpu_online(cpu1, false)
>> End stop_machine			End stop_machine
>>
>> Broadcast interrupt
>>   Finds that cpu1 in
>>   tick_broadcast_force_mask is offline
>>   and triggers the WARN_ON in
>>   tick_handle_oneshot_broadcast()
>>
>> Clears all broadcast masks
>> in CPU_DEAD stage.
>>
>> This WARN_ON was added to capture scenarios where the broadcast mask, be it
>> oneshot/pending/force_mask contain offline cpus whose tick devices have been
>> removed. But here is a case where we trigger the warn on in a valid scenario.
>>
>> One could argue that the scenario is invalid and ought to be warned against
>> because ideally the broadcast masks need to be cleared of the cpus about to
>> go offine before clearing them in the online_mask so that we dont hit these
>> scenarios.
>>
>> This would mean clearing the masks in CPU_DOWN_PREPARE stage.
> 
> Not necessarily. We could clear the mask in the CPU_DYING stage. That way,
> offline CPUs will automatically get cleared from the force_mask and hence
> the tick-broadcast code will not need to have a special case to deal with
> this scenario. What do you think?

Hmm yeah. Let me confirm this by verifying if we could miss something by
clearing masks in CPU_DYING stage.

Thanks!

Regards
Preeti U Murthy
> 
> Regards,
> Srivatsa S. Bhat
> 
>> ---
>>
>>  kernel/time/tick-broadcast.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
>> index 63c7b2d..30b8731 100644
>> --- a/kernel/time/tick-broadcast.c
>> +++ b/kernel/time/tick-broadcast.c
>> @@ -606,7 +606,12 @@ again:
>>  	 */
>>  	cpumask_clear_cpu(smp_processor_id(), tick_broadcast_pending_mask);
>>
>> -	/* Take care of enforced broadcast requests */
>> +	/* Take care of enforced broadcast requests. We could have offline
>> +	 * cpus in the tick_broadcast_force_mask. Thats ok, we got the interrupt
>> +	 * before we could clear the mask.
>> +	 */
>> +	cpumask_and(tick_broadcast_force_mask,
>> +			tick_broadcast_force_mask, cpu_online_mask);
>>  	cpumask_or(tmpmask, tmpmask, tick_broadcast_force_mask);
>>  	cpumask_clear(tick_broadcast_force_mask);
>>
>>
> 
