From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Support asymmetric idle definition
Date: Mon, 22 May 2017 16:48:14 +0200
Message-ID: <abfc0a2d-04bc-6714-f772-5f5ae23a1680@linaro.org>
References: <1495212343-24873-1-git-send-email-daniel.lezcano@linaro.org>
 <850fab54-d6e6-7b4c-631a-f4ee658c96fa@arm.com>
 <ca383c4a-9eeb-bd35-fa7b-1098bd0a5dc1@linaro.org>
 <45754d0a-6a98-2987-74ed-429926d89cbc@arm.com>
 <ce4ee3e6-baeb-5f99-a8d1-f2f3855fde35@linaro.org>
 <3ce7048e-6d9d-9e46-a6fb-4d3263231536@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35281 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934046AbdEVOsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 10:48:17 -0400
Received: by mail-wr0-f178.google.com with SMTP id z52so40134982wrc.2
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 07:48:17 -0700 (PDT)
In-Reply-To: <3ce7048e-6d9d-9e46-a6fb-4d3263231536@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 22/05/2017 15:02, Sudeep Holla wrote:

[ ... ]

>>>>>> +		drv->cpumask = &cpu_topology[cpu].core_sibling;
>>>>>> +
>>>>>
>>>>> This is not always true and not architecturally guaranteed. So instead
>>>>> of introducing this broken dependency, better to extract information
>>>>> from the device tree.
>>>>
>>>> Can you give an example of a broken dependency ?
>>>>
>>>> The cpu topology information is extracted from the device tree. So
>>>> if the topology is broken, the DT is broken also. Otherwise, the
>>>> topology code must fix the broken dependency from the DT.
>>>>
>>>
>>> No, I meant there's no guarantee that all designs must follow this rule.
>>> I don't mean CPU topology code or binding is broken. What I meant is
>>> linking CPU topology to CPU power domains is wrong. We should make use
>>> of DT you infer this information as it's already there. Topology bindings
>>> makes no reference to power and hence you simply can't infer that
>>> information from it.
>>
>> Ok, I will have a look how power domains can fit in this.
>>
>> However I'm curious to know a platform with a cluster idle state
>> powering down only a subset of CPUs belonging to the cluster.
>>
> 
> We can't reuse CPU topology for power domains:
> 1. As I mentioned earlier for sure, it won't be same with ARM DynamIQ.
> 2. Topology bindings strictly restrict themselves with topology and not
> connected with power-domains. We also have separate power domain
> bindings.

Yes, the theory is valid, but practically nowadays I don't see where we
have a cluster defined by a topology with a different cluster power domain.

By the way, if you have any pointer to documentation for DynamIQ PM and
design? I would be interested to have a look.

> We need to separate topology and power domains. We have some dependency
> like this in big little drivers(both CPUfreq and CPUIdle) but that
> dependencies must be removed as they are not architecturally guaranteed.
> Lorenzo had a patch[1] to solve this issue, I can post the latest
> version of it again and continue the discussion after some basic
> rebase/testing.

Actually, I am not convinced by the approach proposed in this patch.

Let me have a look at the idle power domain before, I do believe we can
do something much more simple.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
