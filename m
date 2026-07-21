Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69193443AA0;
	Tue, 21 Jul 2026 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672626; cv=none; b=LHn4uBvkF9rQOBqrw5/r5MWoJaN4v7v2JWvzD0fiIVgAHOT5iqGuIvN0g3LXLU0W/76uLNd0jT6EenWQ2IfrDRHDXHVSJuthLi6kPcf7Z1e1q68JGmDrYOjnN21xvI90TNcBls0qccc73CDz6Umy0isHfchoHaXukY0lkf+vd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672626; c=relaxed/simple;
	bh=aXG9nAAAfUlPSzfrPl35X/bhXXdEbu+xRIp6Ii7P/qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDpq6UiDddVp41CwMWah+EWfE9I5zpZYuxMlFpTNE8OIOtT/rB4esl5WIIljD3SSU7aikSJJt4M/CS0T3rmODwOjQ9pD1uWKWKiPyrygnCs5toQHmK97D1R/Gt2khq+0LwSaagI24G8+817JC+OnOVAS2Og+RTVi2i4PQOESI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEd5UH7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEd5UH7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCFA1F00A3A;
	Tue, 21 Jul 2026 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672624;
	bh=yAD4QHVbUUp12Y7UuDM4XN9kCLrWF3SSqkkSI/rpVM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEd5UH7K/5gAgmfTwb5cNEVViIdW0Gw1g/y9nfsyRfaD/WtYAQCum3gPy74ZcmOiq
	 OBcXd+MJtyrY32/eIAc5eafuS1pTIrszPCd6qAEfgXS3Uh0QFemCJOsWpeCfztr8t7
	 Xfq+74lms+rvZAoUveW6I2YThO06157HCkFVJkZdPrlB0dYywOKK4rNaPIDKGgwXJP
	 MHxnTvBanDb9ueawgCm6UIZ406YmOR49B4h0wbVnuaaQKXiV4eZ3fyUxIrft12B2Cw
	 h/TKkcbHPeE+/bNTG+dBcx5u1ctr2EfvCwpAoVQBUVRs3N3FT912krdH8TZRxqUSKy
	 A9OD7WEkxxH7A==
Received: by venus (Postfix, from userid 1000)
	id 31997180765; Wed, 22 Jul 2026 00:23:42 +0200 (CEST)
Date: Wed, 22 Jul 2026 00:23:41 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v3 2/4] power: supply: max17042_battery: Initialize
 MAX17055 from battery info
Message-ID: <al_qZdt-_DbSMFta@venus>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
 <20260721185904.40756-3-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l73eowacs2ivgz2q"
Content-Disposition: inline
In-Reply-To: <20260721185904.40756-3-vincent.cloutier@icloud.com>


--l73eowacs2ivgz2q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/4] power: supply: max17042_battery: Initialize
 MAX17055 from battery info
MIME-Version: 1.0

Hello Vincent,

On Tue, Jul 21, 2026 at 02:57:34PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
>=20
> MAX17055 can use charge-full-design-microamp-hours and
> charge-term-current-microamp from monitored-battery for its POR
> configuration. Prepare quantized DesignCap, IChgTerm, and EZ Config dQAcc
> values in the power-supply registration callback after the core has parsed
> battery information.
>=20
> Validate all supplied values before changing the sparse configuration.
> Reject zero, values that quantize to zero, capacities that cannot produce
> dQAcc, and positive termination currents outside the signed register rang=
e.
> Limit this path to MAX17055 because the other supported gauges require
> complete characterization data.
>=20
> Follow the documented POR sequence. Wait for FSTAT.DNR, save HibCfg, exit
> hibernate, write stable battery registers once and verify them after 1 ms,
> issue command writes directly, poll until refresh clears, and restore
> HibCfg. Clear POR only after every step succeeds.
>=20
> Keep driver-backed properties unavailable while initialization is
> incomplete. If an I/O error interrupts the transaction, restore hibernate
> before the next attempt and retry periodically so a transient startup
> failure does not become permanent.
>=20
> Assisted-by: OpenCode:gpt-5.6-sol
> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
> ---

Please split this into smaller patches doing one thing at a time,
which makes it a lot easier to review and also helps to identify
potential bugs with git bisect in the future.

At least the init_complete and the change from 'struct work_struct
work' to 'struct delayed_work work' could be done in advance.

>  drivers/power/supply/max17042_battery.c | 335 +++++++++++++++++++++---
>  include/linux/power/max17042_battery.h  |   2 +
>  2 files changed, 306 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index d409d2f0d383..b25bf26135e0 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -62,18 +62,30 @@
>  #define MAX17042_RESISTANCE_LSB		1 / 4096 /* =CE=A9 */
>  #define MAX17042_TEMPERATURE_LSB	1 / 256 /* =C2=B0C */
> =20
> +#define MAX17055_DQACC_DIV		32
> +#define MAX17055_DPACC_FACTOR		44138
> +#define MAX17055_DPACC_VCHG_FACTOR	51200
> +#define MAX17055_FSTAT_DNR_BIT		BIT(0)
> +#define MAX17055_DNR_POLL_US		10000
> +#define MAX17055_DNR_TIMEOUT_US		2000000
> +#define MAX17055_INIT_RETRY_DELAY_MS	10000
> +#define MAX17055_REFRESH_POLL_US		10000
> +#define MAX17055_REFRESH_TIMEOUT_US	1000000
> +
>  struct max17042_chip {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct power_supply *battery;
>  	enum max170xx_chip_type chip_type;
>  	struct max17042_config_data *config_data;
> -	struct work_struct work;
> -	int    init_complete;
> +	struct delayed_work work;
>  	int    irq;
>  	int    task_period;
>  	bool   enable_current_sense;
>  	bool   enable_por_init;
> +	bool   init_complete;
> +	bool   hib_restore_pending;
> +	u16    hib_cfg;
>  	unsigned int r_sns;
>  	int    vmin;	/* in millivolts */
>  	int    vmax;	/* in millivolts */
> @@ -256,7 +268,7 @@ static int max17042_get_property(struct power_supply =
*psy,
>  	u32 data;
>  	u64 data64;
> =20
> -	if (!chip->init_complete)
> +	if (!READ_ONCE(chip->init_complete))
>  		return -EAGAIN;
> =20
>  	switch (psp) {
> @@ -566,6 +578,24 @@ static int max17042_write_verify_reg(struct regmap *=
map, u8 reg, u32 value)
>  	return ret;
>  }
> =20
> +static int max17055_write_verify_reg(struct regmap *map, u8 reg, u32 val=
ue)
> +{
> +	u32 read_value;
> +	int ret;
> +
> +	ret =3D regmap_write(map, reg, value);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +
> +	ret =3D regmap_read(map, reg, &read_value);
> +	if (ret)
> +		return ret;
> +
> +	return read_value =3D=3D value ? 0 : -EIO;
> +}
> +
>  static inline void max17042_override_por(struct regmap *map,
>  					 u8 reg, u16 value)
>  {
> @@ -801,8 +831,12 @@ static inline void max17042_override_por_values(stru=
ct max17042_chip *chip)
>  	max17042_override_por(map, MAX17042_CONFIG, config->config);
>  	max17042_override_por(map, MAX17042_SHDNTIMER, config->shdntimer);
> =20
> -	max17042_override_por(map, MAX17042_DesignCap, config->design_cap);
> -	max17042_override_por(map, MAX17042_ICHGTerm, config->ichgt_term);
> +	if (chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX17055) {
> +		max17042_override_por(map, MAX17042_DesignCap,
> +				      config->design_cap);
> +		max17042_override_por(map, MAX17042_ICHGTerm,
> +				      config->ichgt_term);
> +	}
> =20
>  	max17042_override_por(map, MAX17042_AtRate, config->at_rate);
>  	max17042_override_por(map, MAX17042_LearnCFG, config->learn_cfg);
> @@ -812,8 +846,10 @@ static inline void max17042_override_por_values(stru=
ct max17042_chip *chip)
> =20
>  	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
>  	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
> -	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
> -	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
> +	if (chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX17055) {
> +		max17042_override_por(map, MAX17042_dQacc, config->dqacc);
> +		max17042_override_por(map, MAX17042_dPacc, config->dpacc);
> +	}
> =20
>  	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
>  	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
> @@ -847,26 +883,162 @@ static inline void max17042_override_por_values(st=
ruct max17042_chip *chip)
>  		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
>  }
> =20
> -static int max17042_init_chip(struct max17042_chip *chip)
> +static int max17055_override_battery_values(struct max17042_chip *chip)
>  {
> +	struct max17042_config_data *config =3D chip->config_data;
>  	struct regmap *map =3D chip->regmap;
> +	unsigned int design_cap;
> +	unsigned int model_cfg;
> +	unsigned int dqacc;
> +	u64 dpacc;
>  	int ret;
> =20
> +	if (config->design_cap) {
> +		ret =3D max17055_write_verify_reg(map, MAX17042_DesignCap,
> +						config->design_cap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (config->dqacc) {
> +		ret =3D max17055_write_verify_reg(map, MAX17042_dQacc,
> +						config->dqacc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (config->ichgt_term) {
> +		ret =3D max17055_write_verify_reg(map, MAX17042_ICHGTerm,
> +						config->ichgt_term);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!config->design_cap && !config->dqacc)
> +		return 0;
> +
> +	ret =3D regmap_read(map, MAX17042_DesignCap, &design_cap);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(map, MAX17042_dQacc, &dqacc);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(map, MAX17055_ModelCfg, &model_cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (!design_cap || !dqacc)
> +		return -ERANGE;
> +
> +	dpacc =3D (u64)dqacc *
> +		(model_cfg & MAX17055_MODELCFG_VCHG_BIT ?
> +		 MAX17055_DPACC_VCHG_FACTOR : MAX17055_DPACC_FACTOR);
> +	do_div(dpacc, design_cap);
> +	if (dpacc > U16_MAX)
> +		return -ERANGE;
> +
> +	return max17055_write_verify_reg(map, MAX17042_dPacc, (u16)dpacc);
> +}
> +
> +static int max17055_restore_hibernate(struct max17042_chip *chip)
> +{
> +	int restore_hib_ret;
> +	int soft_wakeup_ret;
> +
> +	soft_wakeup_ret =3D regmap_write(chip->regmap, MAX17055_SoftWakeup, 0);
> +	restore_hib_ret =3D max17055_write_verify_reg(chip->regmap,
> +						    MAX17055_HibCfg,
> +						    chip->hib_cfg);
> +	if (!soft_wakeup_ret && !restore_hib_ret)
> +		chip->hib_restore_pending =3D false;
> +
> +	return soft_wakeup_ret ?: restore_hib_ret;
> +}
> +
> +static int max17055_init_chip(struct max17042_chip *chip)
> +{
> +	struct regmap *map =3D chip->regmap;
> +	unsigned int hib_cfg;
> +	unsigned int model_cfg;
> +	unsigned int fstat;
> +	int restore_ret;
> +	int ret;
> +
> +	if (chip->hib_restore_pending) {
> +		ret =3D max17055_restore_hibernate(chip);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_read_poll_timeout(map, MAX17042_FSTAT, fstat,
> +				       !(fstat & MAX17055_FSTAT_DNR_BIT),
> +				       MAX17055_DNR_POLL_US,
> +				       MAX17055_DNR_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(map, MAX17055_HibCfg, &hib_cfg);
> +	if (ret)
> +		return ret;
> +
> +	chip->hib_cfg =3D hib_cfg;
> +	chip->hib_restore_pending =3D true;
> +
> +	ret =3D regmap_write(map, MAX17055_SoftWakeup, 0x0090);
> +	if (ret)
> +		goto restore_hibernate;
> +
> +	ret =3D max17055_write_verify_reg(map, MAX17055_HibCfg, 0);
> +	if (ret)
> +		goto restore_hibernate;
> +
> +	ret =3D regmap_write(map, MAX17055_SoftWakeup, 0);
> +	if (ret)
> +		goto restore_hibernate;
> +
>  	max17042_override_por_values(chip);
> =20
> +	ret =3D max17055_override_battery_values(chip);
> +	if (ret)
> +		goto restore_hibernate;
> +
> +	ret =3D regmap_write_bits(map, MAX17055_ModelCfg,
> +				MAX17055_MODELCFG_REFRESH_BIT,
> +				MAX17055_MODELCFG_REFRESH_BIT);
> +	if (ret)
> +		goto restore_hibernate;
> +
> +	ret =3D regmap_read_poll_timeout(map, MAX17055_ModelCfg, model_cfg,
> +				       !(model_cfg &
> +					 MAX17055_MODELCFG_REFRESH_BIT),
> +				       MAX17055_REFRESH_POLL_US,
> +				       MAX17055_REFRESH_TIMEOUT_US);
> +
> +restore_hibernate:
> +	restore_ret =3D max17055_restore_hibernate(chip);
> +	if (restore_ret)
> +		return restore_ret;
> +
> +	return ret;
> +}
> +
> +static int max17042_init_chip(struct max17042_chip *chip)
> +{
> +	struct regmap *map =3D chip->regmap;
> +	int ret;
> +
>  	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) {
> -		regmap_write_bits(map, MAX17055_ModelCfg,
> -				  MAX17055_MODELCFG_REFRESH_BIT,
> -				  MAX17055_MODELCFG_REFRESH_BIT);
> -	}
> +		ret =3D max17055_init_chip(chip);
> +		if (ret)
> +			return ret;
> +	} else {
> +		max17042_override_por_values(chip);
> =20
> -	/* After Power up, the MAX17042 requires 500mS in order
> -	 * to perform signal debouncing and initial SOC reporting
> -	 */
> -	msleep(500);
> +		/* Allow signal debouncing and initial SOC reporting. */
> +		msleep(500);
> =20
> -	if (chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX17055) {
> -		/* Initialize configuration */
>  		max17042_write_config_regs(chip);
> =20
>  		/* write cell characterization data */
> @@ -902,8 +1074,7 @@ static int max17042_init_chip(struct max17042_chip *=
chip)
>  	}
> =20
>  	/* Init complete, Clear the POR bit */
> -	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
> -	return 0;
> +	return regmap_clear_bits(map, MAX17042_STATUS, STATUS_POR_BIT);

another correct, but unrelated change.

>  }
> =20
>  static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 o=
ff)
> @@ -989,18 +1160,28 @@ static irqreturn_t max17042_thread_handler(int id,=
 void *dev)
> =20
>  static void max17042_init_worker(struct work_struct *work)
>  {
> -	struct max17042_chip *chip =3D container_of(work,
> +	struct max17042_chip *chip =3D container_of(to_delayed_work(work),
>  				struct max17042_chip, work);
> -	int ret;
> +	int ret =3D 0;
> =20
>  	/* Initialize registers according to values from config_data */
> -	if (chip->enable_por_init && chip->config_data) {
> +	if (chip->enable_por_init && chip->config_data)
>  		ret =3D max17042_init_chip(chip);
> -		if (ret)
> -			return;
> +
> +	if (ret) {
> +		if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) {
> +			dev_warn_ratelimited(chip->dev,
> +				"initialization failed: %d, retrying\n", ret);
> +			queue_delayed_work(system_freezable_wq, &chip->work,
> +				msecs_to_jiffies(MAX17055_INIT_RETRY_DELAY_MS));
> +		} else {
> +			dev_err(chip->dev, "initialization failed: %d\n", ret);
> +		}
> +		return;
>  	}
> =20
> -	chip->init_complete =3D 1;
> +	WRITE_ONCE(chip->init_complete, true);
> +	power_supply_changed(chip->battery);
>  }
> =20
>  #ifdef CONFIG_OF
> @@ -1060,6 +1241,93 @@ static int max17042_init_defaults(struct max17042_=
chip *chip)
>  	return 0;
>  }
> =20
> +static int max17042_apply_battery_properties(struct max17042_chip *chip,
> +					     struct power_supply_battery_info *info)
> +{
> +	struct max17042_config_data *config;
> +	struct device *dev =3D chip->dev;
> +	bool have_design_cap;
> +	bool have_ichgt_term;
> +	u16 design_cap =3D 0;
> +	u16 ichgt_term =3D 0;
> +	u16 dqacc =3D 0;
> +	u64 data64;
> +
> +	if (!info || chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX17055)
> +		return 0;
> +
> +	have_design_cap =3D chip->enable_current_sense &&
> +		info->charge_full_design_uah >=3D 0;
> +	have_ichgt_term =3D chip->enable_current_sense &&
> +		info->charge_term_current_ua >=3D 0;
> +	if (!have_design_cap && !have_ichgt_term)
> +		return 0;
> +
> +	if (have_design_cap) {
> +		if (!info->charge_full_design_uah)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "battery design capacity must be positive\n");

If it's negative you set have_design_cap=3Dfalse. This would only be
printed for charge_full_design_uah =3D 0. It seems more sensible to
also set have_design_cap to false for this case and drop this extra
check.

Greetings,

-- Sebastian

> +		data64 =3D (u64)info->charge_full_design_uah * chip->r_sns;
> +		do_div(data64, MAX17042_CAPACITY_LSB);
> +		if (!data64)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "battery design capacity is too small for sense resistor\n");
> +		if (data64 > U16_MAX)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "battery design capacity exceeds register range\n");
> +
> +		design_cap =3D (u16)data64;
> +		dqacc =3D design_cap / MAX17055_DQACC_DIV;
> +		if (!dqacc)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "battery design capacity is too small for EZ config\n");
> +	}
> +
> +	if (have_ichgt_term) {
> +		if (!info->charge_term_current_ua)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "charge termination current must be positive\n");
> +
> +		data64 =3D (u64)info->charge_term_current_ua * chip->r_sns;
> +		do_div(data64, MAX17042_CURRENT_LSB);
> +		if (!data64)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "charge termination current is too small for sense resistor\n"=
);
> +		if (data64 > S16_MAX)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "charge termination current exceeds positive register range\n"=
);
> +
> +		ichgt_term =3D (u16)data64;
> +	}
> +
> +	config =3D chip->config_data;
> +	if (!config) {
> +		config =3D devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
> +		if (!config)
> +			return -ENOMEM;
> +	}
> +
> +	if (have_design_cap) {
> +		config->design_cap =3D design_cap;
> +		config->dqacc =3D dqacc;
> +	}
> +	if (have_ichgt_term)
> +		config->ichgt_term =3D ichgt_term;
> +
> +	chip->config_data =3D config;
> +	chip->enable_por_init =3D true;
> +
> +	return 0;
> +}
> +
> +static int max17042_init_battery(struct power_supply *psy)
> +{
> +	struct max17042_chip *chip =3D power_supply_get_drvdata(psy);
> +
> +	return max17042_apply_battery_properties(chip, psy->battery_info);
> +}
> +
>  static const struct regmap_config max17042_regmap_config =3D {
>  	.name =3D "max17042",
>  	.reg_bits =3D 8,
> @@ -1113,6 +1381,7 @@ static const struct power_supply_desc max17042_psy_=
desc =3D {
>  	.set_property	=3D max17042_set_property,
>  	.property_is_writeable	=3D max17042_property_is_writeable,
>  	.external_power_changed	=3D power_supply_changed,
> +	.init		=3D max17042_init_battery,
>  	.properties	=3D max17042_battery_props,
>  	.num_properties	=3D ARRAY_SIZE(max17042_battery_props),
>  };
> @@ -1123,6 +1392,7 @@ static const struct power_supply_desc max17042_no_c=
urrent_sense_psy_desc =3D {
>  	.get_property	=3D max17042_get_property,
>  	.set_property	=3D max17042_set_property,
>  	.property_is_writeable	=3D max17042_property_is_writeable,
> +	.init		=3D max17042_init_battery,
>  	.properties	=3D max17042_battery_props,
>  	.num_properties	=3D ARRAY_SIZE(max17042_battery_props) - 2,
>  };
> @@ -1242,15 +1512,18 @@ static int max17042_probe(struct i2c_client *clie=
nt, struct device *dev, int irq
> =20
>  	chip->irq =3D irq;
> =20
> -	regmap_read(chip->regmap, MAX17042_STATUS, &val);
> +	ret =3D regmap_read(chip->regmap, MAX17042_STATUS, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read status\n");
> +
>  	if (val & STATUS_POR_BIT) {
> -		ret =3D devm_work_autocancel(dev, &chip->work,
> -					   max17042_init_worker);
> +		ret =3D devm_delayed_work_autocancel(dev, &chip->work,
> +						   max17042_init_worker);
>  		if (ret)
>  			return ret;
> -		schedule_work(&chip->work);
> +		queue_delayed_work(system_freezable_wq, &chip->work, 0);
>  	} else {
> -		chip->init_complete =3D 1;
> +		WRITE_ONCE(chip->init_complete, true);
>  	}
> =20
>  	return 0;
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power=
/max17042_battery.h
> index 13aeab1597c6..810e068eafd2 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -25,6 +25,7 @@
>  #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
> =20
>  #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
> +#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
> =20
>  enum max17042_register {
>  	MAX17042_STATUS		=3D 0x00,
> @@ -124,6 +125,7 @@ enum max17055_register {
> =20
>  	MAX17055_ConvgCfg	=3D 0x49,
>  	MAX17055_VFRemCap	=3D 0x4A,
> +	MAX17055_SoftWakeup	=3D 0x60,
> =20
>  	MAX17055_STATUS2	=3D 0xB0,
>  	MAX17055_POWER		=3D 0xB1,
> --=20
> 2.55.0
>=20
>=20

--l73eowacs2ivgz2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpf8WUACgkQ2O7X88g7
+pqvOBAAg82wA/V0mKEXeE6kTqWVayCtH9Ne0TZifpIG+Knw1M/z6oMMKMi/9dTj
a7ZUvTI7JJTcwj1MYH7rOiENcvKuwWi/5UT+0gpN/U4EnPZTdmsHYRsfuVsAuDkZ
QEZdHNqnUR6wLTAphxHywpAdhk4yP/W/l/p7ZiTgbSk73ZJ4IpCELYE3XQ4zjNsI
ZjKz1Y2VDQPR5M2lRf6Lnl12JYA8twO2s22UCLAaxrhuqW0pdLPqxikSvezs6WRF
53a4AX7Wak5iYwW6ns/GODbUyk2bMybKFtGOemfCAFe9O/BdfNU7bc2C2Akw9Ozk
Ec98/xg+Lf4DLElKh6Klv2yoXJFSnpnDm0kc1/wUjuyZOfpA756go0KURGT8efg6
VtI+k+BKZGxp3L8H2e7xOA7eFQ3LabVNFTNTSgSS3liAmeuthreLnyZC0K5JWZ/T
6AfFqCN9yUPAtEr2Pab289XmsedIKpVYqbigR1Kgjy+AbYnqWxn3quluOru3sPZ4
ZZsSUO+fCtE5kYBWMfuMA5coDQLxLPHigWbJImjp8BPgJLKKpMG4xCkAJW4bOlXa
0xFQLB0N2eRx+CkmgIkZKI4rjwMC7LgiDKpfq++/CO9COeXKKnl3w1xihsQDDy/e
cKBMkea8oZSq736UkO+x0KAc1/UEc4Ixpfc14qiJw2uVF4qft8c=
=rwoI
-----END PGP SIGNATURE-----

--l73eowacs2ivgz2q--
