From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] irq / PM: New driver interface for wakeup interrupts
Date: Fri, 1 Aug 2014 10:41:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408011030200.1185-100000@iolanthe.rowland.org>
References: <alpine.DEB.2.10.1408010134440.4997@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1408010134440.4997@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Aug 2014, Thomas Gleixner wrote:

> Anyone who thinks that this can and should be solved at the driver
> level is simply taking the wrong drugs or ran out of supply of the
> proper ones. Either call your shrink or your drug dealer to get out of
> that.

That's absolutely true, but there is a counterpoint: Some of the 
problems in this area _must_ be fixed at the driver level.

In particular, any driver that:

	doesn't prevent its device from generating interrupt requests 
	while the system is suspended

	and allows its device to share an IRQ line with a wakeup source

has to be fixed.  The situation is even worse if the driver's interrupt 
handler blows up when called at an inopportune time (such as when 
clocks or power supplies are off).

Unfortunately, the only reasonable way to find such drivers is to wait
and see when the bad combination of events happens.

Alan Stern
