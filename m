From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Wed, 12 Feb 2014 14:05:13 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402121404280.17677@knanqh.ubzr>
References: <52EBBC23.8020603@linux.intel.com> <52EBC33A.6080101@linaro.org> <52EBC645.2040607@linux.intel.com> <alpine.LFD.2.11.1401311236470.2312@knanqh.ubzr> <20140203125441.GD19029@e103034-lin> <52EFA9D3.1030601@linux.intel.com>
 <20140203145605.GL8874@twins.programming.kicks-ass.net> <52EFC12B.50704@linux.intel.com> <20140212151626.GE28661@e102568-lin.cambridge.arm.com> <52FB9DEE.9020200@linux.intel.com> <20140212173758.GF28661@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140212173758.GF28661@e102568-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Preeti Murthy <preeti.lkml@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Feb 2014, Lorenzo Pieralisi wrote:

> On Wed, Feb 12, 2014 at 04:14:38PM +0000, Arjan van de Ven wrote:
> > 
> > >> sched_cpu_cache_wiped(int llc)
> > >>
> > >> that would be very nice for this; the menuidle side knows this
> > >> for some cases and thus can just call it. This would be a very
> > >> small and minimal change
> > >
> > > What do you mean by "menuidle side knows this for some cases" ?
> > > You mean you know that some C-state entries imply llc clean/invalidate ?
> > 
> > in the architectural idle code we can know if the llc got flushed
> > there's also the per core flags where we know with reasonable certainty
> > that the per core caches got flushed.
> 
> Ok, but that's arch specific, not something we can detect from the menu
> governor in generic code , that's what I wanted to ask because it was not
> clear.

I would think this is meant to be called from architecture specific 
backend code.


Nicolas
