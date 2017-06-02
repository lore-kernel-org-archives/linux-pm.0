From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] ARM: cpuidle: Support asymmetric idle definition
Date: Fri, 2 Jun 2017 11:25:16 +0200
Message-ID: <4fe4558f-5881-11dc-5d36-93c92a272eed@linaro.org>
References: <1496317188-15272-1-git-send-email-daniel.lezcano@linaro.org>
 <3ec88de3-7d18-0ea6-bc27-e98084f2b6f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ec88de3-7d18-0ea6-bc27-e98084f2b6f6@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/06/2017 11:20, Sudeep Holla wrote:
> 
> 
> On 01/06/17 12:39, Daniel Lezcano wrote:
>> Some hardware have clusters with different idle states. The current code does
>> not support this and fails as it expects all the idle states to be identical.
>>
>> Because of this, the Mediatek mtk8173 had to create the same idle state for a
>> big.Little system and now the Hisilicon 960 is facing the same situation.
>>
>> Solve this by simply assuming the multiple driver will be needed for all the
>> platforms using the ARM generic cpuidle driver which makes sense because of the
>> different topologies we can support with a single kernel for ARM32 or ARM64.
>>
>> Every CPU has its own driver, so every single CPU can specify in the DT the
>> idle states.
>>
>> This simple approach allows to support the future dynamIQ system, current SMP
>> and HMP.
>>
>> It is unoptimal from a memory point of view for a system with a large number of
>> CPUs but nowadays there is no such system with a cpuidle driver on ARM.
>>
> 
> While I agree this may be simple solution, but just not necessary for
> systems with symmetric idle states especially one with large number of
> CPUs. I don't like to see 96 CPU Idle driver on say ThunderX. So we
> *must* have some basic distinction done here.
> 
> IMO, we can't punish a large SMP systems just because they don't have
> asymmetric idle states.

Can you point me in the upstream kernel a DTS with 96 cpus and using the
cpuidle-arm driver ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
