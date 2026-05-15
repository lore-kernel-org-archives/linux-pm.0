Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA73E0257;
	Fri, 15 May 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829936; cv=none; b=m8g0sopHEwh3vI/o61ykA7fF4v8hJUdn0iV8t4+OdYF0rAttQIgQF6qr6ELaBHMhDifaSR5hbt5nyrWq0SyQHuW2s19onxCmeXznI/xW1dSB5/vEQgxB130A+gDmjlptvJZeCUdMDGZqrwhi2N/jNLvdg1K2FxTKYtFnmVveF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829936; c=relaxed/simple;
	bh=fM3mJYyX9qpwDv1QMgw4KnhvA98uYsW790tJU4o6Sgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSEYrkL5bA9VjHpUyi/O1LgvxVZOzj7wJsmgMwx27OsySro7XEiaNsAOv6/Uch7xW+pyO5v3GeB1YOX27NQYZN1Pee7SZn6vQwYiWzbHGxZOcK94G3lPpYpUP5gjNnXYpztP/r+7IvSEpXfH5RjdgnxU1rDDW4xfrMSwwdPUB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtpgjGeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtpgjGeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCA2C2BCB0;
	Fri, 15 May 2026 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778829935;
	bh=fM3mJYyX9qpwDv1QMgw4KnhvA98uYsW790tJU4o6Sgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZtpgjGeCLRSc9s+QyQSLVmfQeh5STlLRhws7Le2lSt5ZTUBE+Qh2dLUflqiZYIREL
	 mHycZA/9z9fj40DMy85joJY1xFz6F3HCOMhkmpg6UVc4s6NKN+WI3hyd+jGra+lo89
	 xJ8/vSQcih92h+vNTYH+x6lsvt6iL2Z+HgE+BEc45koCFVmc3XB0LFIOHywR8ryCBy
	 sfHunH9KOeq3L9eyB+U2W0zb4L+ZzHNEa1OwZp0aYin5NT48T/ot+fy4T/qfg4heEG
	 3uA8WXArpAwOZ6IUTynGkLNvBqz+j9jZJkuY1mfVoDvUOgQ0ryb3fnxx8otfU+8thF
	 oRVnSCwrUKcAw==
Message-ID: <17f49974-1f39-4b4c-8577-da33da7f1cc4@kernel.org>
Date: Fri, 15 May 2026 09:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: supply: max17042: add handler for energy_now
 property
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260515-batt-status-v1-0-fed6b7d8cea7@google.com>
 <20260515-batt-status-v1-3-fed6b7d8cea7@google.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260515-batt-status-v1-3-fed6b7d8cea7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15-May-26 07:48, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add handler to report power_supply_prop_energy_now so that users can get
> current SoC in uWH. Additionally, add helper functions to get avg_vcell
> and repcap values in uv and uah units respectively to avoid code
> duplication.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

NACK for multiple reasons:

1. We don't want to do this in all drivers which only support
charge_now and not energy_now, instead the TCPM driver should
convert charge_now to energy_now when necessary itself so that
the TCPM code will work with all battery type power-supply drivers
not just those which provide energy_now.

2. Having energy_now without energy_full is problematic and will
confuse userspace which prefers energy_* over charge_* since
userspace will now miss a reference value for full to report
a charging progress percentage. I also wonder how this works
on the TCPM side does the  Battery Status response message not
have a full value / percentage ?

3. IIRC userspace (upower) picks either energy_* or charge_*
values depending on which are present. I'm not sure if having
both will not confuse userspace. As mentioned in 2. having both
while one of them has an incomplete set of properties is sure
to confuse userspace.

Regards,

Hans





> ---
>  drivers/power/supply/max17042_battery.c | 60 ++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 167fb3fb3732..e16eb6985b70 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -81,6 +81,7 @@ static enum power_supply_property max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
>  	POWER_SUPPLY_PROP_TEMP,
>  	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
>  	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> @@ -95,6 +96,36 @@ static enum power_supply_property max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  };
>  
> +static int max17042_get_repcap_uah(struct max17042_chip *chip, u64 *rep_cap)
> +{
> +	u32 data;
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, MAX17042_RepCap, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*rep_cap = data * 5000000ll;
> +	*rep_cap *= chip->task_period;
> +	do_div(*rep_cap, MAX17042_DEFAULT_TASK_PERIOD);
> +	do_div(*rep_cap, chip->pdata->r_sns);
> +
> +	return 0;
> +}
> +
> +static int max17042_get_avgvcell_uv(struct max17042_chip *chip, u32 *vcell)
> +{
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, vcell);
> +	if (ret < 0)
> +		return ret;
> +
> +	*vcell = (*vcell * 625) / 8;
> +
> +	return 0;
> +}
> +
>  static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
>  {
>  	int ret;
> @@ -180,14 +211,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
>  	int temp, vavg, vbatt, ret;
>  	u32 val;
>  
> -	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, &val);
> +	ret = max17042_get_avgvcell_uv(chip, &val);
>  	if (ret < 0)
>  		goto health_error;
>  
> -	/* bits [0-3] unused */
> -	vavg = val * 625 / 8;
>  	/* Convert to millivolts */
> -	vavg /= 1000;
> +	vavg = val / 1000;
>  
>  	ret = regmap_read(chip->regmap, MAX17042_VCELL, &val);
>  	if (ret < 0)
> @@ -304,11 +333,10 @@ static int max17042_get_property(struct power_supply *psy,
>  		val->intval = data * 625 / 8;
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> -		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
> +		ret = max17042_get_avgvcell_uv(chip, &data);
>  		if (ret < 0)
>  			return ret;
> -
> -		val->intval = data * 625 / 8;
> +		val->intval = data;
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
>  		ret = regmap_read(map, MAX17042_OCVInternal, &data);
> @@ -350,14 +378,9 @@ static int max17042_get_property(struct power_supply *psy,
>  		val->intval = data64;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> -		ret = regmap_read(map, MAX17042_RepCap, &data);
> +		ret = max17042_get_repcap_uah(chip, &data64);
>  		if (ret < 0)
>  			return ret;
> -
> -		data64 = data * 5000000ll;
> -		data64 *= chip->task_period;
> -		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
> -		do_div(data64, chip->pdata->r_sns);
>  		val->intval = data64;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> @@ -370,6 +393,17 @@ static int max17042_get_property(struct power_supply *psy,
>  		data64 = div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
>  		val->intval = div_s64(data64, chip->pdata->r_sns);
>  		break;
> +	case POWER_SUPPLY_PROP_ENERGY_NOW:
> +		ret = max17042_get_repcap_uah(chip, &data64);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = max17042_get_avgvcell_uv(chip, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = data64 * data / 1000000;
> +		break;
>  	case POWER_SUPPLY_PROP_TEMP:
>  		ret = max17042_get_temperature(chip, &val->intval);
>  		if (ret < 0)
> 

