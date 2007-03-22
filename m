From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 16:55:16 -0700
Message-ID: <200703221655.17693.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221556.08948.david-b@pacbell.net>
	<200703230021.04470.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703230021.04470.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 4:21 pm, Rafael J. Wysocki wrote:

> > My answer:  there is NO value to such an arbitrary restriction.
> =

> I'm not talking on restrictions.

You most certainly did talk about them.  You said that if the =

hardware doesn't support a "turn CPU off" mode, then you'd
define that as being incapable of implementing suspend-to-RAM.
That's a restriction ... a very arbitrary one.


> I'm talking on being able to define =

> _anything_ more precisely then just a low-power system-wide state.

Me too.  And I'm trying to convey to you the results of the
investigations I did on that topic.  You don't seem to like
those results though ...


> And let's start from just something, please.  Like STR and "standby" to b=
egin
> with?  At least on ACPI systems we can distinguish one from the other qui=
te
> clearly, so why can't we start from that and _then_ generalize?

That's exactly what I did.  Looked also at APM, and several
different SOC designs (AT91, OMAP1, PXA25x, SA1100, more).

The generalization I came up with is what I've described.
Namely, that coming up with one definition of those states
that can usefully be mapped all platforms is impractical.
They're just labels.  The platform implementor can choose
two states to implement, but non-x86 hardware states rarely
match the expectations of ACPI.

So the fundamental definition needs to be in relative terms,
because platform-specific differences otherwise make trouble.

- Dave
