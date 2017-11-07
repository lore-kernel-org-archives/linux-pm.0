From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2] cpupower : Fix cpupower working when cpu0 is offline
Date: Tue, 7 Nov 2017 11:20:33 -0700
Message-ID: <63bf8c5d-2a7e-484b-8d13-81bb6bef175d@osg.samsung.com>
References: <20171107072005.48034-1-huntbag@linux.vnet.ibm.com>
 <b1ae1a14-b354-6bc5-6118-87c7b65ce8a1@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:41553 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751787AbdKGSUh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Nov 2017 13:20:37 -0500
In-Reply-To: <b1ae1a14-b354-6bc5-6118-87c7b65ce8a1@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhishek <huntbag@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>

On 11/07/2017 01:58 AM, Abhishek wrote:
> Hi,
> 
> Can you have a look at it?
> 
> Thanks and Regards,
> 
> Abhishek Goel
> 
> System Engineer
> 
> IBM India Pvt. Ltd.
> 

Please refrain from top posting on kernel email thread.
In-lining comments and bottom posting is the norm.

> 
> On 11/07/2017 12:50 PM, Abhishek Goel wrote:
>> cpuidle_monitor used to assume that cpu0 is always online which is not
>> a valid assumption on POWER machines. This patch fixes this by searching
>> for the first online cpu and uses it, instead of always using cpu0 for
>> monitoring which may not be online.
>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>> v2: Commit message updated.
>> ---
>>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
>> index 1b5da00..adacf99 100644
>> --- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
>> +++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
>> @@ -130,15 +130,23 @@ static struct cpuidle_monitor *cpuidle_register(void)
>>   {
>>       int num;
>>       char *tmp;
>> +    int first_online_cpu;
>> +
>> +    for (num = 0; num < cpu_count; num++) {
>> +        if (cpupower_is_cpu_online(num))
>> +            break;
>> +    };
>> +    first_online_cpu = num;

Isn't it simpler to use sched_getcpu()n instead and use that instead
of walking the sysfs nodes since assumption is made that the idle state
count is the same for all CPUs

>>
>>       /* Assume idle state count is the same for all CPUs */
>> -    cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);

This simply be:

cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(sched_getcpu);

>> +    cpuidle_sysfs_monitor.hw_states_num =
>> +        cpuidle_state_count(first_online_cpu);
>>
>>       if (cpuidle_sysfs_monitor.hw_states_num <= 0)
>>           return NULL;
>>
>>       for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
>> -        tmp = cpuidle_state_name(0, num);
>> +        tmp = cpuidle_state_name(first_online_cpu, num);
>>           if (tmp == NULL)
>>               continue;
>>
>> @@ -146,7 +154,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
>>           strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
>>           free(tmp);
>>
>> -        tmp = cpuidle_state_desc(0, num);
>> +        tmp = cpuidle_state_desc(first_online_cpu, num);
>>           if (tmp == NULL)
>>               continue;
>>           strncpy(cpuidle_cstates[num].desc, tmp,    CSTATE_DESC_LEN - 1);
> 

thanks,
-- Shuah
