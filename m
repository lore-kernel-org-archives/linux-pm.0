From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Date: Mon, 5 Mar 2018 13:42:17 +0100
Message-ID: <20180305124217.GZ25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305114542.GP25201@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmmVTSnC52EgXxbHh6akCDeBw64w30F8npdpvyabNucw@mail.gmail.com>
 <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 05, 2018 at 01:07:07PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 5, 2018 at 12:50 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Mar 5, 2018 at 12:45 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> >> So I think this is entirely wrong, I would much rather see something
> >> like:
> >>
> >>         tick_nohz_idle_go_idle(next_state->nohz);
> >>
> >> Where the selected state itself has the nohz property or not.
> >
> > Can you elaborate here, I'm not following?
> >
> >> We can always insert an extra state at whatever the right boundary point
> >> is for nohz if it doesn't line up with an existing point.
> 
> OK, I guess I know what you mean: to add a state flag meaning "stop
> the tick if this state is selected".

Yes, that.

> That could work, but I see problems, like having to go through all of
> the already defined states and deciding what to do with them.

Shouldn't be too hard, upon registering a cpuidle driver to the cpuidle
core, the core could go through the provided states and flag all those <
TICK_USEC as not stopping, all those > TICK_USEC as stopping and
splitting the state we'd select for TICK_NSEC sleeps, stopping it for <
and disabling it for >.
