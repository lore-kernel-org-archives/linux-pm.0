From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 6/7] power: supply: bq24190_charger: Cleanup
 error-exit labels in probe()
Date: Thu, 23 Mar 2017 12:21:39 +0100
Message-ID: <20170323112139.4no4ffwabjixtild@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d5qm26pkpgxgtoep"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdCWLVp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:21:45 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-7-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--d5qm26pkpgxgtoep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 03:55:35PM +0100, Hans de Goede wrote:
> Names like out1, out2, etc. do not make it easier to follow what is
> going on and make it harder (require renaming) if any steps are
> later added / removed. Rename the labels to sane names.
>=20
> This also folds out1 and out2 into one pm_runtime_disable step,
> if pm_runtime_get_sync fails we still need to do the put, it
> failing means that the device failed to resume, but the refcount
> will have been incremented and we need to decrement it.
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---

I tried to queue this, but it does not apply without the reset
patch.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 351e020..5e3da66 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1408,12 +1408,12 @@ static int bq24190_probe(struct i2c_client *clien=
t,
>  	pm_runtime_set_autosuspend_delay(dev, 600);
>  	ret =3D pm_runtime_get_sync(dev);
>  	if (ret < 0)
> -		goto out1;
> +		goto pm_runtime_disable;
> =20
>  	ret =3D bq24190_hw_init(bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Hardware init failed\n");
> -		goto out2;
> +		goto pm_runtime_disable;
>  	}
> =20
>  	charger_cfg.drv_data =3D bdi;
> @@ -1424,7 +1424,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (IS_ERR(bdi->charger)) {
>  		dev_err(dev, "Can't register charger\n");
>  		ret =3D PTR_ERR(bdi->charger);
> -		goto out2;
> +		goto pm_runtime_disable;
>  	}
> =20
>  	battery_cfg.drv_data =3D bdi;
> @@ -1433,13 +1433,13 @@ static int bq24190_probe(struct i2c_client *clien=
t,
>  	if (IS_ERR(bdi->battery)) {
>  		dev_err(dev, "Can't register battery\n");
>  		ret =3D PTR_ERR(bdi->battery);
> -		goto out3;
> +		goto unregister_charger;
>  	}
> =20
>  	ret =3D bq24190_sysfs_create_group(bdi);
>  	if (ret) {
>  		dev_err(dev, "Can't create sysfs entries\n");
> -		goto out4;
> +		goto unregister_battery;
>  	}
> =20
>  	bdi->initialized =3D true;
> @@ -1450,7 +1450,7 @@ static int bq24190_probe(struct i2c_client *client,
>  			"bq24190-charger", bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Can't set up irq handler\n");
> -		goto out5;
> +		goto remove_sysfs_group;
>  	}
> =20
>  	if (bdi->extcon) {
> @@ -1459,7 +1459,7 @@ static int bq24190_probe(struct i2c_client *client,
>  		ret =3D devm_extcon_register_notifier(dev, bdi->extcon, -1,
>  						    &bdi->extcon_nb);
>  		if (ret)
> -			goto out5;
> +			goto remove_sysfs_group;
> =20
>  		/* Sync initial cable state */
>  		queue_delayed_work(system_wq, &bdi->extcon_work, 0);
> @@ -1472,19 +1472,17 @@ static int bq24190_probe(struct i2c_client *clien=
t,
> =20
>  	return 0;
> =20
> -out5:
> +remove_sysfs_group:
>  	bq24190_sysfs_remove_group(bdi);
> =20
> -out4:
> +unregister_battery:
>  	power_supply_unregister(bdi->battery);
> =20
> -out3:
> +unregister_charger:
>  	power_supply_unregister(bdi->charger);
> =20
> -out2:
> +pm_runtime_disable:
>  	pm_runtime_put_sync(dev);
> -
> -out1:
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	return ret;
> --=20
> 2.9.3
>=20

--d5qm26pkpgxgtoep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTr8MACgkQ2O7X88g7
+ppifg/8DmJPG9ISTCXdoJoKsQuatG7TGBs2D/q+vBQbOvHP+YBsOYFa+s6xYFvB
WpB0g5LZhsuhnG1QP9AF2suyyVt4Uam/5IJq+iGzxlm3fXsInO9GoW8tsqMk21ys
yFSy2lfmmwtwVdPJ9Gpqt/lfFXma7QevvG1XSfeY0PLPv4hgdvnbtbMJUcdFZ4Ge
Ai1aXHbzhrLqBez9eh6SS+DO8dAKe7wo3jS4KaeZdFnIIXP8Fk3jJSg5HhHYzvir
I2MZgtb8EPlpkRMnYT1VPKoUJpBOt3uoUobUM1iQZY/h95uJVBELzZKhOpeF9vB6
aiDpr4E4bQxYMH+PK4n1miNkFOEo97+LN/+jQ//pTt5ONQBvoNc2DehJ3HOkiJBs
ZI/YfOKR0ynbocM32IsR6FWJZ6FRuQ5XEWZCUvIj0hAuc8rIuPTRyWxijUquG1J8
ulVgi//g4dp5AhquruVPiSbYyhok3s3HxQfl5klrlMeKM1rmScNCbJZflsrfFEuq
KJtrp/FEz/RfWwP+hv91xRfIGh9AszlOB90vtNl2WNfdLaPjVgaqs8+bY/Wsd63F
cWkwbOlOOuIznh9mQeqrvi0piY3DSUioA9J55v/XBrNXiap6cQi6evZVb0oEQ5fz
0tCjJ89YcXhWfuUxzWSTSZENT0iigQ8BzbX4n0Mi+SK2ynFCV44=
=GWdt
-----END PGP SIGNATURE-----

--d5qm26pkpgxgtoep--
