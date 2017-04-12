From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] power: supply: tps65217: remove debug messages for
 function calls
Date: Wed, 12 Apr 2017 17:01:14 +0200
Message-ID: <20170412150113.v3opwtovza2d3qvk@earth>
References: <20170403164446.28076-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gotcspk7xqgieite"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170403164446.28076-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--gotcspk7xqgieite
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 03, 2017 at 06:44:45PM +0200, Enric Balletbo i Serra wrote:
> Equivalent information can be nowadays obtained using function tracer.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
>  drivers/power/supply/tps65217_charger.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 29b61e8..1f52340 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -58,8 +58,6 @@ static int tps65217_config_charger(struct tps65217_char=
ger *charger)
>  {
>  	int ret;
> =20
> -	dev_dbg(charger->dev, "%s\n", __func__);
> -
>  	/*
>  	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
>  	 *
> @@ -205,8 +203,6 @@ static int tps65217_charger_probe(struct platform_dev=
ice *pdev)
>  	int ret;
>  	int i;
> =20
> -	dev_dbg(&pdev->dev, "%s\n", __func__);
> -
>  	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
>  	if (!charger)
>  		return -ENOMEM;

Thanks, queued.

-- Sebastian

--gotcspk7xqgieite
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuQTkACgkQ2O7X88g7
+pr/0g/9F8bj9QghqwMkxZpyt6ef6PEK5WdrWjuJovrpdcgE2vg64G9s2s5sGMaB
UB5lvYVYCUa4CeWGL2UP9q+ViJvOElpg5O13Gxcj9MM9FIR8SIUnlR3qqU+nE5YP
bHhawatq22RhvnJx6hKt60RSfRo6/vqOsUjAHLwQ8lVStbV3mT87S2P8ReAbPHSS
F65K7safRS5bhsyPeNU9Ae20DRlY62HfZ3SI58mIoXQalXqdY1vyDwo7ZPMtmmdG
W52bIk/7bIM0VFCgNzxsZke6Ms8aYp3shhOQFraSyg465GQkegajFUXwgVuEhfnz
kL5Ju73gyYsqF38OrFytin1cKgUUOD3KLrgSefc8LD4yqm7KuJP7809LSGvMqird
iV0szMeVvE5ispTLkWjp+WURj24P88R6bQyYkf5j+nCxrCtsKGS3HIqJ5WhXIWq7
AVRkmGcfkre67QBL2OhmW8nxg6q4BNTr0D8JVqNXW65FlJS+FGtHQiYvis28wSYq
qw/ytXGM+C2RvKOshkUnA8LvcaxXr8FOmGkoX9KuWx1NbVoFrMzrKze/66WYJe8s
Y+XnSuQ+PLgB7qwJIUFlTs+4z0zIv66v4gsMd1dN/u9PPBie/424Gb8oYFNt4ri/
T9KmTgtxc3iCkNnfyM0fwoihI0caAApng2VWMl6mYhkX6JTUOz8=
=erk5
-----END PGP SIGNATURE-----

--gotcspk7xqgieite--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
