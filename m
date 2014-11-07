From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3] imx: thermal: imx_get_temp might be called before
 sensor clock is prepared
Date: Fri, 7 Nov 2014 19:47:10 -0400
Message-ID: <20141107234707.GB27665@developer>
References: <543C3B4B.6080700@web.de>
 <20141107181837.GA23972@developer>
 <545D4B03.6080400@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:39171 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaKGXsc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 18:48:32 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so3070155qaq.16
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 15:48:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <545D4B03.6080400@web.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: linux-pm@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heiner,

On Fri, Nov 07, 2014 at 11:43:15PM +0100, Heiner Kallweit wrote:
> Am 07.11.2014 um 19:18 schrieb Eduardo Valentin:
> >=20
> > Hello Heiner,
> >=20
> > On Mon, Oct 13, 2014 at 10:51:23PM +0200, Heiner Kallweit wrote:
> >> imx_get_temp might be called before the sensor clock is prepared
> >> thus resulting in a timeout of the first attempt to read temp:
> >> thermal thermal_zone0: failed to read out thermal zone 0
> >> Happened to me on a Utilite Standard with IMX6 Dual SoC.
> >>
> >> Reason is that in imx_thermal_probe thermal_zone_device_register
> >> is called before the sensor clock is prepared.
> >> thermal_zone_device_register however calls
> >> thermal_zone_device_update which eventually calls imx_get_temp.
> >>
> >> Fix this by preparing the clock before calling
> >> thermal_zone_device_register.
> >>
> >> Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
> >> ---
> >> v2: revised error path. Bail out and tidy up properly if we can't
> >>     get the clock or fail to enable it
> >> v3: don't print error message if getting clock returns EPROBE_DEFER
> >> ---
> >>  drivers/thermal/imx_thermal.c | 41 +++++++++++++++++++++++++---------=
-------
> >>  1 file changed, 25 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therm=
al.c
> >> index 461bf3d..0e8ef55 100644
> >> --- a/drivers/thermal/imx_thermal.c
> >> +++ b/drivers/thermal/imx_thermal.c
> >> @@ -521,6 +521,30 @@ static int imx_thermal_probe(struct platform_devi=
ce *pdev)
> >>                 return ret;
> >>         }
> >>
> >> +       data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
> >> +       if (IS_ERR(data->thermal_clk)) {
> >> +               ret =3D PTR_ERR(data->thermal_clk);
> >> +               if (ret !=3D -EPROBE_DEFER)
> >> +                       dev_err(&pdev->dev,
> >> +                               "failed to get thermal clk: %d\n", ret=
);
> >> +               cpufreq_cooling_unregister(data->cdev);
> >> +               return ret;
> >> +       }
> >> +
> >> +       /*
> >> +        * Thermal sensor needs clk on to get correct value, normally
> >> +        * we should enable its clk before taking measurement and disa=
ble
> >> +        * clk after measurement is done, but if alarm function is ena=
bled,
> >> +        * hardware will auto measure the temperature periodically, so=
 we
> >> +        * need to keep the clk always on for alarm function.
> >> +        */
> >> +       ret =3D clk_prepare_enable(data->thermal_clk);
> >> +       if (ret) {
> >> +               dev_err(&pdev->dev, "failed to enable thermal clk: %d\=
n", ret);
> >> +               cpufreq_cooling_unregister(data->cdev);
> >> +               return ret;
> >> +       }
> >> +
> >>         data->tz =3D thermal_zone_device_register("imx_thermal_zone",
> >>                                                 IMX_TRIP_NUM,
> >>                                                 BIT(IMX_TRIP_PASSIVE),=
 data,
> >> @@ -531,26 +555,11 @@ static int imx_thermal_probe(struct platform_dev=
ice *pdev)
> >>                 ret =3D PTR_ERR(data->tz);
> >>                 dev_err(&pdev->dev,
> >>                         "failed to register thermal zone device %d\n",=
 ret);
> >> +               clk_disable_unprepare(data->thermal_clk);
> >>                 cpufreq_cooling_unregister(data->cdev);
> >>                 return ret;
> >>         }
> >>
> >> -       data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
> >> -       if (IS_ERR(data->thermal_clk)) {
> >> -               dev_warn(&pdev->dev, "failed to get thermal clk!\n");
> >> -       } else {
> >> -               /*
> >> -                * Thermal sensor needs clk on to get correct value, n=
ormally
> >> -                * we should enable its clk before taking measurement =
and disable
> >> -                * clk after measurement is done, but if alarm functio=
n is enabled,
> >> -                * hardware will auto measure the temperature periodic=
ally, so we
> >> -                * need to keep the clk always on for alarm function.
> >> -                */
> >> -               ret =3D clk_prepare_enable(data->thermal_clk);
> >> -               if (ret)
> >> -                       dev_warn(&pdev->dev, "failed to enable thermal=
 clk: %d\n", ret);
> >> -       }
> >> -
> >>         /* Enable measurements at ~ 10 Hz */
> >>         regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FRE=
Q);
> >>         measure_freq =3D DIV_ROUND_UP(32768, 10); /* 10 Hz */
> >=20
> >=20
> > While here, do you need to move up also the configuration of the
> > measurements at ~ 10 Hz? Or would still the first readings be correct
> > while at the reset value?
> When imx_get_temp is called from thermal_zone_device_register data->mode =
still is
> THERMAL_DEVICE_DISABLED. imx_get_temp therefore will power on the sensor =
and
> trigger a single measurement.
> IMHO this is fully ok and I don't think we have to relocate the setup of =
the
> scheduled measurements.


OK. I see.=20

In this case, can you please re-post this patch on top of my -fixes
patches? I am planing to send it in the -rc cycles.

I've just merged another fix on imx driver and looks like your
patch needs refreshing now.=20


Thanks,

Eduardo Valentin

> >=20
> > Cheers,
> >=20
> > Eduardo Valentin
> >> --
> >> 2.1.2
> Rgds, Heiner
>=20

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXVnuAAoJEMLUO4d9pOJWlwYH/1o3DdqvzFucmM2Xt23CYTCV
CshWA4vVKoMdHdBKIZu/s7Z7Q+izMjo/AoXHDCV90OcwZE4ddZfuQRPJZCqa+26Y
B6Uc3Opyg9Jt6zy4HYYF+Ifnl45R4eYEoryTZgUiFPCaTD0B6oNZhu+3dDkgUn4U
dysfiP1D3AFnY3CU1MegV470umwNwQ01aIaD4QBXjAn+pbaZYBJampmq7Ui3p716
ox4+ZEJI2OhK78/EoaGqZ7rCdpk6xuGlgelQqBpFPT7mjrftYuEfBPAx816tBZ85
m1rdK9FAhKUGSi4R9XQIPFjAr2h94wA0k9uBPy3RyAMPmp8p5dYml4wFiJ0gA94=
=z+ow
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
