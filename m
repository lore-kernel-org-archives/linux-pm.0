Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E83446AF;
	Wed, 13 May 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684590; cv=none; b=MNwUo4mLJvsEY2iSj488jsseGliLtyu0SUT/I/8hEuGqsHsbX8KJADVz0rchP+R44yvoXebGvQhvOqRYMuN7cEXudHXbZ+CVw1dZOmXDCEKIRfBYU0pVMaDKgJxBtCZtqF6aE0L62Sk2Xlb8RfN1QIPS+uikyDJbFgzLRaspfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684590; c=relaxed/simple;
	bh=xMuPJCoCLHDqAUMiT7JGZGh2lfp9ujufscwhYLu2UFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9ErHs4eJet6f8rC9rbw7T4AsrmX/ZMn201smOHV03AQ8Sg5XmSp3ZYD6iw6snVQjMlgc8eABAjuJqK92ak9sEWBqd8nlOXmx14W5+SP0N797PJ9hfbSK17BTpTbBVoZ3I6JnWOdZP1t+DG/SfXy8V1qvxd8PKlL6mctmBmyylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dv5IvH+v; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dv5IvH+v"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96AC21596;
	Wed, 13 May 2026 08:03:03 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E950E3F836;
	Wed, 13 May 2026 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778684588; bh=xMuPJCoCLHDqAUMiT7JGZGh2lfp9ujufscwhYLu2UFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dv5IvH+vB56JDZfqt3U283Lv3OXZUYXxazfkcFR/HJ9Ft/v96nMk5CpqTvhFBClh6
	 l59tFt/kNkr55xbgXOqY6dM6aY3g6T/ixs806GadLu0TSmoThe05WvDlyC5sfXCHC4
	 CfAeBVXd+hZwroryiukCaPjoMySNipLV6wh5c3VQ=
Message-ID: <ce6b0bcd-1b82-4607-a4ad-0a38bc8737c8@arm.com>
Date: Wed, 13 May 2026 16:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] thermal/core: Allocate the thermal class dynamically
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/26 19:05, Daniel Lezcano wrote:
> Use class_create() instead of a statically allocated struct class.
> 
> This allows the thermal class to be managed through a dynamically
> allocated class object and avoids keeping a static class instance
> around.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a79fc4cdb078..748ab76823a3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -949,9 +949,7 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>   	kfree(pos);
>   }
>   
> -static const struct class thermal_class = {
> -	.name = "thermal",
> -};
> +static struct class *thermal_class;
>   static bool thermal_class_unavailable __ro_after_init = true;
>   
>   static inline
> @@ -1078,7 +1076,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   	cdev->np = np;
>   	cdev->ops = ops;
>   	cdev->updated = false;
> -	cdev->device.class = &thermal_class;
> +	cdev->device.class = thermal_class;
>   	cdev->device.release = thermal_cdev_release;
>   	cdev->devdata = devdata;
>   
> @@ -1574,7 +1572,7 @@ thermal_zone_device_register_with_trips(const char *type,
>   	if (!tz->ops.critical)
>   		tz->ops.critical = thermal_zone_device_critical;
>   
> -	tz->device.class = &thermal_class;
> +	tz->device.class = thermal_class;
>   	tz->device.release = thermal_zone_device_release;
>   	tz->devdata = devdata;
>   	tz->num_trips = num_trips;
> @@ -1898,15 +1896,18 @@ static int __init thermal_init(void)
>   	if (result)
>   		goto destroy_workqueue;
>   
> -	result = class_register(&thermal_class);
> -	if (result)
> +	thermal_class = class_create("thermal");
> +	if (IS_ERR(thermal_class)) {
> +		result = PTR_ERR(thermal_class);
>   		goto unregister_governors;
> +	}
>   
>   	thermal_class_unavailable = false;
>   
>   	return 0;
>   
>   unregister_governors:
> +	thermal_class = NULL;
>   	thermal_unregister_governors();
>   destroy_workqueue:
>   	destroy_workqueue(thermal_wq);


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

