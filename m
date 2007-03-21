From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Wed, 21 Mar 2007 16:25:22 -0700
Message-ID: <200703211625.23253.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<Pine.LNX.4.60.0703212325560.7211@poirot.grange>
	<20070321225730.GL6057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321225730.GL6057@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

[ removed crosspost to linux-arm, members-only ]

On Wednesday 21 March 2007 3:57 pm, Pavel Machek wrote:
> Hi!
> =

> > > Which is very much an indication of how weak ACPI is.  It
> > > doesn't contemplate typical SOC behavior, which have a wide
> > > variety of system sleep states that leave the CPU on ... and
> > > which may not even *have* (or need!) a "cpu off" state.
> > > =

> > > My own definition would be more like:  the minimal RAM-based
> > > power-saving system state is "standby".  If the system
> > > implements a deeper RAM-based system sleep state, that's "STR".
> > =

> > Hmmm, this leaves the decision how to call each state COMPLETELY to the =

> > implementor, doesn't it?

Not really.  Standby is not as deep a sleep state as STR, so it
would be wrong to have it save more power than STR.

And remember that the implementor must make various decisions in
any case, since the SOC probably has half a dozen distinct
low power states, but Linux can only name two of them.


> Is that a problem? If someone is clever enough to implement suspend, I
> think we can trust them to name their states right.

Modulo my earlier comment, showing that you **don't** need to be
especially clever to implement a "standby" on most systems ... !

 =

> (And trust me, we can flame them if not).
> =

> (Anyway, my definition would be "mem" =3D=3D RAM is powered, everything
> else is down, except for devices needed for wakeup; "standby" =3D=3D
> something is powered that can be powered down, we'll fix that in next ver=
sion).

That implies that standby is less desirable, and wouldn't be used much.

That's a false implication.  Among other things, it may be more important
to have various wakeup event sources at moderate power, than to go
without them at lower power.  Simple math:  N hours at 75% power savings,
which lets the system become fully operational at any time; versus those
same hours at 0% power savings (full power), because STR (90% savings)
doesn't support some essential wakeup events.


Moreover, that assumes "powered" is the relevant issue, rather than for
example "clocked".  As in:  power is always applied everywhere, registers
are always preserved, but more clocks are gated off in deeper sleep states.

That "CPU and peripheral state is discarded" notion is NOT generally
applicable, so that it shouldn't be hard-coded into a definition of
what distinguishes the states given the "standby" and "mem" names.

- Dave
