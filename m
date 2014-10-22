From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: lockdep splat in CPU hotplug
Date: Wed, 22 Oct 2014 14:37:28 -0400
Message-ID: <20141022143728.18d1eb3d@gandalf.local.home>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz>
	<20141021145809.GA799@home.goodmis.org>
	<alpine.LNX.2.00.1410211703170.24255@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1410211703170.24255@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 21 Oct 2014 17:04:17 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Tue, 21 Oct 2014, Steven Rostedt wrote:
> 
> > > Please have a look at the very first stacktrace in the dump, where lockdep 
> > > is trying to explain where cpu_hotplug.lock#2 has been acquired. It seems 
> > > to imply that cpuidle_pause() is taking cpu_hotplug.lock, but that's not 
> > > the case at all.
> > > 
> > > What am I missing?
> > > 
> > 
> > > -> #1 (cpu_hotplug.lock#2){+.+.+.}:
> > >         [<ffffffff81099fac>] lock_acquire+0xac/0x130
> > >         [<ffffffff815b9f2c>] mutex_lock_nested+0x5c/0x3b0
> > >         [<ffffffff81491892>] cpuidle_pause+0x12/0x30
> > >         [<ffffffff81402314>] dpm_suspend_noirq+0x44/0x340
> > >         [<ffffffff81402958>] dpm_suspend_end+0x38/0x80
> > >         [<ffffffff810a07bd>] hibernation_snapshot+0xcd/0x370
> > >         [<ffffffff810a1248>] hibernate+0x168/0x210
> > >         [<ffffffff8109e9b4>] state_store+0xe4/0xf0
> > >         [<ffffffff813003ef>] kobj_attr_store+0xf/0x20
> > >         [<ffffffff8121e9a3>] sysfs_kf_write+0x43/0x60
> > >         [<ffffffff8121e287>] kernfs_fop_write+0xe7/0x170
> > >         [<ffffffff811a7342>] vfs_write+0xb2/0x1f0
> > >         [<ffffffff811a7da4>] SyS_write+0x44/0xb0
> > >         [<ffffffff815be856>] system_call_fastpath+0x16/0x1b
> > 
> > Yeah, this backtrace looks totally bogus. Unless there's some magic going on
> > with grabbing the get_online_cpus here?
> > 
> > Could you send your config. Maybe it has to do with some debug magic?
> 
> .config attached.
> 

Can you reproduce this all the time? I tried this config and pm-suspend
and pm-hibernate, and they both worked fine without a single lockdep
splat.

-- Steve
