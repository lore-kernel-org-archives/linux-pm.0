From: =?UTF-8?Q?=27Ond=C5=99ej_Jirman=27_via_linux=2Dsunxi?= <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 12:23:48 +0200
Message-ID: <1501064628.14577.1.camel@megous.com>
References: <20170723102749.17323-1-icenowy@aosc.io>
	 <20170723102749.17323-11-icenowy@aosc.io>
	 <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
	 <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
	 <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
	 <82507f40a1ddba8517cf09f51d3afa33@aosc.io>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-pnR/cDIPKuRWxVR3bWQJ"
Return-path: <linux-sunxi+bncBDXLF6FR5INBBPG34HFQKGQEVQQHBTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <82507f40a1ddba8517cf09f51d3afa33-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-h8G6r0blFSE@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-pnR/cDIPKuRWxVR3bWQJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

icenowy-h8G6r0blFSE@public.gmane.org p=C3=AD=C5=A1e v St 26. 07. 2017 v 15:36 +0800:
>=20
> > > >=20
> > > > Otherwse
> > > >=20
> > > > > +               regulator-max-microvolt =3D <1400000>;
> > > > > +               regulator-ramp-delay =3D <200>;
> > > >=20
> > > > Is this an actual constraint of the SoC? Or is it a characteristic
> > > > of the regulator? If it is the latter, it belongs in the driver.
> > > > AFAIK the regulator supports varying the ramp delay (slew rate).
>=20
> I don't know...
>=20
> Maybe I should ask Ondrej?

It is probably neither.

It is used to calculate a delay inserted by the kernel between setting
a new target voltage over I2C and changing the frequency of the CPU.
The actual delay is calculated by the difference between previous and
the new voltage.

I don't remember seeing anything in the datasheet of the regulator.
This is just some low value that works.

It would probably be dependent on the capacitance on the output of the
regulator, actual load (which varies), etc. So it is a board specific
value. One could measure it with an oscilloscope if there's a need to
optimize this.

regards,
  o.

> > > >=20
> > > > ChenYu
> > > >=20
> > > > > +               regulator-boot-on;
> > > > > +               regulator-always-on;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > >  &r_pio {
> > > > >         leds_r_opc: led_pins@0 {
> > > > >                 pins =3D "PL10";
> > > > > --
> > > > > 2.13.0
> > > > >=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--=-pnR/cDIPKuRWxVR3bWQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmrE4sgaRYhzUz5ICbmQmxnfP7/EFAll4bbQACgkQbmQmxnfP
7/EnUxAAjMqGccKdIgDwrz7xLA5Y0mZNYu5UEncp+4oEt/QplG2q0/+G4d1Bxgwl
3iNhQ/l+KF6KWtT6JIhgU7i11UZL0a0Qz9sxI0JxAxy/U+i3tTMlPm5KOaipWTgX
HIA4lzv6VWscG0XH9DU5qCX3Re+eqgCzJfBNMYZ216e27/jLYf5AP7Kyo8sIC73X
VdVMw9xuQgXvDpiCuHJpXUqv6/5p09Hm6YRC7H4+vJhf8w+T8XLwIYb9TfeMo9E4
OZkcuWLYkza9osSj4sBlCTFjno1dsVbqE8fAj1FM9naWs3mKzUMUNMfo21b2LRj3
zOd7nkgK0AE70EilSrvfRgYvjRnw/X1b9Tk6d3afXxF3VYtTF6w7MFtHqxhH4EDR
1j+ABNPcquJqtBzjgH718btgQKlj6Gxkh/TwYnlp3asGQtdpG6QU2E5Fzd5PLgNh
a/GmkulExnL4DTe8QG1fcz1xqKMF0QVKv8P0VdFY3UjX2/7SIB4YhFLLMLo77QwP
ibMIOIIajB6HtnorXV/o6rtFd09ILeLxSKfz+f9I3fZbJbetn8trKH3+IZQd1Fu4
OVIxASQhBhZduX6IsF73aYlJqnQknPz/LrCe9kx0lG875nfky44PSTLqGUkU/RL3
mcVL1XBv/8Ab/YRlgq8pr7emE05MIBkpzsB6OaeGEeEdF9/jvr0=
=7I9k
-----END PGP SIGNATURE-----

--=-pnR/cDIPKuRWxVR3bWQJ--
