Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063D3446AF;
	Wed, 13 May 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684565; cv=none; b=W5TGtssgrK/tH1xnoQcHysKOXa1RbP+cH3cfgoDhV2eXb93VBaq2fGuE9DuRAeRlz+pWGEFnpsOXNVWR5FAvqQP98wAPAZE033Nhw727cyrm56Jtgo+oBXHrcFFR9uvbJoO3Wi3l6mI6b+WrE+8YC2piENxvf1UtVM0zriFc8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684565; c=relaxed/simple;
	bh=ohfdKCGY3wFH3kCGcKzZmVNCFqTzcb/xRRck1CKn0Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhE18py27pssg4demdQMnVnotPE4K9vY2tB8O/SB2DVmTlIL7KXXjYa3KhyM+XrC5t9sCuaJxgeFCZMouLw23/kUbHDFGNpjZk7IG/1tHNOVc7L922YusLsY4QRTFSX1cUdcNfXdG3JkFNNWX2F4Yf9C7mS4XZFEAElTPvZXzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V3sGiU7V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V3sGiU7V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399E81596;
	Wed, 13 May 2026 08:02:35 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DAD33F7B4;
	Wed, 13 May 2026 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778684560; bh=ohfdKCGY3wFH3kCGcKzZmVNCFqTzcb/xRRck1CKn0Ak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V3sGiU7V/9VoR745IrHqp6y7pc9DR+EE2XhyOl4g3yrC4KrXYqQzjIZslFhG8o1ba
	 6psVad/VkMCbD//DIzZKgw7fgbPCfr2orcAp/GkQFVm+htJCn+12cK3X3j4Fx1i77z
	 XExlHRyY6SUx6yEfh6lTix2Moj02LFCux0A7XCdI=
Message-ID: <0ecfc773-2df3-4433-a5cb-cf9f18e5b7e6@arm.com>
Date: Wed, 13 May 2026 16:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] thermal/core: Add dedicated release callback for
 cooling devices
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-2-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260508180511.1306659-2-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel

On 5/8/26 19:05, Daniel Lezcano wrote:
> The thermal class release callback currently handles both thermal
> zones and cooling devices by checking the device name prefix.
> 
> Move the cooling device cleanup to a dedicated struct device release
> callback.  This avoids relying on device names to select the release
> path and keeps the cooling device lifetime handling local to the
> cooling device object.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2f4e2dc46b8f..cf5d4a9c11fe 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -952,7 +952,6 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>   static void thermal_release(struct device *dev)
>   {
>   	struct thermal_zone_device *tz;
> -	struct thermal_cooling_device *cdev;
>   
>   	if (!strncmp(dev_name(dev), "thermal_zone",
>   		     sizeof("thermal_zone") - 1)) {
> @@ -962,13 +961,6 @@ static void thermal_release(struct device *dev)
>   		ida_destroy(&tz->ida);
>   		mutex_destroy(&tz->lock);
>   		complete(&tz->removal);
> -	} else if (!strncmp(dev_name(dev), "cooling_device",
> -			    sizeof("cooling_device") - 1)) {
> -		cdev = to_cooling_device(dev);
> -		thermal_cooling_device_destroy_sysfs(cdev);
> -		kfree_const(cdev->type);
> -		ida_free(&thermal_cdev_ida, cdev->id);
> -		kfree(cdev);
>   	}
>   }
>   
> @@ -1040,6 +1032,16 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
>   		thermal_zone_cdev_bind(tz, cdev);
>   }
>   
> +static void thermal_cdev_release(struct device *dev)
> +{
> +	struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +
> +	thermal_cooling_device_destroy_sysfs(cdev);
> +	kfree_const(cdev->type);
> +	ida_free(&thermal_cdev_ida, cdev->id);
> +	kfree(cdev);
> +}
> +
>   /**
>    * __thermal_cooling_device_register() - register a new thermal cooling device
>    * @np:		a pointer to a device tree node.
> @@ -1093,6 +1095,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   	cdev->ops = ops;
>   	cdev->updated = false;
>   	cdev->device.class = &thermal_class;
> +	cdev->device.release = thermal_cdev_release;
>   	cdev->devdata = devdata;
>   
>   	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);

I hope it's not too late to the party...

This looks good, we avoid the problem we discussed earlier.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

The whole patch set makes the things more clean.
It should be a good foundation for your next changes.
Thanks Daniel!

Regards,
Lukasz
