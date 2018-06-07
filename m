From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Thu, 7 Jun 2018 17:55:32 +0200
Message-ID: <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/07/2018 05:19 PM, Quentin Perret wrote:
> Hi Juri,
> 
> On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
>> On 21/05/18 15:24, Quentin Perret wrote:

[...]

>> Mmm, this gets complicated pretty fast eh? :)
> 
> Yeah, hopefully I'll be able to explain/clarify that :-).
> 
>>
>> I had to go back and forth between patches to start understanding the
>> different data structures and how they are use, and I'm not sure yet
>> I've got the full picture. I guess some nice diagram (cover letter or
>> documentation patch) would help a lot.

+1 on the diagram.

> Right, so I'd like very much to write a nice documentation patch once we
> are more or less OK with the overall design of this framework, but I
> felt like it was a little bit early for that. If we finally decide that
> what I did is totally stupid and that it'd be better to do things
> completely differently, my nice documentation patch would be a lot of
> efforts for nothing.
> 
> But I agree that at the same time all this complex code has to be
> explained. Hopefully the existing comments can help with that.
> Otherwise, I'm more than happy to answer all questions :-)

I'm not sure that the current API is the final one. Not sure that 
em_rescale_cpu_capacity() is really needed.

We should first clarify the provider - consumer relation. Are multiple 
providers allowed, if yes, are they allowed to provide partial EM data? 
Do we really want to allow this overwriting of old EM data 
(em_rescale_cpu_capacity()). In case multiple provider are allowed, is 
there some kind of priority involved?

The re-scaling thing comes from the requirement that the final cpu 
capacity values are only known after the arch_topology driver was able 
to scale the dmipz-capacity-values with the policy->cpuinfo.max_freq but 
why can't we create the EM on arm/arm64 after this? Even though we would 
be forced to get cpufreq's related cpumask from somewhere.

I guess the easiest model will be that the Energy Model (EM) is fully 
initialized with one init call (from the arch) and fixed after that.

In case the EM should not be tight to cpufreq, the interface 
em_create_fd(cpumask_t *span, int nr_states, struct em_data_callback 
*cb) seems ok.

IMHO, part of the problem why this might be harder to understand is the 
fact that the patches show the use of the 2. init call 
'em_rescale_cpu_capacity()' but not the 1. one 
'em_register_freq_domain()'. I guess that Quentin wanted to keep the set 
as small as possible.

[...]
