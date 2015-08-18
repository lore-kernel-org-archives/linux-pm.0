From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 18 Aug 2015 09:12:00 -0700
Message-ID: <20150818161200.GK10748@sirena.org.uk>
References: <20150818052011.GF1864@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7dLEKQsGm0Z6zEmU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818052011.GF1864@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@ti.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7dLEKQsGm0Z6zEmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2015 at 01:20:12PM +0800, Peter Chen wrote:

> ok, I just had suspected below function's correctness, after looking
> it again, it always set 1800 as charging limit, does it be expected?

> +       /* Find the highest supported limit */
> +       best = 0;
> +       for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> +               if (limit < wm831x_usb_limits[i] &&

The above check is intended to ensure that we don't go over the limit
that was passed in in the callback.  The goal is to select the highest
option that is less than the limit passed in.

--7dLEKQsGm0Z6zEmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV01lPAAoJECTWi3JdVIfQtbMIAIGEWQG5nDej5J09OaD+/IbQ
Ru1WGoyeYrg9uBi9teTfai45aVlogdd/KgHz9c9xxg+cQxLVemhecDDvPDTG+enV
BSWCwkth5KYB2NtCjkvx3oPDQYJ9c8YeY75VF7/itMeCsn68KYKpxPCObUpVblYA
vB8ed9Otq37h1a0Jq8RpbkPKmGBNySWur5x+SW7F275VJxufucWSIRgTH2UrAKk9
QoCyIWBXJvEhWFmO0SbLyHCe8np5xqFMrHWk5VGyHjznySf9PfhfNUEH0gC0Ay6Q
ONS9bqCbvbpZ6aazdxnUxqOpRofBf8i66V3RtPJJOm8CcZx1WQ18j9a4vlbHOHA=
=oK1X
-----END PGP SIGNATURE-----

--7dLEKQsGm0Z6zEmU--
