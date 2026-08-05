Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05A3DDAF5;
	Wed,  5 Aug 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926414; cv=none; b=tJp5AXniAF+klPdWKDaOBBnvZmUfKcUadQABG875sOQoRfCR80m38066aUE5s5NZWTDbxD8LRBzG2jYgcYwVgdI7FhiDm3dAdLvgfGi0Az8dVP/4/O+FiQJAC7uRrXpgNwRa2Ja0l5JwsJqEKpoLLYA7gaOGiumSChzpHWSFxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926414; c=relaxed/simple;
	bh=6/Rhk50mKs3YfYiFaxRNfa6gCCxZ3jsvA3oB53Vz0nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToyRAJWDGApPe4NNntkiwDycCe7dvV1JmeN6Quj8DBe/yL2g8EuH+JMepPVUXRR82g0tEUuNaYWQmu0QC8MHl/oT7QNqDgszXv0CzDJ7wofHTP/LlglXhkPZ0h7QxZhRvpYguOX7X7dauTrvBWVbD0PEzJh0eN0uDI5E+nqder8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YxDwtNuI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YxDwtNuI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA894153B;
	Wed,  5 Aug 2026 03:40:07 -0700 (PDT)
Received: from [10.57.0.192] (unknown [10.57.0.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705DE3F632;
	Wed,  5 Aug 2026 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785926411; bh=6/Rhk50mKs3YfYiFaxRNfa6gCCxZ3jsvA3oB53Vz0nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YxDwtNuI70mNsGc7I86Ug9QyIAjNpNB2JXruDq2b6tSmT2YM0hsAxJK+10qZ+Lsdg
	 8n5oeRZBFH7LDQ8Q2u1dJIQzUJSA67uTH+ar82O0gpdEz5E3GDPm3pHA+Uj3QwvpK/
	 kYSQoEjAHOJH2KJ98LrJ6PY3NWPTCbfCb36E5f2E=
Message-ID: <79695a25-9e49-4a8d-8d74-89d64a838a86@arm.com>
Date: Wed, 5 Aug 2026 11:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: hwmon: Remove hwmon class device along
 with its parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <12947893.O9o76ZdvQC@rafael.j.wysocki>
 <5094738.GXAFRqVoOG@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5094738.GXAFRqVoOG@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/26 21:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code creates one hwmon device per thermal zone type and that
> device is registered under the first thermal zone of the given type.
> 
> That turns out to be problematic when the thermal zone holding the
> hwmon device is removed.
> 
> For example, say that there are two ACPI thermal zones on a system
> 
>   /sys/devices/virtual/thermal/thermal_zone0/
>   /sys/devices/virtual/thermal/thermal_zone1/
> 
> The current code registers a hwmon class device for thermal_zone0 only:
> 
>   /sys/devices/virtual/thermal/thermal_zone0/hwmon0/
> 
> because the type is "acpitz" for both of them, but it adds a sysfs
> attribute that belongs to thermal_zone1 under it:
> 
>   /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp2_input
> 
> There is also
> 
>   /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp1_input
> 
> which belongs to thermal_zone0.
> 
> When thermal_zone0 is removed, say because the ACPI thermal driver is
> unbound from the underlying platform device, thermal_remove_hwmon_sysfs()
> skips the removal of hwmon0 because of the temp2_input attribute
> belonging to thermal_zone1 which effectively prevents thermal_zone0
> removal from making progress.
> 
> Address this by making thermal_remove_hwmon_sysfs() remove the entire
> hwmon class device interface for the given thermal zone type when the
> thermal zone device holding it is removed.
> 
> To prevent races with thermal_add_hwmon_sysfs() that may interfere
> with this, carry out the entire addition and removal of hwmon sysfs
> interfaces for thermal zones under thermal_hwmon_list_lock.
> 
> Also adjust the layout of the labels in thermal_add_hwmon_sysfs() to
> the current kernel coding style to align with the new "unlock" label.
> 
> Link: https://lore.kernel.org/linux-pm/20260402021828.16556-1-liujia6264@gmail.com/
> Fixes: f6b6b52ef7a5 ("thermal_hwmon: Pass the originating device down to hwmon_device_register_with_info")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Rebase on top of the new [1/2]
> 
> ---
>   drivers/thermal/thermal_hwmon.c |   89 +++++++++++++++-------------------------
>   1 file changed, 35 insertions(+), 54 deletions(-)
> 
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -95,34 +95,12 @@ thermal_hwmon_lookup_by_type(const struc
>   	struct thermal_hwmon_device *hwmon;
>   	char type[THERMAL_NAME_LENGTH];
>   
> -	mutex_lock(&thermal_hwmon_list_lock);
>   	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
>   		strscpy(type, tz->type);
>   		strreplace(type, '-', '_');
> -		if (!strcmp(hwmon->type, type)) {
> -			mutex_unlock(&thermal_hwmon_list_lock);
> +		if (!strcmp(hwmon->type, type))
>   			return hwmon;
> -		}
>   	}
> -	mutex_unlock(&thermal_hwmon_list_lock);
> -
> -	return NULL;
> -}
> -
> -/* Find the temperature input matching a given thermal zone */
> -static struct thermal_hwmon_temp *
> -thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
> -			  const struct thermal_zone_device *tz)
> -{
> -	struct thermal_hwmon_temp *temp;
> -
> -	mutex_lock(&thermal_hwmon_list_lock);
> -	list_for_each_entry(temp, &hwmon->tz_list, hwmon_node)
> -		if (temp->tz == tz) {
> -			mutex_unlock(&thermal_hwmon_list_lock);
> -			return temp;
> -		}
> -	mutex_unlock(&thermal_hwmon_list_lock);
>   
>   	return NULL;
>   }
> @@ -138,7 +116,9 @@ int thermal_add_hwmon_sysfs(struct therm
>   	struct thermal_hwmon_device *hwmon;
>   	struct thermal_hwmon_temp *temp;
>   	int new_hwmon_device = 1;
> -	int result;
> +	int result = 0;
> +
> +	mutex_lock(&thermal_hwmon_list_lock);
>   
>   	hwmon = thermal_hwmon_lookup_by_type(tz);
>   	if (hwmon) {
> @@ -147,8 +127,10 @@ int thermal_add_hwmon_sysfs(struct therm
>   	}
>   
>   	hwmon = kzalloc_obj(*hwmon);
> -	if (!hwmon)
> -		return -ENOMEM;
> +	if (!hwmon) {
> +		result = -ENOMEM;
> +		goto unlock;
> +	}
>   
>   	INIT_LIST_HEAD(&hwmon->tz_list);
>   	strscpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> @@ -196,24 +178,24 @@ int thermal_add_hwmon_sysfs(struct therm
>   		temp->temp_crit_present = true;
>   	}
>   
> -	mutex_lock(&thermal_hwmon_list_lock);
>   	if (new_hwmon_device)
>   		list_add_tail(&hwmon->node, &thermal_hwmon_list);
>   	list_add_tail(&temp->hwmon_node, &hwmon->tz_list);
> -	mutex_unlock(&thermal_hwmon_list_lock);
>   
> -	return 0;
> +	goto unlock;
>   
> - unregister_input:
> +unregister_input:
>   	device_remove_file(hwmon->device, &temp->temp_input.attr);
> - free_temp_mem:
> +free_temp_mem:
>   	kfree(temp);
> - unregister_name:
> +unregister_name:
>   	if (new_hwmon_device)
>   		hwmon_device_unregister(hwmon->device);
> - free_mem:
> +free_mem:
>   	if (new_hwmon_device)
>   		kfree(hwmon);
> +unlock:
> +	mutex_unlock(&thermal_hwmon_list_lock);
>   
>   	return result;
>   }
> @@ -222,8 +204,11 @@ EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysf
>   
>   void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>   {
> +	struct thermal_hwmon_temp *temp, *entry;
>   	struct thermal_hwmon_device *hwmon;
> -	struct thermal_hwmon_temp *temp;
> +	bool unregister;
> +
> +	guard(mutex)(&thermal_hwmon_list_lock);
>   
>   	hwmon = thermal_hwmon_lookup_by_type(tz);
>   	if (unlikely(!hwmon)) {
> @@ -232,29 +217,25 @@ void thermal_remove_hwmon_sysfs(struct t
>   		return;
>   	}
>   
> -	temp = thermal_hwmon_lookup_temp(hwmon, tz);
> -	if (unlikely(!temp)) {
> -		/* Should never happen... */
> -		dev_dbg(&tz->device, "temperature input lookup failed!\n");
> -		return;
> -	}
> +	unregister = hwmon->device->parent == &tz->device;
>   
> -	device_remove_file(hwmon->device, &temp->temp_input.attr);
> -	if (temp->temp_crit_present)
> -		device_remove_file(hwmon->device, &temp->temp_crit.attr);
> +	list_for_each_entry_safe_reverse(temp, entry, &hwmon->tz_list, hwmon_node) {
> +		if (!unregister && temp->tz != tz)
> +			continue;
>   
> -	mutex_lock(&thermal_hwmon_list_lock);
> -	list_del(&temp->hwmon_node);
> -	kfree(temp);
> -	if (!list_empty(&hwmon->tz_list)) {
> -		mutex_unlock(&thermal_hwmon_list_lock);
> -		return;
> +		device_remove_file(hwmon->device, &temp->temp_input.attr);
> +		if (temp->temp_crit_present)
> +			device_remove_file(hwmon->device, &temp->temp_crit.attr);
> +
> +		list_del(&temp->hwmon_node);
> +		kfree(temp);
>   	}
> -	list_del(&hwmon->node);
> -	mutex_unlock(&thermal_hwmon_list_lock);
>   
> -	hwmon_device_unregister(hwmon->device);
> -	kfree(hwmon);
> +	if (unregister) {
> +		list_del(&hwmon->node);
> +		hwmon_device_unregister(hwmon->device);
> +		kfree(hwmon);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
>   
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

