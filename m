From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Add driver for MAX17211/MAX17215 fuel gauge
Date: Sat, 29 Apr 2017 18:40:53 +0200
Message-ID: <20170429164053.olynja4kyqpwhfpk@earth>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-3-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5ii65dta4x4wbqr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S376726AbdD2QlB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Apr 2017 12:41:01 -0400
Content-Disposition: inline
In-Reply-To: <20170429143429.5685-3-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net


--l5ii65dta4x4wbqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please make sure you Cc the relevant people / mailing lists. You
can use ./scripts/get_maintainer.pl to find out who should receive
the patches.

On Sat, Apr 29, 2017 at 05:34:29PM +0300, Alex A. Mihaylov wrote:
> Maxim Semiconductor MAX17211/MAX17215 single/multi-cell fuel gauge
> monitor with M5 Fuel Gauge algorithm
>=20
> This driver provide userspace access to MAX17211/MAX17215 data with
> power_supply class drivers.

> ---
>  drivers/power/supply/Kconfig            |   8 +
>  drivers/power/supply/Makefile           |   1 +

Please move the entries in both files before CONFIG_BATTERY_MAX17040.

> [...]
>
> +	 * FixMe:
> +	 * Device without no_thermal =3D true not register (err -22)
> +	 * Len of platform device name "max17211-battery.X.auto"
> +	 * more than 20 chars limit in THERMAL_NAME_LENGTH from
> +	 * include/uapi/linux/thermal.h
> +	 */

IIRC we already had problems with small THERMAL_NAME_LENGTH before.
I suggest to add another patch, that increases THERMAL_NAME_LENGTH
(don't forget to Cc/To the thermal subsystem people).

> +	info->bat_desc.no_thermal =3D true;
> +	psy_cfg.drv_data =3D info;
> +
> +	if (w1_max1721x_reg_get(info->w1_dev,
> +			MAX1721X_REG_NRSENSE, &info->rsense))
> +		return -ENODEV;
> +
> +	if (!info->rsense) {
> +		dev_warn(info->dev, "RSenese not calibrated, set 10 mOhms!\n");
> +		info->rsense =3D 1000; /* in regs in 10^-5 */
> +	}
> +	dev_dbg(info->dev, "RSense: %d mOhms.\n", info->rsense / 100);
> +
> +	if (get_string(info->w1_dev, MAX1721X_REG_MFG_STR,
> +			MAX1721X_REG_MFG_NUMB, info->ManufacturerName)) {
> +		dev_err(info->dev, "Can't read manufacturer. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!info->ManufacturerName[0])
> +		strncpy(info->ManufacturerName, DEF_MFG_NAME,
> +			2 * MAX1721X_REG_MFG_NUMB);
> +
> +	if (get_string(info->w1_dev, MAX1721X_REG_DEV_STR,
> +			MAX1721X_REG_DEV_NUMB, info->DeviceName)) {
> +		dev_err(info->dev, "Can't read device. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +	if (!info->DeviceName[0]) {
> +		uint16_t dev_name;
> +
> +		if (w1_max1721x_reg_get(info->w1_dev,
> +				MAX172XX_REG_DEVNAME, &dev_name)) {
> +			dev_err(info->w1_dev, "Can't read device name reg.\n");
> +			return -ENODEV;
> +		}
> +
> +		switch (dev_name & MAX172XX_DEV_MASK) {
> +		case MAX172X1_DEV:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +			break;
> +		case MAX172X5_DEV:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +			break;
> +		default:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +		}
> +	}
> +
> +	if (get_sn_string(info->w1_dev, info->SerialNumber)) {
> +		dev_err(info->dev, "Can't read serial. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	info->bat =3D power_supply_register(&pdev->dev, &info->bat_desc,
> +						&psy_cfg);
> +	if (IS_ERR(info->bat)) {
> +		dev_err(info->dev, "failed to register battery\n");
> +		return PTR_ERR(info->bat);
> +	}

Please use devm_power_supply_register() and drop the remove
function.

> +	return 0;
> +}
> +
> +static int max1721x_battery_remove(struct platform_device *pdev)
> +{
> +	struct max17211_device_info *info =3D platform_get_drvdata(pdev);
> +
> +	power_supply_unregister(info->bat);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver max1721x_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "max1721x-battery",
> +	},
> +	.probe	  =3D max1721x_battery_probe,
> +	.remove   =3D max1721x_battery_remove,
> +};
> +module_platform_driver(max1721x_battery_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
> +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
> +MODULE_ALIAS("platform:max1721x-battery");

-- Sebastian

--l5ii65dta4x4wbqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkEwhIACgkQ2O7X88g7
+pruyQ//RDBUNa31544z066YWodXZvqH9CzaGnJ1jmmiE2B2V/UNltB9qio+ySEl
YJWJCljA8lEGVAEZftYckN8yMOeUP6NVvT0StLUn0A9kSR0qnGd7aNWi1bVWwL8g
sobKM2UT6caKPNjRxv3u3ymViCccK64k/mMVUFPpACmDS88tvQiPunFQRE250RjU
t0rjmcMdPiUd45hMCdpCBA/Mv+0OZpB2xceLH/5mw2CYM7guMwOOdma2u6quyCDx
fLFKpoN9/X0GMFJIkiWyLLRNwAA9b8qc7cMEmp4W2WIQnCHxMHpMpInS3qRK8EXk
zZ5KyWw7W2FiNq4OzFqLe4/0EZrkUs+4jEVQQWJyACdZ+TmTmBX+f3Khb80+WUID
bhbV9bntpsDl4/gbw35mb9JsJp1Ln9o7vV7f88qjAdE/fFcRqyC4H5ZYDqceH4VE
Fz1lxK03yApdIZumK9IF4Uie8+p1pDu2RftWe+kvuYGjP9nIyAgjh581eN90bv64
Z2j98BM1rY3HTjYy7a/bUwY3A0PtELQwDWKlflNNi0pEDiAsyKBsgz6CM6w3e7ib
yhtHpRioKbkUoBLEYcdIC2XHVhKbxkWuL+UoIFtrV1ahQYeSP6yF9B8WahBDdalq
n5CTNFczO0HJfUg2s68bSf3CcW6R96+VUEDh9ghSh94Xmelwp8c=
=KRVQ
-----END PGP SIGNATURE-----

--l5ii65dta4x4wbqr--
