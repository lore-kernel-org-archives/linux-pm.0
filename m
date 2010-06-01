From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 02:54:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006010237340.2933__20529.0153659464$1275353813$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006010232.20263.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Jun 2010, Rafael J. Wysocki wrote:
> On Tuesday 01 June 2010, Neil Brown wrote:
> > My freerunner has a single core so without CONFIG_PREEMPT it may be that
> > there is no actual race-window - maybe the PRE_SUSPENDs will all run before a
> > soft_irq thread has a chance to finish handling of the interrupt (my
> > knowledge of these details is limits).  But on a muilti-core device I think
> > there would definitely be a race-window.
> 
> Yes, there always will be a race window.  The only thing we can do is to
> narrow it, but we cannot really close it (at least not on a PC, but I'm not
> really sure it can be closed at all).

It can be closed, when the state transition from normal event delivery
to wakeup mode is state safe, which it is on most platforms which are
designed for the mobile space.

Not so the current PC style x86 platforms, which are not relevant for
the problem at hand at all. Really, that stuff is going either to gain
sane properties or it's just going into the irrelevant realm.

Any attempt to solve the current x86/ACPI/BIOS/mess is waste of time
and is inevitably going to prevent progress.

> If you really want _all_ events to be delivered timely, the only way to go is
> to avoid using suspend (and use the idle framework for power management).

Amen.

	tglx
