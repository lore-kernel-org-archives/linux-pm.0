From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Wed, 29 Mar 2017 22:50:54 +0200
Message-ID: <20170329205054.GA1440@katana>
References: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
 <20170329184356.8610-6-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329184356.8610-6-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 08:43:54PM +0200, Niklas S=C3=B6derlund wrote:
> Enable hardware trip points by implementing the set_trips callback. The
> thermal core will take care of setting the initial trip point window and
> to update it once the driver reports a TSC has moved outside it.
>=20
> The interrupt structure for this device is a bit odd. There is not a
> dedicated IRQ for each TSC, instead the interrupts are shared between
> all TSCs. IRQn is fired if the temp monitored in IRQTEMPn is reached in
> any of the TSCs, example IRQ3 is fired if temperature in IRQTEMP3 is
> reached in either TSC0, TSC1 or TSC2.
>=20
> For this reason the usage of interrupts in this driver is an all-on or
> all-off design. When an interrupt happens all TSCs are checked and all
> thermal zones are updated. This could be refined to be more fine grained
> but the thermal core takes care of only updating the thermal zones that
> have left their trip point window.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY3B4uAAoJEBQN5MwUoCm2kowP/2rgT008E/9NP/YJVUln5cGt
6cmmZUUMFbWVwfBcZB0bedNg5C0Q+uxVnWPKXNYHYW5wDXjM6NFwM+aPG3YdnXNB
geVv1Zy33xomXdq/Y+qsuw1cJPXejLRudB31R3dhZP0jroLVP/puZ4wsRLSeIgah
sWmO2qwTE/B0L3WdySklpZdmgzc4KdJc9Z6sU+F7O6lIxqp0sEA83MsipPp8LWPb
DOTZTbO9Au6PKBgTxNfmFm/8PEgfLWaxeGXpk6fXlCmD+37lo5tX7AZ5Krf1Abtp
6NUtxMdxvaFzn046bTvjPWzTi2OnSeKisT/mpMPVG2G3/2lADjHbooJr/ZIYKr07
0zhIkfAFcZ/e4HllwflaU72SsSsV3IXXIeR4ylLvdBU6tA3KS6jBrjoOH/byal/i
Xjs17p1CMpKsw/LklomGj2ECcM1IijAbM0LL8xrGL1nNGjC4w2aBu5j8gcToMf3A
vC3lpIilwb20D0Kwa/8rRcv21YPIN9C4oO2sarhj+cxSvoJnUEIxAPTgcUVBvgZf
sE7y/gJi6m49wLruI588m0eIilblj0CA6XH7sZxFhV4S6wV3cN5ZRtQPK408+Nty
N/TIsPbPYAqw7s5NF4UM0MN+ue6kS/9SWSKYcBmssXhOBiZxqVHHGATBGB+84HCa
IvFZkgDOohlOqhP07mo3
=eVYA
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
