From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 2 Oct 2018 15:05:23 +0100
Message-ID: <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002134857.GE26858@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 Oct 2018 at 15:48:57 (+0200), Peter Zijlstra wrote:
> +/**
> + * em_cpu_get() - Return the performance domain for a CPU
> + * @cpu : CPU to find the performance domain for
> + *
> + * Return: the performance domain to which 'cpu' belongs, or NULL if it doesn't
> + * exist.
> + */
> +struct em_perf_domain *em_cpu_get(int cpu)
> +{
> +       return READ_ONCE(per_cpu(em_data, cpu));
> +}
> +EXPORT_SYMBOL_GPL(em_cpu_get);
> 
> But your read side doesn't take, not is required to take em_pd_mutex.
> 
> At that point, the mutex_unlock() doesn't guarantee anything.
> 
> A CPU observing the em_data store, doesn't need to observe the store
> that filled the data structure it points to.

Right but even if I add the smp_store_release(), I can still have a
CPU observing em_data while another is in the process of updating it.
So, if smp_store_release() doesn't guarantee that readers will see a
complete update, do I actually get something interesting from it ?
(That's not a rhetorical question, I'm actually wondering :-)

Thanks,
Quentin
