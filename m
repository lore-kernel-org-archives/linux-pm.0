From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: cpuidle: Support asymmetric idle definition
Date: Mon, 22 May 2017 14:02:12 +0100
Message-ID: <3ce7048e-6d9d-9e46-a6fb-4d3263231536@arm.com>
References: <1495212343-24873-1-git-send-email-daniel.lezcano@linaro.org>
 <850fab54-d6e6-7b4c-631a-f4ee658c96fa@arm.com>
 <ca383c4a-9eeb-bd35-fa7b-1098bd0a5dc1@linaro.org>
 <45754d0a-6a98-2987-74ed-429926d89cbc@arm.com>
 <ce4ee3e6-baeb-5f99-a8d1-f2f3855fde35@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdEVNCP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 09:02:15 -0400
In-Reply-To: <ce4ee3e6-baeb-5f99-a8d1-f2f3855fde35@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>



On 22/05/17 13:41, Daniel Lezcano wrote:
> On 22/05/2017 12:32, Sudeep Holla wrote:
>>
>>
>> On 22/05/17 11:20, Daniel Lezcano wrote:
>>>
>>> Hi Sudeep,
>>>
>>>
>>> On 22/05/2017 12:11, Sudeep Holla wrote:
>>>>
>>>>
>>>> On 19/05/17 17:45, Daniel Lezcano wrote:
>>>>> Some hardware have clusters with different idle states. The current code does
>>>>> not support this and fails as it expects all the idle states to be identical.
>>>>>
>>>>> Because of this, the Mediatek mtk8173 had to create the same idle state for a
>>>>> big.Little system and now the Hisilicon 960 is facing the same situation.
>>>>>
>>>>
>>>> While I agree the we don't support them today, it's better to benchmark
>>>> and record/compare the gain we get with the support for cluster based
>>>> idle states.
>>>
>>> Sorry, I don't get what you are talking about. What do you want to
>>> benchmark ? Cluster idling ?
>>>
>>
>> OK, I was not so clear. I had a brief chat with Lorenzo, we have few
>> reason to have this support:
>> 1. Different number of states between clusters
>> 2. Different latencies(this is the one I was referring above, generally
>>    we keep worst case timings here and wanted to see if any platform
>>    measured improvements with different latencies in the idle states)
> 
> I don't see the point. Are you putting into question the big little design?
>

Not exactly. Since they are generally worst case number, I wanted to
check if someone saw real benefit with 2 different set of values.
Anyways that's not important or blocking, just raised a point, so that
we can stick some benchmarking results with this.

> [ ... ]
> 
>>>>> +	for_each_possible_cpu(cpu) {
>>>>> +
>>>>> +		if (drv && cpumask_test_cpu(cpu, drv->cpumask))
>>>>> +			continue;
>>>>> +
>>>>> +		ret = -ENOMEM;
>>>>> +
>>>>> +		drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
>>>>> +		if (!drv)
>>>>> +			goto out_fail;
>>>>> +
>>>>> +		drv->cpumask = &cpu_topology[cpu].core_sibling;
>>>>> +
>>>>
>>>> This is not always true and not architecturally guaranteed. So instead
>>>> of introducing this broken dependency, better to extract information
>>>> from the device tree.
>>>
>>> Can you give an example of a broken dependency ?
>>>
>>> The cpu topology information is extracted from the device tree. So
>>> if the topology is broken, the DT is broken also. Otherwise, the
>>> topology code must fix the broken dependency from the DT.
>>>
>>
>> No, I meant there's no guarantee that all designs must follow this rule.
>> I don't mean CPU topology code or binding is broken. What I meant is
>> linking CPU topology to CPU power domains is wrong. We should make use
>> of DT you infer this information as it's already there. Topology bindings
>> makes no reference to power and hence you simply can't infer that
>> information from it.
> 
> Ok, I will have a look how power domains can fit in this.
> 
> However I'm curious to know a platform with a cluster idle state
> powering down only a subset of CPUs belonging to the cluster.
> 

We can't reuse CPU topology for power domains:
1. As I mentioned earlier for sure, it won't be same with ARM DynamIQ.
2. Topology bindings strictly restrict themselves with topology and not
connected with power-domains. We also have separate power domain
bindings.

We need to separate topology and power domains. We have some dependency
like this in big little drivers(both CPUfreq and CPUIdle) but that
dependencies must be removed as they are not architecturally guaranteed.
Lorenzo had a patch[1] to solve this issue, I can post the latest
version of it again and continue the discussion after some basic
rebase/testing.

-- 
Regards,
Sudeep

[1] http://www.spinics.net/lists/devicetree/msg76596.html
