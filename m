From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/7] power: supply: bq24190_charger: Never reset the
 charger chip
Date: Thu, 23 Mar 2017 12:20:53 +0100
Message-ID: <20170323112052.ukyazi4pnji7n6st@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4meow3muulp4hiig"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdCWLU6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:20:58 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--4meow3muulp4hiig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 03:55:33PM +0100, Hans de Goede wrote:
> Resetting the charger should never be necessary it should always have
> sane values programmed. If it is running with invalid values while we
> are not running (system turned off or suspended) there is a big problem
> as that may lead to overcharging the battery.
>=20
> The reset in suspend() is meant to put the charger back into default
> mode, but this is not necessary and not a good idea. If the charger has
> been programmed with a higher max charge_current / charge_voltage then
> putting it back in default-mode will reset those to the safe power-on
> defaults, leading to slower charging, or charging to a lower voltage
> (and thus not using the full capacity) while suspended which is
> undesirable. Reprogramming the max charge_current / charge_voltage
> after the reset will not help here as that will put the charger back
> in host mode and start the i2c watchdog if the host then does not do
> anything for 40s (iow if we're suspended for more then 40s) the watchdog
> expires resetting the device to default-mode, including resetting all
> the registers to there safe power-on defaults. So the only way to keep
> using custom charge settings while suspending is to keep the charger in
> its normal running state with the i2c watchdog disabled. This is fine
> as the charger will still automatically switch from constant current
> to constant voltage and stop charging when the battery is full.
>=20
> Besides never being necessary resetting the charger also causes problems
> on systems where the charge voltage limit is set higher then the reset
> value, if this is the case and the charger is reset while charging and
> the battery voltage is between the 2 voltages, then about half the time
> the charger gets confused and claims to be charging (REG08 contains 0x64)
> but in reality the charger has decoupled itself from VBUS (Q1 off) and
> is drawing 0A from VBUS, leaving the system running from the battery.
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---

I skipped this patch for now due to ongoing discussion and behaviour
change. I think your reasoning makes sense and will queue this, if I
don't hear it results in regression in the next few days.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 58 ----------------------------=
------
>  1 file changed, 58 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 7a2a496..b535f24 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -526,40 +526,6 @@ static int bq24190_set_mode_host(struct bq24190_dev_=
info *bdi)
>  	return bq24190_write(bdi, BQ24190_REG_CTTC, v);
>  }
> =20
> -static int bq24190_register_reset(struct bq24190_dev_info *bdi)
> -{
> -	int ret, limit =3D 100;
> -	u8 v;
> -
> -	/* Reset the registers */
> -	ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> -			BQ24190_REG_POC_RESET_MASK,
> -			BQ24190_REG_POC_RESET_SHIFT,
> -			0x1);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Reset bit will be cleared by hardware so poll until it is */
> -	do {
> -		ret =3D bq24190_read_mask(bdi, BQ24190_REG_POC,
> -				BQ24190_REG_POC_RESET_MASK,
> -				BQ24190_REG_POC_RESET_SHIFT,
> -				&v);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (!v)
> -			break;
> -
> -		udelay(10);
> -	} while (--limit);
> -
> -	if (!limit)
> -		return -EIO;
> -
> -	return 0;
> -}
> -
>  /* Charger power supply property routines */
> =20
>  static int bq24190_charger_get_charge_type(struct bq24190_dev_info *bdi,
> @@ -1380,10 +1346,6 @@ static int bq24190_hw_init(struct bq24190_dev_info=
 *bdi)
>  		return -ENODEV;
>  	}
> =20
> -	ret =3D bq24190_register_reset(bdi);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret =3D bq24190_set_mode_host(bdi);
>  	if (ret < 0)
>  		return ret;
> @@ -1534,7 +1496,6 @@ static int bq24190_remove(struct i2c_client *client)
>  		pm_runtime_put_noidle(bdi->dev);
>  	}
> =20
> -	bq24190_register_reset(bdi);
>  	bq24190_sysfs_remove_group(bdi);
>  	power_supply_unregister(bdi->battery);
>  	power_supply_unregister(bdi->charger);
> @@ -1577,23 +1538,6 @@ static __maybe_unused int bq24190_runtime_resume(s=
truct device *dev)
> =20
>  static __maybe_unused int bq24190_pm_suspend(struct device *dev)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
> -	int error;
> -
> -	error =3D pm_runtime_get_sync(bdi->dev);
> -	if (error < 0) {
> -		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> -		pm_runtime_put_noidle(bdi->dev);
> -	}
> -
> -	bq24190_register_reset(bdi);
> -
> -	if (error >=3D 0) {
> -		pm_runtime_mark_last_busy(bdi->dev);
> -		pm_runtime_put_autosuspend(bdi->dev);
> -	}
> -
>  	return 0;
>  }
> =20
> @@ -1612,8 +1556,6 @@ static __maybe_unused int bq24190_pm_resume(struct =
device *dev)
>  		pm_runtime_put_noidle(bdi->dev);
>  	}
> =20
> -	bq24190_register_reset(bdi);
> -	bq24190_set_mode_host(bdi);
>  	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> =20
>  	if (error >=3D 0) {
> --=20
> 2.9.3
>=20

--4meow3muulp4hiig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTr5QACgkQ2O7X88g7
+pr6PQ/9Hjxoa91ArPE/nhK2FnEVqfDkwhcRtoukEwQdi3gpX6yHtzbDyahINvch
9sfpGGXPo7IShvdPyLBQWZACcJhBCRClbzd3bNC9iDb9s1oeGMry1cCPeBWG/kDw
pyUMqB4mAcJFpj13GPZswR4aUu9ru0Px/mwY8EV/nJnD3mQDF2tVxQEPe+VPqggm
ya3M+u7mcYvsmPZeiyxmYDI5GBypoHJ00W6Fp3AMjAUhBnV+jhGiPklPpKxQxK0e
JjNao8Eb0zAl8A8ssoCCTOiMGwg8b8BoS3vDTXo+bWajGqnJFXemOOLCjsUpFaaa
kwS+/nEP2tsFX51QKs0VVXCI93YHtPDT+Cc0N3e75yUm36+w91aB8FDLzXBgX4kG
c18LmHhpmE+XoYQXxbUPPCUTjK30oDtlZvC0UwoehPx3N9uEEr6aj4dWMIqBBcBh
Q98SdM6/W8KYFGaaFhKjyD+2Pg/AxGqh7hgOhQfxVBloIo2OBblgJsHfDYHhojuZ
/j8QgNsOFbTCKFF/F2G3lIaEjXtZ+oOcNTbyGbkuXb9y2SH1p+JnhdUmGBY0SOK/
+kztHoXmduD/wtVYzpG54e3rAt+DUtjLJgKjWpUXSb/wwJ2pFWpJucG2hhXCprk+
RormlJSean+sIfGgDub9moBsH5yTix2Hv7JjRB06Gy00Uf0r8jY=
=TOIA
-----END PGP SIGNATURE-----

--4meow3muulp4hiig--
