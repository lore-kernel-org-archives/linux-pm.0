From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Thu, 25 Aug 2016 12:22:52 +0100
Message-ID: <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 18, 2016 at 03:36:44PM -0700, Srinivas Pandruvada wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> We generalize the scheduler's asym packing to provide an
> ordering of the cpu beyond just the cpu number.  This allows
> the use of the ASYM_PACKING scheduler machinery to move
> loads to prefered CPU in a sched domain based on a preference
> defined by sched_asym_prefer function.
> 
> We also record the most preferred cpu in a sched group when
> we build the cpu's capacity for fast lookup of preferred cpu
> during load balancing.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[...]

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c64fc51..75e1002 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -532,6 +532,22 @@ struct dl_rq {
>  
>  #ifdef CONFIG_SMP
>  
> +#ifndef sched_asym_prefer
> +
> +/* For default ASYM_PACKING, lower numbered cpu is prefered */
> +static inline bool sched_asym_prefer(int a, int b)
> +{
> +	return a < b;
> +}
> +
> +#endif /* sched_asym_prefer */

Isn't this a very significant change in the interface between
architecture and the scheduler?

If I'm not mistaken, our current interface is quite strict when it comes
to information passed from the architecture into the scheduler. We allow
'topology' flags, but not behavioural flags, to be set by the
architecture, and the architecture can expose current and max cpu
capacities through the arch_scale_*() functions. For NUMA, we can expose
'distance' between nodes (and more?).

These are meant to describe the system topology to the scheduler, so it
can make better decisions on its own. sched_asym_prefer() is is not only
affecting scheduler behaviour, it is handing off scheduling decisions to
architecture code. In essence allowing logic to be plugged into the
scheduler, although with a somewhat limited scope of impact.

Should this been seen as the architecture/scheduler is up for revision
and we will start allowing architecture code to plug in function to
affect scheduling behaviour?

I haven't reviewed the entire patch set in detail, but why can't the cpu
priority list be handed to the scheduler instead of moving scheduling
decisions out of the scheduler?

Isn't it possible to express the cpu 'priority' as different cpu
capacities instead? Without understanding the details of ITMT, it seems
to me that what you really have is different cpu compute capacities, and
that is what we have cpu capacity for.

Is the intention long term to change the cpu priority order on the fly,
otherwise I don't see why you would put the logic in architecture code?

Finally, the existing callback functions from the scheduler to
architecture code are prefixed with arch_, I think this one should do
the same to make it clear that this function may be implemented by
generic scheduler code.

Thanks,
Morten
