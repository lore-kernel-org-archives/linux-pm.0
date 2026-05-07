Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA73CF05E;
	Thu,  7 May 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148144; cv=none; b=FHCdpu6vK4ludU6ssJk64C1QlW4QOKYGcd+QShrQBe6LVfM+QOZVWoRYI8A1Gfw3ieP9pN3ZPZzTCZeVIZ8GyKP+txfvDu3I/Oz0DWC6jaJrELf0+7L6PTZB6y+9Fkp0iF1KQ2hdxkKcY1kTwnwJFJXcWqvppEw6LlhwQbMk1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148144; c=relaxed/simple;
	bh=j/IEEiLS0P881qaC5FiyBW62HgEJkePONUiFsmT1P5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PifOob/W/wMD63IONXoPMHzZXMCeTwgiSZBBAyInUEg07yC9xMMvEX8+MQ8Z1EQv7cEkvXX66hCJ6ejZ/Umpw1XHL0f18LXCXccl1yD5p9bC5QmwqL1/ne3KxtCfwm77j2cfclJ2s3WdhE6Zy2eU5boD+WgBnBZpYjOwTVzl0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qSGz8AuL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qSGz8AuL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C341476;
	Thu,  7 May 2026 03:02:11 -0700 (PDT)
Received: from [10.57.21.243] (unknown [10.57.21.243])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A68D3F763;
	Thu,  7 May 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778148136; bh=j/IEEiLS0P881qaC5FiyBW62HgEJkePONUiFsmT1P5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSGz8AuL+k3oFTOmy0quS6KmrVyRoCxNFAxDaXr3Hgs1wiNiD+SkhuhRfuGt26X7B
	 EIKwezDs3db9f015SDCE3MetozyUMKfsJk2+IZmGy+CEeOlbBIqkht6IHrKIUDQDYJ
	 feJZbNJKNwTCIRv2sJZ2XLiYCcE6CN7TW1OKuzUE=
Message-ID: <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
Date: Thu, 7 May 2026 11:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 5/5/26 15:44, Daniel Lezcano wrote:
> In preparation for the upcoming changes separating OF and non-OF code,
> split __thermal_cooling_device_register() into allocation and addition
> phases.
> 
> This allows moving the device node assignment out of the core
> initialization path.
> 
> This change is not a trivial split. The lifetime of the cooling device
> is managed by the device core through put_device(), which triggers
> thermal_release() to free all associated resources.
> 
> With the introduction of thermal_cooling_device_alloc(), the allocation
> path must mirror what thermal_release() undoes. In contrast,
> thermal_cooling_device_add() must not perform any rollback and relies
> on put_device() for cleanup on error paths. This avoids both double
> free and resource leaks.
> 
> As part of this rework, add the missing device_initialize() call when
> allocating the cooling device.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 117 ++++++++++++++++++++-------------
>   1 file changed, 73 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 664a4cc95199..fd4c61197d1e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1040,29 +1040,10 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
>   		thermal_zone_cdev_bind(tz, cdev);
>   }
>   
> -/**
> - * __thermal_cooling_device_register() - register a new thermal cooling device
> - * @np:		a pointer to a device tree node.
> - * @type:	the thermal cooling device type.
> - * @devdata:	device private data.
> - * @ops:	standard thermal cooling devices callbacks.
> - *
> - * This interface function adds a new thermal cooling device (fan/processor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> - * to all the thermal zone devices registered at the same time.
> - * It also gives the opportunity to link the cooling device to a device tree
> - * node, so that it can be bound to a thermal zone created out of device tree.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
>   static struct thermal_cooling_device *
> -__thermal_cooling_device_register(struct device_node *np,
> -				  const char *type, void *devdata,
> -				  const struct thermal_cooling_device_ops *ops)
> +thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
> -	unsigned long current_state;
>   	int ret;
>   
>   	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> @@ -1076,6 +1057,8 @@ __thermal_cooling_device_register(struct device_node *np,
>   	if (!cdev)
>   		return ERR_PTR(-ENOMEM);
>   
> +	cdev->ops = ops;
> +
>   	ret = ida_alloc(&thermal_cdev_ida, GFP_KERNEL);
>   	if (ret < 0)
>   		goto out_kfree_cdev;
> @@ -1087,17 +1070,36 @@ __thermal_cooling_device_register(struct device_node *np,
>   		goto out_ida_remove;
>   	}
>   
> +	return cdev;
> +
> +out_ida_remove:
> +	ida_free(&thermal_cdev_ida, cdev->id);
> +out_kfree_cdev:
> +	kfree(cdev);
> +	return ERR_PTR(ret);
> +}
> +
> +static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
> +{
> +	unsigned long current_state;
> +	int ret;
> +
>   	mutex_init(&cdev->lock);
>   	INIT_LIST_HEAD(&cdev->thermal_instances);
> -	cdev->np = np;
> -	cdev->ops = ops;
>   	cdev->updated = false;
>   	cdev->device.class = &thermal_class;
> +	device_initialize(&cdev->device);
>   	cdev->devdata = devdata;
>   
> +	thermal_cooling_device_setup_sysfs(cdev);
> +
> +	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> +	if (ret)

In case of error here, when the cdev->device won't have this name,
would thermal_release() still be able to call the cleanup
for the sysfs bits?
IMHO the check 'if()' there might bite us and we might not free
the sysfs allocated memory.


> +		goto out_put_device;
> +
>   	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
>   	if (ret)
> -		goto out_cdev_type;
> +		goto out_put_device;
>   
>   	/*
>   	 * The cooling device's current state is only needed for debug
> @@ -1111,35 +1113,62 @@ __thermal_cooling_device_register(struct device_node *np,
>   	if (ret)
>   		current_state = ULONG_MAX;
>   
> -	thermal_cooling_device_setup_sysfs(cdev);
> -
> -	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -	if (ret)

In this current code case, we explicitly call the
thermal_cooling_device_destroy_sysfs() which will definitely clean-up
all stuff.


> -		goto out_cooling_dev;
> -
>   	ret = device_register(&cdev->device);
> -	if (ret) {
> -		/* thermal_release() handles rest of the cleanup */
> -		put_device(&cdev->device);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		goto out_put_device;
>   
>   	if (current_state <= cdev->max_state)
>   		thermal_debug_cdev_add(cdev, current_state);
>   
>   	thermal_cooling_device_init_complete(cdev);
>   
> -	return cdev;
> +	return 0;
>   
> -out_cooling_dev:
> -	thermal_cooling_device_destroy_sysfs(cdev);
> -out_cdev_type:
> -	kfree_const(cdev->type);
> -out_ida_remove:
> -	ida_free(&thermal_cdev_ida, cdev->id);
> -out_kfree_cdev:
> -	kfree(cdev);
> -	return ERR_PTR(ret);
> +out_put_device:
> +	/*
> +	 * The device core will release the memory via
> +	 * thermal_release() after put_device() is called in the error
> +	 * path
> +	 */
> +	put_device(&cdev->device);
> +	return ret;
> +}
> +
> +/**
> + * __thermal_cooling_device_register() - register a new thermal cooling device
> + * @np:		a pointer to a device tree node.
> + * @type:	the thermal cooling device type.
> + * @devdata:	device private data.
> + * @ops:	standard thermal cooling devices callbacks.
> + *
> + * This interface function adds a new thermal cooling device (fan/processor/...)
> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> + * to all the thermal zone devices registered at the same time.
> + * It also gives the opportunity to link the cooling device to a device tree
> + * node, so that it can be bound to a thermal zone created out of device tree.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +static struct thermal_cooling_device *
> +__thermal_cooling_device_register(struct device_node *np,
> +				  const char *type, void *devdata,
> +				  const struct thermal_cooling_device_ops *ops)
> +{
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	cdev = thermal_cooling_device_alloc(type, ops);
> +	if (IS_ERR(cdev))
> +		return cdev;
> +
> +	cdev->np = np;
> +
> +	ret = thermal_cooling_device_add(cdev, devdata);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return cdev;
>   }
>   
>   /**

The rest looks OK

Regards,
Lukasz

