Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31D30C163
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883779; cv=none; b=HFXXCroBt6Xn+qpdTT8WsOoJYF3UeS+J5hu6TDjW1ceWS76G+D+6SD3y8k8IgQZLLls/4oYinz2pnHftdNVwn5I+dl0ykQ5ylNkEf/RgBWbwu4Yo3hZuraGUKiPCDMGYbFQzZAlxKVAVp+oj5NjaJ08xZPnPAZ69TlJ2SeTXuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883779; c=relaxed/simple;
	bh=rDH8B+QqgndpGE3qse8f/2bDTYp/j4uHy9m1Q2rSD20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGcf+5WI+CVcsbQJMqQBtvyQZWnj3/zGbuC7GP7Q+h8A8/+nBAgiHnD8YIkf6ZTAphUWDSemslT+hvjSwRwO4iVOdvEqminWnqadvb4sdXlvsgOmgls7mEmw0cOYsxWGlZTcz6rFFXZ47RrhvXut8YTq7UNIAlRRqaZTFwt6wYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OA078xnY; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA078xnY"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651bc83e74aso697802d50.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778883777; x=1779488577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5m7nm9/acQjAEPOHXxWuk1T8HUQRk5NC7/L7t4zgkds=;
        b=OA078xnY3CDSdzAvwGg+bjxKcVgDkkAGpYYnYGC3D++Pqb7HvX/XHleyqM9XGCLdL0
         cBx09u9gaftVwsOOwpEjWPNlNlsi2weSQ2doV6AmnVWgLQ99DvuTaa399chxxMEiR8JV
         q3RX2Da2Tx8WJII4YLCKqGW7ezdF1iC1ssIDWriwXXVQIHybvMkhJBOV4Bja5uaUiuDY
         mVUUX+0nXGfYJMvjHfZyFPBuBzs36TM4ZW+OlbfaxhQ9JfjEd0tW8xcg2XPSUHG5Wwt6
         ACXxc8W8AM0JnThXmMsf7a/thA3oSjuAPva2iKscDlD4K964eSjnyWILPshtg62ni8ZB
         q+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883777; x=1779488577;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m7nm9/acQjAEPOHXxWuk1T8HUQRk5NC7/L7t4zgkds=;
        b=TPYQC7K1GSjo/pbjG7YPoLTaGM0d1AoZp+Dz0fENcugMP6k52h+8euDnpEjAGiqAfg
         /F+mI52392yWlIK6/6huntG60sWKoV97J4v/36veqYlapB2rUF008IX61GAs+t/qyeH3
         PdpJYis5+xrC5t14eH9cO7YGmbDuUCAOt/BNjTvT1W82YF6LjUCWoojVjAF52OWQo0FE
         lP20u9V94wX0BSY8mQucrSObhPA3DEUNdOl2SYPovzrjK5TNwzIHOgtaC99wliGQ00cf
         ubr6KTkYmWsloCWM6ajcjPUz4pYiaqp7ekBMTysVCWo0kX4LHYf6Jzr+CRHTvyRX29F6
         cjoA==
X-Gm-Message-State: AOJu0YzX+UYSYca5dXlxtbvwo9mtS4PSxMWG+8sGhxnVgKiMGFg6YW2C
	TXgxKA5kkckGSKH15UqVxOk2K5XSPGg3bLyltoZ6qfQzyR+lsJLHSxK99XWeSkpCKQ==
X-Gm-Gg: Acq92OEuKhliNg5poM5BLRevOYvCf+L1BkBm1no+9bchzyqf3YmHz83rv2LGGHe+8O7
	jbD3LEwnd8S+ZlJwztZEXxF7wl36MucdxXk3J8rrGalusS67VhdvT0Ku7o67abrXHIpRYkhQq8o
	JtRrmnl6dKqPZeD6fPD4qFCb66zB4aifccRh3NAarh5D9jgor+6xgjJyXuFJ4Vq45xDAsa8B+Hv
	Us3BoMisfKKzmTjbaNQ0CCd77NPV69R5e0+ZBi72bCYILLzbXeq6c+fP7EOlNE6pXGLgq5bbUIz
	R+1dz3hNmhPcrM4vRv48RIGQszm7yi36oOQlGlwT0d8m/NVbWZkQhraT3rr5UigIFIQ3sy77ubl
	7SJ3tTfkwmVA5i6rs7efiplwevcDscsc3SXPSsKzN4mOG0gzaQJ1oc7yPCCuqP6VKXDWgdFeaoG
	jr0bYCSGx1fy4eiX393cV69iF3IvFjHDBHQz7ByCAPY/6lKNPFhqYBJ8P4Ks08X9Q+Ho2p7QMyF
	eXvotjZFg==
X-Received: by 2002:a05:690e:4403:b0:65c:2738:c687 with SMTP id 956f58d0204a3-65e2270ef58mr4744685d50.21.1778883776819;
        Fri, 15 May 2026 15:22:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:9ee1:b971:dc61:3e74? ([2600:1700:4570:89a0:9ee1:b971:dc61:3e74])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbcda4bsm3144803d50.18.2026.05.15.15.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:22:56 -0700 (PDT)
Message-ID: <14fa7e1b-89e8-498f-90ea-f82586c5d6b9@google.com>
Date: Fri, 15 May 2026 15:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: supply: max17042: add handler for energy_now
 property
To: Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>,
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
 <17f49974-1f39-4b4c-8577-da33da7f1cc4@kernel.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <17f49974-1f39-4b4c-8577-da33da7f1cc4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hans,

Thanks for the review.

On 5/15/26 12:25 AM, Hans de Goede wrote:
> Hi,
>
> On 15-May-26 07:48, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add handler to report power_supply_prop_energy_now so that users can get
>> current SoC in uWH. Additionally, add helper functions to get avg_vcell
>> and repcap values in uv and uah units respectively to avoid code
>> duplication.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> NACK for multiple reasons:
>
> 1. We don't want to do this in all drivers which only support
> charge_now and not energy_now, instead the TCPM driver should
> convert charge_now to energy_now when necessary itself so that
> the TCPM code will work with all battery type power-supply drivers
> not just those which provide energy_now.

Got it. I will pivot and update the TCPM driver to fetch charge_now and
a voltage property (voltage_avg) from the battery power supply,
performing the energy_now calculation locally.


>
> 2. Having energy_now without energy_full is problematic and will
> confuse userspace which prefers energy_* over charge_* since
> userspace will now miss a reference value for full to report
> a charging progress percentage. I also wonder how this works
> on the TCPM side does the  Battery Status response message not
> have a full value / percentage ?

Only the present state of charge of the battery (in units of 0.1Wh) is
sent out to the port partner as part of Battery Status response message
per USB PD spec.

`energy_full` and `energy_full_design` are sent out as part of Battery
Capacity response message. I plan to send out the patches to support
Batt Caps soon.


>
> 3. IIRC userspace (upower) picks either energy_* or charge_*
> values depending on which are present. I'm not sure if having
> both will not confuse userspace. As mentioned in 2. having both
> while one of them has an incomplete set of properties is sure
> to confuse userspace.

I see.


I will drop this patch for now.


Thanks,

Amit


>
> Regards,
>
> Hans
>
>
>
>
>
>> ---
>>  drivers/power/supply/max17042_battery.c | 60 ++++++++++++++++++++++++++-------
>>  1 file changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>> index 167fb3fb3732..e16eb6985b70 100644
>> --- a/drivers/power/supply/max17042_battery.c
>> +++ b/drivers/power/supply/max17042_battery.c
>> @@ -81,6 +81,7 @@ static enum power_supply_property max17042_battery_props[] = {
>>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>> +	POWER_SUPPLY_PROP_ENERGY_NOW,
>>  	POWER_SUPPLY_PROP_TEMP,
>>  	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
>>  	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>> @@ -95,6 +96,36 @@ static enum power_supply_property max17042_battery_props[] = {
>>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>>  };
>>  
>> +static int max17042_get_repcap_uah(struct max17042_chip *chip, u64 *rep_cap)
>> +{
>> +	u32 data;
>> +	int ret;
>> +
>> +	ret = regmap_read(chip->regmap, MAX17042_RepCap, &data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*rep_cap = data * 5000000ll;
>> +	*rep_cap *= chip->task_period;
>> +	do_div(*rep_cap, MAX17042_DEFAULT_TASK_PERIOD);
>> +	do_div(*rep_cap, chip->pdata->r_sns);
>> +
>> +	return 0;
>> +}
>> +
>> +static int max17042_get_avgvcell_uv(struct max17042_chip *chip, u32 *vcell)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, vcell);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*vcell = (*vcell * 625) / 8;
>> +
>> +	return 0;
>> +}
>> +
>>  static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
>>  {
>>  	int ret;
>> @@ -180,14 +211,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
>>  	int temp, vavg, vbatt, ret;
>>  	u32 val;
>>  
>> -	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, &val);
>> +	ret = max17042_get_avgvcell_uv(chip, &val);
>>  	if (ret < 0)
>>  		goto health_error;
>>  
>> -	/* bits [0-3] unused */
>> -	vavg = val * 625 / 8;
>>  	/* Convert to millivolts */
>> -	vavg /= 1000;
>> +	vavg = val / 1000;
>>  
>>  	ret = regmap_read(chip->regmap, MAX17042_VCELL, &val);
>>  	if (ret < 0)
>> @@ -304,11 +333,10 @@ static int max17042_get_property(struct power_supply *psy,
>>  		val->intval = data * 625 / 8;
>>  		break;
>>  	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
>> -		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
>> +		ret = max17042_get_avgvcell_uv(chip, &data);
>>  		if (ret < 0)
>>  			return ret;
>> -
>> -		val->intval = data * 625 / 8;
>> +		val->intval = data;
>>  		break;
>>  	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
>>  		ret = regmap_read(map, MAX17042_OCVInternal, &data);
>> @@ -350,14 +378,9 @@ static int max17042_get_property(struct power_supply *psy,
>>  		val->intval = data64;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
>> -		ret = regmap_read(map, MAX17042_RepCap, &data);
>> +		ret = max17042_get_repcap_uah(chip, &data64);
>>  		if (ret < 0)
>>  			return ret;
>> -
>> -		data64 = data * 5000000ll;
>> -		data64 *= chip->task_period;
>> -		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
>> -		do_div(data64, chip->pdata->r_sns);
>>  		val->intval = data64;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>> @@ -370,6 +393,17 @@ static int max17042_get_property(struct power_supply *psy,
>>  		data64 = div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
>>  		val->intval = div_s64(data64, chip->pdata->r_sns);
>>  		break;
>> +	case POWER_SUPPLY_PROP_ENERGY_NOW:
>> +		ret = max17042_get_repcap_uah(chip, &data64);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = max17042_get_avgvcell_uv(chip, &data);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = data64 * data / 1000000;
>> +		break;
>>  	case POWER_SUPPLY_PROP_TEMP:
>>  		ret = max17042_get_temperature(chip, &val->intval);
>>  		if (ret < 0)
>>
