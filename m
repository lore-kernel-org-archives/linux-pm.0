From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 0/3] power: supply: charger-manager: 1 fix and 2 minor
 clean-ups
Date: Sat, 12 Aug 2017 14:03:21 -0400
Message-ID: <20170812180321.d24ishd23ymcthxe@earth>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfw6theywbofcjo4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--rfw6theywbofcjo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 07, 2017 at 12:37:54AM +0200, Christophe JAILLET wrote:
> This patch series improves 'charger_manager_probe()'. The first patch is
> about a missing memory allocation failure test.
> The 2 others are just things spotted in this function:
>    - a comment that is no more up to date
>    - a style issue (which saves 1 line)
>=20
> Christophe JAILLET (3):
>   power: supply: charger-manager: Fix a NULL pointer dereference in
>     'charger_manager_probe()'
>   power: supply: charger-manager: Fix a comment
>   power: supply: charger-manager: Slighly simplify code
>=20
>  drivers/power/supply/charger-manager.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks, queued.

-- Sebastian

--rfw6theywbofcjo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPQuUACgkQ2O7X88g7
+pqRpA/+OftlFXQjpubmZccu4LlGZq/4FEIAGOzndcOFXLjHjf00r06pSxbm0hlU
qHZbp6ShvftdDHmnMXzL4NoJTBLSq/gpX0ifyZgrFR09o75suM7XsDpF4RLNDiBa
4HmJyfZUGBKMt6je02yzSOUTmMy1YENeVul3kWC9uec0E/8Zk9fs1KpK6Zy2RnDz
AET22QuJwXAei4h0FV/iAlVnpo41e+JesVjCFTxhFJiIzte6qAKjRiaAUhFP76SB
Qv52BXtQsTil7UDBRUHyQk6vRVqSs86SKXta2JdZbydtnrH7qyVL8i+oCC5npREL
Yl/3wLEV3Nn1rkw8jZuk23jqZSNQZav9wSfj/HA8RT/v7SpCsycvZRRKm3xcaPLt
yvVYseuLNP8uRs7qKo1jkvG3fZVSbUkgwE4q1htgUmhVGGaxCYPEwffigDoKaKRv
jS6qJvYPnv79Jd4AEd1pb+ijrPIuVIr4Tvv0z62mP0kgGkSVmVKXfl9R5IktqrDY
/Fw0xDE6B+15N3UMLlRjJedIRA85PrZw5TuoZYBt6WD1EOZDXWbzzYHv/FhhjfSH
fw9IAcUOAO8SONKTFvAc+g1zOUe/2Ly3LKTBq4bOTojr6IbU93ysAEGjJjBYOoC7
HbfLYmkIjdJNPHGTX+ziOOksnTh2tI4GFLWmzq01xMch/8lcldc=
=WFTY
-----END PGP SIGNATURE-----

--rfw6theywbofcjo4--
