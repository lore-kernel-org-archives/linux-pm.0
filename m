Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166A1DDA18;
	Fri, 29 May 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061175; cv=none; b=TtMkKyiqvAeGdqL0HTTj5DMityyA7KYb7ULVdjb4Hx939uKveMtVWMKGb5DXQZ/v7Vgxzhr0EmdjcYxmBTvqCw1WEUvT5z/ZNXisiKoHWE+zlNWA3/Bvgv71reT3lg67IOAWKSxLJAF8lHSkoiqpmHA6TqYvqrq4f7bc4ctovHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061175; c=relaxed/simple;
	bh=6ISuJf9Ng+C3Z3SaW7nQja5JGHkXUpGmWJi+tFkSKAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo5AWK7nKrLus3dJnN+Egp4UUbxS3YQM2NCikPB7l9Ya32wy9j42TcPyWT+s/z9L0CLWfKBGoDBI9RQNnp9Vxx6J08i6ZYaWlOweIDKO+FIgH8FFvHbRyF8g91sETlZ9OBPcx5GtV7CasmbKef1DnOyD/w2BRXWido+NaUmwdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rOf+7xyO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rOf+7xyO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4A022D7;
	Fri, 29 May 2026 06:26:07 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2E13FB3E;
	Fri, 29 May 2026 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780061172; bh=6ISuJf9Ng+C3Z3SaW7nQja5JGHkXUpGmWJi+tFkSKAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rOf+7xyOSB8ONJPiiYATN1S3Ig6Pd1xDHEoq6gjViALAgwSjLURkzbZenWTb0uDQH
	 /OySxo+rgQsMKle8JMCeX5b788oDWJYfvdHT0e+7MsdPS0qH7QD2frgu4yxLjz2pK0
	 VOMW4zK9NqInNq+Ng0e3Y/pdfhfIceaFuMeMd2tI=
Message-ID: <dc9896ac-8d7d-49eb-b435-6e2aa949f8be@arm.com>
Date: Fri, 29 May 2026 14:26:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] thermal/of: Move cooling device OF helpers out
 of thermal core
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
 <20260526140802.1059293-17-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-17-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> The functions:
>   - thermal_of_cooling_device_register()
>   - devm_thermal_of_cooling_device_register()
> 
> are specific to device tree usage but are currently implemented in
> thermal_core.c.
> 
> Move them to thermal_of.c to better reflect the separation between
> generic thermal core code and OF-specific logic.
> 
> This change is enabled by the recent split of the cooling device
> registration into allocation and addition phases, allowing OF-specific
> handling (such as device node assignment) to be isolated from the core.
> 
> No functional change intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/thermal/thermal_core.c | 80 +-------------------------------
>   drivers/thermal/thermal_core.h |  5 ++
>   drivers/thermal/thermal_of.c   | 83 ++++++++++++++++++++++++++++++++++
>   include/linux/thermal.h        | 49 ++++++++++++--------
>   4 files changed, 119 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bb4fc3ff2ad5..28a20d4b475c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -963,7 +963,7 @@ static void thermal_cdev_release(struct device *dev)
>   	kfree(cdev);
>   }
>   
> -static struct thermal_cooling_device *
> +struct thermal_cooling_device *
>   thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
> @@ -1002,7 +1002,7 @@ thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_devi
>   	return ERR_PTR(ret);
>   }
>   
> -static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
>   {
>   	unsigned long current_state;
>   	int ret;
> @@ -1090,44 +1090,6 @@ thermal_cooling_device_register(const char *type, void *devdata,
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>   
> -/**
> - * thermal_of_cooling_device_register() - register an OF thermal cooling device
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
> -struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np,
> -				     const char *type, void *devdata,
> -				     const struct thermal_cooling_device_ops *ops)
> -{
> -	struct thermal_cooling_device *cdev;
> -	int ret;
> -
> -	cdev = thermal_cooling_device_alloc(type, ops);
> -	if (IS_ERR(cdev))
> -		return cdev;
> -
> -	cdev->np = np;
> -
> -	ret = thermal_cooling_device_add(cdev, devdata);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	return cdev;
> -}
> -EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> -
>   static void thermal_cooling_device_release(void *data)
>   {
>   	struct thermal_cooling_device *cdev = data;
> @@ -1135,44 +1097,6 @@ static void thermal_cooling_device_release(void *data)
>   	thermal_cooling_device_unregister(cdev);
>   }
>   
> -/**
> - * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
> - *					       device
> - * @dev:	a valid struct device pointer of a sensor device.
> - * @np:		a pointer to a device tree node.
> - * @type:	the thermal cooling device type.
> - * @devdata:	device private data.
> - * @ops:	standard thermal cooling devices callbacks.
> - *
> - * This function will register a cooling device with device tree node reference.
> - * This interface function adds a new thermal cooling device (fan/processor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> - * to all the thermal zone devices registered at the same time.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
> -struct thermal_cooling_device *
> -devm_thermal_of_cooling_device_register(struct device *dev,
> -				struct device_node *np,
> -				const char *type, void *devdata,
> -				const struct thermal_cooling_device_ops *ops)
> -{
> -	struct thermal_cooling_device *cdev;
> -	int ret;
> -
> -	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
> -	if (IS_ERR(cdev))
> -		return cdev;
> -
> -	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	return cdev;
> -}
> -EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> -
>   /**
>    * devm_thermal_cooling_device_register() - register a thermal cooling device
>    *
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 0acb7d9587ca..e98b0aa5aacc 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -267,6 +267,11 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
>   void thermal_governor_update_tz(struct thermal_zone_device *tz,
>   				enum thermal_notify_event reason);
>   
> +struct thermal_cooling_device *
> +thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops);
> +
> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata);
> +
>   /* Helpers */
>   #define for_each_trip_desc(__tz, __td)	\
>   	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 75fb7663c507..8c49d449d43f 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -510,3 +510,86 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
>   			       devm_thermal_of_zone_match, tz));
>   }
>   EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
> +
> +/**
> + * thermal_of_cooling_device_register() - register an OF thermal cooling device
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
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np,
> +				     const char *type, void *devdata,
> +				     const struct thermal_cooling_device_ops *ops)
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
> +}
> +EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> +
> +static void thermal_of_cooling_device_release(void *data)
> +{
> +	struct thermal_cooling_device *cdev = data;
> +
> +	thermal_cooling_device_unregister(cdev);
> +}
> +
> +/**
> + * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
> + *                                             device
> + * @dev:        a valid struct device pointer of a sensor device.
> + * @np:         a pointer to a device tree node.
> + * @type:       the thermal cooling device type.
> + * @devdata:    device private data.
> + * @ops:        standard thermal cooling devices callbacks.
> + *
> + * This function will register a cooling device with device tree node reference.
> + * This interface function adds a new thermal cooling device (fan/processor/...)
> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
> + * to all the thermal zone devices registered at the same time.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +                                struct device_node *np,
> +                                const char *type, void *devdata,
> +                                const struct thermal_cooling_device_ops *ops)
> +{
> +        struct thermal_cooling_device *cdev;
> +        int ret;
> +
> +        cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
> +        if (IS_ERR(cdev))
> +                return cdev;
> +
> +        ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
> +        if (ret)
> +                return ERR_PTR(ret);
> +
> +        return cdev;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 60e596e7d7ae..6d1862ac187f 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -200,6 +200,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>   
>   void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
>   
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
> +				   const struct thermal_cooling_device_ops *ops);
> +
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +					struct device_node *np,
> +					const char *type, void *devdata,
> +					const struct thermal_cooling_device_ops *ops);
>   #else
>   
>   static inline
> @@ -213,6 +222,23 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>   						   struct thermal_zone_device *tz)
>   {
>   }
> +
> +static inline struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np,
> +				   const char *type, void *devdata,
> +				   const struct thermal_cooling_device_ops *ops)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +					struct device_node *np,
> +					const char *type, void *devdata,
> +					const struct thermal_cooling_device_ops *ops)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
>   #endif
>   
>   int for_each_thermal_trip(struct thermal_zone_device *tz,
> @@ -254,17 +280,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
>   
>   struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>   		void *, const struct thermal_cooling_device_ops *);
> +
>   struct thermal_cooling_device *
>   devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
>   				     const struct thermal_cooling_device_ops *ops);
> -struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
> -				   const struct thermal_cooling_device_ops *ops);
> -struct thermal_cooling_device *
> -devm_thermal_of_cooling_device_register(struct device *dev,
> -				struct device_node *np,
> -				const char *type, void *devdata,
> -				const struct thermal_cooling_device_ops *ops);
> +
>   void thermal_cooling_device_update(struct thermal_cooling_device *);
>   void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>   struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
> @@ -310,18 +330,7 @@ thermal_cooling_device_register(const char *type, void *devdata,
>   	const struct thermal_cooling_device_ops *ops)
>   { return ERR_PTR(-ENODEV); }
>   static inline struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np,
> -	const char *type, void *devdata,
> -	const struct thermal_cooling_device_ops *ops)
> -{ return ERR_PTR(-ENODEV); }
> -static inline struct thermal_cooling_device *
> -devm_thermal_of_cooling_device_register(struct device *dev,
> -				struct device_node *np,
> -				const char *type, void *devdata,
> -				const struct thermal_cooling_device_ops *ops)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> +
>   static inline void thermal_cooling_device_unregister(
>   	struct thermal_cooling_device *cdev)
>   { }


I would change the order of patch 04/10 and this one.

Other than that:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
