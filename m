From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 1/2] cpuidle: Add new macro to enter a retention idle
 state
Date: Wed, 8 Nov 2017 16:24:46 -0700
Message-ID: <20200037-2029-8ba4-b9d0-7a5c3dac01a4@codeaurora.org>
References: <1510076133-18139-1-git-send-email-pprakash@codeaurora.org>
 <1510076133-18139-2-git-send-email-pprakash@codeaurora.org>
 <6518212.kvKYyx3eLf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdKHXYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 18:24:48 -0500
In-Reply-To: <6518212.kvKYyx3eLf@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com


On 11/8/2017 3:47 PM, Rafael J. Wysocki wrote:
> On Tuesday, November 7, 2017 6:35:32 PM CET Prashanth Prakash wrote:
>> If a CPU is entering a low power idle state where it doesn't lose any
>> context, then there is no need to call cpu_pm_enter()/cpu_pm_exit().
>> Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
>> drivers when they are entering retention state. By not calling
>> cpu_pm_enter and cpu_pm_exit we reduce the latency involved in
>> entering and exiting the retention idle states.
>>
>> On ARM64 based Qualcomm Server Platform we measured below overhead for
>> for calling cpu_pm_enter and cpu_pm_exit for retention states.
>>
>> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
>>         Average overhead of cpu_pm_enter - 1.2us
>>         Average overhead of cpu_pm_exit  - 3.1us
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  include/linux/cpuidle.h | 38 +++++++++++++++++++++++---------------
>>  1 file changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 8f7788d..54cbd9d 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -258,21 +258,29 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
>>  #endif
>>  
>>  #define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
>> -({								\
>> -	int __ret;						\
>> -								\
>> -	if (!idx) {						\
>> -		cpu_do_idle();					\
>> -		return idx;					\
>> -	}							\
>> -								\
>> -	__ret = cpu_pm_enter();					\
>> -	if (!__ret) {						\
>> -		__ret = low_level_idle_enter(idx);		\
>> -		cpu_pm_exit();					\
>> -	}							\
>> -								\
>> -	__ret ? -1 : idx;					\
>> +	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 0)
>> +
>> +#define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
>> +	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 1)
>> +
>> +#define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, is_retention) \
>> +({									\
>> +	int __ret = 0;							\
>> +									\
>> +	if (!idx) {							\
>> +		cpu_do_idle();						\
>> +		return idx;						\
>> +	}								\
>> +									\
>> +	if (!is_retention)						\
>> +		__ret =  cpu_pm_enter();				\
>> +	if (!__ret) {							\
>> +		__ret = low_level_idle_enter(idx);			\
>> +		if (!is_retention)					\
>> +			cpu_pm_exit();					\
>> +	}								\
>> +									\
>> +	__ret ? -1 : idx;						\
>>  })
>>  
>>  #endif /* _LINUX_CPUIDLE_H */
>>
> The ordering of the macros seems kind of backwards.  The inner-most
> ones usually go first (which is more natural for a human reader too).
I will change it and send out v2.

Thanks,
Prashanth
