From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes
 because of lockup detector watchdog threads
Date: Tue, 9 Jan 2018 16:43:05 +0200
Message-ID: <1515508985.3310.8.camel@nxp.com>
References: <1515184652.6892.26.camel@nxp.com>
         <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
         <20180108040121.GB4003@vireshk-i7> <1515417622.3207.5.camel@nxp.com>
         <20180108151450.GA30937@e110439-lin> <1515426694.3207.28.camel@nxp.com>
         <CAJZ5v0hnY+2pL0LGAeQv7xZcYN42+_azKH9cGGLvPU1iO6fmWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hnY+2pL0LGAeQv7xZcYN42+_azKH9cGGLvPU1iO6fmWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-01-09 at 02:17 +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 8, 2018 at 4:51 PM, Leonard Crestez  wrote:
> > On Mon, 2018-01-08 at 15:14 +0000, Patrick Bellasi wrote:
> > > On 08-Jan 15:20, Leonard Crestez wrote:
> > > > On Mon, 2018-01-08 at 09:31 +0530, Viresh Kumar wrote:
> > > > > On 05-01-18, 23:18, Rafael J. Wysocki wrote:
> > > > > > On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez  wrote:

> > > > > > > When using the schedutil governor together with the softlockup detector
> > > > > > > all CPUs go to their maximum frequency on a regular basis. This seems
> > > > > > > to be because the watchdog creates a RT thread on each CPU and this
> > > > > > > causes regular kicks with:
> > > > > > > 
> > > > > > >     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
> > > > > > > 
> > > > > > > The schedutil governor responds to this by immediately setting the
> > > > > > > maximum cpu frequency, this is very undesirable.
> > > > > > > 
> > > > > > > The issue can be fixed by this patch from android:
> > > > > > > 
> > > > > > > The patch stalled in a long discussion about how it's difficult for
> > > > > > > cpufreq to deal with RT and how some RT users might just disable
> > > > > > > cpufreq. It is indeed hard but if the system experiences regular power
> > > > > > > kicks from a common debug feature they will end up disabling schedutil
> > > > > > > instead.

> > > > > > Patrick has a series of patches dealing with this problem area AFAICS,
> > > > > > but we are currently integrating material from Juri related to
> > > > > > deadline tasks.

> > > > > I am not sure if Patrick's patches would solve this problem at all as
> > > > > we still go to max for RT and the RT task is created from the
> > > > > softlockup detector somehow.

> > > > I assume you're talking about the series starting with
> > > > "[PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates"
> > > > 
> > > > I checked and they have no effect on this particular issue (not
> > > > surprising).
> > > 
> > > Yeah, that series was addressing the same issue but for one specific
> > > RT thread: the one used by schedutil to change the frequency.
> > > For all other RT threads the intended behavior was still to got
> > > to max... moreover those patches has been superseded by a different
> > > solution which has been recently proposed by Peter:
> > > 
> > >    20171220155625.lopjlsbvss3qgb4d@hirez.programming.kicks-ass.net
> > > 
> > > As Viresh and Rafael suggested, we should eventually consider a
> > > different scheduling class and/or execution context for the watchdog.
> > > Maybe a generalization of Juri's proposed SCHED_FLAG_SUGOV flag for
> > > DL tasks can be useful:
> > > 
> > >    20171204102325.5110-4-juri.lelli@redhat.com
> > > 
> > > Although that solution is already considered "gross" and thus perhaps
> > > it does not make sense to keep adding special DL tasks.
> > > 
> > > Another possible alternative to "tag an RT task" as being special, is
> > > to use an API similar to the one proposed by the util_clamp RFC:
> > > 
> > >    20170824180857.32103-1-patrick.bellasi@arm.com
> > > 
> > > which would allow to define what's the maximum utilization which can
> > > be required by a properly configured RT task.

> > Marking the watchdog as somehow "not important for performance" would
> > probably work, I guess it will take a while to get a stable solution.
> > 
> > BTW, in the current version it seems the kick happens *after* the RT
> > task executes. It seems very likely that cpufreq will go back down
> > before a RT executes again, so how does it help? Unless most of the
> > workload is RT. But even in that case aren't you better off with
> > regular scaling since schedutil will notice utilization is high anyway?
> > 
> > Scaling freq up first would make more sense except such operations can
> > have very high latencies anyway.

> I guess what happens is that it takes time to switch the frequency and
> the RT task gives the CPU away before the frequency actually changes.

What I am saying is that as far as I can tell when cpufreq_update_util
is called when the task has already executed and is been switched out.
My tests are not very elaborate but based on some ftracing it seems to
me that the current behavior is for cpufreq spikes to always trail RT
activity. Like this:

          <idle>-0     [002]   496.510138: sched_switch:         swapper/2:0 [120] S ==> watchdog/2:20 [0]
      watchdog/2-20    [002]   496.510156: bprint:               watchdog: IN watchdog(2)
      watchdog/2-20    [002]   496.510364: bprint:               watchdog: OU watchdog(2)
      watchdog/2-20    [002]   496.510377: bprint:               update_curr_rt: watchdog kick RT! cpu=2 comm=watchdog/2
      watchdog/2-20    [002]   496.510383: kernel_stack:         <stack trace>
=> deactivate_task (c0157d94)
=> __schedule (c0b13570)
=> schedule (c0b13c8c)
=> smpboot_thread_fn (c015211c)
=> kthread (c014db3c)
=> ret_from_fork (c0108214)
      watchdog/2-20    [002]   496.510410: sched_switch:         watchdog/2:20 [0] D ==> swapper/2:0 [120]
          <idle>-0     [001]   496.510488: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.510634: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.510817: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.510867: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.511036: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.511079: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.511243: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.511282: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.511445: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.511669: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.511859: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.511906: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.512073: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.512114: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.512269: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.512312: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.512448: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.512662: sched_switch:         sugov:0:580 [49] T ==> swapper/1:0 [120]
          <idle>-0     [001]   496.513185: sched_switch:         swapper/1:0 [120] S ==> sugov:0:580 [49]
         sugov:0-580   [001]   496.513239: cpu_frequency:        state=996000 cpu_id=0
         sugov:0-580   [001]   496.513243: cpu_frequency:        state=996000 cpu_id=1
         sugov:0-580   [001]   496.513245: cpu_frequency:        state=996000 cpu_id=2
         sugov:0-580   [001]   496.513247: cpu_frequency:        state=996000 cpu_id=3

I guess it would still help if an RT task starts, blocks and then
immediately resumes?

> > Viresh suggested earlier to move watchdog to DL but apparently per-cpu
> > threads are not supported. sched_setattr fails on this check:
> > 
> > kernel/sched/core.c#n4167

> Actually, how often does the softlockup watchdog run?

Every 4 seconds (really it's /proc/sys/kernel/watchdog_thresh * 2 / 5
and watchdog_thresh defaults to 10). There is a per-cpu hrtimer which
wakes the per-cpu thread in order to check that tasks can still
execute, this works very well against bugs like infinite loops in
softirq mode. The timers are synchronized initially but can get
staggered (for example by hotplug).

My guess is that it's only marked RT so that it executes ahead of other
threads and the watchdog doesn't trigger simply when there are lots of
userspace tasks.

--
Regards,
Leonard
