From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/7] thermal: rcar_gen3_thermal: record and check
 number of TSCs found
Date: Mon, 20 Mar 2017 21:09:39 +0100
Message-ID: <20170320200939.GB1587@katana>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
 <20170317155300.21566-5-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54512 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755821AbdCTUJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 16:09:42 -0400
Content-Disposition: inline
In-Reply-To: <20170317155300.21566-5-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 04:52:57PM +0100, Niklas S=C3=B6derlund wrote:
> Record how many TSCs are found in struct rcar_gen3_thermal_priv, this is
> needed to be able to add hardware interrupts for trip points later. Also
> add a check to make sure at least one TSC is found.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_g=
en3_thermal.c
> index 9b6bc03dd142a8dd..3b6e85abfadc61a3 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -74,6 +74,7 @@ struct rcar_gen3_thermal_tsc {
>  };
> =20
>  struct rcar_gen3_thermal_priv {
> +	unsigned int num_tscs;
>  	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>  };
> =20
> @@ -305,6 +306,12 @@ static int rcar_gen3_thermal_probe(struct platform_d=
evice *pdev)
>  			goto error_unregister;
>  		}
>  		tsc->zone =3D zone;
> +		priv->num_tscs++;
> +	}
> +
> +	if (!priv->num_tscs) {
> +		ret =3D -ENODEV;
> +		goto error_unregister;

I would have probably done 'priv->num_tscs =3D i;' after the loop instead
of 'priv->num_tscs++;' in the loop, but that is super-minor.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY0DcDAAoJEBQN5MwUoCm26jQP/AuPqLDbnUP7UGyThV09WMKf
+D5nz3MhxfydfGtq5kNWfdhE48C52QaSRQJi5u3/FQ1rcckxMEaGGCM8m6EI0xDm
392sjDUFdUh4CmBwKqV0En2m11EreDcIBpOAakvbuyT3pG7S8mADcDy0UttX923A
apSvtC9qpunH8ITxu4cnDP89aLNoquc/WMbGt2pPWIBhZZpIRi0+SqgeDZUDcy6i
plMokP9+STTNYadn16Eqtvzl39PiFVljIVFeJK460J5ugEh/l90gzgxyFeHlLUUR
RmTjxvRzP6rGDuK6lqlNAepoBf62+6QIZsmADVkp/j15GJ1kWAAUpyLz4FdbEwDf
Pm+e3QmCc4vVZZYbWa1YpYorPuQJK0dpAV0kGvf9ovIp3ykjZjbtmXiBXkDUsUTe
0f6eNnRvDyuNRyp30E9aJRxru5rTHFVsMNP9IKQarJr2cSsBJZvfxqQMpUpLfZNG
Z//crZMyASCO2CB3mejCHRCK+JKvg9inwZ/gUyOhL/Ke4gZhrlEZsRpIND/tUQ9H
fkxKxVQiEzZcJ1vJtRE0JWi7rcqd6MZmAYQnqIsiY+lLB4W3fLqpnQH+wpKhCdMU
iE5z30RWT5VtH50DjQ71ymyVFJ+l6u0HsMiBPJYO5Ia3Gg/074BEBZ0hSirmGsLN
yY3AAYXV/+1YJbiL+MWu
=q9CL
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
