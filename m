From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] ARM: cpuidle: Support asymmetric idle definition
Date: Fri, 2 Jun 2017 12:40:47 +0200
Message-ID: <e79e44d6-6f01-6829-3924-6feca7633eae@linaro.org>
References: <1496317188-15272-1-git-send-email-daniel.lezcano@linaro.org>
 <3ec88de3-7d18-0ea6-bc27-e98084f2b6f6@arm.com>
 <4fe4558f-5881-11dc-5d36-93c92a272eed@linaro.org>
 <a96db56b-a773-f0a7-431e-acbb969333d1@arm.com>
 <d96a6da1-318f-3465-9227-714036431f81@linaro.org>
 <47e3d236-8d36-d04d-5f87-9fece6875d66@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34455 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBKkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2017 06:40:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id 123so11150317wmg.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Jun 2017 03:40:50 -0700 (PDT)
In-Reply-To: <47e3d236-8d36-d04d-5f87-9fece6875d66@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 02/06/2017 12:14, Sudeep Holla wrote:
> 
> 
> On 02/06/17 11:06, Daniel Lezcano wrote:
>> On 02/06/2017 11:39, Sudeep Holla wrote:
>>>
>>>
>>> On 02/06/17 10:25, Daniel Lezcano wrote:
>>>> On 02/06/2017 11:20, Sudeep Holla wrote:
>>>>>
>>>>>
>>>>> On 01/06/17 12:39, Daniel Lezcano wrote:
>>>>>> Some hardware have clusters with different idle states. The current code does
>>>>>> not support this and fails as it expects all the idle states to be identical.
>>>>>>
>>>>>> Because of this, the Mediatek mtk8173 had to create the same idle state for a
>>>>>> big.Little system and now the Hisilicon 960 is facing the same situation.
>>>>>>
>>>>>> Solve this by simply assuming the multiple driver will be needed for all the
>>>>>> platforms using the ARM generic cpuidle driver which makes sense because of the
>>>>>> different topologies we can support with a single kernel for ARM32 or ARM64.
>>>>>>
>>>>>> Every CPU has its own driver, so every single CPU can specify in the DT the
>>>>>> idle states.
>>>>>>
>>>>>> This simple approach allows to support the future dynamIQ system, current SMP
>>>>>> and HMP.
>>>>>>
>>>>>> It is unoptimal from a memory point of view for a system with a large number of
>>>>>> CPUs but nowadays there is no such system with a cpuidle driver on ARM.
>>>>>>
>>>>>
>>>>> While I agree this may be simple solution, but just not necessary for
>>>>> systems with symmetric idle states especially one with large number of
>>>>> CPUs. I don't like to see 96 CPU Idle driver on say ThunderX. So we
>>>>> *must* have some basic distinction done here.
>>>>>
>>>>> IMO, we can't punish a large SMP systems just because they don't have
>>>>> asymmetric idle states.
>>>>
>>>> Can you point me in the upstream kernel a DTS with 96 cpus and using the
>>>> cpuidle-arm driver ?
>>>>
>>>
>>> The bindings are upstream right. Not all DTS are upstream, firmware
>>> generate them especially for large systems.
>>>
>>> Check arch/arm64/boot/dts/cavium/thunder{,2}-{88,99}xx.dtsi, it has
>>> supports PSCI and firmware can update DTB to add the idle states.
>>> They are systems with 96 and 128 CPUs.
>>
>> Ok, so I have to assume there are out of tree DTB with idle state
>> definitions. In other circumstances I would have just ignored this
>> argument but I can admit the DTB blob thing is in the grey area between
>> what we have to support upstream and out of tree changes.
>>
> 
> Not entirely true. It's clear, we support anything whose binding is
> upstream. I do agree that there are lots of out of tree bindings but I
> am not referring to them. I am just referring to out of tree DTS with
> already upstreamed binding.

That is what I meant :)

>> However, even if it is suboptimal, I'm convinced doing a per-cpu driver
>> makes more sense.
>>
> 
> OK, but I think a simple check to decide not to, on SMP system is not
> too much a ask ?

Yes, it is :)

We end up with a hack by parsing and analyzing the DT based on the idea
different idle states means different cluster where you stated right
before in the topology comment that is not necessary true. So Lorenzo's
patch adds heuristic which may be wrong.

If we decide to consider all cpus with their own set of idle states,
everything is solved with a cpuidle driver per cpu.

The only drawback is the memory consumption.

But on the other side, as the idle state are per cpu, we don't trash the
cache.

Moreover, we already had that, an array of idle states per cpu (see
commit 46bcfad7), it was in the struct cpuidle_device instead of the
struct cpuidle_driver. It has been moved away in the latter with the
assumption the SMP have all the same idle states but now we see it is no
longer true.

Creating a cpuidle_driver per cpu is like using the previous approach.
The only thing is we must improve to save memory, that's all (eg. a
pointer allocating the idle states rather than hardcoding it).

We can live with a driver per cpu and do the memory optimization.

If we have an observed regression with large SMP systems, we fix it.

>> You said, we punish large SMP systems, I don't think it is true,
>> especially from a performance point of view. Do you have access to such
>> hardware to check if it is correct?
>>
> 
> Sorry, I thought "punish" is bit a harsh but couldn't find the work. I
> can say penalize instead.
> 
> No I don't have such a system to test.
> 
>> We have more memory used but it is not related on how we implement the
>> driver above but on the fixed array size in the cpuidle structures.
>>
> 
> Yes, I agree. But I will see what we can do at minimum to avoid it on
> system's that don't need it.
> 
>> I can take care of optimizing the memory usage in the cpuidle framework
>> which will benefit all architectures but that will take some time.
>>
> 
> Yest that's always good to have but I was not referring to that.
> 
>> So can you consider acking this patch, so that unblocks other HMP idle
>> development and I take care of optimizing the structure memory usage?
>>
> 
> I am thinking of checking DT to see if we need multiple driver support
> or not. But then it comes down to what Lorenzo had already posted.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
