From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Avoid using inactive policies
Date: Fri, 18 Nov 2016 13:20:40 +0100
Message-ID: <CAJZ5v0jc0hiYVi9jiRmBSZ6E9=8KM-516GWyesGNtz5=CrzT3Q@mail.gmail.com>
References: <2600582.kqN5q7nCq0@vostro.rjw.lan> <20161118031750.GD3110@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbcKRMUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2016 07:20:43 -0500
In-Reply-To: <20161118031750.GD3110@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Fri, Nov 18, 2016 at 4:17 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-11-16, 16:08, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> There are two places in the cpufreq core in which low-level driver
>> callbacks may be invoked for an inactive cpufreq policy, which isn't
>> guaranteed to work in general.  Both are due to possible races with
>> CPU offline.
>>
>> First, in cpufreq_get(), the policy may become inactive after
>> the check against policy->cpus in cpufreq_cpu_get() and before
>> policy->rwsem is acquired, in which case using the policy going
>> forward may not be correct.
>>
>> Second, an analogous situation is possible in cpufreq_update_policy().
>>
>> Avoid using inactive policies by adding policy_is_inactive() checks
>> to the code in the above places.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq.c |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
>> +++ linux-pm/drivers/cpufreq/cpufreq.c
>> @@ -1526,7 +1526,10 @@ unsigned int cpufreq_get(unsigned int cp
>>
>>       if (policy) {
>>               down_read(&policy->rwsem);
>> -             ret_freq = __cpufreq_get(policy);
>> +
>> +             if (!policy_is_inactive(policy))
>> +                     ret_freq = __cpufreq_get(policy);
>> +
>>               up_read(&policy->rwsem);
>>
>>               cpufreq_cpu_put(policy);
>> @@ -2265,6 +2268,9 @@ int cpufreq_update_policy(unsigned int c
>>
>>       down_write(&policy->rwsem);
>>
>> +     if (policy_is_inactive(policy))
>
> You also need to set some value to 'ret' as it is uninitialized right now.

Right, thanks!
