Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A362E738D;
	Fri, 29 May 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048038; cv=none; b=ruAjG9SkX84ivk33qdVnXZrkvYrjckKQT8qnrz8WQBgRNIsDvk111y5dA6hU5MVDs0tgII/a64lMoeqL/01gEd77dX1qKQFoGL3atiiYCI01nfTgmoWtZEV5LpwnkuNbhCrOtUh7S1PmAMRoOAWJNZjTIKTu3gS9rntojcM69Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048038; c=relaxed/simple;
	bh=oeKvE1HGp4+iXJ2fxLXg3Ihl6RSf1rkqVUI/7FduHlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0RGbdn1d6aoVnNQWCTIjsgNX8W2jJybYv7LF+AvVEUbNZYxCjUNmQC/gSac3Da1FIO0uNCLia5Ouk7Vvqk07o3nHxgKwRD/UvPuByclC1uKAwBfKq/mQ6wiOuEWOjTgqljS91pEPfh1Upvx5H5XRcu27SmmCTC1fQy1PkPeFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sspxgcjY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sspxgcjY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC3C2247;
	Fri, 29 May 2026 02:47:11 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CD33FB3E;
	Fri, 29 May 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780048036; bh=oeKvE1HGp4+iXJ2fxLXg3Ihl6RSf1rkqVUI/7FduHlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sspxgcjYPBiJMLU6XV2HbLdCPpE3b5KJDPqCtYKbbWsITXmYnrqIcQNPpPFpdRa1Y
	 R5X0hRU8LzcV3CxdxsoLcAOU10Il2B6DTOaj8ej7j0kFu9IcsabnwmHNw9JOrzY7SM
	 ieiHW34Yosu1F322f3PrwhIWrk31Q8o5OhtAM9g0=
Message-ID: <cf13dbff-552c-43e1-9862-6b1a19c4e50f@arm.com>
Date: Fri, 29 May 2026 10:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] thermal/core: Introduce non-OF
 thermal_cooling_device_register()
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
 <20260526140802.1059293-13-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-13-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> Split the cooling device registration API into OF and non-OF variants.
> 
> Introduce thermal_cooling_device_register() for non-device-tree users
> and rework thermal_of_cooling_device_register() to use the new
> alloc/add split.
> 
> This removes the need for the internal __thermal_cooling_device_register()
> helper and makes the separation between OF and non-OF users explicit.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 60 ++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index db01361569d7..0b3db889d60d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1059,8 +1059,7 @@ static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void
>   }
>   
>   /**
> - * __thermal_cooling_device_register() - register a new thermal cooling device
> - * @np:		a pointer to a device tree node.
> + * thermal_cooling_device_register() - register a new thermal cooling device
>    * @type:	the thermal cooling device type.
>    * @devdata:	device private data.
>    * @ops:	standard thermal cooling devices callbacks.
> @@ -1068,16 +1067,13 @@ static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void
>    * This interface function adds a new thermal cooling device (fan/processor/...)
>    * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
>    * to all the thermal zone devices registered at the same time.
> - * It also gives the opportunity to link the cooling device to a device tree
> - * node, so that it can be bound to a thermal zone created out of device tree.
>    *
>    * Return: a pointer to the created struct thermal_cooling_device or an
>    * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
>    */
> -static struct thermal_cooling_device *
> -__thermal_cooling_device_register(struct device_node *np,
> -				  const char *type, void *devdata,
> -				  const struct thermal_cooling_device_ops *ops)
> +struct thermal_cooling_device *
> +thermal_cooling_device_register(const char *type, void *devdata,
> +				const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
>   	int ret;
> @@ -1086,34 +1082,12 @@ __thermal_cooling_device_register(struct device_node *np,
>   	if (IS_ERR(cdev))
>   		return cdev;
>   
> -	cdev->np = np;
> -
>   	ret = thermal_cooling_device_add(cdev, devdata);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
>   	return cdev;
>   }
> -
> -/**
> - * thermal_cooling_device_register() - register a new thermal cooling device
> - * @type:	the thermal cooling device type.
> - * @devdata:	device private data.
> - * @ops:		standard thermal cooling devices callbacks.
> - *
> - * This interface function adds a new thermal cooling device (fan/processor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> - * to all the thermal zone devices registered at the same time.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
> -struct thermal_cooling_device *
> -thermal_cooling_device_register(const char *type, void *devdata,
> -				const struct thermal_cooling_device_ops *ops)
> -{
> -	return __thermal_cooling_device_register(NULL, type, devdata, ops);
> -}
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>   
>   /**
> @@ -1121,22 +1095,36 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>    * @np:		a pointer to a device tree node.
>    * @type:	the thermal cooling device type.
>    * @devdata:	device private data.
> - * @ops:		standard thermal cooling devices callbacks.
> + * @ops:	standard thermal cooling devices callbacks.
>    *
> - * This function will register a cooling device with device tree node reference.
>    * This interface function adds a new thermal cooling device (fan/processor/...)
>    * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
>    * to all the thermal zone devices registered at the same time.
> + * It also gives the opportunity to link the cooling device to a device tree
> + * node, so that it can be bound to a thermal zone created out of device tree.
>    *
>    * Return: a pointer to the created struct thermal_cooling_device or an
>    * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
>    */
>   struct thermal_cooling_device *
>   thermal_of_cooling_device_register(struct device_node *np,
> -				   const char *type, void *devdata,
> -				   const struct thermal_cooling_device_ops *ops)
> +				     const char *type, void *devdata,
> +				     const struct thermal_cooling_device_ops *ops)
>   {
> -	return __thermal_cooling_device_register(np, type, devdata, ops);
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
>   EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>   
> @@ -1173,7 +1161,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
>   	struct thermal_cooling_device *cdev;
>   	int ret;
>   
> -	cdev = __thermal_cooling_device_register(np, type, devdata, ops);
> +	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
>   	if (IS_ERR(cdev))
>   		return cdev;
>   

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
