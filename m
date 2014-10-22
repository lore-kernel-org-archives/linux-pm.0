From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: lockdep splat in CPU hotplug
Date: Wed, 22 Oct 2014 16:36:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410221634550.22681@pobox.suse.cz>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz> <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz> <5447BEFE.2040806@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5447BEFE.2040806@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Dave Jones <davej@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Oct 2014, Daniel Lezcano wrote:

> > > I am seeing the lockdep report below when resuming from suspend-to-disk
> > > with current Linus' tree (c2661b80609).
> > > 
> > > The reason for CCing Ingo and Peter is that I can't make any sense of one
> > > of the stacktraces lockdep is providing.
> > > 
> > > Please have a look at the very first stacktrace in the dump, where lockdep
> > > is trying to explain where cpu_hotplug.lock#2 has been acquired. It seems
> > > to imply that cpuidle_pause() is taking cpu_hotplug.lock, but that's not
> > > the case at all.
> > > 
> > > What am I missing?
> > 
> > Okay, reverting 442bf3aaf55a ("sched: Let the scheduler see CPU idle
> > states") and followup 83a0a96a5f26 ("sched/fair: Leverage the idle state
> > info when choosing the "idlest" cpu") which depends on it makes the splat
> > go away.
> 
> Are you able to reproduce it by offlining the cpu and onlining it again ?

No, that doesn't trigger it (please note that all the relevant stacktraces 
from lockdep are going through hibernation).

-- 
Jiri Kosina
SUSE Labs
