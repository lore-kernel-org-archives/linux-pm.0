Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE532C3266;
	Fri, 29 May 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059317; cv=none; b=iUc53rfxAqVYhqrJuGK85yog/mC3LFTvSUxCZ2jJ7GILREk6au2tmexU1WTVR07yYscchiOzRi2Y3R9rije2K52eRrFBYGW9+9RV9sUnhKDz21KwQ4iktjwyHRIMBJp99TwTh6HZjC1qacZLVc9WQ0J+6htc3+aW2AAYxVBRqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059317; c=relaxed/simple;
	bh=aMp0yllWObmstKNJEaNK+etgKQ9OJ4QVq6gAFknPaig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thZCm9whvzUIlm+wbgWyofFy7hB8G4WaRuTSYaE6T6pLdsp1o347evGr/1QxpajHrTNbYnnGvX5O2BaD4A9YXkUM0ubxisUr30cg/gXPC6Nh86+1UpO6He1+3psw6ysc3VYkSBghU40sauZbK4yjePwx0HEA6ASJSE3moUAjgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lC7AyrSA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lC7AyrSA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F2C20E3;
	Fri, 29 May 2026 05:55:09 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FFF93F632;
	Fri, 29 May 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780059314; bh=aMp0yllWObmstKNJEaNK+etgKQ9OJ4QVq6gAFknPaig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lC7AyrSAhykfji09aSXHfZTW13bMR8/6/hfUypzeffVjWx8GcwsFOMMSUfWapE4BN
	 rDSdT6D+tARHW+TJaZMptNvRqxhu2ztQlgUvWHZ0XIAG6hce03If4P5o8VdoGDIjqU
	 kiCgMyyVZC/z/7tqDaFtlTgZuk5ZORHJTFe+iEkY=
Message-ID: <e22455bb-c59a-4de7-b8ba-09cb411bc3ed@arm.com>
Date: Fri, 29 May 2026 13:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] thermal/core: Add
 devm_thermal_cooling_device_register()
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <20260526140802.1059293-14-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-14-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> Introduce a device-managed variant of the non-OF cooling device
> registration API.
> 
> This complements devm_thermal_of_cooling_device_register() and allows
> non-device-tree users to register cooling devices with automatic
> cleanup tied to the device lifecycle.
> 
> The helper relies on devm_add_action_or_reset() to release the cooling
> device via thermal_cooling_device_release() on driver detach or probe
> failure.
> 
> This keeps the API consistent across OF and non-OF users and avoids
> manual cleanup in error paths.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 35 ++++++++++++++++++++++++++++++++++
>   include/linux/thermal.h        |  7 +++++--
>   2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 0b3db889d60d..bb4fc3ff2ad5 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1173,6 +1173,41 @@ devm_thermal_of_cooling_device_register(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
>   
> +/**
> + * devm_thermal_cooling_device_register() - register a thermal cooling device
> + *
> + * @dev:	a valid struct device pointer of a sensor device.
> + * @type:	the thermal cooling device type.
> + * @devdata:	device private data.
> + * @ops:	standard thermal cooling devices callbacks.
> + *
> + * This function will register a cooling device. This interface
> + * function adds a new thermal cooling device (fan/processor/...)  to
> + * /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind
> + * itself to all the thermal zone devices registered at the same time.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +struct thermal_cooling_device *
> +devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
> +				     const struct thermal_cooling_device_ops *ops)
> +{
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	cdev = thermal_cooling_device_register(type, devdata, ops);
> +	if (IS_ERR(cdev))
> +		return cdev;
> +
> +	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return cdev;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_cooling_device_register);
> +
>   static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
>   {
>   	struct thermal_cooling_device *pos = NULL;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 0ddc77aeeca2..fc3f4a098370 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -253,8 +253,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
>   struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>   		void *, const struct thermal_cooling_device_ops *);
>   struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
> -				   const struct thermal_cooling_device_ops *);
> +devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
> +				     const struct thermal_cooling_device_ops *ops);
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
> +				   const struct thermal_cooling_device_ops *ops);
>   struct thermal_cooling_device *
>   devm_thermal_of_cooling_device_register(struct device *dev,
>   				struct device_node *np,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
