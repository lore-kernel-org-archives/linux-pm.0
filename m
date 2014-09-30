From: Wang Weidong <wangweidong1@huawei.com>
Subject: Re: [RESEND PATCH] acpi-cpufreq: get the cur_freq from acpi_processor_performance
 states
Date: Tue, 30 Sep 2014 15:09:45 +0800
Message-ID: <542A5739.6040207@huawei.com>
References: <53F589C3.4050504@huawei.com> <2075276.PKjjuvNeys@vostro.rjw.lan> <54264C0B.1000607@huawei.com> <2361937.mQR3H5xj3F@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:1697 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaI3HJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 03:09:54 -0400
In-Reply-To: <2361937.mQR3H5xj3F@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org >> \"linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>

On 2014/9/28 4:01, Rafael J. Wysocki wrote:
> On Saturday, September 27, 2014 01:32:59 PM Wang Weidong wrote:
>> On 2014/9/27 7:21, Rafael J. Wysocki wrote:
>>> On Thursday, August 21, 2014 01:55:15 PM Wang Weidong wrote:
>>>> As the initialized freq_tables maybe different from the p-states
>>>> values, so the array index is different as well.
>>>>
>>>> p-states value: [2400 2400 2000 ...], while the freq_tables:
>>>> [2400 2000 ... CPUFREQ_TABLE_END]. After setted the freqs 2000,
>>>> the perf->state is 3 while the freqs_table's index should be 2.
>>>> So when call the get_cur_freq_on_cpu, the freqs value we get
>>>> is 2400.
>>>>
>>>> So, fix the problem with the correct tables.
>>>
>>> What you're saying is basically that freq_table and perf->states
>>> diverge at one point.  Shouldn't we re-generate freq_table in that
>>> case instead of fixing up get_cur_freq_on_cpu() only in a quite
>>> indirect way? 
>>>
>> Hi Rafael,
>>
>> Thanks for your reply.
>>
>> You mean that we should re-generate the freq_table in that case?
>> Could we fix the table init like this:
>>
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -779,7 +779,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>
>>         /* table init */
>>         for (i = 0; i < perf->state_count; i++) {
>> -               if (i > 0 && perf->states[i].core_frequency >=
>> +               if (i > 0 && perf->states[i].core_frequency >
>>                     data->freq_table[valid_states-1].frequency / 1000)
>>                         continue;
>>
>> when the value is same, we just keep the value into the freq_table.
> 
> That would only be OK if it is guaranteed that the set of available
> states hasn't changed, which I'm not sure is the case.
> 
> Rafael
> 

Yep, ACPI maybe will dynamic to report the states to the OS . So I should consider it again.

Regards,
Wang
> 
> .
> 


