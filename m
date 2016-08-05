From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait condition
Date: Sat, 06 Aug 2016 01:36:12 +0200
Message-ID: <15658239.PaGHkd0aLz@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <11865228.rNvS61kIxv@vostro.rjw.lan> <20160804220908.GF26555@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804220908.GF26555@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 04, 2016 03:09:08 PM Steve Muckle wrote:
> On Thu, Aug 04, 2016 at 11:19:00PM +0200, Rafael J. Wysocki wrote:

[cut]
 
> > > This is also an issue for the remote wakeup case where I currently have
> > > another invocation of the hook in check_preempt_curr(), so I can know if
> > > preemption was triggered and skip a remote schedutil update in that case
> > > to avoid a duplicate IPI.
> > > 
> > > It seems to me worth evaluating if a higher level set of hook locations
> > > could be used. One possibility is higher up in CFS:
> > > - enqueue_task_fair, dequeue_task_fair
> > > - scheduler_tick
> > > - active_load_balance_cpu_stop, load_balance
> > 
> > Agreed, that's worth checking.
> > 
> > > Though this wouldn't solve my issue with check_preempt_curr. That would
> > > probably require going further up the stack to try_to_wake_up() etc. Not
> > > yet sure what the other hook locations would be at that level.
> > 
> > That's probably too far away from the root cfs_rq utilization changes IMO.
> 
> Is your concern that the rate of hook calls would be decreased?

It might be decreased, but also we might end up using utilization values
that wouldn't reflect the current situation (eg. if the hook is called before
update_load_avg(), the util value used by the governor may not be adequate).

Thanks,
Rafael
