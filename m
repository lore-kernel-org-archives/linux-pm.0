Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D62EAB61;
	Fri, 29 May 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059371; cv=none; b=PgH5vk1dZIbrb1N0BnwYT3p3ZyXq977wbf2JB/T1mT0wySS036MWsKA326J9p/6psP/ythFYSIZ2UxOfRuhZjFSULOov2xutjoTeSHZF7mr07Xu0KdkQD7q5LjeMK0Ed2WFuNJZRlrHuXOPrUFSQfAb91e49ExXlNptjBzPmpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059371; c=relaxed/simple;
	bh=0QxfIEC8qyuYWwOAb2WgzCIMH4/1O2Q1V9Anr+5ikEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/jM4ZsRH7OvxE4pb43S+TbMnA1VNpx0m+EA6jCcHWgpiKmwTxVdnDTOm70iY4sOfvvhGJBtexMY4F1h6jqojyD6X8dU7BZx5mXbfg+QpCIifUcmQ4elJwEivCrd3ExeB0u4VE+n74xnvRexaBhR1bV+lvCr5QQmNijb0xMG6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ocxpLU7J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ocxpLU7J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DAD20E3;
	Fri, 29 May 2026 05:56:02 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19FFC3FB3E;
	Fri, 29 May 2026 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780059367; bh=0QxfIEC8qyuYWwOAb2WgzCIMH4/1O2Q1V9Anr+5ikEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocxpLU7JwcuFGJNzN52Odm0/9BAn+vFuXL4dL3SP0K9Ycz25oxgomjRgE2vfGn+7x
	 fdUro768IWnWcg1hZ8/X6pd+pLdb+uO7r0QttFPxl3OZxgcIhKskHQ68rYS20sB8sS
	 pe9KxdyjtNBsrE0SkjGCfY7PP+sZBiDo9TODVQYk=
Message-ID: <312d7b76-66a4-48e1-b8dd-23082b68de41@arm.com>
Date: Fri, 29 May 2026 13:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] hwmon: Use non-OF thermal cooling device
 registration API
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
 linux-hwmon@vger.kernel.org,
 "open list:CHROMEOS EC HARDWARE MONITORING" <chrome-platform@lists.linux.dev>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <20260526140802.1059293-15-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-15-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> Some HWMON drivers register cooling devices using the OF helper
> devm_thermal_of_cooling_device_register() with a NULL device node.
> 
> With the introduction of a dedicated non-OF registration API,
> switch these users to devm_thermal_cooling_device_register()
> to make the intent explicit and avoid relying on OF-specific helpers.
> 
> This is a pure refactoring with no functional change.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/cros_ec_hwmon.c  | 4 ++--
>   drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>   drivers/hwmon/mlxreg-fan.c     | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 6cf5ab0f4b73..77dd9f28962d 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -532,8 +532,8 @@ static void cros_ec_hwmon_register_fan_cooling_devices(struct device *dev,
>   
>   		cpriv->hwmon_priv = priv;
>   		cpriv->index = i;
> -		cdev = devm_thermal_of_cooling_device_register(dev, NULL, type, cpriv,
> -							       &cros_ec_thermal_cooling_ops);
> +		cdev = devm_thermal_cooling_device_register(dev, type, cpriv,
> +							    &cros_ec_thermal_cooling_ops);
>   		if (IS_ERR(cdev)) {
>   			dev_warn(dev, "failed to register fan %zu as a cooling device: %pe\n", i,
>   				 cdev);
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 038edffc1ac7..47b373ea6db4 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1161,8 +1161,8 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
>   	if (cdata) {
>   		cdata->fan_num = fan_num;
>   		cdata->data = data;
> -		cdev = devm_thermal_of_cooling_device_register(dev, NULL, name, cdata,
> -							       &dell_smm_cooling_ops);
> +		cdev = devm_thermal_cooling_device_register(dev, name, cdata,
> +							    &dell_smm_cooling_ops);
>   		if (IS_ERR(cdev)) {
>   			devm_kfree(dev, cdata);
>   			ret = PTR_ERR(cdev);
> diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
> index 137a90dd2075..860de6cfd8a4 100644
> --- a/drivers/hwmon/mlxreg-fan.c
> +++ b/drivers/hwmon/mlxreg-fan.c
> @@ -583,8 +583,8 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
>   		pwm->fan = fan;
>   		/* Set minimal PWM speed. */
>   		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
> -		pwm->cdev = devm_thermal_of_cooling_device_register(dev, NULL, mlxreg_fan_name[i],
> -								    pwm, &mlxreg_fan_cooling_ops);
> +		pwm->cdev = devm_thermal_cooling_device_register(dev, mlxreg_fan_name[i],
> +								 pwm, &mlxreg_fan_cooling_ops);
>   		if (IS_ERR(pwm->cdev)) {
>   			dev_err(dev, "Failed to register cooling device\n");
>   			return PTR_ERR(pwm->cdev);


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
