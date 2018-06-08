From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Fri, 8 Jun 2018 14:39:33 +0200
Message-ID: <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/08/2018 10:25 AM, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Thursday 07 Jun 2018 at 17:55:32 (+0200), Dietmar Eggemann wrote:
>> On 06/07/2018 05:19 PM, Quentin Perret wrote:
>>> Hi Juri,
>>>
>>> On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
>>>> On 21/05/18 15:24, Quentin Perret wrote:

[...]

> The comment above em_register_freq_domain() explains that, at least
> partially. In the current implementation, if multiple providers register
> the same frequency domain, all but the first will be ignored. The reason
> I implemented this that way is because: 1) it's simple; 2) it should
> cover the current use-cases for EAS and IPA.
> 
> But we could do something more clever. We could add a parameter to
> em_register_freq_domain() that would represent some sort of priority. In
> this case, if multiple providers register the same freq domain, the
> higher priority would override the lower priority. For example, power
> values coming from firmware could overwrite power values estimated with
> P=CV^2f for example.

In your current '(3)* Arm/Arm64 init code' (* see at the end of this 
email) you have this dev_pm_opp_of_estimate_power() em_data_callback 
active_power function.

Let's say thermal and the task scheduler would initialize the EM 
independently. They would still end up using C from dt, and f, V and P 
from opp library in your example.

IMHO, this information should be only provided once from one source per 
platform.

>> The re-scaling thing comes from the requirement that the final cpu capacity
>> values are only known after the arch_topology driver was able to scale the
>> dmipz-capacity-values with the policy->cpuinfo.max_freq but why can't we
>> create the EM on arm/arm64 after this?
> 
> What if you don't have dmips-capacity-mhz values in the DT and still
> want to use IPA ? There is no good reason to create a dependency between
> the thermal subsystem and the arch_topology driver IMO.

Mmmmh, that's correct. So it can't be simply called in 
init_cpu_capacity_callback() [drivers/base/arch_topology.c] in case the 
cpus_to_visit mask is empty. There is this dependency that cpufreq can 
be loaded at any time, requiring this re-scaling of capacity values ... 
That's not nice ...

>> Even though we would be forced to get cpufreq's related cpumask from
>> somewhere.
> 
> That's the easy part. The difficult part is, where do you get power
> values from ? You have to let the lower layers register those values
> in a centralized location on a voluntary basis. And then it becomes easy
> for consumers to access that data, because they know where it is.

The code in the arch could use the same struct em_data_callback em_cb = 
{ &dev_pm_opp_of_estimate_power } that the cpufreq driver is currently 
using?

>> I guess the easiest model will be that the Energy Model (EM) is fully
>> initialized with one init call (from the arch) and fixed after that.
> 
> Again, I don't think that's possible. You have to let the lower layers
> tell you where the power values come from, at the very least. You could
> let the archs do that aggregation I suppose, but I don't really see the
> benefit over one centralized framework with a generic interface ...
> What's your opinion ?

Don't understand the '... let the lower layers tell you where the power 
values come from ...' part. Where is the difference whether the arch or 
the cpufreq driver uses em_data_callback?

[...]

> So I think I'll drop patch 10/10 for v4 ... That part should be
> discussed separately, with the rest of the Arm-specific changes.

Maybe 3 clearly separated parts of the patch-set; (1) EM (2) EAS uses EM 
(3) Arm/Arm64 init code ?

[...]
