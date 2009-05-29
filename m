From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Fri, 29 May 2009 20:18:38 +0200
Message-ID: <200905292018.39247.rjw__42366.5001093925$1243621238$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0905290942150.2882-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905290942150.2882-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 29 May 2009, Alan Stern wrote:
> On Fri, 29 May 2009, Magnus Damm wrote:
> 
> > > (And by the way, the _noirq ops don't run in atomic context.  They run
> > > in process context with most interrupt deliveries disabled.  It's not
> > > the same thing -- they are allowed to sleep.)
> > 
> > Huh, so if they are allowed to sleep then clock events are still
> > running. And probably some clocksource as well. I guess that's why you
> > say "most" interrupts disabled instead of all. Sharing the timer IRQ
> > is not allowed then?
> 
> Rafael can tell you.  But notice I didn't say the interrupts were
> disabled -- I said that interrupt _delivery_ was disabled.  In general
> the interrupts themselves _are_ enabled; the kernel fields them but
> then does not call the drivers' interrupt handler routines.

That's correct, except for the platforms where __disable_irq() actually masks
the IRQ.  I'm not sure if SuperH is one of these.

> (Except perhaps for IRQs which are explicitly marked as wakeup sources...)

No, they are treated just like the other ones except that we check if any of
them are pending right at the beginning of sysdev_suspend().

> > I wonder if the PM code assumes that the clock event is a sys device?

Yes, it does.

> > We use platform drivers for clock events on SuperH...

Argh.  This is going to hurt, but I'm not sure how badly.  At least on
multiprocessor.

Best,
Rafael
