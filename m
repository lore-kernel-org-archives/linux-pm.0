Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A649364E;
	Fri,  4 Sep 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554264; cv=none; b=LA+W4gxglGCOPc9oJPEFpgJ2eO+GztiI/yd6c/uJX16/LMSu8HBNt80faGgJu/OmmjgmkWzWGsAYaXqR5QYvFUEFxYu59qi9wO4NUeDEDL6Ro7qBd7NJ8/8VB2FselBMqHcapJ7e7yvLZkcArWEWaHPI3PeTRWqe6nAYDC+Rpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554264; c=relaxed/simple;
	bh=7SElf+ReQ8IcEttoBIW+44bFrHA464bH9fv1c19QZW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mo+ZSIZYvk3fvbVxStON4uO/y428Q4HTDl7iYXGlnMmzOPeookI+chLVRVmo0bIH0yOatxln29k32azJt70wnon8QCr8EyBWDmdLdE6YiNZCjBsls0fj6LWyY/8PXtzm1F5E4dhhkyPyQdKbgrQDEcP0Vjz9Z0xyoeALHzK9Zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=a1M15yVV; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="a1M15yVV"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 81CA65340619;
	Fri, 04 Sep 2026 22:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1788554256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tc/uP77MaqbAnIfYkM9ZpItzzwpaVJcgRLtGIvi2hxk=;
	b=a1M15yVV2Pb7mu1w4Gn8NC4gd3U6CzxZ4u6t5VyUgNA1t/6AjDRRWyp+QfBr8hpfHJqnaW
	DuHKydrgNg0Z94apK7o5GuIe0+Lzy3GAlmmWSodYgSWyHqkbADmS24nFWyOih/WJFC/SHL
	9U7BrXvxUCqXKS0KPVwM9np9gzpyxAw=
Message-ID: <44d4db6f-6b84-4cec-9e85-cb7b437bb7f9@ixit.cz>
Date: Fri, 4 Sep 2026 22:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] power: supply: qcom_smbx: add SMB5 support
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>
References: <20260820-submit-qcom-smbx-send-v1-v4-0-818dabb2771e@snyders.xyz>
 <20260820-submit-qcom-smbx-send-v1-v4-2-818dabb2771e@snyders.xyz>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260820-submit-qcom-smbx-send-v1-v4-2-818dabb2771e@snyders.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 12:03, Robin Snyders via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Introduce support for the SMB5 charger found on PM7250B, PM8150B and
> related Qualcomm PMICs.
> 
> SMB5 uses different DCDC status offsets, charger-state encodings and
> electrical ranges. Select these from per-PMIC match data, with PM7250B
> using the PM8150B compatible fallback and parameter block. Read
> overvoltage from the SMB5 status bit, use the already-prescaled IIO
> voltage reading, and convert the SMB5 current-sense voltage to microamps.
> Use battery-info property presence when selecting voltage and current
> targets.
> 
> Keep Type-C power-role and VBUS control with the dedicated TCPM and
> regulator drivers. Clear the unsupported HVDCP negotiation modes so stale
> firmware settings cannot raise VBUS. Leave the firmware recharge policy
> unchanged and match the downstream default of ADC-based AICL disabled,
> while enabling periodic hardware AICL with its twelve-second SMB5 rerun
> interval. Preserve the existing three-second SMB2 interval.
> 
> PM8150B places the charger and VBUS regulator in the same DCDC peripheral,
> but the SMB5 path does not write the regulator registers. qcom_smbx reads
> 0x1108 and 0x110b, while qcom_usb_vbus-regulator writes 0x1140, 0x1152
> and 0x1153. The SMB2-only OTG configuration write to 0x1153 is not part
> of the SMB5 initialization sequence. The TCPM port and PD PHY use the
> separate 0x15xx and 0x17xx peripherals. Name the USBIN BC1.2 integration
> register and SMB2-only OTG definitions accordingly to make this ownership
> boundary explicit.
> 
> Program the battery limits and complete SMB5 input and charging setup
> from the power-supply registration init callback before device_add
> publishes the properties. This makes all public callbacks safe without
> driver-specific probe synchronization.
> 
> Suspend USB input and charging before SMB5 initialization. On a later
> failure, restore the original charging-enable state before the
> input-suspend state; leave the input suspended if charging cannot be
> restored. Cancel status work before unregistering the power supply during
> managed teardown. Update the Kconfig description to cover both charger
> generations.
> 
> On a OnePlus 7T Pro, register reads from the initial implementation
> confirmed the programmed 4.40 V, 1.50 A and 500 mA limits. A 180-second
> guarded charging trace and a subsequent 600-second runtime trace
> completed without crossing the voltage guard.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: Joel Selvaraj <foss@joelselvaraj.com>
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> Co-developed-by: Robin Snyders <robin@snyders.xyz>
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---
>   drivers/power/supply/Kconfig     |   8 +-
>   drivers/power/supply/qcom_smbx.c | 757 ++++++++++++++++++++++++++++++---------
>   2 files changed, 598 insertions(+), 167 deletions(-)
> 

[...]

>   
> +/* Return 1 when in overvoltage state, else 0 or -errno */
> +static int smbx_ov_status(struct smb_chip *chip)
> +{
> +	u8 mask;
> +	int rc;
> +	u32 val;
> +
> +	switch (chip->gen) {
> +	case SMB2:
> +		mask = SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT;
> +		break;
> +	case SMB5:
> +		mask = SMB5_CHARGER_ERROR_STATUS_BAT_OV_BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = regmap_read(chip->regmap,
> +			 chip->base + BATTERY_CHARGER_STATUS_2, &val);
> +	if (rc)
> +		return rc;
> +
> +	return !!(val & mask);
> +}
> +
> +static int smb_map_charge_status(struct smb_chip *chip, u32 stat, int *val)

would it make sense to split into smb{2,5}_map_charge_status and pass as .data 
and call match_data->map_charge_status(chip, stat, val)?

> +{
> +	switch (chip->gen) {
> +	case SMB2:
> +		switch (stat) {
> +		case SMB2_TRICKLE_CHARGE:
> +		case SMB2_PRE_CHARGE:
> +		case SMB2_FAST_CHARGE:
> +		case SMB2_FULLON_CHARGE:
> +		case SMB2_TAPER_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_CHARGING;
> +			return 0;
> +		case SMB2_TERMINATE_CHARGE:
> +		case SMB2_INHIBIT_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_FULL;
> +			return 0;
> +		case SMB2_DISABLE_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			return 0;
> +		}
> +		break;
> +	case SMB5:
> +		switch (stat) {
> +		case SMB5_TRICKLE_CHARGE:
> +		case SMB5_PRE_CHARGE:
> +		case SMB5_FULLON_CHARGE:
> +		case SMB5_TAPER_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_CHARGING;
> +			return 0;
> +		case SMB5_TERMINATE_CHARGE:
> +		case SMB5_INHIBIT_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_FULL;
> +			return 0;
> +		case SMB5_PAUSE_CHARGE:
> +		case SMB5_DISABLE_CHARGE:
> +			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			return 0;
> +		}
> +		break;
> +	}
> +
> +	*val = POWER_SUPPLY_STATUS_UNKNOWN;
> +	return 0;
> +}
> +
>   static int smb_get_prop_status(struct smb_chip *chip, int *val)
>   {
> -	unsigned char stat[2];
> +	u32 stat;
>   	int usb_online = 0;
>   	int rc;
>   
> @@ -491,49 +619,36 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
>   		return rc;
>   	}
>   
> -	rc = regmap_bulk_read(chip->regmap,
> -			      chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
> +	rc = regmap_read(chip->regmap,
> +			 chip->base + BATTERY_CHARGER_STATUS_1, &stat);
>   	if (rc < 0) {
>   		dev_err(chip->dev, "Failed to read charging status ret=%d\n",
>   			rc);
>   		return rc;
>   	}
>   
> -	if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
> +	rc = smbx_ov_status(chip);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* In overvoltage state */
> +	if (rc == 1) {
>   		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
>   		return 0;
>   	}
>   
> -	stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
> +	stat &= BATTERY_CHARGER_STATUS_MASK;
>   
> -	switch (stat[0]) {
> -	case TRICKLE_CHARGE:
> -	case PRE_CHARGE:
> -	case FAST_CHARGE:
> -	case FULLON_CHARGE:
> -	case TAPER_CHARGE:
> -		*val = POWER_SUPPLY_STATUS_CHARGING;
> -		return rc;
> -	case DISABLE_CHARGE:
> -		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -		return rc;
> -	case TERMINATE_CHARGE:
> -	case INHIBIT_CHARGE:
> -		*val = POWER_SUPPLY_STATUS_FULL;
> -		return rc;
> -	default:
> -		*val = POWER_SUPPLY_STATUS_UNKNOWN;
> -		return rc;
> -	}
> +	return smb_map_charge_status(chip, stat, val);
>   }
>   
>   static inline int smb_get_current_limit(struct smb_chip *chip,
>   					 unsigned int *val)
>   {
> -	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
> +	int rc = regmap_read(chip->regmap, chip->base + chip->icl_status, val);
>   
>   	if (rc >= 0)
> -		*val *= CURRENT_SCALE_FACTOR;
> +		*val *= chip->icl_step_ua;
>   	return rc;
>   }
>   
> @@ -541,12 +656,13 @@ static int smb_set_current_limit(struct smb_chip *chip, unsigned int val)
>   {
>   	unsigned char val_raw;
>   
> -	if (val > 4800000) {
> +	if (val > chip->icl_max_ua) {
>   		dev_err(chip->dev,
> -			"Can't set current limit higher than 4800000uA");
> +			"Can't set current limit higher than %uuA",
> +			chip->icl_max_ua);
>   		return -EINVAL;
>   	}
> -	val_raw = val / CURRENT_SCALE_FACTOR;
> +	val_raw = val / chip->icl_step_ua;
>   
>   	return regmap_write(chip->regmap, chip->base + USBIN_CURRENT_LIMIT_CFG,
>   			    val_raw);
> @@ -607,12 +723,10 @@ static void smb_status_change_work(struct work_struct *work)
>   static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
>   			     int *val)
>   {
> -	int rc;
> -	union power_supply_propval status;
> +	int rc, status;
>   
> -	rc = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_STATUS,
> -				       &status);
> -	if (rc < 0 || status.intval != POWER_SUPPLY_STATUS_CHARGING) {
> +	rc = smb_get_prop_status(chip, &status);
> +	if (rc < 0 || status != POWER_SUPPLY_STATUS_CHARGING) {
>   		*val = 0;
>   		return 0;
>   	}
> @@ -625,7 +739,61 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
>   	return iio_read_channel_processed(chan, val);
>   }
>   
> -static int smb_get_prop_health(struct smb_chip *chip, int *val)
> +static int smb_get_prop_current_now(struct smb_chip *chip, int *val)
> +{
> +	s64 current_ua;
> +	int rc;
> +
> +	rc = smb_get_iio_chan(chip, chip->usb_in_i_chan, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	current_ua = (s64)*val * chip->usbin_current_scale;
> +	if (current_ua < INT_MIN || current_ua > INT_MAX)
> +		return -ERANGE;
> +
> +	*val = (int)current_ua;
> +	return 0;
> +}
> +
> +static int smb5_get_prop_health(struct smb_chip *chip, int *val)
> +{
> +	int rc;
> +	unsigned int stat;
> +
> +	rc = smbx_ov_status(chip);
> +	if (rc < 0) {
> +		dev_err(chip->dev,
> +			"Couldn't determine overvoltage status: %d\n", rc);
> +		return rc;
> +	}
> +	if (rc) {
> +		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		return 0;
> +	}
> +
> +	rc = regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_7,
> +			 &stat);
> +	if (rc < 0) {
> +		dev_err(chip->dev, "Couldn't read charger status 7 rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (stat & SMB5_BAT_TEMP_STATUS_TOO_COLD_BIT)
> +		*val = POWER_SUPPLY_HEALTH_COLD;
> +	else if (stat & SMB5_BAT_TEMP_STATUS_TOO_HOT_BIT)
> +		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
> +	else if (stat & SMB5_BAT_TEMP_STATUS_COLD_SOFT_BIT)
> +		*val = POWER_SUPPLY_HEALTH_COOL;
> +	else if (stat & SMB5_BAT_TEMP_STATUS_HOT_SOFT_BIT)
> +		*val = POWER_SUPPLY_HEALTH_WARM;
> +	else
> +		*val = POWER_SUPPLY_HEALTH_GOOD;
> +
> +	return 0;
> +}
> +
> +static int smb2_get_prop_health(struct smb_chip *chip, int *val)
>   {
>   	int rc;
>   	unsigned int stat;
> @@ -637,15 +805,15 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
>   		return rc;
>   	}
>   
> -	if (stat & CHARGER_ERROR_STATUS_BAT_OV_BIT)
> +	if (stat & SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT)
>   		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> -	else if (stat & BAT_TEMP_STATUS_TOO_COLD_BIT)
> +	else if (stat & SMB2_BAT_TEMP_STATUS_TOO_COLD_BIT)
>   		*val = POWER_SUPPLY_HEALTH_COLD;
> -	else if (stat & BAT_TEMP_STATUS_TOO_HOT_BIT)
> +	else if (stat & SMB2_BAT_TEMP_STATUS_TOO_HOT_BIT)
>   		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
> -	else if (stat & BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT)
> +	else if (stat & SMB2_BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT)
>   		*val = POWER_SUPPLY_HEALTH_COOL;
> -	else if (stat & BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT)
> +	else if (stat & SMB2_BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT)
>   		*val = POWER_SUPPLY_HEALTH_WARM;
>   	else
>   		*val = POWER_SUPPLY_HEALTH_GOOD;
> @@ -653,6 +821,19 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
>   	return 0;
>   }
>   
> +static int smb_get_prop_health(struct smb_chip *chip, int *val)

I would drop this function and just called
smb{2,5}_get_prop_health directly with

match_data->get_prop_health(chip, val)

> +{
> +	switch (chip->gen) {
> +	case SMB2:
> +		return smb2_get_prop_health(chip, val);
> +	case SMB5:
> +		return smb5_get_prop_health(chip, val);
> +	default:
> +		dev_err(chip->dev, "unsupported SMB chip generation\n");
> +		return -EINVAL;
> +	}
> +}
> +
>   static int smb_get_property(struct power_supply *psy,
>   			     enum power_supply_property psp,
>   			     union power_supply_propval *val)
> @@ -669,8 +850,7 @@ static int smb_get_property(struct power_supply *psy,
>   	case POWER_SUPPLY_PROP_CURRENT_MAX:
>   		return smb_get_current_limit(chip, &val->intval);
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
> -					 &val->intval);
> +		return smb_get_prop_current_now(chip, &val->intval);
>   	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>   		return smb_get_iio_chan(chip, chip->usb_in_v_chan,
>   					 &val->intval);

[...]

> +static const struct smb_match_data pmi8998_match_data = {
> +	.init_seq = smb2_init_seq,
> +	.init_seq_len = ARRAY_SIZE(smb2_init_seq),
> +	.name = "pmi8998",
> +	.gen = SMB2,
> +	.fv_min_uv = 3487500,
> +	.fv_max_uv = 4920000,
> +	.fv_step_uv = 7500,
> +	.fcc_max_ua = 4500000,
> +	.fcc_step_ua = 25000,
> +	.icl_max_ua = 4800000,
> +	.icl_step_ua = 25000,
> +	.icl_status = SMB2_ICL_STATUS,
> +	.usbin_current_scale = 1,
> +};
> +
> +static const struct smb_match_data pm660_match_data = {
> +	.init_seq = smb2_init_seq,
> +	.init_seq_len = ARRAY_SIZE(smb2_init_seq),
> +	.name = "pm660",
> +	.gen = SMB2,
> +	.fv_min_uv = 3487500,
> +	.fv_max_uv = 4920000,
> +	.fv_step_uv = 7500,
> +	.fcc_max_ua = 4500000,
> +	.fcc_step_ua = 25000,
> +	.icl_max_ua = 4800000,
> +	.icl_step_ua = 25000,
> +	.icl_status = SMB2_ICL_STATUS,
> +	.usbin_current_scale = 1,
>   };

I don't see any difference between pmi8998 and pm660 (which applies for many 
parts between these chips usually). Maybe would be worth it just to ruse the 
pmi8998 for the pm660 and only set the name?

>   
> -static int smb_init_hw(struct smb_chip *chip)
> +static const struct smb_match_data pm8150b_match_data = {
> +	.init_seq = smb5_init_seq,
> +	.init_seq_len = ARRAY_SIZE(smb5_init_seq),
> +	.name = "pm8150b",
> +	.gen = SMB5,
> +	.fv_min_uv = 3600000,
> +	.fv_max_uv = 4790000,
> +	.fv_step_uv = 10000,
> +	.fcc_max_ua = 8000000,
> +	.fcc_step_ua = 50000,
> +	.icl_max_ua = 5000000,
> +	.icl_step_ua = 50000,
> +	.icl_status = SMB5_AICL_ICL_STATUS,
> +	.usbin_current_scale = 5,
> +};
> +
> +static int smb_init_hw(struct smb_chip *chip,
> +		       const struct smb_init_register *init_seq, size_t len)
>   {
>   	int rc, i;
>   
> -	for (i = 0; i < ARRAY_SIZE(smb_init_seq); i++) {
> +	for (i = 0; i < len; i++) {

since you touching this - C99 would be nice:
for (int i = ...

So far running these patches on Pixel 3 since yesterday, so far looks ok. I 
still need debug some crashes, but these usually happen regardless to charging, 
so likely not issue of this driver :))

David
