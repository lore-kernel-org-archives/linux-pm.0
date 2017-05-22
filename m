From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: cpuidle: Support asymmetric idle definition
Date: Mon, 22 May 2017 14:59:14 +0100
Message-ID: <4299ef3e-1cb2-983c-f0c1-13f16724256d@arm.com>
References: <1495212343-24873-1-git-send-email-daniel.lezcano@linaro.org>
 <850fab54-d6e6-7b4c-631a-f4ee658c96fa@arm.com>
 <ca383c4a-9eeb-bd35-fa7b-1098bd0a5dc1@linaro.org>
 <45754d0a-6a98-2987-74ed-429926d89cbc@arm.com>
 <ce4ee3e6-baeb-5f99-a8d1-f2f3855fde35@linaro.org>
 <3ce7048e-6d9d-9e46-a6fb-4d3263231536@arm.com>
 <20170522133452.GC9325@leoy-ThinkPad-T440>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933851AbdEVN7R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 09:59:17 -0400
In-Reply-To: <20170522133452.GC9325@leoy-ThinkPad-T440>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>



On 22/05/17 14:34, Leo Yan wrote:
> Hi Sudeep,
> 
> On Mon, May 22, 2017 at 02:02:12PM +0100, Sudeep Holla wrote:
> 
> [...]
> 
>>>>>> On 19/05/17 17:45, Daniel Lezcano wrote:
>>>>>>> Some hardware have clusters with different idle states. The current code does
>>>>>>> not support this and fails as it expects all the idle states to be identical.
>>>>>>>
>>>>>>> Because of this, the Mediatek mtk8173 had to create the same idle state for a
>>>>>>> big.Little system and now the Hisilicon 960 is facing the same situation.
>>>>>>>
>>>>>>
>>>>>> While I agree the we don't support them today, it's better to benchmark
>>>>>> and record/compare the gain we get with the support for cluster based
>>>>>> idle states.
>>>>>
>>>>> Sorry, I don't get what you are talking about. What do you want to
>>>>> benchmark ? Cluster idling ?
>>>>>
>>>>
>>>> OK, I was not so clear. I had a brief chat with Lorenzo, we have few
>>>> reason to have this support:
>>>> 1. Different number of states between clusters
>>>> 2. Different latencies(this is the one I was referring above, generally
>>>>    we keep worst case timings here and wanted to see if any platform
>>>>    measured improvements with different latencies in the idle states)
>>>
>>> I don't see the point. Are you putting into question the big little design?
>>>
>>
>> Not exactly. Since they are generally worst case number, I wanted to
>> check if someone saw real benefit with 2 different set of values.
>> Anyways that's not important or blocking, just raised a point, so that
>> we can stick some benchmarking results with this.
> 
> In case you are interesting for Hikey960 idle states, you could see
> the two clustsers have different idle states:
> http://termbin.com/d7ed

Probably this if  off-topic, but I found CPU_NAP_0 really interesting:

1. CPU_NAP_0 has arm,psci-suspend-param as 0x00000000 which generally
   not recommended to avoid conflict with WFI

2. Initially I assumed, CPU_NAP_0 is retention/standby state, but then I
   see "local-timer-stop", which indicates it's power down state which
   means arm,psci-suspend-param is wrong.

-- 
Regards,
Sudeep
