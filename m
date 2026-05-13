Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320D3845B0;
	Wed, 13 May 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684578; cv=none; b=c8uDKZEjLT2FfGVVFWRPeKI8G4WdA/J0TMKWRNSx0P/6ojypM/JFYmjTdVMbLhdMb+Cp5tSxlanlCvwQhQrMgWPZ6wzE2sTMD/crcLl1JsL4jaU4vptlW4NT4624rWaGcOBp+htyaPDCUUtUYKs+HLJTOHQPYZL0TXzAVyjQe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684578; c=relaxed/simple;
	bh=SzDI7PYtoBWY8ohRuW3Z1pDEpeCl0qk5ZniSz7W75J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYdZopHjWyXGCDYSx4HcbbFqqGIspp3sDC2sIMU+K9rIG9LQ+E+V/9BOl3t/owg6A5x9TBv4CmBG0JUnrF1a3Gnb6szxBk4Ylsyp0Ixku//hMzs2KA6XKglL1oVbWV7vXKOceMfSmFX70ifcarHLn6KspSthQ4XWWtv+MezN+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DrnAOqYZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DrnAOqYZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C74C21596;
	Wed, 13 May 2026 08:02:50 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47673F7B4;
	Wed, 13 May 2026 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778684576; bh=SzDI7PYtoBWY8ohRuW3Z1pDEpeCl0qk5ZniSz7W75J4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DrnAOqYZN6QWurJx/tc2+pFc0/Oe1QzcLtmzY+jNQvJ9ea/L768CIhEO7BOaJH4I/
	 /cfZ/LnNNkvCsCE+j1llcNg0ffU4u9cPex3Mqz5EhjLhYSdtgVQhkdmGyFZgsCp850
	 wRoxnI1zT46MaDLaj4/SQBml3N/zdGfCFOn2LC48=
Message-ID: <cdbc4fa5-53cb-4288-a3d6-6c53fce1c290@arm.com>
Date: Wed, 13 May 2026 16:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] thermal/core: Add dedicated release callback for
 thermal zones
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-3-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260508180511.1306659-3-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/26 19:05, Daniel Lezcano wrote:
> The thermal class release callback currently handles thermal zone
> cleanup by checking the device name prefix.
> 
> Move the thermal zone cleanup to a dedicated struct device release
> callback.  This avoids relying on device names to select the release
> path and keeps the thermal zone lifetime handling local to the thermal
> zone object.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cf5d4a9c11fe..a79fc4cdb078 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -949,24 +949,8 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>   	kfree(pos);
>   }
>   
> -static void thermal_release(struct device *dev)
> -{
> -	struct thermal_zone_device *tz;
> -
> -	if (!strncmp(dev_name(dev), "thermal_zone",
> -		     sizeof("thermal_zone") - 1)) {
> -		tz = to_thermal_zone(dev);
> -		thermal_zone_destroy_device_groups(tz);
> -		thermal_set_governor(tz, NULL);
> -		ida_destroy(&tz->ida);
> -		mutex_destroy(&tz->lock);
> -		complete(&tz->removal);
> -	}
> -}
> -
>   static const struct class thermal_class = {
>   	.name = "thermal",
> -	.dev_release = thermal_release,
>   };
>   static bool thermal_class_unavailable __ro_after_init = true;
>   
> @@ -1473,6 +1457,17 @@ static void thermal_zone_init_complete(struct thermal_zone_device *tz)
>   	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   }
>   
> +static void thermal_zone_device_release(struct device *dev)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +
> +	thermal_zone_destroy_device_groups(tz);
> +	thermal_set_governor(tz, NULL);
> +	ida_destroy(&tz->ida);
> +	mutex_destroy(&tz->lock);
> +	complete(&tz->removal);
> +}
> +
>   /**
>    * thermal_zone_device_register_with_trips() - register a new thermal zone device
>    * @type:	the thermal zone device type
> @@ -1580,6 +1575,7 @@ thermal_zone_device_register_with_trips(const char *type,
>   		tz->ops.critical = thermal_zone_device_critical;
>   
>   	tz->device.class = &thermal_class;
> +	tz->device.release = thermal_zone_device_release;
>   	tz->devdata = devdata;
>   	tz->num_trips = num_trips;
>   	for_each_trip_desc(tz, td) {

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
