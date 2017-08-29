From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: core: Delete two error messages for a
 failed memory allocation in power_supply_check_supplies()
Date: Tue, 29 Aug 2017 10:45:18 +0200
Message-ID: <20170829084518.l5dk3yfflgiagv7g@earth>
References: <5f2600b3-e498-af9f-32b3-b41ebd81159b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpgk5xl4qcszlf4m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f2600b3-e498-af9f-32b3-b41ebd81159b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mpgk5xl4qcszlf4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 26, 2017 at 07:37:00PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 26 Aug 2017 19:22:32 +0200
>=20
> Omit extra messages for a memory allocation failure in this function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 540d3e0aa011..3d46863baa52 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -259,18 +259,14 @@ static int power_supply_check_supplies(struct power=
_supply *psy)
>  	/* All supplies found, allocate char ** array for filling */
>  	psy->supplied_from =3D devm_kzalloc(&psy->dev, sizeof(psy->supplied_fro=
m),
>  					  GFP_KERNEL);
> -	if (!psy->supplied_from) {
> -		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
> +	if (!psy->supplied_from)
>  		return -ENOMEM;
> -	}
> =20
>  	*psy->supplied_from =3D devm_kzalloc(&psy->dev,
>  					   sizeof(char *) * (cnt - 1),
>  					   GFP_KERNEL);
> -	if (!*psy->supplied_from) {
> -		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
> +	if (!*psy->supplied_from)
>  		return -ENOMEM;
> -	}
> =20
>  	return power_supply_populate_supplied_from(psy);
>  }
> --=20
> 2.14.0
>=20

--mpgk5xl4qcszlf4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlKZ4ACgkQ2O7X88g7
+po/LQ/9FmiRimB0OY5/gtpVu1lN6dkhrqh3QlAf3tab8h2hbiqH2/oRqgmHb80b
J3dkv1kt5Iuzlcpo03IpwD/aveXU+rCgbhXxjErjrlwNwMIgck8suHWY8ddYwFWl
BTpnNdv3TbZa7UBl89QNLg74K5+T1a3MujU93SMH2QNszx9d45xRuymcH7an3AO0
13TndxsDnwSmuBL57HOIxKIfm6V1cfXmXAIOhr8O10XnbTIwM+mE7qf4piuOWaag
i4BUnBHVLlYUB/F28cxQPqjvt9MUp0MQ3phfOpbGHOkIECzzFfrW4vuEhssNBH3i
Rd/odeT5VsFaTlT9iiR9YGz+diGO3Ll/UhY7WZc1V/wj+gi+eIfvTYB+ysrEh5ut
K5xp2vTL7OEfAisZREb5KL6r7Wl//zwjcYo1xpbu6Xd/nk4BUnp9qIeG50tMgV2w
lxDf73UKotFwvJiOC8dbIiD3Zkj5s423Wg5nVCbJmiJetAK9jA1H29ZJ5mGNPnX3
/mJQ9QO5z+FtDFzWXZf5sYsu49SrEG0cFZKTRNXCNKVZ+YGirs1khLqeQdRHgrYA
vrj1717q8k+qo2ZHu+3IEfc+Rn56bKUsNLeQ2VD7fUvRC7VlUI8f4rjFjjk0nzdU
zw7R6wGpqGdOY994YjvzBd/XO44QtH54exMt3zk7dawJSR2JQP8=
=0hDl
-----END PGP SIGNATURE-----

--mpgk5xl4qcszlf4m--
