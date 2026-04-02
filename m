Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB913FEE;
	Thu,  2 Apr 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149271; cv=none; b=IslpCJwrEvxZ3/Fhh+nXg11TFjS2/8tuffwNwxPtmhOIrHftuw4252YChOEZVZUp8lTYB3sQ4ZRc8DkV8mBpynYlxhnzjphggzz6vHYEce77to7OmS9I788HRvQ/pbhVn8IKFvaMzDo7nFcVaoQte1fMoTZV7BUmykniCRLJ7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149271; c=relaxed/simple;
	bh=2OWqMG9cAvyIiZhUJJh6c3apSC/Ro+i93PaoDjc2ohY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TKVkkptBl7UoziHuALmVE7O/18gqh2LaTi7FRbUA/hLWgUqaidMshL48VB2rKkbgx0Rz13lolK+4t1V1zpHbjTcsFKGE72m4D1dF5wgfF8t4PoQiKoeoFeihMR2SAxgKfB4QEkK3WQlElVHTJdW4hqbAUzYU/pmGQw+r4B6Szcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=TyDduWOp; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="TyDduWOp"
Message-ID: <d0d17d65-893d-44c8-a929-92ba5b71d7f6@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775149257;
	bh=2OWqMG9cAvyIiZhUJJh6c3apSC/Ro+i93PaoDjc2ohY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TyDduWOpNvxQeMWOJLRKd7O4x57VGwm/FtjFB4aCLFl7jth9inkleHxhtz7dfmZpO
	 ainHsiv56YhFZcMxmPC6M0wdfV/f5bNz9T4fDyPLaFgxbBcKiYU+Tt4hIw74Jodnmh
	 wBAzw0LIaUuYcMk2fb2yJxzZTEAN/qFAlVGgh+tQ=
Date: Thu, 2 Apr 2026 19:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH 5/8] thermal: khadas-mcu-fan: Add fan config from platform
 data Add regulator support
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
 <20260402-add-mcu-fan-khadas-vim4-v1-5-2b12eb4ac7b0@aliel.fr>
 <5e3e8684-f893-4fb0-879e-9661820f72dd@linaro.org>
Content-Language: en-US
In-Reply-To: <5e3e8684-f893-4fb0-879e-9661820f72dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/2/26 5:39 PM, Neil Armstrong wrote:
> On 4/2/26 16:27, Ronald Claveau wrote:
>> Replace the hardcoded MAX_LEVEL constant and fan register
>> with values read from platform_data (fan_reg, max_level),
>> as new MCUs need different values.
>>
>> Optionally acquire and enable a "fan" regulator supply
>> at probe time and on resume,
>> so boards that gate fan power through a regulator are handled.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   drivers/thermal/khadas_mcu_fan.c | 43 ++++++++++++++++++++++++++++++
>> ++++------
>>   1 file changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/
>> khadas_mcu_fan.c
>> index d35e5313bea41..55b496625e3bd 100644
>> --- a/drivers/thermal/khadas_mcu_fan.c
>> +++ b/drivers/thermal/khadas_mcu_fan.c
>> @@ -13,13 +13,15 @@
>>   #include <linux/regmap.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/thermal.h>
>> -
>> -#define MAX_LEVEL 3
>> +#include <linux/regulator/consumer.h>
>>     struct khadas_mcu_fan_ctx {
>>       struct khadas_mcu *mcu;
>> +    unsigned int fan_reg;
>>       unsigned int level;
>> +    unsigned int max_level;
>>       struct thermal_cooling_device *cdev;
>> +    struct regulator *power;
>>   };
>>     static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>> @@ -27,8 +29,7 @@ static int khadas_mcu_fan_set_level(struct
>> khadas_mcu_fan_ctx *ctx,
>>   {
>>       int ret;
>>   -    ret = regmap_write(ctx->mcu->regmap,
>> KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
>> -               level);
>> +    ret = regmap_write(ctx->mcu->regmap, ctx->fan_reg, level);
>>       if (ret)
>>           return ret;
>>   @@ -40,7 +41,9 @@ static int khadas_mcu_fan_set_level(struct
>> khadas_mcu_fan_ctx *ctx,
>>   static int khadas_mcu_fan_get_max_state(struct
>> thermal_cooling_device *cdev,
>>                       unsigned long *state)
>>   {
>> -    *state = MAX_LEVEL;
>> +    struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>> +
>> +    *state = ctx->max_level;
>>         return 0;
>>   }
>> @@ -61,7 +64,7 @@ khadas_mcu_fan_set_cur_state(struct
>> thermal_cooling_device *cdev,
>>   {
>>       struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>>   -    if (state > MAX_LEVEL)
>> +    if (state > ctx->max_level)
>>           return -EINVAL;
>>         if (state == ctx->level)
>> @@ -83,11 +86,32 @@ static int khadas_mcu_fan_probe(struct
>> platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct khadas_mcu_fan_ctx *ctx;
>>       int ret;
>> +    const struct khadas_mcu_fan_pdata *pdata =
>> dev_get_platdata(&pdev->dev);
>>         ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>       if (!ctx)
>>           return -ENOMEM;
>> +
>>       ctx->mcu = mcu;
>> +    ctx->fan_reg   = pdata->fan_reg;
>> +    ctx->max_level = pdata->max_level;
>> +
>> +    ctx->power = devm_regulator_get_optional(dev->parent, "fan");
>> +    if (IS_ERR(ctx->power)) {
>> +        if (PTR_ERR(ctx->power) == -ENODEV)
>> +            ctx->power = NULL;
>> +        else
>> +            return PTR_ERR(ctx->power);
>> +    }
>> +
>> +    if (ctx->power) {
>> +        ret = regulator_enable(ctx->power);
>> +        if (ret) {
>> +            dev_err(dev, "Failed to enable fan power supply: %d\n",
>> ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>>       platform_set_drvdata(pdev, ctx);
>>         cdev = devm_thermal_of_cooling_device_register(dev->parent,
>> @@ -130,6 +154,13 @@ static int khadas_mcu_fan_suspend(struct device
>> *dev)
>>   static int khadas_mcu_fan_resume(struct device *dev)
>>   {
>>       struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
>> +    int ret;
>> +
>> +    if (ctx->power) {
>> +        ret = regulator_enable(ctx->power);
> 
> Seems you're missing a regulator_disable() on suspend.
> 
> Neil
> 

You right, I will add the regulator_disable on suspend for next version.
Thanks for your feedback.

>> +        if (ret)
>> +            return ret;
>> +    }
>>         return khadas_mcu_fan_set_level(ctx, ctx->level);
>>   }
>>
> 


-- 
Best regards,
Ronald
