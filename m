From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/PATCH] PM / Sleep: Timer quiesce in freeze state
Date: Wed, 29 Oct 2014 09:24:32 +0100
Message-ID: <20141029082432.GV3337@twins.programming.kicks-ass.net>
References: <5446787E.60202@linux.intel.com>
 <20141024153656.GM12706@worktop.programming.kicks-ass.net>
 <544DE5CF.9040501@linux.intel.com>
 <20141027074419.GE10501@worktop.programming.kicks-ass.net>
 <544F4B31.7050308@linux.intel.com>
 <20141028082503.GN3337@twins.programming.kicks-ass.net>
 <5450253B.5020802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5450253B.5020802@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 29, 2014 at 07:22:35AM +0800, Li, Aubrey wrote:
> On 2014/10/28 16:25, Peter Zijlstra wrote:
> > On Tue, Oct 28, 2014 at 03:52:17PM +0800, Li, Aubrey wrote:
> > 
> >> Both clocksource and clockevents are not per-cpu device, why do we need
> >> to run their suspend callback on *each* cpu?
> > 
> > Uhm, you mean to say we don't use per-cpu timer lists and per-cpu timer
> > hardware for clockevents then?
> > 
> 
> From OS level, currently tick device is per-cpu implementation while
> clocksource and clockevent devices are global device.
> 
> We already stop tick by clockevents_notify(suspend) on each cpu, that
> addresses per-cpu timer list.

Right, I know. But I was saying I might have confused myself between
events and sources while going through that call chain, thereby
(mistakenly) thinking the source suspend code needed more than the 1
cpu.

Its easy to confuse yourself trying to reverse engineer that opaque
callchain :-)

> And, we already call clocksource_suspend() and clockevents_suspend() in
> timekeeping_suspend() on the tick timer CPU. Yes, we didn't suspend
> per-cpu timer hardware on x86 because x86 does not have lapic timer
> suspend implementation. If we need to implement this, I think we can do
> the cross-CPU calls in clocksource/clockevents suspend(), but I didn't
> see any necessary we need to do this now.
> 
> so, I think we are okay now, :)

Right, I tend to agree, we'll find out quickly enough once those
platforms will try this code anyhow ;-)
