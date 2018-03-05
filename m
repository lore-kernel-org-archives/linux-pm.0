From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
Date: Mon, 5 Mar 2018 12:47:23 +0100
Message-ID: <CAJZ5v0gdsSXOLL=nJW801L0LzE0CeyPCCrgq4_0tyi40wNLa+w@mail.gmail.com>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2332986.m9oRvTSu8E@aspire.rjw.lan>
 <20180305113803.GO25201@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305113803.GO25201@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 5, 2018 at 12:38 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 11:26:24PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> In order to address the issue with short idle duration predictions
>> by the idle governor after the tick has been stopped, prepare the
>> menu governor code for reordering with respect to the timekeeping
>> code that stops the tick.
>>
>> Use the observation that menu_select() can be split into two
>> functions, one predicting the idle duration and one selecting the
>> idle state, and rework it accordingly.
>
> I actually think this is the wrong way around.

In the meantime I concluded that this patch and the next one are
overdesign really.  I have a replacement for the two already. :-)

The only thing I need is the expected idle duration that can be
returned from ->select too.

> We really should be predicting state not duration. Yes the duration
> thing is an intermediate value, but I don't think it makes any sense
> what so ever to preserve that in the predictor. The end result is the
> idle state, we should aim for that.
>
> As per:
>
>   https://lkml.org/lkml/2017/7/18/615
>
> there are definite advantages to _not_ preserving duration information
> beyond the state boundaries.

Well, OK

The reason why I need the predicted idle duration is because the
target residency of the selected state may be below the tick period
duration and if this is the deepest state available, we still want to
stop the tick if the predicted idle duration is long.

IOW, the target residency of the selected state doesn't tell you how
much time you should expect to be idle in general.
