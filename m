From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 00:32:24 +0100
Message-ID: <200703220032.26013.rjw@sisk.pl>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Ben Dooks <ben@simtec.co.uk>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 March 2007 23:57, Pavel Machek wrote:
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
> =

> Is that a problem? If someone is clever enough to implement suspend, I
> think we can trust them to name their states right.
> =

> (And trust me, we can flame them if not).
> =

> (Anyway, my definition would be "mem" =3D=3D RAM is powered, everything
> else is down, except for devices needed for wakeup; "standby" =3D=3D
> something is powered that can be powered down, we'll fix that in next ver=
sion).

I think we can define "standby" a bit more precisely.  Something like:
- processes are frozen,
- devices are suspended,
- nonboot CPUs are down (and in low powered states, if possible),
- "system" devices may or may not be suspended, depending on the platform,
- the boot CPU may or may not be in a low power state, depending on the pla=
tform,
- RAM is powered
- wake up need not be BIOS-driven (main difference from "mem")

Greetings,
Rafael
