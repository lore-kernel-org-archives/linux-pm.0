Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEF198A17
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540058; cv=none; b=mvAz0ye12Ik5OHmYLQ1bZyIMnLEcMbwJcrCiC+VOKZw2+4Mga+Yy5Yb5QTL5oacdgZ0BkmYrRyFyXbJSbQRZE9vls1VjKpJ3aVpZglT/eRmiNZnuw+tQqWIlgk6RjEhptMq/vFhXUD9N6qbQoMqZsNbbu8DRaPzusJX1ETfQG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540058; c=relaxed/simple;
	bh=Zo8UU7gNMthFb+s6GvgE7Ac+dlBAdwtYjHMnUdkdkOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCuaqJQwgaNCquGO0gwU6kQw2gDORvbOgpIbDSJ0x7nTxRK9xJBgFDE2Gdgf+1iVL3fjm6+9plgTVt9XmTi1psbkA9Is/woqZSDbgexEuIVxgvfaV91K1OiAItUCk06ZYSZ24/d1qtYJg97vp7v7f5e8neLPqlDPGN4UK/ENLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2fTeJwO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2fTeJwO"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a3d2824e4bso3281414e87.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540055; x=1776144855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ImMoQmdeN0sXH0eMNoFhdmKeC5AJW/5BcE3F1ViYts=;
        b=b2fTeJwOZe+pjXNTU1XODKu/DCHbTUC4JupDhSN1relnv5LxExvfFWT78MZlxnO1A5
         JDmX+ZXlZgzN03tUrshFkckpOZYBDvs7SvkOGX9FfmczmXJnkS9In8R5vdMjz3FxTheN
         oCxh25e+tK3Md+ZtVCLUJ9wO+IpvE72mKRX5eehcPbC1xQjxJ8EY+EXlBXem0O2cgyCH
         ca4AL9eMyniMJht/ehH7q8ksYu99FMQK9dzOV2+w043GAqy5fRn7+UuyFiubJtEiI6Or
         gXFSH9j20hHJlCuYNP8ewhMqJCmXL3hNmngr3rh1CPz9tQEMdH7jeNL38lpfpSBsPHK9
         mXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540055; x=1776144855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ImMoQmdeN0sXH0eMNoFhdmKeC5AJW/5BcE3F1ViYts=;
        b=gV8hSFhu91efdUPKHFRm8B8qcLAYItu5GbetXc9B+17Qw8KPznujLn7tlYDkQxOHSl
         zu9GNzoyhI2ZfrQJYYedI3mjF9thu5/PwbhmT02+XrdD6Kk6iWHdFotPZBP5o0kHPUMJ
         m3dGq8xThUwGDSAw1PR+61t48O2i2OV+/VIxfnARGT664yXenW278LrWzXKf/Sr6ocbq
         wXg/sN9K7/md8JPSBk116GYOD5yDwPD2azR7+ZZiOu4mkoptfqZG4BjN0mbNVn41roKU
         RKLzShcoRGplh6ERvEyufh5XKVj6sdH9dsGG1/aBifnTm6PI5HoL3IngEmvT3V5JfXUK
         KM+g==
X-Gm-Message-State: AOJu0YwDj1Z3BbNgGP7Ui+EJgO41OglV/CoJ5FEA5+dpvZR5xBbHr4FA
	uWYUvb8CUewHsA/K4OyNK9YxA0cjvRR4/66URV27co1aFsB2w5NN2RkB
X-Gm-Gg: AeBDiessJ9I2MNrtduGwEo9kRp4PAfQLokMZxvgJ51RiGGBX/IZ2DkSC2LSJNhuVQg3
	nQCwZh0lOqjntXUKxLB9WpVJO+KEX4guHGXPCS+/DQu0HTsChvgR4fZY+E3uJe5BA43oGkQg9sz
	SgOfZJg0EBvkAYzym+OoiNQghFI7coZ+k69aHD/6XaIWCsY8xlOm7yb4Kp08YDaM/QgLGlYDz6g
	z34GtW68eL7owJVbvAI0DjbbwSxZeZBTc5lx1NfNp2ZoEAQCru/9g+Vclbbxc/trshHMuQFPdzU
	0cwB17tmDK+rKocbIzoUDHFmlhzKFh0FwxiXUz/jYc7hOjsWGDWg3QzxoctZWy8fp7euJuLc26P
	eqspV2xAiIrGx1Ht+8nxwWtU2LN3nnfkPlU1OhfsQEpLlx36ElR0Dxa37SU/xwiBK/en3s5Z7w3
	cnXBbVJT0mGp3OLDiOeZpU43kGAFGbUQoT0n8f54b2p7xw9p6ViWbDYbdKcOYwL4q6lTLmOJY+o
	3BP5kWWDWR5XgEusko=
X-Received: by 2002:a05:6512:68e:b0:5a3:d375:f583 with SMTP id 2adb3069b0e04-5a3d375f6d1mr2806594e87.35.1775540055129;
        Mon, 06 Apr 2026 22:34:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ca3100sm3874421e87.35.2026.04.06.22.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 22:34:13 -0700 (PDT)
Message-ID: <16340915-f63f-41f7-b68f-6208120d9c09@gmail.com>
Date: Tue, 7 Apr 2026 08:34:12 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add input current limit property
To: Andreas Kemnade <andreas@kemnade.info>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2026 00:17, Andreas Kemnade wrote:
> Add input current property to be able to work around issues created by
> automatic input limiting and have some control.
> Disabling the automatic management is another step.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/power/supply/bd71828-power.c | 62 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
> index 0e00acb589937..5e78faa0a4aaf 100644
> --- a/drivers/power/supply/bd71828-power.c
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -24,6 +24,7 @@
>   #define BD7182x_MASK_CONF_PON			BIT(0)
>   #define BD71815_MASK_CONF_XSTB			BIT(1)
>   #define BD7182x_MASK_BAT_STAT			0x3f
> +#define BD7182x_MASK_ILIM			0x3f
>   #define BD7182x_MASK_DCIN_STAT			0x07
>   
>   #define BD7182x_MASK_WDT_AUTO			0x40
> @@ -48,9 +49,11 @@ struct pwr_regs {
>   	unsigned int vbat_avg;
>   	unsigned int ibat;
>   	unsigned int ibat_avg;
> +	unsigned int ilim_stat;
>   	unsigned int btemp_vth;
>   	unsigned int chg_state;
>   	unsigned int bat_temp;
> +	unsigned int dcin_set;
>   	unsigned int dcin_stat;
>   	unsigned int dcin_online_mask;
>   	unsigned int dcin_collapse_limit;
> @@ -66,9 +69,11 @@ static const struct pwr_regs pwr_regs_bd71828 = {
>   	.vbat_avg = BD71828_REG_VBAT_U,
>   	.ibat = BD71828_REG_IBAT_U,
>   	.ibat_avg = BD71828_REG_IBAT_AVG_U,
> +	.ilim_stat = BD71828_REG_ILIM_STAT,
>   	.btemp_vth = BD71828_REG_VM_BTMP_U,
>   	.chg_state = BD71828_REG_CHG_STATE,
>   	.bat_temp = BD71828_REG_BAT_TEMP,
> +	.dcin_set = BD71828_REG_DCIN_SET,

Hi Andreas / Sebastian,

Sorry for belated review (although, I don't think this did float on the 
list quite THAT long...)

I believe this is the ILIM_STAT register in the data sheet, at address 
0x6d, right? (The bit field is named as: LIM_DCIN_STAT[5:0]). If so, 
then I have a follow-up question in the setter...

>   	.dcin_stat = BD71828_REG_DCIN_STAT,
>   	.dcin_online_mask = BD7182x_MASK_DCIN_DET,
>   	.dcin_collapse_limit = BD71828_REG_DCIN_CLPS,
> @@ -441,6 +446,7 @@ static int bd71828_charger_get_property(struct power_supply *psy,
>   	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
>   	u32 vot;
>   	u16 tmp;
> +	int t;
>   	int online;
>   	int ret;
>   
> @@ -459,6 +465,20 @@ static int bd71828_charger_get_property(struct power_supply *psy,
>   		vot = tmp;
>   		/* 5 milli volt steps */
>   		val->intval = 5000 * vot;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		if (!pwr->regs->ilim_stat)
> +			return -ENODATA;
> +
> +		ret = regmap_read(pwr->regmap, pwr->regs->ilim_stat, &t);
> +		if (ret)
> +			return ret;
> +
> +		t++;
> +		val->intval = (t & BD7182x_MASK_ILIM) * 50000;
> +		if (val->intval > 2000000)
> +			val->intval = 2000000;

I would have preferred using the linear-ranges here.

> +
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -467,6 +487,45 @@ static int bd71828_charger_get_property(struct power_supply *psy,
>   	return 0;
>   }
>   
> +static int bd71828_charger_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		if (val->intval > 2000000)
> +			return -EINVAL;
> +
> +		if (val->intval < 50000)
> +			return -EINVAL;
> +

I would have preferred using the linear ranges here as well. That'd help 
if we support this in the other variants.

> +		if (!pwr->regs->dcin_set)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(pwr->regmap, pwr->regs->dcin_set,
> +					  BD7182x_MASK_ILIM,
> +					  val->intval / 50000 - 1);

The "burning question" I have is - how well this has been verified? I 
ask because the data-sheet version which I read (rev 0p17, DS2 draft) 
marks this register as a read-only. I know my data-sheet, targeting the 
design-sample 2 of bd71828 (not bd71879) is ancient. It may be this is 
an error in the data-sheet but I had to ask anyways...

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bd71828_charger_property_is_writeable(struct power_supply *psy,
> +						 enum power_supply_property psp)
> +{
> +	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return !!(pwr->regs->dcin_set);
> +	default:
> +		return false;
> +	}
> +}
> +
>   static int bd71828_battery_get_property(struct power_supply *psy,
>   					enum power_supply_property psp,
>   					union power_supply_propval *val)
> @@ -571,6 +630,7 @@ static int bd71828_battery_property_is_writeable(struct power_supply *psy,
>   
>   /** @brief ac properties */
>   static const enum power_supply_property bd71828_charger_props[] = {
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>   	POWER_SUPPLY_PROP_ONLINE,
>   	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>   };
> @@ -600,6 +660,8 @@ static const struct power_supply_desc bd71828_ac_desc = {
>   	.properties	= bd71828_charger_props,
>   	.num_properties	= ARRAY_SIZE(bd71828_charger_props),
>   	.get_property	= bd71828_charger_get_property,
> +	.set_property	= bd71828_charger_set_property,
> +	.property_is_writeable   = bd71828_charger_property_is_writeable,
>   };
>   
>   static const struct power_supply_desc bd71828_bat_desc = {
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260401-bd-inp-limit-3acb51e15e9c
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>

Yours,
	-- Matti


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
