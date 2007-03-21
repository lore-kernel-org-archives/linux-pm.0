From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Wed, 21 Mar 2007 23:57:30 +0100
Message-ID: <20070321225730.GL6057@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<200703201644.59046.david-b@pacbell.net>
	<Pine.LNX.4.60.0703212153350.7211@poirot.grange>
	<200703211507.55125.david-b@pacbell.net>
	<Pine.LNX.4.60.0703212325560.7211@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0703212325560.7211@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Which is very much an indication of how weak ACPI is.  It
> > doesn't contemplate typical SOC behavior, which have a wide
> > variety of system sleep states that leave the CPU on ... and
> > which may not even *have* (or need!) a "cpu off" state.
> > =

> > My own definition would be more like:  the minimal RAM-based
> > power-saving system state is "standby".  If the system
> > implements a deeper RAM-based system sleep state, that's "STR".
> =

> Hmmm, this leaves the decision how to call each state COMPLETELY to the =

> implementor, doesn't it?

Is that a problem? If someone is clever enough to implement suspend, I
think we can trust them to name their states right.

(And trust me, we can flame them if not).

(Anyway, my definition would be "mem" =3D=3D RAM is powered, everything
else is down, except for devices needed for wakeup; "standby" =3D=3D
something is powered that can be powered down, we'll fix that in next versi=
on).
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
