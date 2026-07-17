Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0C175A6A;
	Fri, 17 Jul 2026 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247158; cv=none; b=PWJO9WPZHtTG3bcPBqIiyW1jvmw2UR9dCW1LMIWxGHMzRxD285qZPlHdIDYDPp/lnP1kfExoJO4eid5JcP0Jmg5yOXKre2zaGnsLJJLUED5g4atV1PuC5rEsHH+nGnk8S4q+2KaAmha1WUARdZ/LJ8M5ciO7uB54C5S4pWvVYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247158; c=relaxed/simple;
	bh=KIAwAAQokTNdCR3ckxl4/D1QUgaY77KFcvLQMPr8uqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itVU3rzeWD5sfwksx5ENc41nVzG9O81jD3xMbXDF3Tfj3HhOhTqAIOntimSMwvk+4NeobNdc+yDhHSae/XFEl3fAL5L1LPIqoLAIfpQCBpGwbP3D0YdXZpzpeDx/i1zUPmuLZvev3fWij938Nuh1V0BamzoABUdE/DaTEdKlx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG0YaV2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG0YaV2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930EA1F00A3F;
	Fri, 17 Jul 2026 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784247156;
	bh=arF6rlh8o7ke4rkjfVNLQeaX4PXR9UGuNplSZpPUZ1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mG0YaV2LY5jIMgQsUbOAOjP66EjwMkaigqGNtP5mOFoyENN+Fs8l8hJXmnHlQTibe
	 p334Z144jeHDhOkHESTUtJSqw9WvSTxExckvlcfiFIfONp1NN2INZhcSXH9oQYuotP
	 8p0cLwZvYoAJuuimpIHnPZ7sK0FV9hX6TpersG7+1re3CWlqL09BZb+urRnRNnq9jQ
	 J1oXEaAI7CaaxM23KfjCksZmNDFb/1ecTz7M4FKHL+XTpI4tcyCqn9ODCvZ3ERoYQU
	 WUXCuuy+aml8PvoHbFTqcEpWScF1Em0uM6ciL7Q19PRDR4nrUxhdt52BdSDLJXUPI0
	 WimwVHYIhOWOA==
Date: Thu, 16 Jul 2026 19:12:32 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: Add support batteryless
 boards as MAINS
Message-ID: <allv5PQRd8kr2JG1@baldur>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <20260518-add_dc_in_support-v1-2-31fbaa329879@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-add_dc_in_support-v1-2-31fbaa329879@oss.qualcomm.com>

On Mon, May 18, 2026 at 07:19:40PM +0530, Rakesh Kota wrote:
> Add support for the "qcom,batteryless" device tree property.
> When this boolean property is present, the driver registers the power
> supply as POWER_SUPPLY_TYPE_MAINS instead of BATTERY. This prevents
> userspace from triggering battery power-saving sequences when using
> powered by 12V adapters.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 47 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 490137a23d00e97a9e6ced21d1e66fe637db6c9d..35d266375d8c46b161a64f9c2a8c6054dc2211de 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -332,6 +332,7 @@ struct qcom_battmgr {
>  	struct qcom_battmgr_wireless wireless;
>  
>  	struct work_struct enable_work;
> +	bool batteryless;

This is a local variable used only within qcom_battmgr_probe()

>  
>  	/*
>  	 * @lock is used to prevent concurrent power supply requests to the
> @@ -930,6 +931,47 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
>  	.property_is_writeable = qcom_battmgr_bat_is_writeable,
>  };
>  
> +static int qcom_battmgr_dcin_get_property(struct power_supply *psy,
> +					  enum power_supply_property psp,
> +					  union power_supply_propval *val)
> +{
> +	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	if (!battmgr->service_up)
> +		return -EAGAIN;
> +
> +	ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = battmgr->status.status;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = battmgr->info.present;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_property dcin_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +};
> +
> +static const struct power_supply_desc dcin_psy_desc = {

Everything else in this driver is prefixed based on which firmware
interface it's operating against, but you decided to ignore that
convention...

Don't do that.

> +	.name = "qcom-battmgr-dcin",

Isn't this what we call qcom-battmgr-ac for the compute targets?

Is there any reason to not unify the naming?

> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = dcin_props,
> +	.num_properties = ARRAY_SIZE(dcin_props),
> +	.get_property = qcom_battmgr_dcin_get_property,
> +};
> +
>  static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>  					enum power_supply_property psp,
>  					union power_supply_propval *val)
> @@ -1652,6 +1694,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  	mutex_init(&battmgr->lock);
>  	init_completion(&battmgr->ack);
>  
> +	battmgr->batteryless = device_property_read_bool(dev, "qcom,batteryless");
>  	match = of_match_device(qcom_battmgr_of_variants, dev->parent);
>  	if (match)
>  		battmgr->variant = (unsigned long)match->data;
> @@ -1690,7 +1733,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>  					     "failed to register wireless charing power supply\n");
>  	} else {
> -		if (battmgr->variant == QCOM_BATTMGR_SM8550)
> +		if (battmgr->batteryless)
> +			psy_desc = &dcin_psy_desc;

The psy_desc here is what is used to register the bat_psy on the line
below. Why would you register "dcin" as your bat_psy?

Is there an actual reason or are you just lazy?

Regards,
Bjorn

> +		else if (battmgr->variant == QCOM_BATTMGR_SM8550)
>  			psy_desc = &sm8550_bat_psy_desc;
>  		else
>  			psy_desc = &sm8350_bat_psy_desc;
> 
> -- 
> 2.34.1
> 
