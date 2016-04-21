From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Thu, 21 Apr 2016 19:17:15 +0200
Message-ID: <20160421171715.GJ3430@twins.programming.kicks-ass.net>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
 <6087716.bi8vDPiZNy@vostro.rjw.lan>
 <20160420140117.GZ3448@twins.programming.kicks-ass.net>
 <CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
 <57180293.1040809@intel.com>
 <CANRm+CwW_STS21Fu0iKs5gVps9OF8GFKB4ksqLqT=33O-hoOWg@mail.gmail.com>
 <20160421123341.GJ3408@twins.programming.kicks-ass.net>
 <CAJZ5v0j1krY6HO34QKY-NzJoc5jdS8C+qDQvDmWEZeOxE=5SQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39564 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcDURRY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 13:17:24 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j1krY6HO34QKY-NzJoc5jdS8C+qDQvDmWEZeOxE=5SQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Thu, Apr 21, 2016 at 07:07:51PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 21, 2016 at 2:33 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Apr 21, 2016 at 09:09:43AM +0800, Wanpeng Li wrote:
> >> >> Sometimes .update_curr hook is called w/o tasks actually running, it is
> >> >> captured by:
> >> >>
> >> >>          u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
> >> >>
> >> >> We should not trigger cpufreq update in this case for rt/deadline
> >> >> classes, and this patch fix it.
> >
> >> I add a print to print when delta_exec is zero for rt class, something
> >
> > So its zero, so what?
> >
> >> like below:
> >
> >>       watchdog/5-48    [005] d...   568.449105: update_curr_rt: rt
> >> delta_exec is zero
> >>       watchdog/5-48    [005] d...   568.449111: <stack trace>
> >>  => put_prev_task_rt
> >>  => pick_next_task_idle
> >
> > So we'll go idle, but as of this point we're still running the rt task.
> 
> Skipping the update in that case might be the right thing to do, though.

It is; the patch looks fine, but the Changelog is entirely
misleading/wrong.

Its not because the task isn't running; it is. Its because we end up
calling update_curr() multiple times and bailing when nothing changed is
indeed the right thing.




