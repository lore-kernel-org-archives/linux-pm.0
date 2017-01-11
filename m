From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 1/2] cpufreq: intel_pstate: Expose global sysfs
 attributes upfront
Date: Wed, 11 Jan 2017 03:32:44 +0100
Message-ID: <CAJZ5v0jhqc0AQjoQC+tF1+0_D_0xpJRQ2n9o8+vpi84EwTsaOQ@mail.gmail.com>
References: <21825845.nN3skUNMsO@aspire.rjw.lan> <2389828.jxMzLa8mev@aspire.rjw.lan>
 <1484081335.28749.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33780 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758083AbdAKCcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 21:32:45 -0500
In-Reply-To: <1484081335.28749.11.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jan 10, 2017 at 9:48 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2017-01-05 at 02:51 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Expose the intel_pstate's global sysfs attributes before registering
>> the driver to prepare for the addition of an attribute that also will
>> have to work if the driver is not registered.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>
> [...]
>
>>  #ifdef CONFIG_ACPI
>> @@ -1055,12 +1058,22 @@ static ssize_t show_turbo_pct(struct kob
>>       int total, no_turbo, turbo_pct;
>>       uint32_t turbo_fp;
>>
>> +     mutex_lock(&intel_pstate_driver_lock);
>> +
>> +     if (!driver_registered) {
>> +             mutex_unlock(&intel_pstate_limits_lock);
> It should be
>                 mutex_unlock(&intel_pstate_driver_lock);
>
>> +             return -EAGAIN;
>> +     }
>> +
>>       cpu = all_cpu_data[0];
>>
>>
> [...]
>
>> @@ -1070,8 +1083,18 @@ static ssize_t show_num_pstates(struct k
>>       struct cpudata *cpu;
>>       int total;
>>
>> +     mutex_lock(&intel_pstate_driver_lock);
>> +
>> +     if (!driver_registered) {
>> +             mutex_unlock(&intel_pstate_limits_lock);
> Change to
>                 mutex_unlock(&intel_pstate_driver_lock);
>
>> +             return -EAGAIN;
>> +     }
>> +
>>       cpu = all_cpu_data[0];
>>       total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate +
>> 1;
>> +
>> +     mutex_unlock(&intel_pstate_driver_lock);
>> +
>>       return sprintf(buf, "%u\n", total);
>>  }
>>
>> @@ -1080,12 +1103,21 @@ static ssize_t show_no_turbo(struct kobj
>>  {
>>       ssize_t ret;
>>
>> +     mutex_lock(&intel_pstate_driver_lock);
>> +
>> +     if (!driver_registered) {
>> +             mutex_unlock(&intel_pstate_limits_lock);
> Same here
>                 mutex_unlock(&intel_pstate_driver_lock);
>
>> +             return -EAGAIN;
>> +     }
>> +
>>       update_turbo_state();
>>       if (limits->turbo_disabled)
>>               ret = sprintf(buf, "%u\n", limits->turbo_disabled);
>>       else
>>               ret = sprintf(buf, "%u\n", limits->no_turbo);
>>
>> +     mutex_unlock(&intel_pstate_driver_lock);
>> +
>>       return ret;
>>  }
>>
>> @@ -1099,6 +1131,13 @@ static ssize_t store_no_turbo(struct kob
>>       if (ret != 1)
>>               return -EINVAL;
>>
>> +     mutex_lock(&intel_pstate_driver_lock);
>> +
>> +     if (!driver_registered) {
>> +             mutex_unlock(&intel_pstate_driver_lock);
>> +             return -EAGAIN;
>> +     }
>> +
>>       mutex_lock(&intel_pstate_limits_lock);       if (limits-
>> >turbo_disabled) {
>>                 pr_warn("Turbo disabled by BIOS or unavailable on
>> processor\n");
>>                 mutex_unlock(&intel_pstate_limits_lock);
> Also
>                 mutex_unlock(&intel_pstate_driver_lock);>
>
>>                 return -EPERM;
>>         }
>>
>>       update_turbo_state();
>> @@ -1114,6 +1153,8 @@ static ssize_t store_no_turbo(struct kob
>>
>>       intel_pstate_update_policies();
>>
>> +     mutex_unlock(&intel_pstate_driver_lock);
>> +
>>       return count;
>>  }
>>

It looks like I sent an old version of the patch.  I'll send a correct
one shortly.

Thanks,
Rafael
