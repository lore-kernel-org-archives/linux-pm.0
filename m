Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD63C2BA2;
	Wed, 15 Jul 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100572; cv=none; b=KQKId4xzwumAOglb9w+hKqmKwXlVieFQaAPayPb3xmxhwv7ipM49X3vQEGiYjAuhSqzOy7Pd6rELzKKbLjA1nyj8EMOv7zX/KvPIP3ZgrpHROHEaGiVCXVX09kpU7uNhdtK4QmaYgHWPTyUPZnLyIjp1+kyaT6W/CYvthRuQXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100572; c=relaxed/simple;
	bh=MsXvHNOp7jRLeDUmwfDBA82AWHhFNBc6/5erc1wQXKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlTYBhYlWVzY05R4eVA3aXbUAzCkZx4G7wTReeDhjMI/D/PBn00tS64xFA5hOMYt0GJN/5HByG/NAmNo8jCWe1wjTVPuCR42WidGwkgq75vA7cCmFjXcGwDlcpFk4AjiWkRbuKchiZszAxmp/sL14M3eFMP6klEMgFx2XlRS64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QsxDWt3K; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QsxDWt3K"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE8D5152B;
	Wed, 15 Jul 2026 00:29:23 -0700 (PDT)
Received: from [10.57.2.177] (unknown [10.57.2.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58BF33F915;
	Wed, 15 Jul 2026 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784100567; bh=MsXvHNOp7jRLeDUmwfDBA82AWHhFNBc6/5erc1wQXKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QsxDWt3KD0gLwwOVoSwz6F9QcdMXkaoZzWSEXTWUDIGD8Wbyn3D8MGU6B6LhHga5H
	 7BIEM0JS4ez1HsCRWPMHhfRoAtjGUsdKSVU/XGI2BRVs6ji9U/sUxioC0KlqV7r46w
	 n5UTC4yHj6i0ZuJHGmRoDUwkvaiT8cfh48r7v5Eo=
Message-ID: <a886ad87-d17a-4ace-8388-fab5c4c2ba3c@arm.com>
Date: Wed, 15 Jul 2026 08:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] thermal/drivers/imx: Fix rounding and clamp for
 i.MX7D alarm
To: Haoning.CHENG@cn.bosch.com
Cc: linux-pm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-2-d54d8690e16e@cn.bosch.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-2-d54d8690e16e@cn.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/14/26 11:28, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> 
> Convert the alarm temperature from millicelsius to degrees for i.MX7D
> using ceiling division instead of integer division, ensuring rounding
> errors do not cause the alarm to trigger below the intended threshold.
> Use DIV_ROUND_UP() for non-negative values and plain integer division
> for negative values, since C rounds toward zero which is equivalent to
> ceiling when the divisor is positive.
> 
> Add clamp() to ensure the hardware register value stays within the 9-bit
> range (0..0x1ff) of the i.MX7D alarm field, preventing silent truncation
> if an out-of-range value is written.
> 
> Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> ---
>   drivers/thermal/imx_thermal.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..7f7d1116b9d6 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -240,10 +240,16 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>   
>   	data->alarm_temp = alarm_temp;
>   
> -	if (data->socdata->version == TEMPMON_IMX7D)
> -		alarm_value = alarm_temp / 1000 + data->c1 - 25;
> -	else
> +	if (data->socdata->version == TEMPMON_IMX7D) {
> +		if (alarm_temp >= 0)
> +			alarm_temp = DIV_ROUND_UP(alarm_temp, 1000);
> +		else
> +			alarm_temp /= 1000;
> +		alarm_value = alarm_temp + data->c1 - 25;
> +		alarm_value = clamp(alarm_value, 0, 0x1ff);
> +	} else {
>   		alarm_value = (data->c2 - alarm_temp) / data->c1;
> +	}
>   
>   	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
>   		     soc_data->high_alarm_mask);
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
