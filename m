From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Fri, 8 Jun 2018 18:39:56 +0200
Message-ID: <a51f0aee-8d4b-1149-9cb5-ad1777a93f34@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
 <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
 <20180608131104.GA7838@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608131104.GA7838@e108498-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/08/2018 03:11 PM, Quentin Perret wrote:
> On Friday 08 Jun 2018 at 14:39:33 (+0200), Dietmar Eggemann wrote:

[...]

>>>> Even though we would be forced to get cpufreq's related cpumask from
>>>> somewhere.
>>>
>>> That's the easy part. The difficult part is, where do you get power
>>> values from ? You have to let the lower layers register those values
>>> in a centralized location on a voluntary basis. And then it becomes easy
>>> for consumers to access that data, because they know where it is.
>>
>> The code in the arch could use the same struct em_data_callback em_cb = {
>> &dev_pm_opp_of_estimate_power } that the cpufreq driver is currently using?
> 
> How do you know from the arch code if you should get power from DT
> with dev_pm_opp_of_estimate_power or use another callback that reads
> power from firmware (SCMI) ?

Ah, ok, cpufreq dt, scpi and arm_big_little are dt, cpufreq scmi can be 
different ...

> 
> I don't think it is reasonable to assume a single source of information for
> an arch. It is is already an incorrect assumption even if just you look at
> the Arm world.

Ok, I see.

> 
>>> Again, I don't think that's possible. You have to let the lower layers
>>> tell you where the power values come from, at the very least. You could
>>> let the archs do that aggregation I suppose, but I don't really see the
>>> benefit over one centralized framework with a generic interface ...
>>> What's your opinion ?
>>
>> Don't understand the '... let the lower layers tell you where the power
>> values come from ...' part. Where is the difference whether the arch or the
>> cpufreq driver uses em_data_callback?
> 
> Because different CPUFreq drivers can be used for one arch. There are
> different CPUFreq drivers because there are different ways of getting
> information about the platform, even just for the Arm world (DT, SCPI,
> SCMI, ...). It's the same thing for power values, they don't necessarily
> come from DT.

scpi is dt ? At least scpi-cpufreq.c uses this 
dev_pm_opp_of_estimate_power too.

> The point of having a centralized EM framework with a standardized
> callback prototype is flexibility. You can implement a callback that
> estimates power from the DT. You can implement a callback that reads
> power from firmware. But you can also have a completely ad-hoc EM
> provider in a module if you like. All you have to do to provide data to
> the framework is respect the callback API.

IMHO, this idea is good, there should be also user of this outside 
arm/arm64 ...

[...]
