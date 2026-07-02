Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07647DFB2;
	Thu,  2 Jul 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996133; cv=none; b=YBgMnMees8klbZB361eOufYP9a0fQXKfS3+e+UuyKdeKGlxQnjqnKsfewQqnM8UOX4BticG6bNgL5PMUHdxdrq3inJIR6YC1p5r1uBsOJum2eF11UnNd2hN9msSQb+W8Pyw1fUlq/V3rs4jEVPhbUI6lKLMXzypGRskWYAbjL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996133; c=relaxed/simple;
	bh=GhGY2uJlPlxapIVd2591Q8ZB/UGIi44eagOQNiP6pbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmVrNbE1VvflO7M00Jp10Xco+dOx6dRQ2v6/OccOqV6ieGsirRq4W/L81wRUL11eitGqjYXBLvzVXcdFsp4RNOHM2+om1FA+jatq51oG2h01eEy1znZILZQKT7F/lIcI5bKzXo1i4XEVXSOe9+rBySbxVWsVQ7z3pOrrZd5hyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmRB+8p/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmRB+8p/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CECD1F00A3A;
	Thu,  2 Jul 2026 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996132;
	bh=j4TUqQ9a83KckGoDbJG7Jsv1SNP3jjBNDc9CRHtia2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RmRB+8p/aHlHF6f+RB2xKZ9qKdJgmm+qVKRYbBQg5FDjh+u+1s8ySofHq0+fKn18N
	 WQ0wThJI1QeeZYSt1ETq+52XYa/sYcBrayKXF61sZldB6i3Smr/YCkh8LxObJnZaWn
	 hZ3s+8Zf0XhhL8AQKA7rlYJ2G0RQEKUUm76GyPbr+UHqoaIuPXkhO4ImFUBjsGYrbW
	 H+6h00k6LC8+iufOHZN4rBjMqDDchk6ikqW3q2m26wrsQ+L5ePXtpoQQFmLZYjPguC
	 On1gyRYkVqOHTLXSU1B6Q1eR6qyQChbsPTKRNenT06TSfZ0vVvQ8XNXSalFOMywZOj
	 CqsqulV1Mwupw==
Message-ID: <9bbe1461-a731-4cbc-89db-2ff0866bd3d7@kernel.org>
Date: Thu, 2 Jul 2026 14:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] power: supply: Add helpers to get and put arrays
 of power supply handles
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
References: <20260701-batt-status-v4-0-a31d97b1ae57@google.com>
 <20260701-batt-status-v4-1-a31d97b1ae57@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20260701-batt-status-v4-1-a31d97b1ae57@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1-Jul-26 02:34, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add power_supply_get_system_batteries() to allow drivers to obtain
> a list of registered battery type power supply references in the
> system. Also add power_supply_put_system_batteries() to perform
> cleanup after the former function is called.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_core.c | 153 +++++++++++++++++++++++++++++++
>  include/linux/power_supply.h             |  15 +++
>  2 files changed, 168 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 2532e221b2e1..70f35f64cc72 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -477,6 +477,159 @@ struct power_supply *power_supply_get_by_name(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_by_name);
>  
> +static bool power_supply_is_system_battery(struct power_supply *psy)
> +{
> +	union power_supply_propval val;
> +
> +	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
> +		return false;
> +
> +	if (!power_supply_get_property_direct(psy, POWER_SUPPLY_PROP_SCOPE,
> +					      &val))
> +		if (val.intval == POWER_SUPPLY_SCOPE_DEVICE)
> +			return false;
> +
> +	return true;
> +}
> +
> +static int __power_supply_get_num_system_batteries(struct power_supply *epsy,
> +						   void *data)
> +{
> +	int *count = data;
> +
> +	if (power_supply_is_system_battery(epsy))
> +		(*count)++;
> +
> +	return 0;
> +}
> +
> +static int power_supply_get_num_system_batteries(struct device *dev)
> +{
> +	int ret, count = 0;
> +
> +	ret = power_supply_for_each_psy(&count,
> +					__power_supply_get_num_system_batteries);
> +
> +	dev_dbg(dev, "%s: count: %d ret %d\n", __func__, count, ret);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +struct psy_get_supplies_data {
> +	int cnt;
> +	int size;
> +	struct power_supply **psys;
> +};
> +
> +static int
> +__power_supply_populate_system_batteries_array(struct power_supply *epsy,
> +					       void *_data)
> +{
> +	struct psy_get_supplies_data *data = _data;
> +
> +	if (power_supply_is_system_battery(epsy)) {
> +		if (data->size <= data->cnt)
> +			return -EOVERFLOW;
> +
> +		get_device(&epsy->dev);
> +		data->psys[data->cnt] = epsy;
> +		atomic_inc(&epsy->use_cnt);
> +		data->cnt++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +power_supply_populate_system_batteries_array(struct device *dev, int size,
> +					     struct power_supply **batteries)
> +{
> +	int ret;
> +
> +	struct psy_get_supplies_data data = {
> +		.cnt = 0,
> +		.size = size,
> +		.psys = batteries,
> +	};
> +
> +	ret = power_supply_for_each_psy(&data,
> +					__power_supply_populate_system_batteries_array);
> +
> +	dev_dbg(dev, "%s Found %d batteries with array size %d ret %d\n",
> +		__func__, data.cnt, data.size, ret);
> +
> +	if (ret < 0 || !data.cnt) {
> +		power_supply_put_system_batteries(batteries, data.cnt);
> +		return ret;
> +	}
> +
> +	return data.cnt;
> +}
> +
> +/**
> + * power_supply_get_system_batteries() - Fetches references to battery type
> + *                                       power supplies in the system.
> + * @dev: Pointer to device requesting the power supply refs.
> + * @psys: Pointer to an array of power supply refs.
> + *
> + * Helper function to get handles to battery type power supplies in the system.
> + * If acquiring a ref to a power supply fails, then the search for battery type
> + * power supplies will abort and the acquired power supply references will be
> + * released.
> + *
> + * Return: Indicates the number of battery type power supplies returned on
> + * success or a negative error code on failure.
> + *
> + * Call power_supply_put_system_batteries() after use to cleanup resources.
> + */
> +int __must_check power_supply_get_system_batteries(struct device *dev,
> +						   struct power_supply ***psys)
> +{
> +	int ret;
> +
> +	if (!psys)
> +		return -EINVAL;
> +
> +	ret = power_supply_get_num_system_batteries(dev);
> +	if (ret <= 0) {
> +		*psys = NULL;
> +		return ret;
> +	}
> +
> +	*psys = kzalloc_objs(**psys, ret);
> +	if (!*psys)
> +		return -ENOMEM;
> +
> +	ret = power_supply_populate_system_batteries_array(dev, ret, *psys);
> +	if (ret <= 0)
> +		*psys = NULL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_system_batteries);
> +
> +/**
> + * power_supply_put_system_batteries() - Cleanup resources allocated by
> + *                                       power_supply_get_system_batteries()
> + * @psys: Array of power supply references to release and free.
> + * @count: Number of elements in the array.
> + */
> +void power_supply_put_system_batteries(struct power_supply **psys, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (psys[i])
> +			power_supply_put(psys[i]);
> +	}
> +
> +	kfree(psys);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_put_system_batteries);
> +
>  /**
>   * power_supply_put() - Drop reference obtained with power_supply_get_by_name
>   * @psy: Reference to put
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 7a5e4c3242a0..9167a33d074b 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -806,11 +806,26 @@ extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern struct power_supply *power_supply_get_by_name(const char *name);
> +extern int __must_check power_supply_get_system_batteries(struct device *dev,
> +							  struct power_supply ***psys);
> +extern void power_supply_put_system_batteries(struct power_supply **psys, int count);
>  extern void power_supply_put(struct power_supply *psy);
>  #else
>  static inline void power_supply_put(struct power_supply *psy) {}
>  static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }
> +static inline int __must_check power_supply_get_system_batteries(struct device *dev,
> +								 struct power_supply ***psys)
> +{
> +	if (psys)
> +		*psys = NULL;
> +	return 0;
> +}
> +
> +static inline void power_supply_put_system_batteries(struct power_supply **psys,
> +						     int count)
> +{
> +}
>  #endif
>  extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
>  							  const char *property);
> 

