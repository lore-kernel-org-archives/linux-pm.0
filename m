Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090647;
	b=m1hEiYw2oENNVFeBBZYsHl41rpzPFv7yGlSQGWDao/7dSy9WuiHqEL5Wy4XYsOd8Ze+L
	 7i/aa8uGBoo/vScBZLnwFrtq3h7NO+YiH7yuTUj1F/T5xuTAfSMNuKUcx4tvkrfzBcacv
	 G+A9UZHyDYqCOYR5vZbzzFvXfps0WnOPjuo0/c+bLfFS1JqqGlKW055WYozA+Z/o0zxct
	 oTCzk929mbLBxReI9l6hzNvMTKs6zxhj6ymI/2VbluDiiOq3uSXoCj1Dpj62FdZvVjpxx
	 iqJGQusuRxKL3O/u41z+7DdHNhlD1WKQsiS1jcTjZ9H8TfgH/Q0tceL3EoAAgvIgUbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UAJvdvXND8MFc/VoiTbz1OJtExB4AirxeFsvHI+V5hE=;
	b=a9jd6/yAbg65l3fT9pyAq6B9mYY9rUhW6XY3F4cRjCrsD1JCuoIjgKFATzkvDVzVXdfN
	 FQzrAi8kKth3cp6j9LNsTaaQCjG9oWPoiVXdpK8NvGNJIc5i7MgVTPpE00SjMQw6IY/3T
	 d02Omm8kIpcO2EUrv9hKY6rtimixPoYXRHnIvJ9H75EiJrMHdfrCKLxE6m0f6W2x2wh7d
	 FsMnTAsTeMv6JKcIqp1tYOZb3lKbTTQeemM4DZINHjeeIruC0cnMpgV8cVbu5BMDizxux
	 5WpQIHrS+zXvDywRxMNZUmKbRf0Wvg4nizYifRyT28lwVdR2iBYW872rk/VvyZQavdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AwDuq+ea;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B0606A339
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 12:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC2B0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AwDuq+ea
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16609255e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 04:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795090645; x=1795695445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAJvdvXND8MFc/VoiTbz1OJtExB4AirxeFsvHI+V5hE=;
        b=AwDuq+eatSrAnL+zS/UWVIpORebaGiFOmF3Zop+PBpDwoqJ6Kw3hoA3EBsdk2qdqga
         Zfgmtfwgufs1LbJZxWIOo/QWFyIMI4APCo0FIMViYjOFfCGJ/IDW6q/Tz76fg4Vt1bFO
         dpZKj4il2SG53Nd0xEABt68MRqHCwRVHco9TfA9GFMc2DIpQ9kzuJt7OwwHoB0x2HHs5
         H3OoSYqZZm+vt78i3RChOTOqwDIvQ0fGLe8K5CMIQbKkqMsD0oof5PlTw/taEKbcYzMP
         FOtFFQ2noKsPwexDxy4DgIb/fMbY5SQE8Zh0T6U0sUVN0iWU3kuQJb7mVTQugjMZouSD
         bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090645; x=1795695445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAJvdvXND8MFc/VoiTbz1OJtExB4AirxeFsvHI+V5hE=;
        b=gC3UT7ytC/ooEvDNdA/7XeCIpn20lPgY7d1H9p/gh6xMee1fjqofjJlSoIlDFAwYEr
         VYJD7Iet3A623Vrn5jhis2Y91hDCiacC1irFc3MPGrbPYGX6LkQoYOIYqgt7/43P7WTJ
         q5CPMYYN6e8MK/8rpUN3Mv1ra5tbRoMK26NXa37zkLtiobGhV7dpM3YkimloRWZA3/ff
         PNmUvllgrN1xJqoWCjKjujmkv+er8MQ4sMN1RKh9iHaUssLJEhUUDCb7v3/lH7LaGJsU
         P2cX48kHFZSjWE9qQ9rxZuUmRX24n5TqQiM3nJ8hFrv+YakWKyQNSRUPR3ibjFBL2EhW
         lkSQ==
X-Forwarded-Encrypted: i=1; AL+hErFBhEYfnEDsak6Ttst96RMU6xGx+GVwKxvsawnmgpXYaDsoCSG/plReFsztEdiNnFQBY5Z6Q7Sn5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9v598V1VPc9hOI7P5MBVL5I8BbgR+5wDbbkwtBsHci+m+sqOhs
	YFK54Rj1nT+Cy3Xz3RUsUOeWHEwGHnIAGt3VAmUpl/qYTuv/QAhRP4MXHHOPmUfFkEU=
X-Gm-Gg: AYBFou0TyyaszwjIhlAKycva/WtgKIpGQkvjE24yA5EUj9ZMz8trXZ1x4NNgpow8mlg
	d7N1rYRVVxzFC5FTg6irebVWgVxBw6OKXtWlLhsnPybHN61S8Qs4bTO5CG/G3HIM/diNvb1H2TS
	WfaYTzr2+U7rcoTVAnYtpMx41bZsRvZPu/ze5f785m0nr6hVH/CM2X+2ejAD41XrNFTfu+sYEzi
	A0K323hrOaBLTC4iq3AqbaKB7uRSRWP2/U3omqixE3L8p9KWW/nBmic/5vUDKPY/JJtPjbwjaU7
	CdUt147G4DO2JjoKbz593pa+5j70Wt0m5y9A688cEj1Aap4LpLfsRQzq1GPrekw8yvFQPqAKHao
	/L0HObdE8h/tH6xH98AVqIM0NQ88zQUDb139osrnSdMo3MPaJ3MLCGVhdMXNauIom+0Bat0ElX2
	m41jch14U8radthk88vdIiZ0czCJRve0s/P5JB4Mo8WgpDnrd3QjvSW3npkAplfz6LjZOzjSRH3
	9RtN4rGQEkfi1bkvMdvyKwyBpLRuHVx3y+NPN0sGyg4n5nchP3kiib2Fr+dj6yLPGUWxIvmV38y
	sVzvUwgS9F0SLMVV/dWT4BHAQlW7jePS+CO2ahK75l2qPDMDj9D6C8q3idVrWw==
X-Received: by 2002:a05:600d:6011:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4bb7da12dd2mr112140475e9.6.1795090644975;
        Thu, 19 Nov 2026 04:17:24 -0800 (PST)
Received: from [192.168.0.252] ([79.115.63.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560882asm10866932f8f.27.2026.11.19.04.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:17:24 -0800 (PST)
Message-ID: <29209163-a01a-4862-9824-90616da73f49@linaro.org>
Date: Thu, 19 Nov 2026 14:17:23 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal: samsung: acpm-tmu: refactor SoC-specific
 operations into driver data
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>,
 Thomas Turner <tturner@lineageos.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
 <20261118-acpm-tmu-e850-support-v2-2-19848c0d97e5@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-2-19848c0d97e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 3:51 PM, Alexey Klimov wrote:
> The current ACPM TMU driver assumes that all TMU operations (init,
> threshold updates, and interrupt clearing) are handled exclusively
> via ACPM IPC commands, which is true for the GS101.
> 
> However, other Exynos platforms (like Exynos850) lack complete firmware
> support for these operations and require direct MMIO register access
> instead for missing ACPM TMU IPC calls.
> 
> Prepare the driver for multi-SoC support by moving the hardcoded GS101
> IPC calls into SoC-specific callbacks: "tz_control", "tmu_init",
> "tmu_update_thresholds" and "tmu_check_and_clear_irqs" within the
> acpm_tmu_driver_data struct. Additionally, save the regmap pointer in
> the private structure so that these callbacks can utilize it for other
> SoCs.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/thermal/samsung/acpm-tmu.c | 113 +++++++++++++++++++++++++++----------
>  1 file changed, 82 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
> index 4799ef518a7a..0def0ec09084 100644
> --- a/drivers/thermal/samsung/acpm-tmu.c
> +++ b/drivers/thermal/samsung/acpm-tmu.c
> @@ -74,6 +74,8 @@ struct acpm_tmu_sensor {
>  };
>  
>  struct acpm_tmu_priv {
> +	const struct acpm_tmu_driver_data *data;
> +	struct regmap *regmap;
>  	struct regmap_field *regmap_fields[REG_INTPEND_COUNT];
>  	struct acpm_handle *handle;
>  	struct device *dev;
> @@ -86,9 +88,18 @@ struct acpm_tmu_priv {
>  
>  struct acpm_tmu_driver_data {
>  	const struct reg_field *reg_fields;
> +	const struct regmap_config *regmap_config;
>  	const struct acpm_tmu_sensor_group *sensor_groups;
>  	unsigned int num_sensor_groups;
>  	unsigned int mbox_chan_id;
> +
> +	/* SoC-specific TMU routines and values */
> +	int (*tz_control)(struct acpm_tmu_sensor *sensor, bool on);

on e850 this sets CORE_EN, what this callback do is to enable or
disable a sensor group

what do you think about:

int (*enable_sensor)(struct acpm_tmu_sensor *sensor, bool on);

> +	int (*tmu_check_and_clear_irqs)(struct acpm_tmu_sensor *sensor,
> +					bool *pending_irq);

drop tmu prefixes, the struct is already acpm_tmu

> +	int (*tmu_init)(struct acpm_tmu_priv *priv);
> +	int (*tmu_update_thresholds)(struct acpm_tmu_sensor *sensor,
> +				     u8 thresholds[2], u8 inten);
>  };

How about doing the following:

struct acpm_tmu_soc_ops {
	int (*init)(...);
	int (*enable_sensor)(...);
	int (*set_thresholds)(...);
        bool (*clear_pending_irq)(...);
};

struct acpm_tmu_driver_data {
	...
	const struct acpm_tmu_soc_ops *ops;
};

static const struct acpm_tmu_soc_ops gs101_tmu_ops = {
	.init			= gs101_init,
	.enable_sensor		= gs101_enable_sensor,
	.set_thresholds		= gs101_set_thresholds,
	.clear_pending_irq	= gs101_clear_pending_irq,
};

>  
>  #define ACPM_TMU_SENSOR_GROUP(_mask, _id)		\
> @@ -131,24 +142,32 @@ static const struct regmap_config gs101_regmap_config = {
>  	.max_register = GS101_REG_INTPEND(15),
>  };
>  
> -static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
> -	.reg_fields = gs101_reg_fields,
> -	.sensor_groups = gs101_sensor_groups,
> -	.num_sensor_groups = ARRAY_SIZE(gs101_sensor_groups),
> -	.mbox_chan_id = 9,
> -};
> +static int gs101_tz_control(struct acpm_tmu_sensor *sensor, bool on)
> +{
> +	struct acpm_tmu_priv *priv = sensor->priv;
> +	struct acpm_handle *handle = priv->handle;
> +
> +	return handle->ops->tmu.tz_control(handle, priv->mbox_chan_id,
> +					   sensor->group->id, on);
> +}
> +
> +static int gs101_tmu_init(struct acpm_tmu_priv *priv)
> +{
> +	struct acpm_handle *handle = priv->handle;
> +
> +	return handle->ops->tmu.init(handle, priv->mbox_chan_id);
> +}
>  
>  static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
>  {
>  	struct acpm_tmu_priv *priv = sensor->priv;
> -	struct acpm_handle *handle = priv->handle;
> -	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
>  	int ret;
>  
> -	ret = ops->tz_control(handle, priv->mbox_chan_id, sensor->group->id,
> -			      on);
> -	if (ret)
> -		return ret;
> +	if (priv->data->tz_control) {
> +		ret = priv->data->tz_control(sensor, on);
> +		if (ret)
> +			return ret;
> +	}
>  

Both SoCs implement all the callbacks, and tmu_check_and_clear_irqs()
is already called unconditionally. Please make all of them mandatory
and drop the NULL checks. As it is, a missing tz_control() would still
flip sensor->enabled.

>  	WRITE_ONCE(sensor->enabled, on);
>  
> @@ -227,8 +246,8 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  	return 0;
>  }
>  
> -static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
> -				      u8 thresholds[2], u8 inten)
> +static int gs101_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
> +				       u8 thresholds[2], u8 inten)

This moves the SoC-independent part (sensor->lock, disabling the sensor
and restoring its state) into the GS101 callback, and patch 3 then
duplicates it for Exynos850. Please keep that part in the core and have
the SoC callback only program the thresholds.

>  {
>  	struct acpm_tmu_priv *priv = sensor->priv;
>  	struct acpm_handle *handle = priv->handle;
> @@ -292,7 +311,8 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
>  	if (ret)
>  		return ret;
>  
> -	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
> +	if (priv->data->tmu_update_thresholds)
> +		ret = priv->data->tmu_update_thresholds(sensor, thresholds, inten);
>  
>  	pm_runtime_put_autosuspend(dev);
>  
> @@ -331,12 +351,12 @@ static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
>  	.set_trips = acpm_tmu_set_trips,
>  };
>  
> -static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
> +static int gs101_handle_irqs(struct acpm_tmu_sensor *sensor, bool *pending_irq)

why not keeping the bool, the ret code is not used anyway.

>  {
>  	struct acpm_tmu_priv *priv = sensor->priv;
>  	const struct acpm_tmu_ops *ops = &priv->handle->ops->tmu;
>  	unsigned long mask = sensor->group->mask;
> -	bool pending_irq = false;
> +	bool pending = false;
>  	int i, ret;
>  	u32 val;
>  
> @@ -345,16 +365,16 @@ static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
>  	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
>  		ret = regmap_field_read(priv->regmap_fields[i], &val);
>  		if (ret)
> -			return false;
> +			return ret;
>  
>  		if (val) {
> -			pending_irq = true;
> +			pending = true;
>  			break;
>  		}
>  	}
>  
> -	if (!pending_irq)
> -		return false;
> +	if (!pending)
> +		return 0;
>  
>  	ret = ops->clear_tz_irq(priv->handle, priv->mbox_chan_id,
>  				sensor->group->id);
> @@ -362,10 +382,12 @@ static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
>  		dev_err_ratelimited(priv->dev,
>  				    "Sensor %u: failed to clear IRQ (%d)\n",
>  				    sensor->group->id, ret);
> -		return false;
> +		return ret;
>  	}
>  
> -	return true;
> +	*pending_irq = true;
> +
> +	return ret;
>  }
>  
>  static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
> @@ -383,8 +405,13 @@ static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
>  
>  	for (i = 0; i < priv->num_sensors; i++) {
>  		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
> +		bool pending_irq = false;
>  
> -		if (!sensor->tzd || !acpm_tmu_clear_pending_irq(sensor))
> +		if (!sensor->tzd)
> +			continue;
> +
> +		ret = priv->data->tmu_check_and_clear_irqs(sensor, &pending_irq);
> +		if (ret || !pending_irq)
>  			continue;
>  
>  		handled = true;
> @@ -398,15 +425,30 @@ static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> +static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
> +	.reg_fields = gs101_reg_fields,
> +	.regmap_config = &gs101_regmap_config,
> +	.sensor_groups = gs101_sensor_groups,
> +	.num_sensor_groups = ARRAY_SIZE(gs101_sensor_groups),
> +	.mbox_chan_id = 9,
> +	.tz_control = gs101_tz_control,
> +	.tmu_check_and_clear_irqs = gs101_handle_irqs,
> +	.tmu_init = gs101_tmu_init,
> +	.tmu_update_thresholds = gs101_tmu_update_thresholds,
> +};
> +
>  static const struct of_device_id acpm_tmu_match[] = {
> -	{ .compatible = "google,gs101-tmu-top" },
> +	{
> +		.compatible = "google,gs101-tmu-top",
> +		.data = &acpm_tmu_gs101
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, acpm_tmu_match);
>  
>  static int acpm_tmu_probe(struct platform_device *pdev)
>  {
> -	const struct acpm_tmu_driver_data *data = &acpm_tmu_gs101;
> +	const struct acpm_tmu_driver_data *data;
>  	struct acpm_handle *acpm_handle;
>  	struct device *dev = &pdev->dev;
>  	struct acpm_tmu_priv *priv;
> @@ -414,6 +456,10 @@ static int acpm_tmu_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	int i, ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -ENODEV, "No matching driver data found\n");

plain return -ENODEV would do too, dev_err_probe brings nothing here.

Cheers,
ta

