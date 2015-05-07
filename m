From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/6] cpufreq: powernv: Call throttle_check() on receiving
 OCC_THROTTLE
Date: Thu, 07 May 2015 17:49:22 +0530
Message-ID: <554B584A.3030507@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1430729652-14813-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <55484072.5060400@linux.vnet.ibm.com> <5548641C.5090208@linux.vnet.ibm.com> <5548824C.2030602@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5548824C.2030602@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/05/2015 02:11 PM, Preeti U Murthy wrote:
> On 05/05/2015 12:03 PM, Shilpasri G Bhat wrote:
>> Hi Preeti,
>>
>> On 05/05/2015 09:30 AM, Preeti U Murthy wrote:
>>> Hi Shilpa,
>>>
>>> On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
>>>> Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
>>>> notification by executing *throttle_check() on any one of the cpu on
>>>> the chip. This is a sanity check to verify if we were indeed
>>>> throttled/unthrottled after receiving OCC_THROTTLE notification.
>>>>
>>>> We cannot call *throttle_check() directly from the notification
>>>> handler because we could be handling chip1's notification in chip2. So
>>>> initiate an smp_call to execute *throttle_check(). We are irq-disabled
>>>> in the notification handler, so use a worker thread to smp_call
>>>> throttle_check() on any of the cpu in the chipmask.
>>>
>>> I see that the first patch takes care of reporting *per-chip* throttling
>>> for pmax capping condition. But where are we taking care of reporting
>>> "pstate set to safe" and "freq control disabled" scenarios per-chip ?
>>>
>>
>> IMO let us not have "psafe" and "freq control disabled" states managed per-chip.
>> Because when the above two conditions occur it is likely to happen across all
>> chips during an OCC reset cycle. So I am setting 'throttled' to false on
>> OCC_ACTIVE and re-verifying if it actually is the case by invoking
>> *throttle_check().
> 
> Alright like I pointed in the previous reply, a comment to indicate that
> psafe and freq control disabled conditions will fail when occ is
> inactive and that all chips face the consequence of this will help.

>From your explanation on the thread of the first patch of this series,
this will not be required.

So,
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Regards
Preeti U Murthy
> 
>>
>>>>
>>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>>> ---
>>>>  drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++--
>>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>>>> index 9268424..9618813 100644
>>>> --- a/drivers/cpufreq/powernv-cpufreq.c
>>>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>>>> @@ -50,6 +50,8 @@ static bool rebooting, throttled, occ_reset;
>>>>  static struct chip {
>>>>  	unsigned int id;
>>>>  	bool throttled;
>>>> +	cpumask_t mask;
>>>> +	struct work_struct throttle;
>>>>  } *chips;
>>>>
>>>>  static int nr_chips;
>>>> @@ -310,8 +312,9 @@ static inline unsigned int get_nominal_index(void)
>>>>  	return powernv_pstate_info.max - powernv_pstate_info.nominal;
>>>>  }
>>>>
>>>> -static void powernv_cpufreq_throttle_check(unsigned int cpu)
>>>> +static void powernv_cpufreq_throttle_check(void *data)
>>>>  {
>>>> +	unsigned int cpu = smp_processor_id();
>>>>  	unsigned long pmsr;
>>>>  	int pmsr_pmax, pmsr_lp, i;
>>>>
>>>> @@ -373,7 +376,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>>>  		return 0;
>>>>
>>>>  	if (!throttled)
>>>> -		powernv_cpufreq_throttle_check(smp_processor_id());
>>>> +		powernv_cpufreq_throttle_check(NULL);
>>>>
>>>>  	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
>>>>
>>>> @@ -418,6 +421,14 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>>>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>>>>  };
>>>>
>>>> +void powernv_cpufreq_work_fn(struct work_struct *work)
>>>> +{
>>>> +	struct chip *chip = container_of(work, struct chip, throttle);
>>>> +
>>>> +	smp_call_function_any(&chip->mask,
>>>> +			      powernv_cpufreq_throttle_check, NULL, 0);
>>>> +}
>>>> +
>>>>  static char throttle_reason[][30] = {
>>>>  					"No throttling",
>>>>  					"Power Cap",
>>>> @@ -433,6 +444,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>>>>  	struct opal_msg *occ_msg = msg;
>>>>  	uint64_t token;
>>>>  	uint64_t chip_id, reason;
>>>> +	int i;
>>>>
>>>>  	if (msg_type != OPAL_MSG_OCC)
>>>>  		return 0;
>>>> @@ -466,6 +478,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>>>>  			occ_reset = false;
>>>>  			throttled = false;
>>>>  			pr_info("OCC: Active\n");
>>>> +
>>>> +			for (i = 0; i < nr_chips; i++)
>>>> +				schedule_work(&chips[i].throttle);
>>>> +
>>>>  			return 0;
>>>>  		}
>>>>
>>>> @@ -476,6 +492,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>>>>  		else if (!reason)
>>>>  			pr_info("OCC: Chip %u %s\n", (unsigned int)chip_id,
>>>>  				throttle_reason[reason]);
>>>> +		else
>>>> +			return 0;
>>>
>>> Why the else section ? The code can never reach here, can it ?
>>
>> When reason > 5 , we dont want to handle it.
> 
> Of course! My bad!
>>
>>>
>>>> +
>>>> +		for (i = 0; i < nr_chips; i++)
>>>> +			if (chips[i].id == chip_id)
>>>> +				schedule_work(&chips[i].throttle);
>>>>  	}
>>>
>>> Should we not do this only when we get unthrottled so as to cross verify
>>> if it is indeed the case ? In case of throttling notification, opal's
>>> verdict is final and there is no need to cross verify right ?
>>
>> Two reasons for invoking *throttle_check() on throttling:
>> 1) We just got to know the reason and not the Pmax value we are getting
>> throttled to.
>> 2) It could be a spurious message caused due to late/lost delivery. My point
>> here is let us not completely rely on the notification to declare throttling
>> unless we verify it from reading PMSR.
> 
> Sounds good.
> 
> Regards
> Preeti U Murthy
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
