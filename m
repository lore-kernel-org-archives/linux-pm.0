From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] IRQ: don't suspend nested_thread irqs over system suspend.
Date: Sat, 31 Jan 2015 00:06:37 +0100
Message-ID: <1465455.9L1ju05BhM@vostro.rjw.lan>
References: <20150131092545.33ed35b8@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1720934.r2CIFyKrKG"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53881 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760957AbbA3Wn7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 17:43:59 -0500
In-Reply-To: <20150131092545.33ed35b8@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>


--nextPart1720934.r2CIFyKrKG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, January 31, 2015 09:25:45 AM NeilBrown wrote:
>=20
> Nested IRQs can only fire when the parent irq fires.
> So when the parent is suspended, there is no need to suspend
> the child irq.
>=20
> Suspending nested irqs can cause a problem is they are suspended or
> resumed in the wrong order.
> If an interrupt fires while the parent is active but the child is
> suspended, then the interrupt will not be acknowledged properly
> and so an interrupt storm can result.
> This is particularly likely if the parent is resumed before
> the child, and the interrupt was raised during suspend.
>=20
> Ensuring correct ordering would be possible, but it is simpler
> to just never suspend nested interrupts.  This patch does that.

Clever. :-)

This is fine by me.  Thomas, what do you think?

> This patch allows the IRQF_EARLY_RESUME to be removed from
> twl4030_sih_setup().  That flag attempts to fix the same problem
> is a very different way, but causes
>=20
> [   56.095825] WARNING: CPU: 0 PID: 3 at ../kernel/irq/manage.c:661 i=
rq_nested_primary_handler+0x18/0x28()
> [   56.095825] Primary handler called for nested irq 348
>=20
> warnings on resume.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 3ca532592704..40cbcfb7fc43 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -118,6 +118,8 @@ void suspend_device_irqs(void)
>  =09=09unsigned long flags;
>  =09=09bool sync;
> =20
> +=09=09if (irq_settings_is_nested_thread(desc))
> +=09=09=09continue;
>  =09=09raw_spin_lock_irqsave(&desc->lock, flags);
>  =09=09sync =3D suspend_device_irq(desc, irq);
>  =09=09raw_spin_unlock_irqrestore(&desc->lock, flags);
> @@ -158,6 +160,8 @@ static void resume_irqs(bool want_early)
> =20
>  =09=09if (!is_early && want_early)
>  =09=09=09continue;
> +=09=09if (irq_settings_is_nested_thread(desc))
> +=09=09=09continue;
> =20
>  =09=09raw_spin_lock_irqsave(&desc->lock, flags);
>  =09=09resume_irq(desc, irq);

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart1720934.r2CIFyKrKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJUzA6HAAoJEILEb/54YlRxUz4P/0AI3rSnxIzCzruG+jRIUCGt
L62fyV++f6dT+QZ4vlGvgaz+GJbCDKkbOrzA8/t2UK0uNBOCzMTeL0eorpykiTm5
6eRQiHOilusINZ34fKYTOBmvExI29PVg6tsyju5aifx1+jcFejTmJERQksOjIIWi
bYVMNCfyp8NChgq2545eBZ8sCgpJ4Wi7iZx+SAaEyr7tKpx8asRWnHMTb30FjQDt
89g6NpYSDJ5YFZYSRdELVzDCxUGh/VOXaq/DV411rvWLLXUCDZT4JsGc4U73AzEe
5HUGceIAy/cPb3JRDAz1QwIxDmAr6ah9/J3xUio4QfpwXj5Qpmmz4rHjomXBWMF/
wmpwRx8NHhigCfj1jObe6CMieDOdM+Ck4t1rjh0j8naXjchRJ+o56h8JjtOsuN1p
KXfBT6bZWPINCFb/2BgLetLgiqe5lpE1ilt3c7Q7iEJk+C/KgiVmJ4MzbnNjB5Un
say1gbq91UDwVY34ZNFtoA0GCfD5Cta8FKiLvt4EYPbNhcpTTDH0WqUWy9RyNLvL
l6KIauFmK6WK1Fxqhmq6sVJf6bmfa3fVXSAy7k91Uu5I+wqAHS47K6kVa/h/K/2o
1APjLZSY+SJSZuQdNWV34eMf4yxkziD+/RhT1mtHqYvYv9MMvAuL+ZVIz/3m90lK
sK7usBC6r3rU5eXwPw63
=AO3S
-----END PGP SIGNATURE-----

--nextPart1720934.r2CIFyKrKG--

