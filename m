From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power_supply: bq24257: use flags argument of
 devm_gpiod_get
Date: Sat, 13 Jun 2015 04:39:16 +0200
Message-ID: <20150613023916.GC17513@earth>
References: <1434093882-31795-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1434099244-28202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50284 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbbFMCjU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 22:39:20 -0400
Content-Disposition: inline
In-Reply-To: <1434099244-28202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <gnurou@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 12, 2015 at 10:54:04AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.
>=20
> Simplify driver accordingly. Furthermore this is one caller less that
> stops us making the flags argument to gpiod_get*() mandatory.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1, sent with Message-Id: 1434093882-31795-1-git=
-send-email-u.kleine-koenig@pengutronix.de:
>=20
>  - make it compilable

Thanks, queued for 4.2.

-- Sebastian

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVe5fUAAoJENju1/PIO/qatXAP/iHSO4804z3gEB7gkZbw2dOi
MmFm/L8dlblvwOKLR5hlzYDClw2iNaj4P1HzpBeEHA+kC+hTpIuIN+XxyC/IXwS1
lryDX3azvSpI7hJcNIpwMwXU3qpmbSMDog2/j66S1ad9tN35hHxLxLcdAJrJAxec
Xkig5wiPuB241mwMDW33k/ta8CqsbgQ95oUDzFIvDtNZdseLNntn58UL5bSb1ynO
GW/T8pQ9FCnnuthPaZo+RDJlZT3REBzPR4Jph14Mfx4/dxVON5AVSzEg/ic5FEhM
28fGdsYpR/dTMlGu++T24IKqE+/oPt4rXbgZwuxIIehF+C2Tyg8lpnfnXlAGg93Y
ko5WO0d0sq158MlSIpjeGso6+RzaR/LYTl2fw8IhL30r9byJTuGRh7G5zXLgOs3t
/jH1eoVmcPVlHKMgrOmE+20MgwXKCjwDzYEr6ciqn1pUACnovJM7Bgz0JdmI/zJE
5BaIWDs2b0X9xSQXBAkapDitaHi8r7j8AT7EdvPgEjb9A3psg5jl6VgH7UHPNybz
xxBhlm7ZiLKu1Jkbrj7D1euATrJ+nI0Y2zcATknHzltzxsvXBkaUFowi0UiqRcK/
q4PED47ePPME/KE5tr8EKKxiyHSy7nHlEUNjYO8HL3c/drcKkIEAhVUnnYy2iTI0
H1excl1yu6rI/eGEdhBI
=JbSW
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
