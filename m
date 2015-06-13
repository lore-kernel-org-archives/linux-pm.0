From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: bq25890: use flags argument of
 devm_gpiod_get
Date: Sat, 13 Jun 2015 04:38:40 +0200
Message-ID: <20150613023840.GB17513@earth>
References: <1434093574-22456-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50243 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbbFMCip (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 22:38:45 -0400
Content-Disposition: inline
In-Reply-To: <1434093574-22456-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <gnurou@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 12, 2015 at 09:19:34AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.
>=20
> Simplify driver accordingly. Furthermore this is one caller less that
> stops us making the flags argument to gpiod_get*() mandatory.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this patch applies to next and is only necessary on top of 4aeae9cb0dad
> (power_supply: Add support for TI BQ25890 charger chip).
>=20
> Note I plan to make the flags parameter mandatory for 4.3. So unless
> this change gets into 4.2, would it be ok to let it go in via the gpio
> tree?
>=20
> Best regards
> Uwe

Thanks, queued for 4.2.

-- Sebastian

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVe5etAAoJENju1/PIO/qamLsP/RUD9FtrcZkkI6iHDpk70WJR
7/N7OqMyHG9QtkFNGwi/q1yLep+GEfQGcI2IqZl0yLPzuYdWHHt83S19bbr6Meh0
JVtnTtE6EICTAotz7emXrTf4Z8tXks/HvKrnxT47NZJdziDjxv6MFSPLiM9DZYza
5dEMGhMdtnzhpU5yhOgjtvzd2kuT5eog66e+A8tiBiXhmmZAOooyWH0cAgoi7YKg
AyfldKufaPpInHc3VYgBKMctjGX2DFpgp1Y0quDWWsDIhsMWbxcyADYr6Lr6ZKfQ
D7ddp6bl/9c24H0P/fFqww7WnuDggDG3P5LbfyqMFyw4g25DRcanfd1mv3nW3KG1
Sgf9w8Ft6HUp6fAC39u2NGz+n39roTpN/r4+84AXUHJzhfSYFYqaHNe+EWGv6g/h
NhrPBvXL/aL+VL44kp4M4pfA1jhvsTjH0Q0miwgF1X4mquu7QLiN804iBacaQTWM
lp8kBfmZ+9J8w3dJCsXDiFZBw8bds8gopFGx/1rC0M3Vp0z0KtzylAxQ6qM0oDj5
KADzPcaa79qBNjrL6pQ8R2BBOPPZCJXvpt9PB7/FU/ij1snalWo4VET0R2BN7xaP
LRzW4yYPN7SwPR9hzZy7Q+qJtA81gQqKGYwJogWvXSVsOzffYenHzV/JVud6dVFX
bwi2PLTYHto4+4VnbLel
=VRID
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
