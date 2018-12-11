From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Tue, 11 Dec 2018 10:51:48 +0100
Message-ID: <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com> <20181210225134.GB24811@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210225134.GB24811@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 10, 2018 at 10:36:40PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > One question on this; why is this tracked unconditionally?
> >
> > Because I didn't quite see how to make that conditional in a sensible way.
>
> Something like:
>
>         if (static_branch_unlikely(__tracepoint_idle_above) ||
>             static_branch_unlikely(__tracepoint_idle_below)) {
>
>                 // do stuff that calls trace_idle_above() /
>                 // trace_idle_below().
>
>         }
>
> > These things are counters and counting with the help of tracepoints
> > isn't particularly convenient (and one needs debugfs to be there to
> > use tracepoints and they require root access etc).
>
> Root only should not be a problem for a developer; and aren't these
> numbers only really interesting if you're prodding at the idle governor?

What about regression testing?

> > > Would not a tracepoint be better?; then there is no overhead in the
> > > normal case where nobody gives a crap about these here numbers.
> >
> > There is an existing tracepoint that in principle could be used to
> > produce this information, but it is such a major PITA in practice that
> > nobody does that.  Guess why. :-)
>
> Sounds like you need to ship a convenient script or something :-)

That would be a very ugly script.  Also I'd need to expose
drv->states[i].disabled somehow (that's not accessible from user space
now).

> > Also, the "usage" and "time" counters are there in sysfs, so why not these two?
> >
> > And is the overhead really that horrible?
>
> Dunno; it could be cold cachelines, at which point it can be fairly
> expensive. Also, being stuck with API is fairly horrible if you want to
> 'fix' it.

All of the cache lines involved should've been touched earlier in this
code path by the governor.  At least menu and the new one both touch
them.

The API part I'm not too worried about.  I know it is useful and two
other people have told that to me already. :-)
