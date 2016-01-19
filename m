From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Tue, 19 Jan 2016 16:49:41 +0000
Message-ID: <20160119164941.GI8573@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
 <20160112110658.GG1084@ubuntu>
 <20160115163031.GU18603@e106622-lin>
 <20160118055034.GC30762@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40856 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbcASQtO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jan 2016 11:49:14 -0500
Content-Disposition: inline
In-Reply-To: <20160118055034.GC30762@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 18/01/16 11:20, Viresh Kumar wrote:
> On 15-01-16, 16:30, Juri Lelli wrote:
> > But governor_enabled seems to not be checked anymore outside cpufreq.c
> > (see also 01/19), as it was in the commit you are referring to.
> 
> Okay, I must have told you this earlier but anyway ..
> 
> governor_enabled was introduced long back to keep governor state
> changes serialized. Because of the complex cases we had in hand
> (governor-per-policy or system wide governors, etc.), it failed to do
> so. Though simple races were avoided with it, complex ones still came
> back to haunt us.
> 
> We fixed that by managing state changes within ondemand and
> conservative governors instead and that worked very well.
> 
> Then I wrote a patch to kill the stupid code around governor_enabled
> thing, but I got into few races. Those races happened because of
> userspace governor, which was getting into invalid states on some
> extreme cases (These were caught using the test-suite I wrote and you
> perhaps used it).
> 
> And I never came back to fix those corner cases ..
> 

OK, thanks for the explanation.

> You can try that on ARM or x86 by running following command from my
> test-suite (I remember that you are using it, right?):
> 

Yep, I'm constantly running those on my boxes.

> ./runme.sh -f sp1 or sp2 or sp3
> 
> Only one of sp1, sp2 or sp3 is required..
> 

I'm actually hitting this running sp2, on linux-pm/linux-next :/.

 ======================================================
 [ INFO: possible circular locking dependency detected ]
 4.4.0+ #445 Not tainted
 -------------------------------------------------------
 trace.sh/1723 is trying to acquire lock:
  (s_active#48){++++.+}, at: [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94

 but task is already holding lock:
  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

-> #2 (od_dbs_cdata.mutex){+.+.+.}:
        [<c075b040>] mutex_lock_nested+0x7c/0x434
        [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
        [<c0017c10>] return_to_handler+0x0/0x18

-> #1 (&policy->rwsem){+++++.}:
        [<c075ca8c>] down_read+0x58/0x94
        [<c057c244>] show+0x30/0x60
        [<c01f934c>] sysfs_kf_seq_show+0x90/0xfc
        [<c01f7ad8>] kernfs_seq_show+0x34/0x38
        [<c01a22ec>] seq_read+0x1e4/0x4e4
        [<c01f8694>] kernfs_fop_read+0x120/0x1a0
        [<c01794b4>] __vfs_read+0x3c/0xe0
        [<c017a378>] vfs_read+0x98/0x104
        [<c017a434>] SyS_read+0x50/0x90
        [<c000fd40>] ret_fast_syscall+0x0/0x1c

-> #0 (s_active#48){++++.+}:
        [<c008238c>] lock_acquire+0xd4/0x20c
        [<c01f6ae4>] __kernfs_remove+0x288/0x328
        [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
        [<c01fa024>] remove_files+0x44/0x88
        [<c01fa5a4>] sysfs_remove_group+0x50/0xa4
        [<c058285c>] cpufreq_governor_dbs+0x3f0/0x5d4
        [<c0017c10>] return_to_handler+0x0/0x18

 other info that might help us debug this:

 Chain exists of:
  s_active#48 --> &policy->rwsem --> od_dbs_cdata.mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(od_dbs_cdata.mutex);
                                lock(&policy->rwsem);
                                lock(od_dbs_cdata.mutex);
   lock(s_active#48);

  *** DEADLOCK ***

 5 locks held by trace.sh/1723:
  #0:  (sb_writers#6){.+.+.+}, at: [<c017beb8>] __sb_start_write+0xb4/0xc0
  #1:  (&of->mutex){+.+.+.}, at: [<c01f8418>] kernfs_fop_write+0x6c/0x1c8
  #2:  (s_active#35){.+.+.+}, at: [<c01f8420>] kernfs_fop_write+0x74/0x1c8
  #3:  (cpu_hotplug.lock){++++++}, at: [<c0029e6c>] get_online_cpus+0x48/0xb8
  #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4

 stack backtrace:
 CPU: 2 PID: 1723 Comm: trace.sh Not tainted 4.4.0+ #445
 Hardware name: ARM-Versatile Express
 [<c001883c>] (unwind_backtrace) from [<c0013f50>] (show_stack+0x20/0x24)
 [<c0013f50>] (show_stack) from [<c044ad90>] (dump_stack+0x80/0xb4)
 [<c044ad90>] (dump_stack) from [<c0128edc>] (print_circular_bug+0x29c/0x2f0)
 [<c0128edc>] (print_circular_bug) from [<c0081708>] (__lock_acquire+0x163c/0x1d74)
 [<c0081708>] (__lock_acquire) from [<c008238c>] (lock_acquire+0xd4/0x20c)
 [<c008238c>] (lock_acquire) from [<c01f6ae4>] (__kernfs_remove+0x288/0x328)
 [<c01f6ae4>] (__kernfs_remove) from [<c01f78c8>] (kernfs_remove_by_name_ns+0x4c/0x94)
 [<c01f78c8>] (kernfs_remove_by_name_ns) from [<c01fa024>] (remove_files+0x44/0x88)
 [<c01fa024>] (remove_files) from [<c01fa5a4>] (sysfs_remove_group+0x50/0xa4)
 [<c01fa5a4>] (sysfs_remove_group) from [<c058285c>] (cpufreq_governor_dbs+0x3f0/0x5d4)
 [<c058285c>] (cpufreq_governor_dbs) from [<c0017c10>] (return_to_handler+0x0/0x18)

Now, I couldn't yet make sense of this, but it seems to be
triggered by setting ondemand, printing its attributes and then
switching to conservative (that's what sp2 does, right?). Also, s_active
seems to come into play only when lockdep is enabled. Are you seeing
this as well?

> > Now that
> > users of this should be holding policy->rwsem, so that should suffice
> > for protecting governor_enabled, as governor_enabled is only changed
> > inside here.
> 
> If we can get rid of the rwsem dropping problem, then yeah this can be
> killed for sure.
> 

OK.

> > I run some test on a x86 box I setup and didn't see anything related to
> > this. I'll wait to get the first 0-day report anyway.
> 

0-day is setup. I didn't yet receive any major bad thing from it :).

> Okay, so run the above test and make sure you have following enabled
> in your configuration:
> 
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> 

Yep, that's what I normally use for developing.

Thanks,

- Juri

> > > > -	mutex_lock(&cpufreq_governor_mutex);
> > > >  	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
> > > >  	    || (!policy->governor_enabled
> > > >  	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
> > > > -		mutex_unlock(&cpufreq_governor_mutex);
> > > >  		return -EBUSY;
> > > >  	}
> > > 
> > > Actually the above checks should also be removed as the governors are
> > > responsible for maintaining their state machines. But
> > > userspace/powersave/performance don't have that support yet and so
> > > these checks save them from going into undefined states.
> > > 
> > > Over that, above and below checks are incomplete..
> > > 
> > 
> > You mean we need an additional patch that extends the checks performed?
> 
> Yeah, we need to add some state-management code in
> userspace/powersave/performance governors as well.
> 
> -- 
> viresh
> 
