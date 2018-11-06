From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Date: Wed, 7 Nov 2018 00:39:31 +0100
Message-ID: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com> <20181106195127.GD9781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106195127.GD9781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Instead of this detector; why haven't you used the code from
> > > kernel/irq/timings.c ?
> >
> > Because it doesn't help much AFAICS.
> >
> > Wakeups need not be interrupts in particular
>
> You're alluding to the MWAIT wakeup through the MONITOR address ?

Yes.

> > and interrupt patterns that show up when the CPU is busy may not be
> > relevant for when it is idle.
>
> I think that is not always true; consider things like the periodic
> interrupt from frame rendering or audio; if there is nothing more going
> on in the system than say playing your favourite tune, it gets the
> 'need more data soon' interrupt from the audio card, wakes up, does a little
> mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
> sleep. Same for video playback I assume, the vsync interrupt for buffer
> flips is fairly predictable.
>
> The interrupt predictor we have in kernel/irq/timings.c should be very
> accurate in predicting those interrupts.

In the above case the interrupts should produce a detectable pattern
of wakeups anyway.

In general, however, I need to be convinced that interrupts that
didn't wake up the CPU from idle are relevant for next wakeup
prediction.  I see that this may be the case, but to what extent is
rather unclear to me and it looks like calling
irq_timings_next_event() would add considerable overhead.
