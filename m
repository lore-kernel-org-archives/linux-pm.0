From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpufreq: Make iowait boost a policy option
Date: Sat, 10 Jun 2017 15:56:28 +0200
Message-ID: <20170610135628.GL8337@worktop.programming.kicks-ass.net>
References: <20170519062344.27692-1-joelaf@google.com>
 <20170519062344.27692-2-joelaf@google.com>
 <20170519094245.ztm6tt2iwkaiwsya@hirez.programming.kicks-ass.net>
 <CAJWu+opefgyzER6jKTa1ktrT4pGL=bKdhAP2+i40k5tYAR38wA@mail.gmail.com>
 <20170522082154.f57cqovterd2qajv@hirez.programming.kicks-ass.net>
 <CAJWu+op_QRJWt=L=gGOk15pryD+1pm5xk9q90yt9wD1insdEzA@mail.gmail.com>
 <CAJWu+opua5nw5w=hUUNWVWekV_6HBPb1mM3PgR8VN=GcoTwMgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39839 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdFJN4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2017 09:56:39 -0400
Content-Disposition: inline
In-Reply-To: <CAJWu+opua5nw5w=hUUNWVWekV_6HBPb1mM3PgR8VN=GcoTwMgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Sat, Jun 10, 2017 at 01:08:18AM -0700, Joel Fernandes wrote:

> Adding Juri and Patrick as well to share any thoughts. Replied to
> Peter in the end of this email.

Oh sorry, I completely missed your earlier reply :-(

> On Wed, May 24, 2017 at 1:17 PM, Joel Fernandes <joelaf@google.com> wrote:
> > On Mon, May 22, 2017 at 1:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> >> Suppose your (I/O) device has the task waiting for a completion for 1ms
> >> for each request. Further suppose that feeding it the next request takes
> >> .1ms at full speed (1 GHz).
> >>
> >> Then we get, without contending tasks, a cycle of:
> >>
> >>
> >>  R----------R----------                                 (1 GHz)
> >>
> >>
> >> Which comes at 1/11-th utilization, which would then select something
> >> like 100 MHz as being sufficient. But then the R part becomes 10x longer
> >> and we end up with:
> >>
> >>
> >>  RRRRRRRRRR----------RRRRRRRRRR----------               (100 MHz)
> >>
> >>
> >> And since there's still plenty idle time, and the effective utilization
> >> is still the same 1/11th, we'll not ramp up at all and continue in this
> >> cycle.
> >>
> >> Note however that the total time of the cycle increased from 1.1ms
> >> to 2ms, for an ~80% decrease in throughput.
> >
> > Got it, thanks for the explanation.
> >
> >>> Are you trying to boost the CPU frequency so that a process waiting on
> >>> I/O does its next set of processing quickly enough after iowaiting on
> >>> the previous I/O transaction, and is ready to feed I/O the next time
> >>> sooner?
> >>
> >> This. So we break the above pattern by boosting the task that wakes from
> >> IO-wait. Its utilization will never be enough to cause a significant
> >> bump in frequency on its own, as its constantly blocked on the IO
> >> device.
> >
> > It sounds like this problem can happen with any other use-case where
> > one task blocks on the other, not just IO. Like a case where 2 tasks
> > running on different CPUs block on a mutex, then on either task can
> > wait on the other causing their utilization to be low right?

No, with two tasks bouncing on a mutex this does not happen. For both
tasks are visible and consume time on the CPU. So, if for example, a
task A blocks on a task B, then B will still be running, and cpufreq
will still see B and provide it sufficient resource to keep running.
That is, if B is cpu bound, and we recognise it as such, it will get
full CPU.

The difference with the IO is that the IO device is completely
invisible. This makes sense in that cpufreq cannot affect the devices
performance, but it does lead to the above issue.

> >>> The case I'm seeing a lot is a background thread does I/O request and
> >>> blocks for short period, and wakes up. All this while the CPU
> >>> frequency is low, but that wake up causes a spike in frequency. So
> >>> over a period of time, you see these spikes that don't really help
> >>> anything.
> >>
> >> So the background thread is doing some spurious IO but nothing
> >> consistent?
> >
> > Yes, its not a consistent pattern. Its actually a 'kworker' that woke
> > up to read/write something related to the video being played by the
> > YouTube app and is asynchronous to the app itself. It could be writing
> > to the logs or other information. But this definitely not a consistent
> > pattern as in the use case you described but intermittent spikes. The
> > frequency boosts don't help the actual activity of playing the video
> > except increasing power.

Right; so one thing we can try is to ramp-up the boost. Because
currently its a bit of an asymmetric thing in that we'll instantly boost
to max and then slowly back off again.

If instead we need to 'earn' full boost by repeatedly blocking on IO
this might sufficiently damp your spikes.

> >> Also note that if you set the boost OPP to the lowest OPP you
> >> effectively do disable it.
> >>
> >> Looking at the code, it appears we already have this in
> >> iowait_boost_max.
> >
> > Currently it is set to:
> >  sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq
> >
> > Are you proposing to make this a sysfs tunable so we can override what
> > the iowait_boost_max value is?

Not sysfs, but maybe cpufreq driver / platform. For example have it be
the OPP that provides the max Instructions per Watt.

> Peter I didn't hear back from you. Maybe my comment here did not make
> much sense to you? 

Again sorry; I completely missed it :/

> That could be because I was confused what you meant by
> iowait_boost_max setting to 0. Currently afaik there isn't an upstream
> way of doing this. Were you suggesting making iowait_boost_max as a
> tunable and setting it to 0?

Tunable as in exposed to the driver, not userspace.

But I'm hoping an efficient OPP and the ramp-up together would be enough
for your case and also still work for our desktop/server loads.
