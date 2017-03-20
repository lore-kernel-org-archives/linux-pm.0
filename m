From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/7] thermal: rcar_gen3_thermal: check that TSC exists
 before memory allocation
Date: Mon, 20 Mar 2017 21:02:43 +0100
Message-ID: <20170320200243.GA1587@katana>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
 <20170317155300.21566-4-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317155300.21566-4-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 04:52:56PM +0100, Niklas S=C3=B6derlund wrote:
> Move the check for a TSC resource before allocating memory for a new
> TSC. If no TSC is found there is little point in allocating memory for
> it.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY0DVjAAoJEBQN5MwUoCm2Vw8QAIVCbRV2cE+0Y/EF1I8cKe5c
/KB9+bjonXpZrJelNwwiAz7mvO/sd8aTb1McpmqVQMFwb1ksJtBt+ijyiABL0Gtc
n1fUdCO7qewDdCZINX0LBUQ94eWRHYnD4ikVz0tlwry2xOIUgaAogxBi6S11XZf+
Cy74CvZ7qBRr9ZWJvaSBLE5xVboT+E5bTp8Qg/jb3XvBgVklhBgmm+AGxErJA/c2
WOEUkHYDimJL9vOB3IifA7Z/+rEjnG+s5cUMUq2rB2t4LVgSGZLWk7HVw2/5iGHr
urryF6fqdh+lEOLTMMr2MeT/E5DoFtEyEw2y1GiCtELcTKDy0SS1NTcdQ2JjzQRN
QUIagAAC79eFdO6hqIxy8IyU+1P5bYJyZ18a8AlRJqJ0A1meoduygjmnUtxi7reF
PsP9LfYc0Q9tapEWLOYqMqgy3jYPcWLAsWoi5eR3XiVtPeibHDGtMfcirltxE3Dc
2rbprn8q/FvxnWtJJXHYTbryw2Mubm/rZSdL0YYIp+JsUWuWStzMKjqYPnAhrxha
Yrt3QFnRw8pFrn/a/ohHhZ6WorwdFiwfVmoQ7tcG4ByL1loPqCFecqUneBHsD5g4
4TXw3W0EkzO1KZ7JPP0y45fre1dLSi10TQmmjqt4GQbJPWefsYv6zOLvtBD88yf+
0Ut9g9O5j/mxxsgU0Wjg
=OKEc
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
