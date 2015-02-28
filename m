From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 00/20] cpufreq: Don't loose cpufreq history on CPU
 hotplug
Date: Fri, 27 Feb 2015 18:36:42 -0800
Message-ID: <54F129BA.3030202@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <CAKohponfFhGCAm8Dn_9V4doLhJzt6362q31Ub2nC9C3+o1Mvug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48039 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbB1Cgp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 21:36:45 -0500
In-Reply-To: <CAKohponfFhGCAm8Dn_9V4doLhJzt6362q31Ub2nC9C3+o1Mvug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Prarit Bhargava <prarit@redhat.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Srivatsa Bhat <srivatsa@mit.edu>

On 02/26/2015 09:26 PM, Viresh Kumar wrote:
> On 19 February 2015 at 17:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi Rafael,
>>
>> The aim of this series is to stop managing cpufreq sysfs directories on CPU
>> hotplugs.
>>
>> Currently on removal of a 'cpu != policy->cpu', we remove its sysfs directories
>> by removing the soft-link. And on removal of policy->cpu, we migrate the sysfs
>> directories to the next cpu. But if policy->cpu was the last CPU, we remove the
>> policy completely and allocate it again as soon as the CPUs come back. This has
>> shortcomings:
>>
>> - Code Complexity
>> - Slower hotplug
>> - sysfs file permissions are reset after all policy->cpus are offlined
>> - CPUFreq stats history lost after all policy->cpus are offlined
>> - Special management of sysfs stuff during suspend/resume
>>
>>
>> To make things simple we stop playing with sysfs files unless the driver is
>> getting removed. Also the policy is kept intact to be used later.
>>
>> First few patches provide a clean base for others *more important* patches.
>>
>> Rebased-over: your bleeding edge branch as there were dependencies on my earlier
>> patches.
>>
>> Pushed here:
>>
>> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/core/sysfs
>>
>> v1->V2:
>> - Dropped the idea of using policy-lists for getting policy for any cpu
>> - Also dropped fallback list and its per-cpu variable
>> - Stopped cleaning cpufreq_cpu_data and doing list_del(policy) on logical
>>    hotplug.
>> - Added support for physical hotplug of CPUs (Untested).
>
> Gentle reminder for reviews !! :)
>
Sorry, caught up on some internal work. Should be able to get to this by 
Wednesday.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
