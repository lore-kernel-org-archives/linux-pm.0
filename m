From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] thermal: rcar: change type of ctemp in
 rcar_thermal_update_temp()
Date: Tue, 6 Jan 2015 09:03:24 -0400
Message-ID: <20150106130321.GA4661@developer>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shimoda-san,

On Tue, Jan 06, 2015 at 07:02:08PM +0900, Yoshihiro Shimoda wrote:
> Since the ctemp is used for rcar_thermal_write() in
> rcar_thermal_update_temp(), the type of ctemp should be "u32" instead
> of "int".

In your V2, can you please include in your description that you are also
updating the helper variables 'old' and 'new'?

The description does not mention it.

>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_therma=
l.c
> index bbdf64e..6dcead1 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -63,7 +63,7 @@ struct rcar_thermal_priv {
>  	struct mutex lock;
>  	struct list_head list;
>  	int id;
> -	int ctemp;
> +	u32 ctemp;
>  };
> =20
>  #define rcar_thermal_for_each_priv(pos, common)	\
> @@ -145,7 +145,7 @@ static int rcar_thermal_update_temp(struct rcar_therm=
al_priv *priv)
>  {
>  	struct device *dev =3D rcar_priv_to_dev(priv);
>  	int i;
> -	int ctemp, old, new;
> +	u32 ctemp, old, new;

But you also update them, as necessary.

>  	int ret =3D -EINVAL;
> =20
>  	mutex_lock(&priv->lock);
> --=20
> 1.7.9.5
>=20


BR,=20

Eduardo Valentin

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq90QAAoJEMLUO4d9pOJWXXEIAILMKJ6OSTDOli3j+uaL0WZG
9XStcpVB+6iOiqHsEwC5tVHyomqHw6947KOaevHChJUDouRrckXYj7N6OINbcUuf
V9aX4W3xxEm9jtsL5zBa8u7GLWexSs2KoL3Xv+vvMDzI9zRebWnfT6nEaLMljo1q
ZRgNIPcHQI6652+fEWsuBERlV15n7K3wjLSaOlt4EcaksDjfdAwtnJCExMEhHsTM
pzkRXg6dQujNmf28zH74ff/0mWGtkMU35VyT4yGErBm//4OIZ1/FwSupz2pbAF3z
7ylNNwZ+4QuF6IJX5GbnZKMTo+xapCxCy4U/f4YT9FA45eSneg98sFCyjlww8Ig=
=Eval
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
