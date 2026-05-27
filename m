Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0577396579;
	Wed, 27 May 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875576; cv=none; b=UfIDVHw3BuChyMINjPXwnr6nD7FmCuUHOhHlWfQq9GwxQaRxPjLmf8y8wTbZRxpCxD71lTt+jqlZ7KvYpHPS5kJa0+yOm+u3Pdbc46T3vDk62aNJJ8f8wAdfWlkcs//OWBZ82omiyCnURb+9yuU7T7g0r1EtRwP/qCBSwlb22eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875576; c=relaxed/simple;
	bh=yW/IQw++XLRR/CzMzjAfkfnR8Kxglizdpzl8dv8jzWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/Fqu9i5wJkI/hEcxbnHZawmC9ascgM+xjpG51CgeJt7TSTVeh2mFgnWFXNowfx1/npud+RC9a1MrzbA1etLNbhEz0T1rVmAhA9k9lsNJUn1NaQ5KH6xyTg45+GEO3AjAVvd3lJnfAosAEemuDTZPlJy9Ijp4M0Xnv1eCzo1L+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQEvmrtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQEvmrtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE521F000E9;
	Wed, 27 May 2026 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779875574;
	bh=xpicSIcdbRhMqvRSlfdrldSbJ0CuDgnbN5bHk5btR/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LQEvmrtYip53xWNPKa/Whmxwlm3VB0QUSV2IBsngQMSGy5bf7NoQ3y61LVPgeFmKP
	 AogLUEfYFZOH+A7OzWYq+DJJh0LgEKlUoY7Md8Y02X+H5uw3BSX/6H85GSWyEWA2Is
	 s+QxOHYv511DmVx5GGfSEikzJGnbZoR4MdV23nnZdvNYv+u3n/SwMiXaW45LF1kRfP
	 6kXQV0NI+79s57HwNqSZa8j4gQp8KK0tVTerL3v4F/TJpgG7uuh4X7jMeUP+HPZCas
	 bV/x2XMi7XcXiB5VxNf7xNc8r9qws5tDXnMiCqHFVRnfPyIYROlV8Nub4lNzWq62sr
	 ta4RCLhU1lR8w==
Message-ID: <6f53fb78-ec28-4765-be66-0d6abd022216@kernel.org>
Date: Wed, 27 May 2026 11:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] power: supply: Add helpers to get and put arrays
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
References: <20260527-batt-status-v2-0-4282985165f3@google.com>
 <20260527-batt-status-v2-1-4282985165f3@google.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260527-batt-status-v2-1-4282985165f3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for the new version.

On 27-May-26 02:02, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add power_supply_get_battery_all() to allow drivers to obtain a list of
> registered battery type power supply references in the system. Also add
> power_supply_put_array() to release references to the power supplies
> when no longer needed.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/power/supply/power_supply_core.c | 137 +++++++++++++++++++++++++++++++
>  include/linux/power_supply.h             |  12 +++
>  2 files changed, 149 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index a446d3d086fc..04e5c1083e8f 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -482,6 +482,127 @@ struct power_supply *power_supply_get_by_name(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_by_name);
>  
> +static int __power_supply_get_num_battery(struct power_supply *epsy, void *data)
> +{
> +	int *count = data;
> +
> +	if (epsy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
> +		(*count)++;
> +
> +	return 0;
> +}
> +
> +static int power_supply_get_num_battery(struct device *dev)
> +{
> +	int ret, count = 0;
> +
> +	ret = power_supply_for_each_psy(&count, __power_supply_get_num_battery);
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
> +static int __power_supply_populate_battery_array(struct power_supply *epsy,
> +						 void *_data)
> +{
> +	struct psy_get_supplies_data *data = _data;
> +
> +	if (epsy->desc->type == POWER_SUPPLY_TYPE_BATTERY) {
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
> +static int power_supply_populate_battery_array(struct device *dev, int size,
> +					       struct power_supply **batteries)
> +{
> +	int ret;
> +
> +	struct psy_get_supplies_data data = {
> +		.cnt = 0,
> +		.size = size,
> +		.psys = batteries,
> +	};
> +
> +	ret = power_supply_for_each_psy(&data, __power_supply_populate_battery_array);
> +
> +	dev_dbg(dev, "%s Found %d batteries with array size %d ret %d\n",
> +		__func__, data.cnt, data.size, ret);
> +
> +	if (ret < 0) {
> +		power_supply_put_array(batteries, data.cnt);
> +		return ret;
> +	}
> +
> +	return data.cnt;
> +}
> +
> +/**
> + * power_supply_get_battery_all() - Fetches references to all battery type power
> + *                                  supplies.
> + * @dev: Pointer to device requesting the power supply refs.
> + * @psys: Pointer to an array of power supply refs.
> + *
> + * Helper function to get handles to all battery type power supplies.
> + * If acquiring a ref to a power supply fails, then the search for battery
> + * type power supplies will abort and the acquired power supply references will
> + * be released.
> + *
> + * Return: Indicates the number of battery type power supplies returned on
> + * success or a negative error code on failure.
> + *
> + * The caller should invoke power_supply_put_array() on the returned array
> + * of psy refs and free the array returned by this function using kfree()
> + * after use.
> + */
> +int __must_check power_supply_get_battery_all(struct device *dev,
> +					      struct power_supply ***psys)
> +{
> +	int ret;
> +
> +	if (!psys)
> +		return -EINVAL;
> +
> +	ret = power_supply_get_num_battery(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!ret) {
> +		*psys = NULL;
> +		return 0;
> +	}
> +
> +	*psys = kzalloc_objs(**psys, ret);
> +	if (!*psys)
> +		return -ENOMEM;
> +
> +	ret = power_supply_populate_battery_array(dev, ret, *psys);
> +	if (ret <= 0) {
> +		kfree(*psys);
> +		*psys = NULL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_battery_all);
> +
>  /**
>   * power_supply_put() - Drop reference obtained with power_supply_get_by_name
>   * @psy: Reference to put
> @@ -496,6 +617,22 @@ void power_supply_put(struct power_supply *psy)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put);
>  
> +/**
> + * power_supply_put_array() - Drop references to an array of power supplies.
> + * @psys: Array of power supply references to put.
> + * @count: Number of elements in the array.
> + */
> +void power_supply_put_array(struct power_supply **psys, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (psys[i])
> +			power_supply_put(psys[i]);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(power_supply_put_array);
> +

I think it would be better to call this: power_supply_put_battery_all()
and move it to directly below power_supply_get_battery_all()and also
have it call kfree(psys) so that it does all the teardown of what
power_supply_get_battery_all() has done.

Regards,

Hans



>  static int power_supply_match_device_fwnode(struct device *dev, const void *data)
>  {
>  	return dev->parent && dev_fwnode(dev->parent) == data;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 7a5e4c3242a0..026412164a88 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -806,11 +806,23 @@ extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern struct power_supply *power_supply_get_by_name(const char *name);
> +extern int __must_check power_supply_get_battery_all(struct device *dev,
> +						     struct power_supply ***psys);
> +extern void power_supply_put_array(struct power_supply **psys, int count);
>  extern void power_supply_put(struct power_supply *psy);
>  #else
>  static inline void power_supply_put(struct power_supply *psy) {}
>  static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }
> +static inline int __must_check power_supply_get_battery_all(struct device *dev,
> +							    struct power_supply ***psys)
> +{
> +	if (psys)
> +		*psys = NULL;
> +	return 0;
> +}
> +
> +static inline void power_supply_put_array(struct power_supply **psys, int count) {}
>  #endif
>  extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
>  							  const char *property);
> 

