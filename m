Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0643900E;
	Mon, 13 Jul 2026 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953845; cv=none; b=YGBD56lqc+iWEGNou7g4bJkw6wVnfbTHLX4zvnd19A6m4PMQEdqMz/CEY6HdidegVDwwHhl4s8saVBdiR4tvhb1QkEsZ/bBI22F0YTiewd14afHY9QjYv8nhCWgvPnomYlniLapEMkVBRf53bjOLo5zxrl8mh6wOaq9NkTSq6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953845; c=relaxed/simple;
	bh=jXWZ8N81s562nbqm4nTLQDKQENpJOc0VxLLomCZS08s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKFe/JAWS0/uKl/KMCfMTtuvE/KTSKrtXfkeKwrrAkLXHXcJzVkZ2veMOUaXbCkvpMYH4NiRwEIKLVYGtxxwrq5Lln6yaSqDi7PWiudrui+pxR6dV1ka7ctptufb6+VmeEf8AH4c1GlCoto2HtK0hciZBJbJkQOhNfoECUWI96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a9C2LSD8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a9C2LSD8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B8F4152B;
	Mon, 13 Jul 2026 07:43:57 -0700 (PDT)
Received: from [10.57.2.209] (unknown [10.57.2.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E653F7B4;
	Mon, 13 Jul 2026 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783953841; bh=jXWZ8N81s562nbqm4nTLQDKQENpJOc0VxLLomCZS08s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a9C2LSD8X8yHmHN+D+GlT2sIPTq2ZJUvevUK6QFmr/5dDC17Ad7pnQzrO+GRNMKDQ
	 T9tIEJ/00jdXBuHyT+gPWjGwlj1geWItx40qXWv0bDyUB/0RibtkVuwdFkhb6XI4vP
	 UbdjGdMltTuVOsrIwOTBZKpv0pfK2JF8IcvB9+EY=
Message-ID: <046d89e6-9837-4b59-bda8-070c6366b6fe@arm.com>
Date: Mon, 13 Jul 2026 15:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] thermal/drivers/imx: Add calibration offset
 support
To: Haoning.CHENG@cn.bosch.com
Cc: linux-pm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-0-09b6b7669be1@cn.bosch.com>
 <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-2-09b6b7669be1@cn.bosch.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-2-09b6b7669be1@cn.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/13/26 11:22, Haoning CHENG via B4 Relay wrote:
> From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
> 
> Some boards need a small per-design correction to align the reported CPU
> temperature with board-level measurements.
> 
> Read the optional fsl,temp-calibration-offset-millicelsius property from
> DT and apply it to the i.MX6/6SX/7D calibration formulas. When the
> property is not present, the default offset remains 0, preserving the
> current behaviour.

s/behaviour/behavior/

Also, you can add a description in this patch header with an example
how this is going to be calculated. The full mechanism is split
into two components: this driver and the thermal framework.

When the IRQ (which was programmed for e.g. 'panic temp' value)
is triggered then thermal fwk is kicked. In that the 'get_temp'
will be called.

What this change effectively does is:
- program the IRQ firing temp level higher (based on dt example)
- provide the temp value lower to thermal fwk
then you don't touch other stuff which is generic in this
thermal scope (like trip points).

It's kind of tricky to grasp and I would suggest to describe it
somewhere. These are popular chips and many boards use them,
so many engineers might miss this bit.

> 
> Signed-off-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
> ---
>   drivers/thermal/imx_thermal.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..0a443e608957 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -207,6 +207,7 @@ struct imx_thermal_data {
>   	struct regmap *tempmon;
>   	u32 c1, c2; /* See formula in imx_init_calib() */
>   	int temp_max;
> +	s32 calibration_offset;
>   	int alarm_temp;
>   	int last_temp;
>   	bool irq_enabled;
> @@ -223,6 +224,7 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
>   	struct regmap *map = data->tempmon;
>   	int critical_value;
>   
> +	panic_temp -= data->calibration_offset;
>   	critical_value = (data->c2 - panic_temp) / data->c1;
>   
>   	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
> @@ -239,11 +241,14 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
>   	int alarm_value;
>   
>   	data->alarm_temp = alarm_temp;
> +	alarm_temp -= data->calibration_offset;
>   
> -	if (data->socdata->version == TEMPMON_IMX7D)
> -		alarm_value = alarm_temp / 1000 + data->c1 - 25;
> -	else
> +	if (data->socdata->version == TEMPMON_IMX7D) {
> +		alarm_value = DIV_ROUND_UP(alarm_temp, 1000) + data->c1 - 25;
> +		alarm_value = clamp(alarm_value, 0, 0x1ff);

This doesn't belong to the $subject. Needs extra patch.

> +	} else {
>   		alarm_value = (data->c2 - alarm_temp) / data->c1;
> +	}
>   
>   	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
>   		     soc_data->high_alarm_mask);
> @@ -277,6 +282,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>   		*temp = (n_meas - data->c1 + 25) * 1000;
>   	else
>   		*temp = data->c2 - n_meas * data->c1;
> +	*temp += data->calibration_offset;
>   
>   	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>   	if (data->socdata->version == TEMPMON_IMX6Q) {
> @@ -629,6 +635,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, data);
>   
> +	of_property_read_s32(dev->of_node,
> +			     "fsl,temp-calibration-offset-millicelsius",
> +			     &data->calibration_offset);
> +


No bounds check here or debug message?
Playing with raw registers which handle thermal safety net it's kind of
risky IMO (a typo by one digit and the board dies).
Done once in the setup code won't harm performance and something which
goes to the DT schema is quite stable to reuse.

Regards,
Lukasz


