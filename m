From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Date: Wed, 15 May 2019 18:48:54 +0200
Message-ID: <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:16PM +0530, Parth Shah wrote:
> Abstract
> ========
> 
> The modern servers allows multiple cores to run at range of
> frequencies higher than rated range of frequencies. But the power budget
> of the system inhibits sustaining these higher frequencies for
> longer durations.
> 
> However when certain cores are put to idle states, the power can be
> effectively channelled to other busy cores, allowing them to sustain
> the higher frequency.
> 
> One way to achieve this is to pack tasks onto fewer cores keeping others idle,
> but it may lead to performance penalty for such tasks and sustaining higher
> frequencies proves to be of no benefit. But if one can identify unimportant low
> utilization tasks which can be packed on the already active cores then waking up
> of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
> and waking up new core is expensive for such case.
> 
> Current CFS algorithm in kernel scheduler is performance oriented and hence
> tries to assign any idle CPU first for the waking up of new tasks. This policy
> is perfect for major categories of the workload, but for jitter tasks, one
> can save energy by packing it onto active cores and allow other cores to run at
> higher frequencies.
> 
> These patch-set tunes the task wake up logic in scheduler to pack exclusively
> classified jitter tasks onto busy cores. The work involves the use of additional
> attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 

Why does this make sense? Don't these higher freq bins burn power like
stupid? That is, it makes sense to use turbo-bins for single threaded
workloads that are CPU-bound and need performance.

But why pack a bunch of 'crap' tasks onto a core and give it turbo;
that's just burning power without getting anything back for it.
