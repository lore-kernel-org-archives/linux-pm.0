From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as
 reboot mode write interface
Date: Thu, 18 Apr 2019 11:46:27 +0200
Message-ID: <20190418094627.fadq3i4tptqq42gm@earth.universe>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
 <20190411055341.9263-2-nandor.han@vaisala.com>
 <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
 <b046dc29-002c-39a9-5a54-562c49adb691@vaisala.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp45vzivwhqghxsu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b046dc29-002c-39a9-5a54-562c49adb691@vaisala.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nandor Han <nandor.han@vaisala.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--bp45vzivwhqghxsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2019 at 09:29:08AM +0300, Nandor Han wrote:
> On 4/18/19 12:56 AM, Sebastian Reichel wrote:
> > On Thu, Apr 11, 2019 at 05:54:09AM +0000, Han Nandor wrote:
> > > Add a new reboot mode write interface that is using an NVMEM cell
> > > to store the reboot mode magic.
> > >=20
> > > Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> > > ---
>=20
> <snip>
>=20
> > > +module_platform_driver(nvmem_reboot_mode_driver);
> > > +
> > > +MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
> > > +MODULE_DESCRIPTION("NVMEM reboot mode driver");
> > > +MODULE_LICENSE("GPL v2");
> >=20
> > I suppose as of bf7fbeeae6db "GPL v2" is deprecated, before it was
> > often read as GPL v2 only. In both cases it makes sense to just
> > use "GPL". Otherwise the driver looks fine to me, but I'm waiting
> > for Rob's review of the DT bindings before merging this.
> >=20
> > -- Sebastian
> >=20
>=20
> Thanks Sebastian.
>=20
> Do you want me to send a new revision with license changed to "GPL"?..or
> will you change it when it's merged?

I prefer to get a follow-up patch for things dealing with copyright/license
details.

-- Sebastian

--bp45vzivwhqghxsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly4R28ACgkQ2O7X88g7
+prNZA//XDDqbQSmWJFOQvIRbF4LK9kgFNI94HURh1VJJP0TW101JAnm2uzGa/b/
2znaMCKDNQYBxemhpezoJMDQcDeZYolZQjqjK5H9Jb5I7KtwpHla0yvF7lG0ftWa
uGeDjKXoI3v+rhQOFNFVZ65HzoTmIgeTUSmHqbKISNGP875/hjNADXHcn6zkjG22
eAl0YIbugztjdlyQ0+Xcbm/QM01b+b7F2ni8KnDI7HLxtxScsl6DTAyYlmRX4lGm
5yxkGtg+U7TvtVMErHnXL86Q6EoQMKZ2la9yBiYejOFP6vTaCcidjsh1BS54VP8I
Fr4E9mGdmVYiaXKXj1/JVXmBIsMP2l6mSoVvnlFnLHZV5qnz/xvGiSKdMTtRQXZ1
NnWIxHlNAfnFQ0b3p4qbJBULdpIITHJFkneR46r3Bgsh1n41X9nFNLeyTvXD4ur2
9LU8o6lgmHp5SyDZpBGV9mICQs+NEoYK9jvNTYDXeJlDM1OQLAI3cVltkgqesAtv
3dF/GG0gYH74xhDedVgsAYG2r8bKbv9a+d22mUVr/ApuXDiZ5k6BeWmCOaArPF8Q
63SBCnhhysKfYuOHdWNeENjeXuaZFJuyBsPbZ0mNMaArmCiRtY9CwZKPh/fa10pD
9c6Ons+hOgnINLhT5h7Smd3O1JWt+rdXlceu4wMn3FWFnLSGJC4=
=vUsW
-----END PGP SIGNATURE-----

--bp45vzivwhqghxsu--
