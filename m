From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] nds32: Power management for nds32
Date: Wed, 24 Oct 2018 11:46:13 +0200
Message-ID: <20181024094613.GA25773@amd>
References: <cover.1540349342.git.nickhu@andestech.com>
 <ccc18702a8d93c0a31e46f53c498b6d34c9c17e1.1540349342.git.nickhu@andestech.com>
 <20181024065117.GA18779@amd>
 <20181024093843.GA18476@andestech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024093843.GA18476@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Hu <nickhu@andestech.com>
Cc: Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= <zong@andestech.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= <alankao@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>
List-Id: linux-pm@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Can we get rid of "is_bit_1" array here, and use normal bit operations
> > on another variable here?
> >
> Do you mean like this:
>=20
>  static int nointc_set_wake(struct irq_data *data, unsigned int on)  {
>         unsigned long int_mask =3D __nds32__mfsr(NDS32_SR_INT_MASK);
>         static unsigned long irq_orig_bit =3D 0;
>         u32 bit =3D 1 << data->hwirq;
>=20
>         if (on) {
>                 if (int_mask & bit)
>                         __assign_bit(data->hwirq, &irq_orig_bit, true);
>                 else
>                         __assign_bit(data->hwirq, &irq_orig_bit, false);
> =20
>                 __assign_bit(data->hwirq, &int_mask, true);
>                 __assign_bit(data->hwirq, &wake_mask, true);
>=20
>         } else {
>                 if (!(irq_orig_bit & bit))
>                         __assign_bit(data->hwirq, &int_mask, false);
>=20
>                 __assign_bit(data->hwirq, &wake_mask, false);
>                 __assign_bit(data->hwirq, &irq_orig_bit, false);
>         }
>=20
>         __nds32__mtsr_dsb(int_mask, NDS32_SR_INT_MASK);
> =20
>         return 0;

Yes, that is better. You don't need =3D 0 on static variable
afaict. (And may want to put it out of a function so it stands out).=20

You can add my Acked-by on resulting patch.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQP2UACgkQMOfwapXb+vJXwACfSdiA+90qawZRRQRvxxDC0LK2
U74An0bjc/fSIkbk2JG3erC5eZSr/PDu
=PSUH
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
