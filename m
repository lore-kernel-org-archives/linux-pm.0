From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Thermal: change spin lock
Date: Tue, 24 Sep 2013 11:34:12 -0700
Message-ID: <5241DB24.50804@linux.intel.com>
References: <1379023514-14982-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5241BE94.5060203@linux.intel.com> <5241C867.8010503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36649 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab3IXSZ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Sep 2013 14:25:58 -0400
In-Reply-To: <5241C867.8010503@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com

On 09/24/2013 10:14 AM, Eduardo Valentin wrote:
> On 24-09-2013 12:32, Srinivas Pandruvada wrote:
>> How long it take for thermal maintainers to look at a patch and comment?
>> Already 12 days.
> Well, I dont think there is a hard deadline for this. This specific
> period is still within 2 weeks time frame, which is pretty reasonable time.
>
> Also, adding maintainers in your To: list call their attention to your
> patch.
>
> Besides, I don't think throwing such kind of comment would help to speed
> the process.
Thanks for the review. Updated and sent again.
>> Thanks,
>> Srinivas
>>
>> On 09/12/2013 03:05 PM, Srinivas Pandruvada wrote:
>>> Change spin_lock to spin_lock_irqsave and spin_unlock to
>>> spin_unlock_irqrestore as the data it is trying to protect can also
>>> be modified in a notification call called from interrupt handler.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>    drivers/thermal/x86_pkg_temp_thermal.c | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c
>>> b/drivers/thermal/x86_pkg_temp_thermal.c
>>> index f36950e..7722cb9 100644
>>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
>>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
>>> @@ -316,18 +316,19 @@ static void
>>> pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
>>>        int phy_id = topology_physical_package_id(cpu);
>>>        struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
>>>        bool notify = false;
>>> +    unsigned long flags;
>>>          if (!phdev)
>>>            return;
>>>    -    spin_lock(&pkg_work_lock);
>>> +    spin_lock_irqsave(&pkg_work_lock, flags);
>>>        ++pkg_work_cnt;
>>>        if (unlikely(phy_id > max_phy_id)) {
>>> -        spin_unlock(&pkg_work_lock);
>>> +        spin_unlock_irqrestore(&pkg_work_lock, flags);
>>>            return;
>>>        }
>>>        pkg_work_scheduled[phy_id] = 0;
>>> -    spin_unlock(&pkg_work_lock);
>>> +    spin_unlock_irqrestore(&pkg_work_lock, flags);
>>>          enable_pkg_thres_interrupt();
>>>        rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
>>> @@ -397,6 +398,7 @@ static int pkg_temp_thermal_device_add(unsigned
>>> int cpu)
>>>        int thres_count;
>>>        u32 eax, ebx, ecx, edx;
>>>        u8 *temp;
>>> +    unsigned long flags;
>>>          cpuid(6, &eax, &ebx, &ecx, &edx);
>>>        thres_count = ebx & 0x07;
>>> @@ -420,19 +422,19 @@ static int pkg_temp_thermal_device_add(unsigned
>>> int cpu)
>>>            goto err_ret_unlock;
>>>        }
>>>    -    spin_lock(&pkg_work_lock);
>>> +    spin_lock_irqsave(&pkg_work_lock, flags);
>>>        if (topology_physical_package_id(cpu) > max_phy_id)
>>>            max_phy_id = topology_physical_package_id(cpu);
>>>        temp = krealloc(pkg_work_scheduled,
>>>                (max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>>>        if (!temp) {
>>> -        spin_unlock(&pkg_work_lock);
>>> +        spin_unlock_irqrestore(&pkg_work_lock, flags);
>>>            err = -ENOMEM;
>>>            goto err_ret_free;
>>>        }
>>>        pkg_work_scheduled = temp;
>>>        pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
>>> -    spin_unlock(&pkg_work_lock);
>>> +    spin_unlock_irqrestore(&pkg_work_lock, flags);
>>>          phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
>>>        phy_dev_entry->first_cpu = cpu;
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

