From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] irq / PM: New driver interface for wakeup interrupts
Date: Fri, 01 Aug 2014 02:51:53 +0200
Message-ID: <18540471.qjHjCLCFs6@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1407311552530.885-100000@iolanthe.rowland.org> <1483885.6aPDiGeI4u@vostro.rjw.lan> <alpine.DEB.2.10.1408010134440.4997@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1408010134440.4997@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday, August 01, 2014 01:41:31 AM Thomas Gleixner wrote:
> On Thu, 31 Jul 2014, Rafael J. Wysocki wrote:
> > On Thursday, July 31, 2014 04:12:55 PM Alan Stern wrote:
> > > Pardon me for sticking my nose into the middle of the conversation, but
> > > here's what it looks like to me:
> > > 
> > > The entire no_irq phase of suspend/resume is starting to seem like a
> > > mistake.  We should never have done it.
> > 
> > In hindsight, I totally agree.  Question is what we can do about it now.
> 
> <SNIP>
> 
> > So how can we eliminate the noirq phase in a workable way?
> 
> The straight way to do that is breaking the world and some more and
> then fix up a gazillion of device drivers by doing a massive voodoo
> debugging effort simply because in most cases we do not get any useful
> information out of the system once the shit hits the fan.
> 
> We could add instrumentation to the core code about interrupts which
> are coming in unexpectedly during suspend, but that does not solve
> anything.
> 
> We really cannot call any device handler at that point as clocks might
> be turned off already and any access to a device register might simply
> cause a full undebuggable stall of the CPU.
> 
> And there is no way to prove that there is no chance of a spurious
> interrupt for a given device. 
> 
> So if we cannot handle it at the infrastructure level, we need to make
> sure that every fricking device driver interrupt handler has a 
> 
>      if (dev->suspended)
>      	return CRAP;
> 
> conditional as the first line of code in it.
> 
> What is that buying us? 
> 
> Nothing than a shitload of hard to understand problems, really. The
> only sensible way to handle this is at the core level.
> 
> #1 There is no way that you can rely on random drivers to do the Right
>    Thing. 
> 
> #2 There is no way that all hardware is implemented in a sane way.
> 
> #3 You CANNOT educate the people who are tasked to implement something
>    which "does the job" to understand all the subtle details of
>    suspend/resume or whatever.

These are fair points.

However, if the driver implements ->runtime_suspend, it has to handle
the "my device is suspended" condition in its interrupt handler regardless.

For such a driver doing the same over system suspend/resume shouldn't
be a real problem.

Rafael
