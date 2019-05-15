From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 4/6] sched/fair: Define core capacity to limit task
 packing
Date: Wed, 15 May 2019 18:37:52 +0200
Message-ID: <20190515163751.GW2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-5-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-5-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:20PM +0530, Parth Shah wrote:
> The task packing on a core needs to be bounded based on its capacity. This
> patch defines a new method which acts as a tipping point for task packing.
> 
> The Core capacity is the method which limits task packing above certain
> point. In general, the capacity of a core is defined to be the aggregated
> sum of all the CPUs in the Core.
> 
> Some architectures does not have core capacity linearly increasing with the
> number of threads( or CPUs) in the core. For such cases, architecture
> specific calculations needs to be done to find core capacity.
> 
> The `arch_scale_core_capacity` is currently tuned for `powerpc` arch by
> scaling capacity w.r.t to the number of online SMT in the core.
> 
> The patch provides default handler for other architecture by scaling core
> capacity w.r.t. to the capacity of all the threads in the core.
> 
> ToDo: SMT mode is calculated each time a jitter task wakes up leading to
> redundant decision time which can be eliminated by keeping track of online
> CPUs during hotplug task.

Urgh, we just got rid of capacity for SMT. Also I don't think the above
clearly defines your metric.
