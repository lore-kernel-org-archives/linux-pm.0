From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
Date: Tue, 10 Apr 2018 14:26:04 +0200
Message-ID: <20180410122604.GE4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
 <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
 <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
 <20180410112637.GD4082@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1804101407040.2058@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804101407040.2058@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: yuankuiz@codeaurora.org, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2018 at 02:07:32PM +0200, Thomas Gleixner wrote:
> On Tue, 10 Apr 2018, Peter Zijlstra wrote:
> > Do you have any actual evidence for that? Is there a compiler stupid
> > enough to generate code to convert a bool to a 1bit value?
> 
> Sure, if you do:
> 
> > > > > > > +       bool                            tick_stopped    : 1;
> 
> which is stupidly allowed by the standard....

The code-gen changes are because of the layout change, not because of
the type change.
