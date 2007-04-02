From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Mon, 2 Apr 2007 10:53:54 -0700
Message-ID: <200704021053.55370.david-b__17281.9422711202$1175540926$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
	<20070402165511.GD5024@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070402165511.GD5024@cosmic.amd.com>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On Monday 02 April 2007 9:55 am, Jordan Crouse wrote:
> On 01/04/07 17:28 -0700, David Brownell wrote:

> > > And so forth.  Like the AT91, we enable the wakeup events prior to
> > > suspending. I'm willing to bet that other PM methods like ACPI
> > > could pick this up pretty quickly too. =

> > =

> > With AT91 (and most ARMs) the wake events are normal IRQs, and the
> > irq infrastructure already handles wake events cleanly.  So I'd
> > claim they don't _want_ to change something that's inexpensive,
> > already deployed (training, code, testing, etc), and working.
> > =

> > So I hope you'll tolerate me if I view this as less of a "how do
> > we get a generic solution" and more of a "how does _this_ x86-ish
> > issue get solved cleanly".
> =

> Thats fair.  x86 does live in a different world then the other embedded
> chips.  I think its reasonable for the x86 folks to get their story strai=
ght
> and then move on from there.

And I think it's good that OLPC doesn't seem to be starved of the
relevant lowlevel chip specs, so the "story" can be based on what
the hardware needs, rather than only what ACPI allows.


> > > Moving =

> > > it into the PM infrastructure seems the best way to handle everybody
> > > equally, regardless of the relative intelligence or stupidity of thei=
r =

> > > hardware implementation.
> > =

> > I guess that's where we disagree:  you're assuming "one call to rule
> > them all", where I'm thinking that IRQ calls should manage IRQs,
> > PCI calls should manage PME#, and so on.
>  =

> Thats fine - I am not sold on a "one call to rule them all", but I do
> want to avoid any #ifdef CONFIG_PM_ACPI #elsif CONFIG_OLPC_PM #else
> nonsense.  =


Right.  In terms of source code, per-device callbacks can encapsulate
that neatly:  OLPC won't use ACPI files, and vice versa.  There may be
cases where that approach isn't enough, but it should cover a bunch
of the most important cases.  (Maybe OLPC won't need any more ...)


> We are keenly aware that we're committing a minor sin by implementing
> yet another PM interface for x86. =


I couldn't call it a sin unless I thought that ACPI were a Goddess,
to be worshipped at the altar of HP/Intel/Microsoft/Phoenix/Toshiba!
Somehow, I don't think you'll find many people who think that ... ;)


> But we believe that our heart is in the =

> right place, and we are dedicated to doing the right thing, and trying
> our hardest not to contribute further to fragmenting the PM subsystem with
> implementation specific code. In many cases we're looking to help
> bring the others into the fold, especially our fellow x86 implementations
> that suffer from the same issues that we do.

Implementation-specific stuff isn't really a problem except when sneaks
out into general purpose code.  At that point you want some abstractions
to hide those platform details.

Yes, I suspect you could be a big help to non-ACPI implementors on x86.


> I appreciate your comments, and the rtc-cmos code will go to good use.

Good!  RTCs are interesting to PM primarily because most platforms seem
to offer some kind of "wake alarm" mechanism ... which means they're a fair
test case for whether a cross-platform interface actually works!

- Dave
