From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 7/7] thermal: rcar_gen3_thermal: add suspend and
 resume support
Date: Mon, 20 Mar 2017 21:27:57 +0100
Message-ID: <20170320202756.GD1587@katana>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
 <20170317155300.21566-8-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317155300.21566-8-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 04:53:00PM +0100, Niklas S=C3=B6derlund wrote:
> To restore operation it's easiest to reinitialise all TSCs. In order to
> do this the current trip window needs to be stored in the TSC structure
> so that it can be restored upon resume.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

If you refactor rcar_thermal_irq_set(), then you'd need adaptions here
as well, but besides this minor thing:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY0DtMAAoJEBQN5MwUoCm2oukP/3yYv9YO//SZI3Qb2QVOg7tF
zHUXIXgHCHvygvOznNZs7nZZ85Epi/WSmu75n4sNt6xg17S/1ugAyUUxYTdwHfeB
81zYafCSw7h+WHmkdO7PLtmpWUjPSUEPIRwxrvmoSP0H1qEhD3IaYfJ8RDtVeaZz
m7xtJejHHG5s2FSWQkdQZjnZbTq8oJqxeFMDZOm/PrIbvpBNI7uXEbRjabPz0fvO
5nxz7aNrwkXFIQzW9KrO5+1zTn6wIGxf5IM1+ngLk1QKLbp37rUTEL6U2llAvkVr
SVcuuVJtCEDSzjRs4s5N0l011Oqgd+U7D4WNe7uTi3yaeYC6g0+G3+1hq1UXDDTr
I+pv+UrsqMMeWz7hI1f7ksEffQNghshkKwt1vRuM+KX5aeC2gPGZXZ2Pfrj1T5oq
3j6bxYKWvqq5/udpKA6mj2n1Yej8OwOX2yaR+r83f8fRcO7enhClra85L6oPvORu
PfLFVkccxIUHXS7xDfs0Js9DvsK2PmTr/k6gIw01BKo6aZsgt4CIonBmLsI/EHl4
8RP1QkNxcvfXGBrkG+TPGLfkflGO1lEziOTUF4+h8MxmZg0EqGHyNWeIC5vFCYiS
QcGCUCWfJGmIO5Q8GCDSUQuCzdN9D/qOUQZyTG6Z1CclrJ73uqB10KfSYdVtjHO6
9T2T0YQe7QtY3wqjUdV2
=r9X/
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
