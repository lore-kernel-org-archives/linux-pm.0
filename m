From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] IRQ: don't suspend nested_thread irqs over system
 suspend.
Date: Sat, 31 Jan 2015 14:37:47 +1100
Message-ID: <20150131143747.7b9a4f10@notabene.brown>
References: <20150131092545.33ed35b8@notabene.brown>
	<1465455.9L1ju05BhM@vostro.rjw.lan>
	<7535701.LlWsyNLDEC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/VyU9OGfJIcfK+NL+GSEgEso"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46737 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbbAaDiA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Jan 2015 22:38:00 -0500
In-Reply-To: <7535701.LlWsyNLDEC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>

--Sig_/VyU9OGfJIcfK+NL+GSEgEso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Jan 2015 00:51:17 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net>
wrote:

> On Saturday, January 31, 2015 12:06:37 AM Rafael J. Wysocki wrote:
> > On Saturday, January 31, 2015 09:25:45 AM NeilBrown wrote:
> > >=20
> > > Nested IRQs can only fire when the parent irq fires.
> > > So when the parent is suspended, there is no need to suspend
> > > the child irq.
> > >=20
> > > Suspending nested irqs can cause a problem is they are suspended or
> > > resumed in the wrong order.
> > > If an interrupt fires while the parent is active but the child is
> > > suspended, then the interrupt will not be acknowledged properly
> > > and so an interrupt storm can result.
> > > This is particularly likely if the parent is resumed before
> > > the child, and the interrupt was raised during suspend.
> > >=20
> > > Ensuring correct ordering would be possible, but it is simpler
> > > to just never suspend nested interrupts.  This patch does that.
> >=20
> > Clever. :-)
> >=20
> > This is fine by me.  Thomas, what do you think?
>=20
> It looks like I've overlooked a potential problem, though.
>=20
> Can a nested interrupt be a wakeup one?  We won't set IRQD_WAKEUP_ARMED f=
or it
> then and may not handle wakeup correctly.
>=20

I only have a fairly narrow understanding of this stuff, but if you have
nested interrupts, you would surely need the parent to be registered as a
wakeup interrupt, else the device wouldn't wake and the nested interrupt
would be ineffective until something else woke the device.

Very few files mention both '.irq_set_wake' and  'irq_set_nested'.

twl6040-irq.c has code to set irq_wake_enable  on the parent if any nested
irqs have had irq_set_wake calls.
tps6586x.c has something similar, but much simpler.
arizona-irq.c and rc5t583-irq.c do the same as tps6586x.c

So I think that any nested interrupts which might want to be wakeup
interrupts already deal with the issue, and I don't introduce a new problem
here.

Thanks,
NeilBrown

> > > This patch allows the IRQF_EARLY_RESUME to be removed from
> > > twl4030_sih_setup().  That flag attempts to fix the same problem
> > > is a very different way, but causes
> > >=20
> > > [   56.095825] WARNING: CPU: 0 PID: 3 at ../kernel/irq/manage.c:661 i=
rq_nested_primary_handler+0x18/0x28()
> > > [   56.095825] Primary handler called for nested irq 348
> > >=20
> > > warnings on resume.
> > >=20
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > >=20
> > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > index 3ca532592704..40cbcfb7fc43 100644
> > > --- a/kernel/irq/pm.c
> > > +++ b/kernel/irq/pm.c
> > > @@ -118,6 +118,8 @@ void suspend_device_irqs(void)
> > >  		unsigned long flags;
> > >  		bool sync;
> > > =20
> > > +		if (irq_settings_is_nested_thread(desc))
> > > +			continue;
> > >  		raw_spin_lock_irqsave(&desc->lock, flags);
> > >  		sync =3D suspend_device_irq(desc, irq);
> > >  		raw_spin_unlock_irqrestore(&desc->lock, flags);
> > > @@ -158,6 +160,8 @@ static void resume_irqs(bool want_early)
> > > =20
> > >  		if (!is_early && want_early)
> > >  			continue;
> > > +		if (irq_settings_is_nested_thread(desc))
> > > +			continue;
> > > =20
> > >  		raw_spin_lock_irqsave(&desc->lock, flags);
> > >  		resume_irq(desc, irq);
> >=20
> >=20
>=20


--Sig_/VyU9OGfJIcfK+NL+GSEgEso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVMxOCznsnt1WYoG5AQLTKxAAmoE3/G5/qQYM5aOcYeU2bp0/ucTE5Ev6
ovGlO7p5INOA/8lthRvLFOHgWrYSBL0Gn9+mujdWPCY8066/j7AL+nAxxr8SpndD
f6jusd2GWB3fEIGO2AS/4ogwyC8VXjJ3Nb07QSiT5dULz62zQtAGV8NMZx+q3aWu
kRa5eI2I83j200Udo3Ya0Qi0Atve2KhLmH5Wnsmo2T80esn1z2MsfpjODDjY2o/v
uLttOqnfDlcQ/54V+NFmssMpPYc2eco5LWeOd+EsOmOwS0T+M4FF2XukpcUIftSo
hc9JSgJ3yE/U+WKfjh1JC193HipLdKMHKDAp+k4i9I/vnQf3V1hGkwWwFUeCyPBA
42U7iSXCXNd6rP/ejkIsxXMTRBfFhqvevUaRP/Zb2MBbpqfdQtB8c/40O4l1Bq0Z
6Xrfondf8KE1ywm+4MzxuA64ZB5zwoZDRmuc1dkB/vsUhmaqXa6cwtGgEJC4tkXb
YzWU4Mi+4HInejNiDsms7r8PspVekQSVlbp28Oi48/39rrbn+NZRbzynBNxoLsvq
nNNjNjxYEZRjvDpCqdzkKPZy/FnnOtVbeVdRzIErYpYL2yHYhCuUY1gKe41XSNUe
J79c2uuBlrU4UewWbBC98h4vNP1eiAM65Atb6hRif4tjkifvyMZNIlQc6Ireajrr
0YbGIy1DqkI=
=ZxEi
-----END PGP SIGNATURE-----

--Sig_/VyU9OGfJIcfK+NL+GSEgEso--
