From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/8] sched: Extend scheduler's asym packing
Date: Thu, 8 Sep 2016 10:01:11 +0200
Message-ID: <20160908080111.GT10153@twins.programming.kicks-ass.net>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1472762024-88771-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472762024-88771-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 01, 2016 at 01:33:38PM -0700, Srinivas Pandruvada wrote:
> +++ b/kernel/sched/sched.h
> @@ -532,6 +532,17 @@ struct dl_rq {
>  
>  #ifdef CONFIG_SMP
>  
> +static inline bool sched_asym_prefer(int a, int b)
> +{
> +	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
> +}
> +
> +/*
> + * Return lowest numbered cpu in the group as the most preferred cpu
> + * for ASYM_PACKING for default case.
> + */
> +#define group_priority_cpu(group) group->asym_prefer_cpu
> +

Both these are no longer used outside of sched/fair.c, and should
probably be moved there. Also the later has no reason for being a macro.
