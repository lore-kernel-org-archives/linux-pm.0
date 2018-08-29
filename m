From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Date: Wed, 29 Aug 2018 14:28:13 +0100
Message-ID: <20180829132811.iacfltcos6kfgp7e@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829100435.GP2960@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Wednesday 29 Aug 2018 at 11:04:35 (+0100), Patrick Bellasi wrote:
> In the loop above we use smp_store_release() to propagate the pointer
> setting in a PER_CPU(em_data), which ultimate goal is to protect
> em_register_perf_domain() from multiple clients registering the same
> power domain.
> 
> I think there are two possible optimizations there:
> 
> 1. use of a single memory barrier
> 
>    Since we are already em_pd_mutex protected, i.e. there cannot be a
>    concurrent writers, we can use one single memory barrier after the
>    loop, i.e.
> 
>         for_each_cpu(cpu, span)
>                 WRITE_ONCE()
>         smp_wmb()
> 
>    which should be just enough to ensure that all other CPUs will see
>    the pointer set once we release the mutex

Right, I'm actually wondering if the memory barrier is needed at all ...
The mutex lock()/unlock() should already ensure the ordering I want no ?

WRITE_ONCE() should prevent load/store tearing with concurrent em_cpu_get(),
and the release/acquire semantics of mutex lock/unlock should be enough to
serialize the memory accesses of concurrent em_register_perf_domain() calls
properly ...

Hmm, let me read memory-barriers.txt again.

> 2. avoid using PER_CPU variables
> 
>    Apart from the initialization code, i.e. boot time, the em_data is
>    expected to be read only, isn't it?

That's right. It's not only read only, it's also not read very often (in
the use-cases I have in mind at least). The scheduler for example will
call em_cpu_get() once when sched domains are built, and keep the
reference instead of calling it again.

>    If that's the case, I think that using PER_CPU variables is not
>    strictly required while it unnecessarily increases the cache pressure.
> 
>    In the worst case we can end up with one cache line for each CPU to
>    host just an 8B pointer, instead of using that single cache line to host
>    up to 8 pointers if we use just an array, i.e.
> 
>         struct em_perf_domain *em_data[NR_CPUS]
>                 ____cacheline_aligned_in_smp __read_mostly;
> 
>    Consider also that: up to 8 pointers in a single cache line means
>    also that single cache line can be enough to access the EM from all
>    the CPUs of almost every modern mobile phone SoC.
> 
>    Note entirely sure if PER_CPU uses less overall memory in case you
>    have much less CPUs then the compile time defined NR_CPUS.
>    But still, if the above makes sense, you still have a 8x gain
>    factor between number Write allocated .data..percp sections and
>    the value of NR_CPUS. Meaning that in the worst case we allocate
>    the same amount of memory using NR_CPUS=64 (the default on arm64)
>    while running on an 8 CPUs system... but still we should get less
>    cluster caches pressure at run-time with the array approach, 1
>    cache line vs 4.

Right, using per_cpu() might cause to bring in cache things you don't
really care about (other non-related per_cpu stuff), but that shouldn't
waste memory I think. I mean, if my em_data var is the first in a cache
line, the rest of the cache line will most likely be used by other
per_cpu variables anyways ...

As you suggested, the alternative would be to have a simple array. I'm
fine with this TBH. But I would probably allocate it dynamically using
nr_cpu_ids instead of using a static NR_CPUS-wide thing though -- the
registration of perf domains usually happens late enough in the boot
process.

What do you think ?

Thanks
Quentin
