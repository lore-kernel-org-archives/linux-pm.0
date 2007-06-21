From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Wed, 20 Jun 2007 23:57:49 -0700
Message-ID: <200706202357.50690.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0706201006190.3311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706201006190.3311-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 June 2007, Alan Stern wrote:
> On Wed, 20 Jun 2007, Rafael J. Wysocki wrote:
> 
> Pardon me for asking what may be a dumb question.  Why does ACPI (or
> anything else) need to know the target system state in order to decide
> how a device should be suspended or whether wakeup should be enabled?

Because the things that distinguish different states are
the particular resources that are available in that state.

A device that needs resource X to be active (e.g. to wake
that part of the system) can't stay active in states where
X is unavailable.  A device that won't issue wakeup events
can probably enter lower power states.

I think it'd be pure confusion to care about whether wakeup
"should" be enabled in this state versus that one.  Enable it
when it's requested and possible, but otherwise there's nothing
to be done.  Runtime PM policies will mostly avoid device states
where wakeup can't work (unless it's disabled for that device),
but if the system enters a state where it can't, tough!


One canonical example is portions of the clock tree that
are available in one state but not another.  My pet example
being the USB clock, often 48 MHz, not being available in
deeper sleep states ... e.g.

  http://lkml.org/lkml/2007/3/22/241
  http://lkml.org/lkml/2007/3/22/242

It's routine for system power states to care about clocks
like that.  PXA 25x docs are probably where I first ran
across that issue, but docs for pretty much any SOC will
talk first about clocks when discussing power management.
(Current flows when clocks tick ...)


Another is power domains.  ACPI talks about those (but not
clocks!) as board level things ... e.g. turn off this power
supply on the mainboard.  Newer SOCs must manage these for
on-chip devices too, since newer manufacturing processes
(with smaller feature sizes) involve higher leakage current
(flowing even when clocks don't tick).

- Dave
