Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88941E505;
	Thu,  4 Jun 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591094; cv=pass; b=WA+oV6auHsrPMfR8YBwQTbI8GygevpL3n5NkPWNlaBAyO26pkMyzt88jytqwC5fn6iski05vilGrWbFO1noL7LBkVqvjnKmytaSFAQMNRbsTUUVbeYQCU1LRx2HqtLDTfR0Du/hLtjaDGD3FCrML/3FKoS1GsoDpOXZJYrNkhmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591094; c=relaxed/simple;
	bh=NceHpWB65zx9yFXbiR516qNKAGaGXhM0VShBl0PiIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDCrjvza82jsI5QvK0VKVkmBSbolIXIJUSGLzvbEjASedk5PTd8ZwhzBS1cbFdv1foLPh72OUOWBOXe6SBRQ8bvvbcmfJvNJn89HT/HpkY+/JdU6KpAu4lle6S2k/Xyf/vzrQicBJ4Fc5R52O7RtUIlqRN+pymOzruNcO0v9dSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JaenmBvc; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JaenmBvc"
ARC-Seal: i=1; a=rsa-sha256; t=1780591072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eLiyCqKPzRKw/mmWady/IaV5KN4lyxmFjZJ7AFF1o2t+EGqbbgNC+Z05XRMg8AZXtRzC3n2IeuLsfNSyDxAKK9NGxRYi7ao8HhNYTBH1DsfZSY4sNW+X7/q+sAOCTxvw7DXX2nl628hX8xNUYxezeZfp3gZ4ZDZ6vtPtpeYy42g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780591072; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PP4PfdKH+CWr7MvA1wQT/TW2fFUGsiKlTpB8A8L36Aw=; 
	b=WAmgfknrffWZH8+4nsprzc23nEcbhTYbOU/nh2tHQ/g69Ys8kQWx0Jo1tfUpMfTaBynmeDNU7yzQVHoGhf8L+oiLuzGI9KRAxBtVbpdIQt3yDGD1R84wR6AMZ8aDKmoclX19KBDKjD/bLIeMFEEkpTpKpce6ry3nvB+9TF1FNWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780591072;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PP4PfdKH+CWr7MvA1wQT/TW2fFUGsiKlTpB8A8L36Aw=;
	b=JaenmBvcrzDwjRSMDjcQ52OiODLeNryIFhLe46Sk37myINNAqug2929lBUHcY7iL
	jPhU3MxD5G3EqG1FLbqLlQ0+VoZRyjrRGqr/CEab19wrLZG0y3GjpubavQfEh5Wb3Zl
	7IAftpDNzojQl0jObvOQwcgJdysH77/Jl7HnapUs=
Received: by mx.zohomail.com with SMTPS id 1780591069870817.1427215597619;
	Thu, 4 Jun 2026 09:37:49 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 6E8F8181D80; Thu, 04 Jun 2026 18:37:46 +0200 (CEST)
Date: Thu, 4 Jun 2026 18:37:46 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v1 8/9] power: supply: Read MAX17042 battery info before
 registration
Message-ID: <aiGkI-JDc-6H5e07@venus>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
 <20260406205759.493288-9-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyglwe247re7hdfg"
Content-Disposition: inline
In-Reply-To: <20260406205759.493288-9-vincent.cloutier@icloud.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.581.16
X-ZohoMailClient: External


--yyglwe247re7hdfg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 8/9] power: supply: Read MAX17042 battery info before
 registration
MIME-Version: 1.0

Hi,

On Mon, Apr 06, 2026 at 04:57:56PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
>=20
> Rework the MAX17042 `monitored-battery` path so the driver can consume DT
> battery information before registering its power-supply device.
>=20
> To do that, factor the parser in `power_supply_core` behind a new
> `devm_power_supply_get_battery_info()` helper and let battery drivers
> pass the pre-parsed `battery_info` through `struct power_supply_config`.
> MAX17042 can then apply the design-capacity and termination-current data
> before registration without exposing the battery too early or reparsing
> the same node later in the class core.
>=20
> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
> ---

This is multiple patches. One to change the power-supply core and
one to change the driver. Apart from that I would prefer a slightly
different solution:

Create a new init callback, which is called from the power-supply
registration method (__power_supply_register) before device_add() is
being called. At this point it's okay to call
power_supply_get_battery_info() and for POWER_SUPPLY_TYPE_BATTERY
devices psy->battery_info is already initialized.

Greetings,

-- Sebastian

>  drivers/power/supply/max17042_battery.c  |  62 ++++++++
>  drivers/power/supply/power_supply_core.c | 188 ++++++++++++++---------
>  include/linux/power/max17042_battery.h   |   1 +
>  include/linux/power_supply.h             |  10 ++
>  4 files changed, 187 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 793164bd55d9..5bf15c19fc5d 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1025,6 +1025,57 @@ static int max17042_init_defaults(struct max17042_=
chip *chip)
>  	return 0;
>  }
> =20
> +static int max17042_apply_battery_properties(struct max17042_chip *chip,
> +					     struct power_supply_battery_info *info)
> +{
> +	struct device *dev =3D chip->dev;
> +	bool needs_config;
> +	u64 data64;
> +
> +	if (!info)
> +		return 0;
> +
> +	needs_config =3D (chip->enable_current_sense &&
> +			(info->charge_full_design_uah !=3D -EINVAL ||
> +			 info->charge_term_current_ua !=3D -EINVAL)) ||
> +		       (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055 &&
> +			info->voltage_max_design_uv > 4250000);
> +	if (!needs_config)
> +		return 0;
> +
> +	if (!chip->config_data) {
> +		chip->config_data =3D devm_kzalloc(dev,
> +						 sizeof(*chip->config_data),
> +						 GFP_KERNEL);
> +		if (!chip->config_data)
> +			return -ENOMEM;
> +	}
> +
> +	if (chip->enable_current_sense &&
> +	    info->charge_full_design_uah !=3D -EINVAL) {
> +		data64 =3D (u64)info->charge_full_design_uah * chip->r_sns;
> +		do_div(data64, MAX17042_CAPACITY_LSB);
> +		chip->config_data->design_cap =3D (u16)data64;
> +		chip->enable_por_init =3D true;
> +	}
> +
> +	if (chip->enable_current_sense &&
> +	    info->charge_term_current_ua !=3D -EINVAL) {
> +		data64 =3D (u64)info->charge_term_current_ua * chip->r_sns;
> +		do_div(data64, MAX17042_CURRENT_LSB);
> +		chip->config_data->ichgt_term =3D (u16)data64;
> +		chip->enable_por_init =3D true;
> +	}
> +
> +	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055 &&
> +	    info->voltage_max_design_uv > 4250000) {
> +		chip->config_data->model_cfg =3D MAX17055_MODELCFG_VCHG_BIT;
> +		chip->enable_por_init =3D true;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct regmap_config max17042_regmap_config =3D {
>  	.name =3D "max17042",
>  	.reg_bits =3D 8,
> @@ -1060,6 +1111,7 @@ static int max17042_probe(struct i2c_client *client=
, struct device *dev, int irq
>  	const struct power_supply_desc *max17042_desc =3D &max17042_psy_desc;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct max17042_chip *chip;
> +	struct power_supply_battery_info *battery_info =3D NULL;
>  	int ret;
>  	u32 val;
>  	bool use_default_config =3D false;
> @@ -1106,12 +1158,22 @@ static int max17042_probe(struct i2c_client *clie=
nt, struct device *dev, int irq
>  	if (chip->r_sns =3D=3D 0)
>  		chip->r_sns =3D MAX17042_DEFAULT_SNS_RESISTOR;
> =20
> +	ret =3D devm_power_supply_get_battery_info(dev, &battery_info);
> +	if (ret && ret !=3D -ENODEV && ret !=3D -ENOENT)
> +		return ret;
> +
> +	ret =3D max17042_apply_battery_properties(chip, battery_info);
> +	if (ret)
> +		return ret;
> +
>  	if (!chip->enable_current_sense) {
>  		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
>  		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
>  		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
>  	}
> =20
> +	psy_cfg.battery_info =3D battery_info;
> +
>  	chip->battery =3D devm_power_supply_register(dev, max17042_desc,
>  						   &psy_cfg);
>  	if (IS_ERR(chip->battery))
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index a446d3d086fc..7ca3ed34095e 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -577,20 +577,76 @@ struct power_supply *devm_power_supply_get_by_refer=
ence(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
> =20
> -int power_supply_get_battery_info(struct power_supply *psy,
> -				  struct power_supply_battery_info **info_out)
> +static void __power_supply_put_battery_info(struct device *dev,
> +					    struct power_supply_battery_info *info)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> +		if (info->ocv_table[i])
> +			devm_kfree(dev, info->ocv_table[i]);
> +	}
> +
> +	if (info->resist_table)
> +		devm_kfree(dev, info->resist_table);
> +
> +	devm_kfree(dev, info);
> +}
> +
> +static void power_supply_init_battery_info(struct power_supply_battery_i=
nfo *info)
> +{
> +	int index;
> +
> +	info->technology =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> +	info->energy_full_design_uwh =3D -EINVAL;
> +	info->charge_full_design_uah =3D -EINVAL;
> +	info->voltage_min_design_uv =3D -EINVAL;
> +	info->voltage_max_design_uv =3D -EINVAL;
> +	info->precharge_current_ua =3D -EINVAL;
> +	info->charge_term_current_ua =3D -EINVAL;
> +	info->constant_charge_current_max_ua =3D -EINVAL;
> +	info->constant_charge_voltage_max_uv =3D -EINVAL;
> +	info->tricklecharge_current_ua =3D -EINVAL;
> +	info->precharge_voltage_max_uv =3D -EINVAL;
> +	info->charge_restart_voltage_uv =3D -EINVAL;
> +	info->overvoltage_limit_uv =3D -EINVAL;
> +	info->maintenance_charge =3D NULL;
> +	info->alert_low_temp_charge_current_ua =3D -EINVAL;
> +	info->alert_low_temp_charge_voltage_uv =3D -EINVAL;
> +	info->alert_high_temp_charge_current_ua =3D -EINVAL;
> +	info->alert_high_temp_charge_voltage_uv =3D -EINVAL;
> +	info->temp_ambient_alert_min =3D INT_MIN;
> +	info->temp_ambient_alert_max =3D INT_MAX;
> +	info->temp_alert_min =3D INT_MIN;
> +	info->temp_alert_max =3D INT_MAX;
> +	info->temp_min =3D INT_MIN;
> +	info->temp_max =3D INT_MAX;
> +	info->factory_internal_resistance_uohm =3D -EINVAL;
> +	info->resist_table =3D NULL;
> +	info->bti_resistance_ohm =3D -EINVAL;
> +	info->bti_resistance_tolerance =3D -EINVAL;
> +
> +	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
> +		info->ocv_table[index] =3D NULL;
> +		info->ocv_temp[index] =3D -EINVAL;
> +		info->ocv_table_size[index] =3D -EINVAL;
> +	}
> +}
> +
> +static int __power_supply_get_battery_info(struct device *dev,
> +					   struct fwnode_handle *srcnode,
> +					   struct power_supply_battery_info **info_out)
>  {
>  	struct power_supply_resistance_temp_table *resist_table;
>  	struct power_supply_battery_info *info;
> -	struct fwnode_handle *srcnode, *fwnode;
> +	struct fwnode_handle *fwnode;
>  	const char *value;
>  	int err, len, index, proplen;
>  	u32 *propdata __free(kfree) =3D NULL;
>  	u32 min_max[2];
> =20
> -	srcnode =3D dev_fwnode(&psy->dev);
> -	if (!srcnode && psy->dev.parent)
> -		srcnode =3D dev_fwnode(psy->dev.parent);
> +	if (!srcnode)
> +		return -ENODEV;
> =20
>  	fwnode =3D fwnode_find_reference(srcnode, "monitored-battery", 0);
>  	if (IS_ERR(fwnode))
> @@ -602,7 +658,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
> =20
> =20
>  	/* Try static batteries first */
> -	err =3D samsung_sdi_battery_get_info(&psy->dev, value, &info);
> +	err =3D samsung_sdi_battery_get_info(dev, value, &info);
>  	if (!err)
>  		goto out_ret_pointer;
>  	else if (err =3D=3D -ENODEV)
> @@ -617,46 +673,13 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  		goto out_put_node;
>  	}
> =20
> -	info =3D devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		err =3D -ENOMEM;
>  		goto out_put_node;
>  	}
> =20
> -	info->technology                     =3D POWER_SUPPLY_TECHNOLOGY_UNKNOW=
N;
> -	info->energy_full_design_uwh         =3D -EINVAL;
> -	info->charge_full_design_uah         =3D -EINVAL;
> -	info->voltage_min_design_uv          =3D -EINVAL;
> -	info->voltage_max_design_uv          =3D -EINVAL;
> -	info->precharge_current_ua           =3D -EINVAL;
> -	info->charge_term_current_ua         =3D -EINVAL;
> -	info->constant_charge_current_max_ua =3D -EINVAL;
> -	info->constant_charge_voltage_max_uv =3D -EINVAL;
> -	info->tricklecharge_current_ua       =3D -EINVAL;
> -	info->precharge_voltage_max_uv       =3D -EINVAL;
> -	info->charge_restart_voltage_uv      =3D -EINVAL;
> -	info->overvoltage_limit_uv           =3D -EINVAL;
> -	info->maintenance_charge             =3D NULL;
> -	info->alert_low_temp_charge_current_ua =3D -EINVAL;
> -	info->alert_low_temp_charge_voltage_uv =3D -EINVAL;
> -	info->alert_high_temp_charge_current_ua =3D -EINVAL;
> -	info->alert_high_temp_charge_voltage_uv =3D -EINVAL;
> -	info->temp_ambient_alert_min         =3D INT_MIN;
> -	info->temp_ambient_alert_max         =3D INT_MAX;
> -	info->temp_alert_min                 =3D INT_MIN;
> -	info->temp_alert_max                 =3D INT_MAX;
> -	info->temp_min                       =3D INT_MIN;
> -	info->temp_max                       =3D INT_MAX;
> -	info->factory_internal_resistance_uohm  =3D -EINVAL;
> -	info->resist_table                   =3D NULL;
> -	info->bti_resistance_ohm             =3D -EINVAL;
> -	info->bti_resistance_tolerance       =3D -EINVAL;
> -
> -	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
> -		info->ocv_table[index]       =3D NULL;
> -		info->ocv_temp[index]        =3D -EINVAL;
> -		info->ocv_table_size[index]  =3D -EINVAL;
> -	}
> +	power_supply_init_battery_info(info);
> =20
>  	/* The property and field names below must correspond to elements
>  	 * in enum power_supply_property. For reasoning, see
> @@ -678,7 +701,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		else if (!strcmp("lithium-ion-manganese-oxide", value))
>  			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
>  		else
> -			dev_warn(&psy->dev, "%s unknown battery type\n", value);
> +			dev_warn(dev, "%s unknown battery type\n", value);
>  	}
> =20
>  	fwnode_property_read_u32(fwnode, "energy-full-design-microwatt-hours",
> @@ -729,7 +752,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		err =3D len;
>  		goto out_put_node;
>  	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
> -		dev_err(&psy->dev, "Too many temperature values\n");
> +		dev_err(dev, "Too many temperature values\n");
>  		err =3D -EINVAL;
>  		goto out_put_node;
>  	} else if (len > 0) {
> @@ -744,28 +767,28 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  		char *propname __free(kfree) =3D kasprintf(GFP_KERNEL, "ocv-capacity-t=
able-%d",
>  							 index);
>  		if (!propname) {
> -			power_supply_put_battery_info(psy, info);
> +			__power_supply_put_battery_info(dev, info);
>  			err =3D -ENOMEM;
>  			goto out_put_node;
>  		}
>  		proplen =3D fwnode_property_count_u32(fwnode, propname);
>  		if (proplen < 0 || proplen % 2 !=3D 0) {
> -			dev_err(&psy->dev, "failed to get %s\n", propname);
> -			power_supply_put_battery_info(psy, info);
> +			dev_err(dev, "failed to get %s\n", propname);
> +			__power_supply_put_battery_info(dev, info);
>  			err =3D -EINVAL;
>  			goto out_put_node;
>  		}
> =20
>  		u32 *propdata __free(kfree) =3D kcalloc(proplen, sizeof(*propdata), GF=
P_KERNEL);
>  		if (!propdata) {
> -			power_supply_put_battery_info(psy, info);
> +			__power_supply_put_battery_info(dev, info);
>  			err =3D -EINVAL;
>  			goto out_put_node;
>  		}
>  		err =3D fwnode_property_read_u32_array(fwnode, propname, propdata, pro=
plen);
>  		if (err < 0) {
> -			dev_err(&psy->dev, "failed to get %s\n", propname);
> -			power_supply_put_battery_info(psy, info);
> +			dev_err(dev, "failed to get %s\n", propname);
> +			__power_supply_put_battery_info(dev, info);
>  			goto out_put_node;
>  		}
> =20
> @@ -773,9 +796,9 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		info->ocv_table_size[index] =3D tab_len;
> =20
>  		info->ocv_table[index] =3D table =3D
> -			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
> +			devm_kcalloc(dev, tab_len, sizeof(*table), GFP_KERNEL);
>  		if (!info->ocv_table[index]) {
> -			power_supply_put_battery_info(psy, info);
> +			__power_supply_put_battery_info(dev, info);
>  			err =3D -ENOMEM;
>  			goto out_put_node;
>  		}
> @@ -791,14 +814,14 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  		err =3D 0;
>  		goto out_ret_pointer;
>  	} else if (proplen < 0 || proplen % 2 !=3D 0) {
> -		power_supply_put_battery_info(psy, info);
> +		__power_supply_put_battery_info(dev, info);
>  		err =3D (proplen < 0) ? proplen : -EINVAL;
>  		goto out_put_node;
>  	}
> =20
>  	propdata =3D kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
>  	if (!propdata) {
> -		power_supply_put_battery_info(psy, info);
> +		__power_supply_put_battery_info(dev, info);
>  		err =3D -ENOMEM;
>  		goto out_put_node;
>  	}
> @@ -806,17 +829,17 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	err =3D fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
>  					     propdata, proplen);
>  	if (err < 0) {
> -		power_supply_put_battery_info(psy, info);
> +		__power_supply_put_battery_info(dev, info);
>  		goto out_put_node;
>  	}
> =20
>  	info->resist_table_size =3D proplen / 2;
> -	info->resist_table =3D resist_table =3D devm_kcalloc(&psy->dev,
> -							 info->resist_table_size,
> -							 sizeof(*resist_table),
> -							 GFP_KERNEL);
> +	info->resist_table =3D resist_table =3D devm_kcalloc(dev,
> +						 info->resist_table_size,
> +						 sizeof(*resist_table),
> +						 GFP_KERNEL);
>  	if (!info->resist_table) {
> -		power_supply_put_battery_info(psy, info);
> +		__power_supply_put_battery_info(dev, info);
>  		err =3D -ENOMEM;
>  		goto out_put_node;
>  	}
> @@ -834,22 +857,35 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	fwnode_handle_put(fwnode);
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> =20
> -void power_supply_put_battery_info(struct power_supply *psy,
> -				   struct power_supply_battery_info *info)
> +int devm_power_supply_get_battery_info(struct device *dev,
> +					      struct power_supply_battery_info **info_out)
>  {
> -	int i;
> +	struct fwnode_handle *srcnode =3D dev_fwnode(dev);
> =20
> -	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> -		if (info->ocv_table[i])
> -			devm_kfree(&psy->dev, info->ocv_table[i]);
> -	}
> +	if (!srcnode && dev->parent)
> +		srcnode =3D dev_fwnode(dev->parent);
> =20
> -	if (info->resist_table)
> -		devm_kfree(&psy->dev, info->resist_table);
> +	return __power_supply_get_battery_info(dev, srcnode, info_out);
> +}
> +EXPORT_SYMBOL_GPL(devm_power_supply_get_battery_info);
> +
> +int power_supply_get_battery_info(struct power_supply *psy,
> +				  struct power_supply_battery_info **info_out)
> +{
> +	struct fwnode_handle *srcnode =3D dev_fwnode(&psy->dev);
> +
> +	if (!srcnode && psy->dev.parent)
> +		srcnode =3D dev_fwnode(psy->dev.parent);
> =20
> -	devm_kfree(&psy->dev, info);
> +	return __power_supply_get_battery_info(&psy->dev, srcnode, info_out);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> +
> +void power_supply_put_battery_info(struct power_supply *psy,
> +				   struct power_supply_battery_info *info)
> +{
> +	__power_supply_put_battery_info(&psy->dev, info);
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> =20
> @@ -1620,9 +1656,13 @@ __power_supply_register(struct device *parent,
>  	 * expose battery data to userspace for battery devices.
>  	 */
>  	if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
> -		rc =3D power_supply_get_battery_info(psy, &psy->battery_info);
> -		if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
> -			goto check_supplies_failed;
> +		if (cfg && cfg->battery_info) {
> +			psy->battery_info =3D cfg->battery_info;
> +		} else {
> +			rc =3D power_supply_get_battery_info(psy, &psy->battery_info);
> +			if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
> +				goto check_supplies_failed;
> +		}
>  	}
> =20
>  	spin_lock_init(&psy->changed_lock);
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power=
/max17042_battery.h
> index 6b6e01d3e499..e9f2118e57c8 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -24,6 +24,7 @@
>  #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
> =20
>  #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
> +#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
> =20
>  enum max17042_register {
>  	MAX17042_STATUS		=3D 0x00,
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 360ffdf272da..f9fca7bb6e24 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -231,6 +231,7 @@ union power_supply_propval {
> =20
>  struct device_node;
>  struct power_supply;
> +struct power_supply_battery_info;
> =20
>  /* Run-time specific power supply configuration */
>  struct power_supply_config {
> @@ -239,6 +240,12 @@ struct power_supply_config {
>  	/* Driver private data */
>  	void *drv_data;
> =20
> +	/*
> +	 * Optional pre-parsed battery info for battery supplies.
> +	 * The pointed-to data must remain valid for the power supply lifetime.
> +	 */
> +	struct power_supply_battery_info *battery_info;
> +
>  	/* Device specific sysfs attributes */
>  	const struct attribute_group **attr_grp;
> =20
> @@ -814,6 +821,9 @@ extern struct power_supply *power_supply_get_by_refer=
ence(struct fwnode_handle *
>  extern struct power_supply *devm_power_supply_get_by_reference(
>  				    struct device *dev, const char *property);
> =20
> +extern int devm_power_supply_get_battery_info(struct device *dev,
> +					      struct power_supply_battery_info **info_out);
> +
>  extern const enum power_supply_property power_supply_battery_info_proper=
ties[];
>  extern const size_t power_supply_battery_info_properties_size;
>  extern int power_supply_get_battery_info(struct power_supply *psy,
> --=20
> 2.53.0
>=20
>=20

--yyglwe247re7hdfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmohqdEACgkQ2O7X88g7
+prmRg/8CEYZ6AtIlJ6/7IutgNbNWKgzjNDFSplk5W5kimKHh74cLNado5PqYkVE
BZDfOmefmpxxmbYOc0f5CGsUDUWtGgSAIvbPjaYOWiJADzaDMe9Jowluq6899WVV
gJw6hSWlW0t3b0RYhCgbeueEQWL/JqnydnijQSaLMvqx/bSxeYaogbgvE8icT9Vv
cTVpz9MbYirgvbG0Og9zEbK9hXIMzsmlOVeNF+XwZm0Fp46jPMv5NvcESQ9+Tamg
cerNFhwh7k+qW2GZzKmTv8sj7KejrYG0c+rCKb5hKifLz4CPkO24uad84U+HZsGx
KdCGCJaTSWsDyhJNl9xg95vpLK62IcrISA9enjjQ4c5F8RunF3VM4yxFzyv9LvBy
CpJItosbo7Vrv/l/2CmCiypzFFuXMZOPXRT/P2iWS0AB72M6SIQ+/WAGWWfUQF58
lCOSgxCpigz9Dr0l+il+QAQ6mbxwL1laMTEo+qD3QcfBUdj299o8GAuzufpfkdWw
01qgzUcNz1rXtc2aKsSGJu4+FnsD2j3OSVd5cGc8IdKSAn2oiOQawurLlKjlHIAs
u7oyvtXvefrZummaGHrnXMF/55cyTL7vXj++MOb92VoLQ3q+O7BrSuM9LXEHG/eY
v8v/8G/KDOiM9HVMXRsqVTvHV7BLprq6iAU207i7iLK8nti7mnw=
=iFGw
-----END PGP SIGNATURE-----

--yyglwe247re7hdfg--
