From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
Date: Mon, 5 Mar 2018 14:53:22 +0100
Message-ID: <20180305135322.GV25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2332986.m9oRvTSu8E@aspire.rjw.lan>
 <20180305113803.GO25201@hirez.programming.kicks-ass.net>
 <CAJZ5v0gdsSXOLL=nJW801L0LzE0CeyPCCrgq4_0tyi40wNLa+w@mail.gmail.com>
 <20180305125012.GA25181@hirez.programming.kicks-ass.net>
 <CAJZ5v0g5x9EWh0MH7wUh4sem9aYB-JuWb_Pn96qNwj=XefOcHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g5x9EWh0MH7wUh4sem9aYB-JuWb_Pn96qNwj=XefOcHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 05, 2018 at 02:05:10PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 5, 2018 at 1:50 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Mar 05, 2018 at 12:47:23PM +0100, Rafael J. Wysocki wrote:

> >> IOW, the target residency of the selected state doesn't tell you how
> >> much time you should expect to be idle in general.
> >
> > Right, but I think that measure isn't of primary relevance. What we want
> > to know is: 'should I stop the tick' and 'what C state do I go to'.
> >
> > In order to answer those questions we need durations as input, but I
> > don't think we should preserve durations throughout. The scheme from the
> > above link reduces to N states in order to deal with arbitrary
> > distributions, only the actual states -- ie boundaries where our answers
> > changes -- are relevant, anything inside those boundaries would lead to
> > the exact same answer anyway.
> 
> I generally agree here, but I'm not convinced about flagging the
> states, splitting them and so on.

I think linking them like that makes sense, but I can see room for
discussion...

> Maybe just return a "nohz" indicator from cpuidle_select() in addition
> to the state index and make the decision in the governor?

Much better option than returning a duration :-)
