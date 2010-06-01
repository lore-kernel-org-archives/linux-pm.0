From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 14:39:29 -0700 (PDT)
Message-ID: <599286.8177.qm__568.236891604279$1275428429$gmane$org@web180301.mail.gq1.yahoo.com>
References: <1275426085.21962.967.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275426085.21962.967.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, James Bottomley <James.Bottomley@suse.de>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

--- On Tue, 6/1/10, James Bottomley <James.Bottomley@suse.de> wrote:

> > As long as you can set a wakeup timer, an S state is just a C state with 
> > side effects.

I've seen similar statements on this endless
thread before; they're not quite true...


> > The significant one is that entering an
> > S state stops the process scheduler and
> > any in-kernel timers.

There's a structural difference too, related
to peripheral device activity and power states.

Specifically, peripherals can be active in C
states (erforming I/O, maybe with DMA etc) and
 will in general not be in lowest power states
(PCI etc).  Whereas entry to ACPI S-states
involves calling the AML code to put those
peripherals into lowest power modes ... ones
they can't in general enter at run time.  (An
additional task of that bytecode is to activate
any wakeup logic, which again is not generally
functional in except in S-states).


The point being perhaps more that ACPI doesn't
map well to the more power-efficient architectures
(often built on ARM) ... hardware vendors provide
all kinds of PM hooks, and Linux can choose between
them so it's more power-miserly than if it tried
to emulate an ACPI based platform.

I've seen some Linux systems which put DRAM into
self-refresh during certain idle modes, for example,
not just during suspend-to-RAM, if it's known that
no DMA is active.  (Why not save that power if it's
safe?)  Likewise, disable some oscillators and PLLs
if they're not needed (the clock API allows that to
be done regardless of "C-states" etc).

The notion of "suspend" gets introduced on such
systems primarily to match the ACPI-ish models  that
exist ... rather than because they necessarily make
good matches for the hardware.  Which has left a
puzzle:  how and why to use such "suspend" models?

Maybe that's underlying some of the pushback for
the notion of automagic entry to "suspend" states.

- Dave
