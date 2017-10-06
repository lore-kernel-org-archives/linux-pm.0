From: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] intel_idle: replace conditionals with
 static_cpu_has(X86_FEATURE_ARAT)
Date: Fri, 6 Oct 2017 14:41:07 -0400
Message-ID: <e85b36ee-98fd-b1c9-1357-5d5af6f0d71d@akamai.com>
References: <bug-109051-18156@https.bugzilla.kernel.org/>
 <1507310385-22388-1-git-send-email-jbaron@akamai.com>
 <20171006113633.0186eb78@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006113633.0186eb78@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 10/06/2017 02:36 PM, Jacob Pan wrote:
> On Fri,  6 Oct 2017 13:19:45 -0400
> Jason Baron <jbaron@akamai.com> wrote:
> 
>> If the 'arat' cpu flag is set, then the conditionals in intel_idle()
>> that guard calling tick_broadcast_enter()/exit() will never be true.
>> Use static_cpu_has(X86_FEATURE_ARAT) to create a fast path to replace
>> the conditional.
>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/idle/intel_idle.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 5dc7ea4..5db5e31 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -913,8 +913,7 @@ static __cpuidle int intel_idle(struct
>> cpuidle_device *dev, struct cpuidle_state *state =
>> &drv->states[index]; unsigned long eax = flg2MWAIT(state->flags);
>>  	unsigned int cstate;
>> -
>> -	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) &
>> MWAIT_CSTATE_MASK) + 1;
>> +	bool uninitialized_var(tick);
>>  
>>  	/*
>>  	 * NB: if CPUIDLE_FLAG_TLB_FLUSHED is set, this idle
>> transition @@ -923,12 +922,19 @@ static __cpuidle int
>> intel_idle(struct cpuidle_device *dev,
>>  	 * useful with this knowledge.
>>  	 */
>>  
>> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>> -		tick_broadcast_enter();
>> +	if (!static_cpu_has(X86_FEATURE_ARAT)) {
>> +		cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) &
>> +				MWAIT_CSTATE_MASK) + 1;
>> +		tick = false;
>> +		if (!(lapic_timer_reliable_states & (1 <<
>> (cstate)))) {
>> +			tick = true;
>> +			tick_broadcast_enter();
>> +		}
>> +	}
>>  
>>  	mwait_idle_with_hints(eax, ecx);
>>  
>> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
>> +	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
>>  		tick_broadcast_exit();
>>  
>>  	return index;
> 
> Seems better to have a function pointer set up at init time to select
> whether we do tick_broadcast or not (two functions). There is no need to
> check CPU feature on every entry.
> 

Hi,

static_cpu_has() uses alternatives patching, so the cpu feature is not
tested on every entry. With the arat flag set you just have two nops in
the straight-line code path with this patch.

Thanks,

-Jason
