From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3] imx: thermal: imx_get_temp might be called before
 sensor clock is prepared
Date: Fri, 7 Nov 2014 14:18:46 -0400
Message-ID: <20141107181837.GA23972@developer>
References: <543C3B4B.6080700@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48603 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaKGSTD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 13:19:03 -0500
Received: by mail-qc0-f182.google.com with SMTP id m20so2991911qcx.13
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 10:19:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <543C3B4B.6080700@web.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: linux-pm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Heiner,

On Mon, Oct 13, 2014 at 10:51:23PM +0200, Heiner Kallweit wrote:
> imx_get_temp might be called before the sensor clock is prepared
> thus resulting in a timeout of the first attempt to read temp:
> thermal thermal_zone0: failed to read out thermal zone 0
> Happened to me on a Utilite Standard with IMX6 Dual SoC.
>=20
> Reason is that in imx_thermal_probe thermal_zone_device_register
> is called before the sensor clock is prepared.
> thermal_zone_device_register however calls
> thermal_zone_device_update which eventually calls imx_get_temp.
>=20
> Fix this by preparing the clock before calling
> thermal_zone_device_register.
>=20
> Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
> ---
> v2: revised error path. Bail out and tidy up properly if we can't
>     get the clock or fail to enable it
> v3: don't print error message if getting clock returns EPROBE_DEFER
> ---
>  drivers/thermal/imx_thermal.c | 41 +++++++++++++++++++++++++------------=
----
>  1 file changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 461bf3d..0e8ef55 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -521,6 +521,30 @@ static int imx_thermal_probe(struct platform_device =
*pdev)
>                 return ret;
>         }
>=20
> +       data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(data->thermal_clk)) {
> +               ret =3D PTR_ERR(data->thermal_clk);
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "failed to get thermal clk: %d\n", ret);
> +               cpufreq_cooling_unregister(data->cdev);
> +               return ret;
> +       }
> +
> +       /*
> +        * Thermal sensor needs clk on to get correct value, normally
> +        * we should enable its clk before taking measurement and disable
> +        * clk after measurement is done, but if alarm function is enable=
d,
> +        * hardware will auto measure the temperature periodically, so we
> +        * need to keep the clk always on for alarm function.
> +        */
> +       ret =3D clk_prepare_enable(data->thermal_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable thermal clk: %d\n",=
 ret);
> +               cpufreq_cooling_unregister(data->cdev);
> +               return ret;
> +       }
> +
>         data->tz =3D thermal_zone_device_register("imx_thermal_zone",
>                                                 IMX_TRIP_NUM,
>                                                 BIT(IMX_TRIP_PASSIVE), da=
ta,
> @@ -531,26 +555,11 @@ static int imx_thermal_probe(struct platform_device=
 *pdev)
>                 ret =3D PTR_ERR(data->tz);
>                 dev_err(&pdev->dev,
>                         "failed to register thermal zone device %d\n", re=
t);
> +               clk_disable_unprepare(data->thermal_clk);
>                 cpufreq_cooling_unregister(data->cdev);
>                 return ret;
>         }
>=20
> -       data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(data->thermal_clk)) {
> -               dev_warn(&pdev->dev, "failed to get thermal clk!\n");
> -       } else {
> -               /*
> -                * Thermal sensor needs clk on to get correct value, norm=
ally
> -                * we should enable its clk before taking measurement and=
 disable
> -                * clk after measurement is done, but if alarm function i=
s enabled,
> -                * hardware will auto measure the temperature periodicall=
y, so we
> -                * need to keep the clk always on for alarm function.
> -                */
> -               ret =3D clk_prepare_enable(data->thermal_clk);
> -               if (ret)
> -                       dev_warn(&pdev->dev, "failed to enable thermal cl=
k: %d\n", ret);
> -       }
> -
>         /* Enable measurements at ~ 10 Hz */
>         regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>         measure_freq =3D DIV_ROUND_UP(32768, 10); /* 10 Hz */


While here, do you need to move up also the configuration of the
measurements at ~ 10 Hz? Or would still the first readings be correct
while at the reset value?

Cheers,

Eduardo Valentin
> --
> 2.1.2

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXQz0AAoJEMLUO4d9pOJWGEEH/286lEalaa7L1o0HhLBlz07Q
fiCT/DUdzEEcXE77YyjMvRYfYp80cnaS7oI30YuC+AKE2Hn5h2fjZGB8pLlSDkOw
YKQ1RzlzzbKVtWsmpJSYC4vnuBa2pZNtKfsW9y558ApLz5Fxf2oHr5a7aGFaHwvN
rNEG+vnIT7xa0FOHGWQQuc63zXmv4IlfIwJ3vWvp6RFGdXOC7Faku7ox8s7d8Y+Q
lUi9NaltmN8J9y+2Z9a4jI992nqlXRB6Spr3L3MajrAqBkFHj8nUaOUkOJBOVWih
fxQnsWL9MC+uJyJKLdp58TAqa8ivexlTsPlhn0imPOhI5arcCfbgJ5cPyuQrvAU=
=kANE
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
