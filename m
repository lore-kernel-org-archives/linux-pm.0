From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/5] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 19 Aug 2015 09:24:18 -0700
Message-ID: <20150819162418.GP10748@sirena.org.uk>
References: <cover.1439974219.git.baolin.wang@linaro.org>
 <a29a038d7ebee931855cbaa065b055db5c5cfef3.1439974219.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sHj+bPVFXs3YLS9f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51542 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbHSQZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 12:25:03 -0400
Content-Disposition: inline
In-Reply-To: <a29a038d7ebee931855cbaa065b055db5c5cfef3.1439974219.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org


--sHj+bPVFXs3YLS9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 05:13:48PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

When people (like Charles and Lee have) have reviewed a change you
should add any tags they gave when you resend the change so they don't
have to duplicate their work and other people know that the review has
happened.

--sHj+bPVFXs3YLS9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1K2xAAoJECTWi3JdVIfQjGgH/jhX4fQtjTgUDfYvnC1+eET9
PgXF4DFJHtZsO1zQDFXKzLrZfYnQvlgaq80PKq7Z+QRiGe9xV9IFHsyGpzYxyJj1
JLPTBNJfST3JYgGWWn07hnZk1m5HyOLpV4eGt0gFmYCmWRqoXGgBIuOCbpss0FY2
Yg56nmUqGMAMY3c+epdLPiAu68S5uwBFZqsY38OJiKTKnHHO2YYCRXeim4zojza4
o6vZF2YXtVtouUIWBbJ+XRXmOfWD9soGMz/LD/sYazYAOd48bepvYZc+mFO3D90O
jl03O44SCh8Sw08w3U6NyjN6/Ki6ECGRSDVQe1RgoLmpvhXIIX1sURdX6COUe6k=
=CHWU
-----END PGP SIGNATURE-----

--sHj+bPVFXs3YLS9f--
