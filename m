Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FD3AB285;
	Wed,  3 Jun 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519782; cv=pass; b=KwFtAz89/W372WpA8xMnygWBfSBWz2cEoboW0TiADQBLGnwhfXMzxIG4utayQzZdLqidZqW5DD0BeKZRKZ52Bx7E+wJqLJjhfqcXDYTsvN+jMPRcdMoemzvKK+I9HLBDP+LRAprwXcE2WcxW20M6AInJO7/E6VLMsWhqYbg+B2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519782; c=relaxed/simple;
	bh=EIHbqThpFLk4+7l+J2r+AY+pBe2LCHyXPONa2fYNLtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpeXoOJP5V0rUE0doikLG6D6OvSZpOEdd1dAhBpkFGNs0X9dNO1eocGSXVnkK1bxVwqlrOKqxxE7WCkIwTwYg5Z3LicElokdUZfwWm8IX6hYusvpKiqN9EBwx9u00qD/OTtYyg9y/2by0W7Gpt4hgVVcm82dChhTLiukVzRVMR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Odr7pRwG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Odr7pRwG"
ARC-Seal: i=1; a=rsa-sha256; t=1780519772; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gNaw/aVeGXamORwDPS9VmXyh/NEGtCbt5BbVKAZbSUEs++LuxY27gzv/WZx1Niua8i2NX1oFEMhAY+5uvmUDVbjgTD7N+ZR+qQ3x3VoZAD+kL06k9b///j2PnJJhWTg/Q7vHCjCsHZKS2aAqa9I1tW3+Gv3m+SMs4sPoS44H1Vg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780519772; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g2Ggrrtuby1B4P9s8RZvI2uOykjjFkJOoqfxyLLflzs=; 
	b=JlYKm7I+MB/1dMqkDDwcndE0LYho7HiwEbvrYiPV97Nc1OShKWsA9Id1O723DjyDzUipBkFs/6Qbmtv+gVHM1Vgba0CGawrvRzalgQ5iEFVrUuHYM5fGfZ22VqLLAPCmGZ+ND9ECtgzR43sbXeX4ezkTrM9nu8pI70N462z2+JY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780519772;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=g2Ggrrtuby1B4P9s8RZvI2uOykjjFkJOoqfxyLLflzs=;
	b=Odr7pRwGPE245t6y2oFYdVPO+5EjOQk2UPc8ux2wof+llR+QKSeQ1dY4vsSXiolR
	+pOFZ81RU85AbWcJ3RC9iCr6eVB+IHZUectxxi3iS9ZNFm5qosur+ygCwwz4GAHo2LA
	ybLbC+v7O/CStFRven3yhHxjqOveshVvTAYNSNfQ=
Received: by mx.zohomail.com with SMTPS id 1780519769083459.43901268952254;
	Wed, 3 Jun 2026 13:49:29 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A7CEA180C6E; Wed, 03 Jun 2026 22:49:25 +0200 (CEST)
Date: Wed, 3 Jun 2026 22:49:25 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Chris Morgan <macromorgan@hotmail.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 7/7] power: supply: bq257xx: Add support for BQ25792
Message-ID: <aiCS4D2-sSi2BdDZ@venus>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
 <20260603-bq25792-v7-7-d487bed276d0@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el3q7esuljbgqf7j"
Content-Disposition: inline
In-Reply-To: <20260603-bq25792-v7-7-d487bed276d0@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.501.96
X-ZohoMailClient: External


--el3q7esuljbgqf7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 7/7] power: supply: bq257xx: Add support for BQ25792
MIME-Version: 1.0

Hi,

On Wed, Jun 03, 2026 at 12:10:55AM +0400, Alexey Charkov wrote:
> Add support for TI BQ25792 integrated battery charger and buck-boost
> converter.
>=20
> It shares high-level logic of operation with the already supported
> BQ25703A, but has a different register map, bit definitions and some of
> the lower-level hardware states.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This has to wait a cycle as it does not apply due to the MFD header
change.

Greetings,

-- Sebastian

>  drivers/power/supply/bq257xx_charger.c | 528 +++++++++++++++++++++++++++=
+++++-
>  include/linux/mfd/bq257xx.h            |  14 +
>  2 files changed, 541 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index 9c082865e745..7d02169248b1 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/bq257xx.h>
> @@ -88,6 +89,53 @@ struct bq257xx_chg {
>  	u32 vsys_min;
>  };
> =20
> +/**
> + * bq25792_read16() - Read a 16-bit value from device register
> + * @pdata: driver platform data
> + * @reg: register address to read from
> + * @val: pointer to store the register value
> + *
> + * Read a 16-bit big-endian value from the BQ25792 device via regmap
> + * and convert to CPU byte order.
> + *
> + * Return: Returns 0 on success or error on failure to read.
> + */
> +static int bq25792_read16(struct bq257xx_chg *pdata, unsigned int reg, u=
16 *val)
> +{
> +	__be16 regval;
> +	int ret;
> +
> +	ret =3D regmap_raw_read(pdata->bq->regmap, reg, &regval, sizeof(regval)=
);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D be16_to_cpu(regval);
> +	return 0;
> +}
> +
> +/**
> + * bq25792_write16() - Write a 16-bit value to device register
> + * @pdata: driver platform data
> + * @reg: register address to write to
> + * @val: 16-bit value to write in CPU byte order
> + *
> + * Convert the value to big-endian and write a 16-bit value to the
> + * BQ25792 device via regmap.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_write16(struct bq257xx_chg *pdata, unsigned int reg, =
u16 val)
> +{
> +	__be16 regval =3D cpu_to_be16(val);
> +	int ret;
> +
> +	ret =3D regmap_raw_write(pdata->bq->regmap, reg, &regval, sizeof(regval=
));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /**
>   * bq25703_get_state() - Get the current state of the device
>   * @pdata: driver platform data
> @@ -119,6 +167,43 @@ static int bq25703_get_state(struct bq257xx_chg *pda=
ta)
>  	return 0;
>  }
> =20
> +/**
> + * bq25792_get_state() - Get the current state of the device
> + * @pdata: driver platform data
> + *
> + * Get the current state of the BQ25792 charger by reading status
> + * registers. Updates the online, charging, overvoltage, and fault
> + * status fields in the driver data structure.
> + *
> + * Return: Returns 0 on success or error on failure to read device.
> + */
> +static int bq25792_get_state(struct bq257xx_chg *pdata)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25792_REG1B_CHARGER_STATUS_0, =
&reg);
> +	if (ret)
> +		return ret;
> +
> +	pdata->online =3D reg & BQ25792_REG1B_PG_STAT;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25792_REG1C_CHARGER_STATUS_1, =
&reg);
> +	if (ret)
> +		return ret;
> +
> +	pdata->charging =3D reg & BQ25792_REG1C_CHG_STAT_MASK;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25792_REG20_FAULT_STATUS_0, &r=
eg);
> +	if (ret)
> +		return ret;
> +
> +	pdata->overvoltage =3D reg & BQ25792_REG20_OVERVOLTAGE_MASK;
> +	pdata->oc_fault =3D reg & BQ25792_REG20_OVERCURRENT_MASK;
> +
> +	return 0;
> +}
> +
>  /**
>   * bq25703_get_min_vsys() - Get the minimum system voltage
>   * @pdata: driver platform data
> @@ -142,6 +227,31 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *=
pdata, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_min_vsys() - Get the minimum system voltage
> + * @pdata: driver platform data
> + * @intval: pointer to store the minimum voltage value
> + *
> + * Read the current minimum system voltage setting from the device
> + * and return it in microvolts.
> + *
> + * Return: Returns 0 on success or error on failure to read.
> + */
> +static int bq25792_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25792_REG00_MIN_SYS_VOLTAGE, &=
reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D FIELD_GET(BQ25792_REG00_VSYSMIN_MASK, reg);
> +	*intval =3D (reg * BQ25792_MINVSYS_STEP_UV) + BQ25792_MINVSYS_MIN_UV;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_set_min_vsys() - Set the minimum system voltage
>   * @pdata: driver platform data
> @@ -166,6 +276,29 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *=
pdata, int vsys)
>  			    reg);
>  }
> =20
> +/**
> + * bq25792_set_min_vsys() - Set the minimum system voltage
> + * @pdata: driver platform data
> + * @vsys: voltage value to set in uV
> + *
> + * Set the minimum system voltage by clamping the requested value
> + * between device limits and writing to the appropriate register.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
> +{
> +	unsigned int reg;
> +	int vsys_min =3D pdata->vsys_min;
> +
> +	vsys =3D clamp(vsys, vsys_min, BQ25792_MINVSYS_MAX_UV);
> +	reg =3D ((vsys - BQ25792_MINVSYS_MIN_UV) / BQ25792_MINVSYS_STEP_UV);
> +	reg =3D FIELD_PREP(BQ25792_REG00_VSYSMIN_MASK, reg);
> +
> +	return regmap_write(pdata->bq->regmap,
> +			    BQ25792_REG00_MIN_SYS_VOLTAGE, reg);
> +}
> +
>  /**
>   * bq25703_get_cur() - Get the reported current from the battery
>   * @pdata: driver platform data
> @@ -195,6 +328,30 @@ static int bq25703_get_cur(struct bq257xx_chg *pdata=
, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_cur() - Get the reported current from the battery
> + * @pdata: driver platform data
> + * @intval: pointer to store the battery current value
> + *
> + * Read the current ADC value from the device representing the battery
> + * charge or discharge current and return it in microamps.
> + *
> + * Return: Returns 0 on success or error on failure to read.
> + */
> +static int bq25792_get_cur(struct bq257xx_chg *pdata, int *intval)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D bq25792_read16(pdata, BQ25792_REG33_IBAT_ADC, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*intval =3D (s16)reg * BQ25792_ADCIBAT_STEP_UA;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_get_ichg_cur() - Get the maximum reported charge current
>   * @pdata: driver platform data
> @@ -218,6 +375,30 @@ static int bq25703_get_ichg_cur(struct bq257xx_chg *=
pdata, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_ichg_cur() - Get the maximum reported charge current
> + * @pdata: driver platform data
> + * @intval: pointer to store the maximum charge current value
> + *
> + * Read the programmed maximum charge current limit from the device.
> + *
> + * Return: Returns 0 on success or error on failure to read value.
> + */
> +static int bq25792_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D bq25792_read16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*intval =3D FIELD_GET(BQ25792_REG03_ICHG_MASK, reg) *
> +		  BQ25792_ICHG_STEP_UA;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_set_ichg_cur() - Set the maximum charge current
>   * @pdata: driver platform data
> @@ -242,6 +423,28 @@ static int bq25703_set_ichg_cur(struct bq257xx_chg *=
pdata, int ichg)
>  			    reg);
>  }
> =20
> +/**
> + * bq25792_set_ichg_cur() - Set the maximum charge current
> + * @pdata: driver platform data
> + * @ichg: current value to set in uA
> + *
> + * Set the maximum charge current by clamping the requested value
> + * between device limits and writing to the appropriate register.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
> +{
> +	int ichg_max =3D pdata->ichg_max;
> +	u16 reg;
> +
> +	ichg =3D clamp(ichg, BQ25792_ICHG_MIN_UA, ichg_max);
> +	reg =3D FIELD_PREP(BQ25792_REG03_ICHG_MASK,
> +			 (ichg / BQ25792_ICHG_STEP_UA));
> +
> +	return bq25792_write16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, reg);
> +}
> +
>  /**
>   * bq25703_get_chrg_volt() - Get the maximum set charge voltage
>   * @pdata: driver platform data
> @@ -265,6 +468,30 @@ static int bq25703_get_chrg_volt(struct bq257xx_chg =
*pdata, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_chrg_volt() - Get the maximum set charge voltage
> + * @pdata: driver platform data
> + * @intval: pointer to store the maximum charge voltage value
> + *
> + * Read the current charge voltage limit from the device.
> + *
> + * Return: Returns 0 on success or error on failure to read value.
> + */
> +static int bq25792_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D bq25792_read16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*intval =3D FIELD_GET(BQ25792_REG01_VREG_MASK, reg) *
> +		  BQ25792_VBATREG_STEP_UV;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_set_chrg_volt() - Set the maximum charge voltage
>   * @pdata: driver platform data
> @@ -291,6 +518,29 @@ static int bq25703_set_chrg_volt(struct bq257xx_chg =
*pdata, int vbat)
>  			    reg);
>  }
> =20
> +/**
> + * bq25792_set_chrg_volt() - Set the maximum charge voltage
> + * @pdata: driver platform data
> + * @vbat: voltage value to set in uV
> + *
> + * Set the maximum charge voltage by clamping the requested value
> + * between device limits and writing to the appropriate register.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
> +{
> +	int vbat_max =3D pdata->vbat_max;
> +	u16 reg;
> +
> +	vbat =3D clamp(vbat, BQ25792_VBATREG_MIN_UV, vbat_max);
> +
> +	reg =3D FIELD_PREP(BQ25792_REG01_VREG_MASK,
> +			 (vbat / BQ25792_VBATREG_STEP_UV));
> +
> +	return bq25792_write16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, reg);
> +}
> +
>  /**
>   * bq25703_get_iindpm() - Get the maximum set input current
>   * @pdata: driver platform data
> @@ -319,6 +569,30 @@ static int bq25703_get_iindpm(struct bq257xx_chg *pd=
ata, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_iindpm() - Get the maximum set input current
> + * @pdata: driver platform data
> + * @intval: pointer to store the maximum input current value
> + *
> + * Read the current input current limit from the device.
> + *
> + * Return: Returns 0 on success or error on failure to read value.
> + */
> +static int bq25792_get_iindpm(struct bq257xx_chg *pdata, int *intval)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D bq25792_read16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D FIELD_GET(BQ25792_REG06_IINDPM_MASK, reg);
> +	*intval =3D reg * BQ25792_IINDPM_STEP_UA;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_set_iindpm() - Set the maximum input current
>   * @pdata: driver platform data
> @@ -344,6 +618,29 @@ static int bq25703_set_iindpm(struct bq257xx_chg *pd=
ata, int iindpm)
>  			    FIELD_PREP(BQ25703_IINDPM_MASK, reg));
>  }
> =20
> +/**
> + * bq25792_set_iindpm() - Set the maximum input current
> + * @pdata: driver platform data
> + * @iindpm: current value in uA
> + *
> + * Set the maximum input current by clamping the requested value
> + * between device limits and writing to the appropriate register.
> + *
> + * Return: Returns 0 on success or error on failure to write.
> + */
> +static int bq25792_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
> +{
> +	u16 reg;
> +	int iindpm_max =3D pdata->iindpm_max;
> +
> +	iindpm =3D clamp(iindpm, BQ25792_IINDPM_MIN_UA, iindpm_max);
> +
> +	reg =3D iindpm / BQ25792_IINDPM_STEP_UA;
> +
> +	return bq25792_write16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT,
> +			       FIELD_PREP(BQ25792_REG06_IINDPM_MASK, reg));
> +}
> +
>  /**
>   * bq25703_get_vbat() - Get the reported voltage from the battery
>   * @pdata: driver platform data
> @@ -368,6 +665,30 @@ static int bq25703_get_vbat(struct bq257xx_chg *pdat=
a, int *intval)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_get_vbat() - Get the reported voltage from the battery
> + * @pdata: driver platform data
> + * @intval: pointer to store the battery voltage value
> + *
> + * Read the current ADC value representing the battery voltage
> + * and return it in microvolts.
> + *
> + * Return: Returns 0 on success or error on failure to read value.
> + */
> +static int bq25792_get_vbat(struct bq257xx_chg *pdata, int *intval)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D bq25792_read16(pdata, BQ25792_REG3B_VBAT_ADC, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*intval =3D reg * BQ25792_ADCVSYSVBAT_STEP_UV;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_hw_init() - Set all the required registers to init the charger
>   * @pdata: driver platform data
> @@ -434,6 +755,108 @@ static int bq25703_hw_init(struct bq257xx_chg *pdat=
a)
>  	return ret;
>  }
> =20
> +/**
> + * bq25792_hw_init() - Initialize BQ25792 hardware
> + * @pdata: driver platform data
> + *
> + * Initialize the BQ25792 by disabling the watchdog, enabling discharge
> + * current sensing with 5A limit, and configuring input current regulati=
on.
> + * Set the charge current, charge voltage, minimum system voltage, and
> + * input current limit from platform data. Enable and configure the ADC
> + * to measure all available channels.
> + *
> + * Return: Returns 0 on success or error code on error.
> + */
> +static int bq25792_hw_init(struct bq257xx_chg *pdata)
> +{
> +	struct regmap *regmap =3D pdata->bq->regmap;
> +	int ret =3D 0;
> +	u8 reg;
> +
> +	/* Disable watchdog (TODO: make it work instead) */
> +	ret =3D regmap_write(regmap, BQ25792_REG10_CHARGER_CONTROL_1, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Enable battery discharge current sensing, 5A discharge current
> +	 * limit, input current regulation and ship FET functions
> +	 */
> +	ret =3D regmap_write(regmap, BQ25792_REG14_CHARGER_CONTROL_5,
> +			   BQ25792_REG14_SFET_PRESENT |
> +			   BQ25792_REG14_EN_IBAT |
> +			   BQ25792_IBAT_5A |
> +			   BQ25792_REG14_EN_IINDPM);
> +	if (ret)
> +		return ret;
> +
> +	if (pdata->vbat_max < 5000000) {
> +		/* 1S batteries */
> +		reg =3D FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_1S);
> +	} else if (pdata->vbat_max < 10000000) {
> +		/* 2S batteries */
> +		reg =3D FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_2S);
> +	} else if (pdata->vbat_max < 14000000) {
> +		/* 3S batteries */
> +		reg =3D FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_3S);
> +	} else {
> +		/* 4S batteries */
> +		reg =3D FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_4S);
> +	}
> +
> +	/* Recharge voltage detection deglitch time (default 1024ms) */
> +	reg |=3D FIELD_PREP(BQ25792_REG0A_TRECHG_MASK, BQ25792_TRECHG_1024MS);
> +
> +	/* Recharge voltage offset: 5% of the set charge voltage */
> +	reg |=3D FIELD_PREP(BQ25792_REG0A_VRECHG_MASK,
> +			  (pdata->vbat_max / 20 - BQ25792_VRECHG_MIN_UV) / BQ25792_VRECHG_STE=
P_UV);
> +
> +	ret =3D regmap_write(regmap, BQ25792_REG0A_RECHARGE_CONTROL, reg);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D bq25792_set_min_vsys(pdata, pdata->vsys_min);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_set_iindpm(pdata, pdata->iindpm_max);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the Input Current Optimizer (the rest is at POR value) */
> +	ret =3D regmap_write(regmap, BQ25792_REG0F_CHARGER_CONTROL_0,
> +			   BQ25792_REG0F_EN_AUTO_IBATDIS |
> +			   BQ25792_REG0F_EN_CHG |
> +			   BQ25792_REG0F_EN_ICO |
> +			   BQ25792_REG0F_EN_TERM);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the ADC. */
> +	ret =3D regmap_write(regmap, BQ25792_REG2E_ADC_CONTROL, BQ25792_REG2E_A=
DC_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear per-channel ADC disable bits - enable all channels */
> +	ret =3D regmap_write(regmap, BQ25792_REG2F_ADC_FUNCTION_DISABLE_0, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(regmap, BQ25792_REG30_ADC_FUNCTION_DISABLE_1, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
>  /**
>   * bq25703_hw_shutdown() - Set registers for shutdown
>   * @pdata: driver platform data
> @@ -446,6 +869,30 @@ static void bq25703_hw_shutdown(struct bq257xx_chg *=
pdata)
>  			   BQ25703_EN_LWPWR, BQ25703_EN_LWPWR);
>  }
> =20
> +/**
> + * bq25792_hw_shutdown() - Shutdown BQ25792 hardware
> + * @pdata: driver platform data
> + *
> + * Perform hardware shutdown for the BQ25792. Currently a no-op
> + * as the device does not require special shutdown configuration.
> + */
> +static void bq25792_hw_shutdown(struct bq257xx_chg *pdata)
> +{
> +	/* Nothing to do here */
> +}
> +
> +/**
> + * bq257xx_set_charger_property() - Set a power supply property
> + * @psy: power supply device
> + * @prop: power supply property to set
> + * @val: value to set for the property
> + *
> + * Handle requests to set power supply properties such as input current
> + * limit, constant charge voltage, and constant charge current. Routes
> + * the request to the chip-specific implementation.
> + *
> + * Return: Returns 0 on success or -EINVAL if property is not supported.
> + */
>  static int bq257xx_set_charger_property(struct power_supply *psy,
>  		enum power_supply_property prop,
>  		const union power_supply_propval *val)
> @@ -469,6 +916,19 @@ static int bq257xx_set_charger_property(struct power=
_supply *psy,
>  	return -EINVAL;
>  }
> =20
> +/**
> + * bq257xx_get_charger_property() - Get a power supply property
> + * @psy: power supply device
> + * @psp: power supply property to get
> + * @val: pointer to store the property value
> + *
> + * Handle requests to get power supply properties, including status,
> + * health, manufacturer, online state, and various voltage/current
> + * measurements. Reads current device state and routes chip-specific
> + * property requests to appropriate handlers.
> + *
> + * Return: Returns 0 on success or -EINVAL if property is not supported.
> + */
>  static int bq257xx_get_charger_property(struct power_supply *psy,
>  				enum power_supply_property psp,
>  				union power_supply_propval *val)
> @@ -550,6 +1010,17 @@ static enum power_supply_property bq257xx_power_sup=
ply_props[] =3D {
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  };
> =20
> +/**
> + * bq257xx_property_is_writeable() - Check if a property is writeable
> + * @psy: power supply device
> + * @prop: power supply property to check
> + *
> + * Determines which power supply properties can be written to. Only
> + * charge current limit, charge voltage limit, and input current
> + * limit are writeable.
> + *
> + * Return: Returns 1 if property is writeable, 0 otherwise.
> + */
>  static int bq257xx_property_is_writeable(struct power_supply *psy,
>  					 enum power_supply_property prop)
>  {
> @@ -622,6 +1093,17 @@ static void bq257xx_external_power_changed(struct p=
ower_supply *psy)
>  	power_supply_changed(psy);
>  }
> =20
> +/**
> + * bq257xx_irq_handler_thread() - Handle charger interrupt
> + * @irq: interrupt number
> + * @private: pointer to driver private data
> + *
> + * Thread handler for charger interrupts. Triggers re-evaluation of
> + * external power status and updates power supply state in response
> + * to charger events.
> + *
> + * Return: Returns IRQ_HANDLED if interrupt was processed.
> + */
>  static irqreturn_t bq257xx_irq_handler_thread(int irq, void *private)
>  {
>  	struct bq257xx_chg *pdata =3D private;
> @@ -662,6 +1144,22 @@ static const struct bq257xx_chip_info bq25703_chip_=
info =3D {
>  		.bq257xx_get_min_vsys =3D &bq25703_get_min_vsys,
>  };
> =20
> +static const struct bq257xx_chip_info bq25792_chip_info =3D {
> +		.default_iindpm_uA =3D BQ25792_IINDPM_DEFAULT_UA,
> +		.bq257xx_hw_init =3D &bq25792_hw_init,
> +		.bq257xx_hw_shutdown =3D &bq25792_hw_shutdown,
> +		.bq257xx_get_state =3D &bq25792_get_state,
> +		.bq257xx_get_ichg =3D &bq25792_get_ichg_cur,
> +		.bq257xx_set_ichg =3D &bq25792_set_ichg_cur,
> +		.bq257xx_get_vbatreg =3D &bq25792_get_chrg_volt,
> +		.bq257xx_set_vbatreg =3D &bq25792_set_chrg_volt,
> +		.bq257xx_get_iindpm =3D &bq25792_get_iindpm,
> +		.bq257xx_set_iindpm =3D &bq25792_set_iindpm,
> +		.bq257xx_get_cur =3D &bq25792_get_cur,
> +		.bq257xx_get_vbat =3D &bq25792_get_vbat,
> +		.bq257xx_get_min_vsys =3D &bq25792_get_min_vsys,
> +};
> +
>  /**
>   * bq257xx_parse_dt() - Parse the device tree for required properties
>   * @pdata: driver platform data
> @@ -707,6 +1205,17 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pda=
ta,
>  	return 0;
>  }
> =20
> +/**
> + * bq257xx_charger_probe() - Probe routine for charger platform device
> + * @pdev: platform device
> + *
> + * Probe the charger device, allocate driver data structure, select the
> + * appropriate chip-specific function pointers, register the power suppl=
y,
> + * parse device tree properties for battery limits, initialize hardware,
> + * and set up the interrupt handler if available.
> + *
> + * Return: Returns 0 on success or error code on failure.
> + */
>  static int bq257xx_charger_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -722,7 +1231,17 @@ static int bq257xx_charger_probe(struct platform_de=
vice *pdev)
>  		return -ENOMEM;
> =20
>  	pdata->bq =3D bq;
> -	pdata->chip =3D &bq25703_chip_info;
> +
> +	switch (bq->type) {
> +	case BQ25703A:
> +		pdata->chip =3D &bq25703_chip_info;
> +		break;
> +	case BQ25792:
> +		pdata->chip =3D &bq25792_chip_info;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unknown chip type\n");
> +	}
> =20
>  	platform_set_drvdata(pdev, pdata);
> =20
> @@ -760,6 +1279,13 @@ static int bq257xx_charger_probe(struct platform_de=
vice *pdev)
>  	return ret;
>  }
> =20
> +/**
> + * bq257xx_charger_shutdown() - Shutdown routine for charger platform de=
vice
> + * @pdev: platform device
> + *
> + * Called during system shutdown to perform charger cleanup, including
> + * disabling watchdog timers or other chip-specific shutdown procedures.
> + */
>  static void bq257xx_charger_shutdown(struct platform_device *pdev)
>  {
>  	struct bq257xx_chg *pdata =3D platform_get_drvdata(pdev);
> diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
> index 4ec72eb920f2..379ef4ee8291 100644
> --- a/include/linux/mfd/bq257xx.h
> +++ b/include/linux/mfd/bq257xx.h
> @@ -200,6 +200,20 @@
>  #define BQ25792_REG0A_TRECHG_MASK		GENMASK(5, 4)
>  #define BQ25792_REG0A_VRECHG_MASK		GENMASK(3, 0)
> =20
> +#define BQ25792_CELL_1S				0
> +#define BQ25792_CELL_2S				1
> +#define BQ25792_CELL_3S				2
> +#define BQ25792_CELL_4S				3
> +
> +#define BQ25792_TRECHG_64MS			0
> +#define BQ25792_TRECHG_256MS			1
> +#define BQ25792_TRECHG_1024MS			2
> +#define BQ25792_TRECHG_2048MS			3
> +
> +#define BQ25792_VRECHG_MIN_UV			50000
> +#define BQ25792_VRECHG_STEP_UV			50000
> +#define BQ25792_VRECHG_MAX_UV			800000
> +
>  /* VOTG regulation */
>  #define BQ25792_REG0B_VOTG_MASK			GENMASK(10, 0)
> =20
>=20
> --=20
> 2.53.0
>=20

--el3q7esuljbgqf7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmogk0kACgkQ2O7X88g7
+pqTRg/9GkpmBCwtwdHd2xVMJYDk1AXPgFN8p3bzmWmnUJp8JpUg+1E5djMtF5hj
7Ay5ZKx6zCyUW+sSdlEeIjF1xh+JZZSDQRVSwlz04lMUtTQvXGGrHIFo9bM+cHLN
v/5XOrJy5lipsoDTPeSYICvV8OMGsz0TNR/e/C+7pPddWNWuhlZ637aAKhf7ZjN+
AbzyZ+aJ2t/Hje8GOMDSxJ8LZvoeR211NvQS9WiiPGuHSaknG2MmKe8mGhDiMdXF
qFs8YvHXchUgA4LK7tN78zBDu7FIevomeBAG4jLg+nYYI+RT5FEzA4HKDqjdz5gK
GSUmLEaz8Lge9ZVf+6cRSmbzz74/9X759HweiIdV6m12s9mT2VZz5N1luhTkpk1Z
lKELbUapKjKeyssDqzu88R0giL49UYugwnMVm0rbzRLu3wOYGYMy0UC/kvmiLe+8
Ss6CilmDi1zzOhIHGwtusfPQGDgYddFrop6zb+cIprhovdXOTkHkEtZ8+dpTyp0E
KuaT8pATYzT6ngXTKq9pDvvuzwy77PfXUxsDVYcqWDkXKs+p1XgDJboEVAsFe3wG
rr/GShKvYJJehQ0eRYNBsknABWDEdtrpplP2872HUHwiA/8RWt/ECosakfnPi9IZ
lWB+eCKLAxLxHEvN4lcBV/cECDnWw8h8bixBKs52DnEebWZipnM=
=NeQx
-----END PGP SIGNATURE-----

--el3q7esuljbgqf7j--
