Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F53D411B;
	Wed, 19 Aug 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123481; cv=none; b=mGf1hJbL6LIS54+woLNBNBsnH5dbuHDmo+GmdNPoBau3rUNJLAQ7RGcHji0EgL3uKHbckcVy/yPFVPuXPOggL9MKG92dybnW/GtizOEbELnX/hrHaVVcWMOmXG08xJ9JUKQ2/LuLlY2RuhV3auS/5mbeU8LpIQVyaEIfrN4OKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123481; c=relaxed/simple;
	bh=s3ceQD9FA64b6OgL8dDpxKekMMjE/+2DmbmXun2IYCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMFpMuXjqRsgPGNeR26eyRV4K4zoS18OCUPdL4kKsYyLpEQsv+kdN9sKx0BrW7I3dhiHcQDTjQ4CxtSIeu+FPYarz9EfxLwvpOApG6Xu0n+0ZoTNI6eu66GwhUKBQW1oqVB7VQiMHB55P35xLpPRJEEXRHvduXqU2+IvstEJeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9eIX+Dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9eIX+Dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AA61F000E9;
	Wed, 19 Aug 2026 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123479;
	bh=gIVfZ26yePoP1FZxfSSR/1V2uNhgWipvSDB0rEd4Zu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9eIX+Dw0S7HGIhilfE+nXTYO4cQbgM0xGjqDrzAl7fLK9wEjr2qKAjH7kSh/I5CQ
	 8KrQyqu2JgInyQwaSBHxlT/y/I9YPUUMI7VSmNVt+nGcPPnnU+3JtE0ZTcEAF1Wppg
	 7Kv03XbKMcaP3oQRd1vqwjxUn6wPb6lH6d+GVb9f433gHPeeFQGBGjHZVM0hKiNL79
	 GV37rt3lQNR3jyN4kn3qWnlluZQb95kdmqCyKZZjkqykCW7tottV2jopNerVoouLxM
	 XHqVQqAfuW2YJuyrfHhzZw/9ZmkBMJMeEp7wW9gfSzjHES5pgps7I62Y90MVIQWGZ9
	 4pyp3HdBOOzhQ==
Date: Wed, 19 Aug 2026 09:11:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "user.email" <zstaseg@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao
 support
Message-ID: <20260819-slick-spotted-chamois-962510@quoll>
References: <20260818151039.409767-1-zstaseg@gmail.com>
 <20260818151039.409767-3-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818151039.409767-3-zstaseg@gmail.com>

On Tue, Aug 18, 2026 at 05:10:38PM +0200, user.email wrote:
> From: Stanislav Zaikin <zstaseg@gmail.com>
> 
> The Xiaomi taoyao firmware defines an additional BATT_CONSTANT_CURRENT
> property (ID 12) between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting
> all higher battery property IDs by one.
> 
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 86 +++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 490137a23d00..390d7c75e36f 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
>  	QCOM_BATTMGR_SM8350,
>  	QCOM_BATTMGR_SM8550,
>  	QCOM_BATTMGR_X1E80100,
> +	QCOM_BATTMGR_TAOYAO,

T < X, do not introduce entries in random order

>  };
>  
>  #define BATTMGR_BAT_STATUS		0x1
> @@ -451,16 +452,87 @@ static const u8 sm8350_bat_prop_map[] = {
>  	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
>  };
>  
> +/*
> + * Xiaomi Taoyao firmware has BATT_CONSTANT_CURRENT (ID 12) inserted
> + * between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting all subsequent
> + * IDs by one.
> + */
> +static const u8 taoyao_bat_prop_map[] = {
> +	[POWER_SUPPLY_PROP_STATUS] = BATT_STATUS,
> +	[POWER_SUPPLY_PROP_HEALTH] = BATT_HEALTH,
> +	[POWER_SUPPLY_PROP_PRESENT] = BATT_PRESENT,
> +	[POWER_SUPPLY_PROP_CHARGE_TYPE] = BATT_CHG_TYPE,
> +	[POWER_SUPPLY_PROP_CAPACITY] = BATT_CAPACITY,
> +	[POWER_SUPPLY_PROP_VOLTAGE_OCV] = BATT_VOLT_OCV,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = BATT_VOLT_NOW,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = BATT_VOLT_MAX,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] = BATT_CURR_NOW,
> +	[POWER_SUPPLY_PROP_TEMP] = BATT_TEMP + 1,
> +	[POWER_SUPPLY_PROP_TECHNOLOGY] = BATT_TECHNOLOGY + 1,
> +	[POWER_SUPPLY_PROP_CHARGE_COUNTER] = BATT_CHG_COUNTER + 1,
> +	[POWER_SUPPLY_PROP_CYCLE_COUNT] = BATT_CYCLE_COUNT + 1,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN] = BATT_CHG_FULL_DESIGN + 1,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL] = BATT_CHG_FULL + 1,
> +	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME + 1,
> +	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG + 1,
> +	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG + 1,
> +	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE + 1,
> +	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
> +	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW + 1,
> +	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR + 1,
> +	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR + 1,
> +};
> +
> +/*
> + * Reverse mapping from Xiaomi Taoyao firmware property IDs to canonical
> + * kernel property IDs.
> + */
> +static const u8 taoyao_to_canonical[] = {
> +	[BATT_STATUS] = BATT_STATUS,
> +	[BATT_HEALTH] = BATT_HEALTH,
> +	[BATT_PRESENT] = BATT_PRESENT,
> +	[BATT_CHG_TYPE] = BATT_CHG_TYPE,
> +	[BATT_CAPACITY] = BATT_CAPACITY,
> +	[BATT_SOH] = BATT_SOH,
> +	[BATT_VOLT_OCV] = BATT_VOLT_OCV,
> +	[BATT_VOLT_NOW] = BATT_VOLT_NOW,
> +	[BATT_VOLT_MAX] = BATT_VOLT_MAX,
> +	[BATT_CURR_NOW] = BATT_CURR_NOW,
> +	[BATT_CHG_CTRL_LIM] = BATT_CHG_CTRL_LIM,
> +	[BATT_CHG_CTRL_LIM_MAX] = BATT_CHG_CTRL_LIM_MAX,
> +	[BATT_CHG_CTRL_LIM_MAX + 1] = 0xff,	/* BATT_CONSTANT_CURRENT - never requested */
> +	[BATT_TEMP + 1] = BATT_TEMP,
> +	[BATT_TECHNOLOGY + 1] = BATT_TECHNOLOGY,
> +	[BATT_CHG_COUNTER + 1] = BATT_CHG_COUNTER,
> +	[BATT_CYCLE_COUNT + 1] = BATT_CYCLE_COUNT,
> +	[BATT_CHG_FULL_DESIGN + 1] = BATT_CHG_FULL_DESIGN,
> +	[BATT_CHG_FULL + 1] = BATT_CHG_FULL,
> +	[BATT_MODEL_NAME + 1] = BATT_MODEL_NAME,
> +	[BATT_TTF_AVG + 1] = BATT_TTF_AVG,
> +	[BATT_TTE_AVG + 1] = BATT_TTE_AVG,
> +	[BATT_RESISTANCE + 1] = BATT_RESISTANCE,
> +	[BATT_POWER_NOW + 1] = BATT_POWER_NOW,
> +	[BATT_POWER_AVG + 1] = BATT_POWER_AVG,
> +	[BATT_CHG_CTRL_EN + 1] = BATT_CHG_CTRL_EN,
> +	[BATT_CHG_CTRL_START_THR + 1] = BATT_CHG_CTRL_START_THR,
> +	[BATT_CHG_CTRL_END_THR + 1] = BATT_CHG_CTRL_END_THR,
> +};
> +
>  static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
>  					  enum power_supply_property psp)
>  {
>  	unsigned int prop;
>  	int ret;
>  
> -	if (psp >= ARRAY_SIZE(sm8350_bat_prop_map))
> -		return -EINVAL;
> -
> -	prop = sm8350_bat_prop_map[psp];
> +	if (battmgr->variant == QCOM_BATTMGR_TAOYAO) {
> +		if (psp >= ARRAY_SIZE(taoyao_bat_prop_map))
> +			return -EINVAL;
> +		prop = taoyao_bat_prop_map[psp];
> +	} else {
> +		if (psp >= ARRAY_SIZE(sm8350_bat_prop_map))
> +			return -EINVAL;
> +		prop = sm8350_bat_prop_map[psp];
> +	}
>  
>  	mutex_lock(&battmgr->lock);
>  	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET, prop, 0);
> @@ -1381,6 +1453,11 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  	switch (opcode) {
>  	case BATTMGR_BAT_PROPERTY_GET:
>  		property = le32_to_cpu(resp->intval.property);
> +
> +		if (battmgr->variant == QCOM_BATTMGR_TAOYAO &&
> +		    property < ARRAY_SIZE(taoyao_to_canonical))
> +			property = taoyao_to_canonical[property];

So device is or is not compatible with sm7325? Above code suggests that
it is not. How does it work when bound by sm7325 compatible?

> +
>  		if (property == BATT_MODEL_NAME) {
>  			if (payload_len != sizeof(resp->strval)) {
>  				dev_warn(battmgr->dev,
> @@ -1617,6 +1694,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
>  	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
> +	{ .compatible = "xiaomi,taoyao-pmic-glink", .data = (void *)QCOM_BATTMGR_TAOYAO },

And here as well wrong order

>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>  	{}
>  };
> -- 
> 2.53.0
> 
