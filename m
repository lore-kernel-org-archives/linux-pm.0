From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60
 SoC
Date: Wed, 20 Feb 2019 00:43:17 +0100
Message-ID: <20190219234317.2oyp3ktqp3cikh5l@earth.universe>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-3-nicolas.ferre@microchip.com>
 <20190208152435.GC23062@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkplu3agw26zk46b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208152435.GC23062@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tkplu3agw26zk46b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 08, 2019 at 04:24:35PM +0100, Alexandre Belloni wrote:
> On 06/02/2019 19:12:21+0100, Nicolas Ferre wrote:
> > Add support for additional reset causes and the proper compatibility
> > string for sam9x60 SoC. The restart function is the same as the samx7.
> >=20
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> > ---
> > v2: split series and collect tag
> >=20
> > Sebastian,
> > I add your Acked-by tag here but as I would like that you take the 3 pa=
tches on
> > your tree now, I let you modify it on your side. I'm expecting Alexandr=
e or
> > Ludovic to have a look as well.
> >=20
>=20
> Sebastian, please take this series through your tree. Thanks!

All right. I just merged them!

-- Sebastian

--tkplu3agw26zk46b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxslJIACgkQ2O7X88g7
+ppA5A/+IgJmgk73r39b7sVQDIRJzLpLKH/r6ioaFSbPCcC4owKjc0U4O0V+peRz
tZfwhfjeARci7EwVfrpmm9cXcoAtQ7A8uLrDjK/30zNZ6bIj/LymFzaF9YbuFo4P
A6N/7HfGPSMjc6a0V09jYWkQ7nHuvdoxocr4TKDg8JREAZVdih4gKtUoWnc26iQQ
gjWPx/yo4KAzHi9BbknO7z1LLxS4wmfjWlvLZTLJ6gv7oSEL48dM/KVsLXN5hWzn
vvpeHgbLl87DWRxFNHLjhO7IDPfVh01lGWnThvqP+1+O/qjCq6w0QPvVbSU7ERPj
qsyKE8ImbXOg8TBVswEord1chbOmCDbawL76vlOq7w1GN2B8Psedr/uu2vV+hS1c
wvSvIEL8f5m8E2OsyfssRjbtJqS+rWHcTuucHdRZa/xY3M+/OscVX8dQ3FLgB9bQ
2+V7AvAR7c8OHiXGF0nZZ4AHAwdb3XbkL/BUiD4+3ko3mpIHwId/EJXRCUlMPdCw
0bGzo9IQSJx50FzIA/3s1Oih1nBto9Gr4qidCD8clRIMvbsyesDiiRgYUl+MqMTh
RQd43y5CebvIchrYvIuM7xPnCHlwbb+7UM2wfHEaRMpoVVntr5HJcgaUlFRWavRs
icJF/h7BInttqAm0OFCo6UoP4wyJvHXWOrNBxQ21EPjD8EqzO18=
=oRbw
-----END PGP SIGNATURE-----

--tkplu3agw26zk46b--
