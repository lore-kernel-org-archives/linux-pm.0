From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Date: Wed, 5 Sep 2018 23:06:38 -0700
Message-ID: <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820094420.26590-8-quentin.perret@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/20/2018 02:44 AM, Quentin Perret wrote:
> In order to ensure a minimal performance impact on non-energy-aware
> systems, introduce a static_key guarding the access to Energy-Aware
> Scheduling (EAS) code.
> 
> The static key is set iff all the following conditions are met for at
> least one root domain:
>    1. all online CPUs of the root domain are covered by the Energy
>       Model (EM);
>    2. the complexity of the root domain's EM is low enough to keep
>       scheduling overheads low;
>    3. the root domain has an asymmetric CPU capacity topology (detected
>       by looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
>       hierarchy).

This is pretty much the list (+ is schedutil running) of conditions to 
set rd->pd != NULL in build_perf_domains().

So when testing 'static_branch_unlikely(&sched_energy_present) && 
rcu_dereference(rd->pd)' don't you test two times the same thing?

Also, if let's say somebody wants to run another EM user (e.g. a thermal 
governor, like IPA) but not EAS on a asymmetric CPU capacity system. 
This can't be achieved with the current static branch approach

So what about using a (disabled by default ?) sched_feature + rd->pd != 
NULL instead?

[...]
