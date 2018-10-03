From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Date: Wed, 3 Oct 2018 08:48:23 +0100
Message-ID: <20181003074822.bwlhiowr4upjwunm@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
 <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
 <20181002142924.GI26858@hirez.programming.kicks-ass.net>
 <20181002144025.wnanxibhdcnl23sf@queper01-lin>
 <20181002191217.GA4160@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002191217.GA4160@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Andrea,

On Tuesday 02 Oct 2018 at 21:12:17 (+0200), Andrea Parri wrote:
> An example might help clarify this: here is a scenario I can _imagine,
> based on your description.
> 
> CPU0 (em_register_perf_domain())	CPU1 (reader)
> 
> [...]					my_pd = READ_ONCE(per_cpu(em_data, 1)); /* em_cpu_get() */
> pd->table = table			if (my_pd)
> WRITE_ONCE(per_cpu(em_data, 1), pd);		my_table = my_pd->table; /* process, dereference, ... my_table */
> 
> In this scenario, we'd like CPU1 to see CPU0's store to ->table (as well
> as the stores to table[]) _if CPU1 sees CPU0's store to em_data (that is,
> if my_pd != NULL).
> 
> This guarantee does not hold with the WRITE_ONCE(), because CPU0 could
> propagate the store to ->table and the store to em_data out-of-order.

Ah, this is a very good point ... It's fine if a reader sees em_data
half way through being updated, but it is NOT fine at all if a reader
gets a pointer onto a half-baked em_perf_domain.

So I agree, there is a problem here.

(I also realize now that I totally misunderstood Peter's messages before
which were basically pointing out this issue :/ ...)

> The smp_store_release(), together with the address dependency headed by
> the READ_ONCE(), provides this guarantee (and more...).
> 
> (Enclosing the reader into an em_pd_mutex critical section would also
> provide this guarantee, but I can imagine a few arguments for not using
> a mutex... ;-) ).

Right, using the mutex in em_cpu_get() could work too, although we
probably don't want to do that. We might very well end up using it in a
RCU critical section for example (although that's not the case with this
series, I'm just looking forward a bit).

So using smp_store_release() is the best choice here. I'll fix that up
for v8.

Thank you very much,
Quentin
