From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/3] Documentation: DT bindings: add more Tegra chip
 compatible strings
Date: Thu, 5 Feb 2015 20:25:22 +0100
Message-ID: <20150205192521.GF15307@katana>
References: <20150130221104.4761.50643.stgit@dusk.lan>
 <20150130221104.4761.4534.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150130221104.4761.4534.stgit-orwA252wQtA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>l
List-Id: linux-pm@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul!

On Fri, Jan 30, 2015 at 03:11:04PM -0700, Paul Walmsley wrote:
> Align compatible strings for several IP blocks present on Tegra chips
> with the latest doctrine from the DT maintainers:
>=20
> http://marc.info/?l=3Ddevicetree&m=3D142255654213019&w=3D2

OK, I am not sure if I like the direction, but having a rule of thumb
here is definately a good thing. Thanks for the pointer!

So, for the I2C part:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08OhAAoJEBQN5MwUoCm211kP/1gwSZCg1BcLlL4f03sgSP7g
43ow1o5erCEDXawaJrwocF5h/w5itymPrTl0V4pFTr2isis7jsaZvt+aBXtfKbeb
gaKuqiMWxmw3iSbClMkT7rWSrM+BaLs2oJqLD6lAEW4F3YDHS0j1Rl0k5It5J230
qNgO2mCar0l7pY7QWsv5vTPBtvNDa/VUaFn+nqzGRCheobMLOiTCaFe11KTnUT2G
Fks0y8yqe5eAmd6kXSylFrp72IORLGpk+mjkZZw5PNmVF3iwcW+HhW4WGLVtdFJv
C3haV/XZ+0Vx0+E0FZslvGZJFljo2bNWhX3zqIhOX4ZEHa0xBKL7KH8+4h9Y9pkN
TGta6Gr9vsByPZbc8kIsPEvELZW0T61dYkkVs5FHnSgFa1iBxOrxxn1rVP22dyHp
koVCrWFrG0A8NLUDrv2msO4RTU7INmO7mpwTGmpcRyDWjIn0OfMPwyISjw4T4pZL
lh4tMOWsTQBboi1itXAhMk8xa97TR9qbyUwOvud/MwqVHiY8ZkQBawXGIoW+y+pO
9qLpccLwI79/l7yl7xpSQpCtylxPAESeXAulTHRYTffoAREWKQwmhPeqe4awoiZg
XGYjKiVlJBnSEYUgVXCkZi5tsqikfBH3p0VY1sKIrW5MhE2by22TTzoDVyvD2y/z
6ov2grGmesT2m3keN2oH
=5LNo
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
