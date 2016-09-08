From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Thu, 8 Sep 2016 20:22:15 +0200
Message-ID: <20160908182215.GA10153@twins.programming.kicks-ass.net>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160908075955.GS10153@twins.programming.kicks-ass.net>
 <20160908180928.GB23509@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160908180928.GB23509@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 08, 2016 at 11:09:28AM -0700, Tim Chen wrote:
> On Thu, Sep 08, 2016 at 09:59:55AM +0200, Peter Zijlstra wrote:
> > I think there's a race here, if two tasks were to write to the sysctl
> > they'd both change the value before getting stuck on the mutex in
> > enable_sched_itmt().
> > 
> > One way around that is doing something like:
> > 
> > 
> > 	struct ctl_table t;
> > 	int val = sysctl_sched_itmt_enabled;
> > 
> > 	t = *table;
> > 	t.data = &val;
> > 
> > 	proc_dointvec_minmax(&t, ...);
> > 
> > 	/* and update the sysctl_sched_itmt_enabled value inside the mutex */
> > 	enable_sched_itmi(val);
> 
> Peter,
> 
> Since enable_sched_itmt is only used by sched_itmt_update_handler,
> I've moved the mutex locking to sched_itmt_update_handler to eliminate
> the race condition in the code path you mentioned.

That is indeed simpler. Thanks!
