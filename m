From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 19 Aug 2015 09:36:44 -0700
Message-ID: <20150819163644.GT10748@sirena.org.uk>
References: <20150818052011.GF1864@shlinux2>
 <20150818161200.GK10748@sirena.org.uk>
 <20150819000236.GA23719@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SJNxsaHkaATHg/Nl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150819000236.GA23719@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@ti.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--SJNxsaHkaATHg/Nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2015 at 08:02:37AM +0800, Peter Chen wrote:

> Below code may be correct for the goal you expressed.

>        for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
>                if (limit >= wm831x_usb_limits[i] &&
>                    wm831x_usb_limits[best] < wm831x_usb_limits[i])
>                        best = i;
>        }

Yes, that's right.

--SJNxsaHkaATHg/Nl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1LCbAAoJECTWi3JdVIfQRBUH/1lMXiLeosMfOrLCNN0ENg9k
G/3UqORzq7+DsdNgHgcJsW9fI8+8L+snO/PIULvcNnDjnrgFXJt64aD2JnOvhZVf
6TopvKfMUJnl0vhSGhlKDMZXwLrv+bTqPu1n5nl0y4fBYHAzVqkOJFmP1fGQA7lP
DUh37MvXNvzbQhc2vXSW/v3+jBnsY888+vYSXgNNh+mCmS87VYsZNfelc214WtNd
h2aUVZ+Y+Zlc4ucWOmXPv9n2MQ6fCeFMMol2FSyxs/2Pjtr+8+ptfHgi07J2Dgqy
GCCX1+pjtEZU35kzgh4vQwA2xIGkW6lr8HbyneOcR0dwR7oeoYygCOE9qFa+/GU=
=YHGQ
-----END PGP SIGNATURE-----

--SJNxsaHkaATHg/Nl--
