From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] IRQ: don't suspend nested_thread irqs over system suspend.
Date: Sat, 31 Jan 2015 00:51:17 +0100
Message-ID: <7535701.LlWsyNLDEC@vostro.rjw.lan>
References: <20150131092545.33ed35b8@notabene.brown> <1465455.9L1ju05BhM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7657109.bRSz8HkkgZ"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58337 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760342AbbA3X2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 18:28:35 -0500
In-Reply-To: <1465455.9L1ju05BhM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>


--nextPart7657109.bRSz8HkkgZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, January 31, 2015 12:06:37 AM Rafael J. Wysocki wrote:
> On Saturday, January 31, 2015 09:25:45 AM NeilBrown wrote:
> >=20
> > Nested IRQs can only fire when the parent irq fires.
> > So when the parent is suspended, there is no need to suspend
> > the child irq.
> >=20
> > Suspending nested irqs can cause a problem is they are suspended or=

> > resumed in the wrong order.
> > If an interrupt fires while the parent is active but the child is
> > suspended, then the interrupt will not be acknowledged properly
> > and so an interrupt storm can result.
> > This is particularly likely if the parent is resumed before
> > the child, and the interrupt was raised during suspend.
> >=20
> > Ensuring correct ordering would be possible, but it is simpler
> > to just never suspend nested interrupts.  This patch does that.
>=20
> Clever. :-)
>=20
> This is fine by me.  Thomas, what do you think?

It looks like I've overlooked a potential problem, though.

Can a nested interrupt be a wakeup one?  We won't set IRQD_WAKEUP_ARMED=
 for it
then and may not handle wakeup correctly.

> > This patch allows the IRQF_EARLY_RESUME to be removed from
> > twl4030_sih_setup().  That flag attempts to fix the same problem
> > is a very different way, but causes
> >=20
> > [   56.095825] WARNING: CPU: 0 PID: 3 at ../kernel/irq/manage.c:661=
 irq_nested_primary_handler+0x18/0x28()
> > [   56.095825] Primary handler called for nested irq 348
> >=20
> > warnings on resume.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> >=20
> > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > index 3ca532592704..40cbcfb7fc43 100644
> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -118,6 +118,8 @@ void suspend_device_irqs(void)
> >  =09=09unsigned long flags;
> >  =09=09bool sync;
> > =20
> > +=09=09if (irq_settings_is_nested_thread(desc))
> > +=09=09=09continue;
> >  =09=09raw_spin_lock_irqsave(&desc->lock, flags);
> >  =09=09sync =3D suspend_device_irq(desc, irq);
> >  =09=09raw_spin_unlock_irqrestore(&desc->lock, flags);
> > @@ -158,6 +160,8 @@ static void resume_irqs(bool want_early)
> > =20
> >  =09=09if (!is_early && want_early)
> >  =09=09=09continue;
> > +=09=09if (irq_settings_is_nested_thread(desc))
> > +=09=09=09continue;
> > =20
> >  =09=09raw_spin_lock_irqsave(&desc->lock, flags);
> >  =09=09resume_irq(desc, irq);
>=20
>=20

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart7657109.bRSz8HkkgZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJUzBj6AAoJEILEb/54YlRxL9wP/RBN9HylTlQ+YgANBfyllvR2
CydmW5T52ZAxIogc+Y0urTZM/4ETyJ0t1Ozs73rJkySNFmFDxiHjYK3dhWLOlKCb
Ly4RsCn0khUZXh9rvLFBndPo0hkoL7oMGpnr5cLI21SE5OGxtpWnaRF6uaZLQUJl
Bu7LG61wxiwag+wFcXJzn2DjbaCJ7pfgqwOKKC1dVviZi3OU2JABTSRpPZ4BbY7n
l/YH7Yx9PlHNnIXfeB8gW0ifHAiKbi6biuYKqFicVMR2225IFK8XRKK7BHLwP9ix
2aPXd4y6GC8yXvu2xh4m4JLQjp1hiXZIBtJDZtQuvcpbHffe8hai4NNJiJxv31do
yFCJm8sIa6mFecogpoSV+9rtWv35TPubwbJAnsg4oI+glwGGUSTBfD0ldvaHSpC0
uYWqtlaOPD3hqUQiMGTB6HkmSbNXrqYj1IYdGaR+1x5YKBSu3XvAsEtggGK/Gsqi
ZXYOw8+l/lp+gyRGoLjUfPK9UuCbHt33rsmdrX95+6pzt2oCjW65dG2p7ldoKfjn
JOyABT0K3BnhMLii2QvOpoNsbLeyQTGQ+ebIUAjwFVtnnfG+dQRtLiUfvYhR8/4c
nB1UxKQrYfk0hGoLgwyaqfD3OND3dM6Q+qpEjWb3Lsd60HOoFjz7f9/95oQllEz8
78nyT/AAkbGJpx6grPjs
=c1fF
-----END PGP SIGNATURE-----

--nextPart7657109.bRSz8HkkgZ--

