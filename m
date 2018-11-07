From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Date: Wed, 7 Nov 2018 13:09:58 +0100
Message-ID: <CAJZ5v0i4_TX_F=2hYKNpsG_QUPsn5EKiyfx2poE6SqsWyEp2Nw@mail.gmail.com>
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net> <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107085936.GI9781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 7, 2018 at 9:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > > Instead of this detector; why haven't you used the code from
> > > > > kernel/irq/timings.c ?
> > > >
> > > > Because it doesn't help much AFAICS.
> > > >
> > > > Wakeups need not be interrupts in particular
> > >
> > > You're alluding to the MWAIT wakeup through the MONITOR address ?
> >
> > Yes.
>
> Right, those will not be accounted for and will need something else.

Precisely. :-)

> > > > and interrupt patterns that show up when the CPU is busy may not be
> > > > relevant for when it is idle.
> > >
> > > I think that is not always true; consider things like the periodic
> > > interrupt from frame rendering or audio; if there is nothing more going
> > > on in the system than say playing your favourite tune, it gets the
> > > 'need more data soon' interrupt from the audio card, wakes up, does a little
> > > mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
> > > sleep. Same for video playback I assume, the vsync interrupt for buffer
> > > flips is fairly predictable.
> > >
> > > The interrupt predictor we have in kernel/irq/timings.c should be very
> > > accurate in predicting those interrupts.
> >
> > In the above case the interrupts should produce a detectable pattern
> > of wakeups anyway.
>
> Ah, not so. Suppose you have both the audio and video interrupt going at
> a steady rate but different rate, then the combined pattern isn't
> trivial at all.

It isn't trivial, but it will appear as a "pattern" to the pattern
detector in v4 of the patch.

Basically, all of that is about looking for a reason to select a
shallower idle state than indicated by the time till the closest timer
alone.

>From that standpoint it makes sense to look at several most recent
wakeups and see if a pattern is forming in there, which is what the
code in v4 of the patch does.  It also makes sense to look at
interrupt patters, but that is costly, so the overhead needs to be
justified.  The question to me is whether or not there is any
additional value in that given that the most recent wakeups are (and
IMO need to be) taken into consideration anyway.

> > In general, however, I need to be convinced that interrupts that
> > didn't wake up the CPU from idle are relevant for next wakeup
> > prediction.  I see that this may be the case, but to what extent is
> > rather unclear to me and it looks like calling
> > irq_timings_next_event() would add considerable overhead.
>
> How about we add a (debug) knob so that people can play with it for now?
> If it turns out to be useful, we'll learn.

So I'm inclined to try to invoke irq_timings_next_event() in addition
to looking at the most recent wakeups and see how far that can get us.

With some extra instrumentation in place it should be possible to
verify how much value that brings to the table.
