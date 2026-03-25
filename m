Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519F30148C
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469182; cv=none; b=TcU/DHoBRIJTJxZRwIqCoIGZdvfSjYDhoD/9XzjSIAPx6hfZF+EmQH1x3Kf+gbciusuhu6VJjmhkkQOSFtwMas8b33UbPwFTwapRCac5op/9/Fm0uDpp9V2OeMhp0fM0SY8LAUmDHzl14YHIRNnnIIXq9I+H8FxXhN6waXIbca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469182; c=relaxed/simple;
	bh=VaZb8EC0HyB9njxGMFlCsQ7lehiZDB027a0U6Tf/jMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6oCcyR5L+dQiq06CkneM8KL7sI0ed6KHWcdtZUaWHn0PkZakBoI3e+3h5+lKV2zMVR/MSk9wQBQXQzFqkzmSALGfxkYGTZrL7L3VFrJ53b/bmYPsI2+YIrs+5MdfjQuyLlu2vooUEXBJWU3DPv4fAjbtOp0B+DpYgv1BP2szgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M75p2Lwm; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M75p2Lwm"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c11c43aca0so145194eec.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774469178; x=1775073978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYs0N76tYfCcM5LVQXVnLx1Cd3lbi2ymgwe34/d1KfU=;
        b=M75p2LwmGC2yE6Ev/cJoTRivOI8gXnonZCw2odIts7chrHFnIJnzkO7ZaZRvAslwug
         NNwndp0/by6N7jTxGkwZ5JBYCaimcSth4H+t/Lrl/Q4b7FEuY1Bc8vBGpKF1YjlEZykY
         i7PhicMXPv4z8WjuocSi/ZHpdrzGAxJnn2ZhErmdwxoBQF31u+ymI9DFJi1uAQCsomfq
         6NszrOj15PYBZZt6VLPl5gFlKNN2xfvXAJf+C7WTiZYOSMEzXQBR69N1G3CujlTwwLAZ
         Dd/4kRjIU4Az+GtvC4X1h59oFkeCRPGNFroM7e2J782UC12aDfg9qm9IYm/i/J6GgiJi
         851w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469178; x=1775073978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYs0N76tYfCcM5LVQXVnLx1Cd3lbi2ymgwe34/d1KfU=;
        b=ZkKHPXXaGjFgWcTi9u6LK93oS76Eq9BNivzlVAb4IxyCGZ0xvcsBXrX9a32IWK7lpQ
         89Ee7y2gDDpbt765hFLfh81fHyDcIohI+c6jIo6Wv+j3jYTGQOoPmMYQ2IpbM4Z2pO5g
         AGE+2md0qgGNg3YnuqVwzxbTb0EruvsKGTNm07s4n+22gKrMhNN6qhuHRjVXKFhV43Yr
         Kcusy4ZYkQFwzzd53DnW25mM4OcDQuGGxrnS9sdfObC4zMceMKlAHfMR9HKAb/CgIv0d
         DAlmCr9w81r/HPWu6YClXokrNCbCzbPUXDJiLyB8APYnpr74OvoFFflbgLhfuhe0pEOV
         Nspg==
X-Forwarded-Encrypted: i=1; AJvYcCV0NH5L7bJ2WFFZEtOEgjAtGLFjaV+pRuWtFhXiZC3+wRAylzWbBrZzHQ78lqJC5VAQ7Q7u4aRkEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweviebCh7naFkyHJL2su+EcIVuWEkel+033kSaF6FViGPCVIkK
	UPZLAPoXScisLeAxTkbKeEyL4iU0KS9hKIhGDrjP+sfnFm1zumd5WVwsJA7yHdTqxw==
X-Gm-Gg: ATEYQzzPe6UUANymzkadLXKRt8o5sAGbQKUH37nnNerauC9h6fRumYuSq0vWzgyGMPx
	1yrQqoiVlyRfGaeLKPSGFfFprRU1p0mw1RhdPgNCnE5eaAyBOlCrvwU1iJgHEzxbYPtEsFus6bp
	NwMBwFsWVeTY3MjImJUIYy0x8xeQE5ZRaCAyRbVm7fAt6cwdJVvAO0ygJ6b+jpwkT+F66ZAW/oX
	nTIH7h2EqWgT9S0B6dN0L1JwHkG10n1tgFfVGMPquPyp34Ewy8GlsIpqrEAaqxpXfimHxyr5pqV
	8rxKCNY4biMil2ScRUGtCPAvz6WjjPtPkV3O4FPtMqn1DfmYwnzRVbxbS4E2G4tbuPWxqAmgZdY
	OHJbZyjR8B0gOyaNbOdGcv8VhN9cw5hU2IThgcn/op+XS+E4lQ4CAF4t0M+ku3euKiXTV/yJqbp
	1c/Nny9toJIYz4HZ8PW4FCSa+20mWXPCXs3jUVgg1GK9j+lG9QQclQh5am4oCtt+v61b1W/Q8B1
	BWaAgnWD0eHJhyDjnUVXz2frQ==
X-Received: by 2002:a05:7300:e790:b0:2be:1f56:ed2a with SMTP id 5a478bee46e88-2c15bddba72mr2570232eec.16.1774469177832;
        Wed, 25 Mar 2026 13:06:17 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:e936:31c5:12be:a407? ([2a00:79e0:2e7c:8:e936:31c5:12be:a407])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9ceb0sm539807eec.19.2026.03.25.13.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 13:06:17 -0700 (PDT)
Message-ID: <51a60b2d-1461-46a8-8ed4-4622b9f19124@google.com>
Date: Wed, 25 Mar 2026 13:06:12 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 3/6] mfd: max77759: add register bitmasks and
 modify irq configs for charger
To: Lee Jones <lee@kernel.org>,
 Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
 <20260314-max77759-charger-v8-3-226ca5f8c7d2@google.com>
 <20260325151004.GD1141718@google.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20260325151004.GD1141718@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

Thanks for the review!

On 3/25/26 8:10 AM, Lee Jones wrote:
> On Sat, 14 Mar 2026, Amit Sunil Dhamne via B4 Relay wrote:
>
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add register bitmasks for charger function.
>>
>> In addition split the charger IRQs further such that each bit represents
>> an IRQ downstream of charger regmap irq chip. In addition populate the
>> ack_base to offload irq ack to the regmap irq chip framework.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: André Draszik <andre.draszik@linaro.org>
>> ---
>>   drivers/mfd/max77759.c       |  91 ++++++++++++++++++++--
>>   include/linux/mfd/max77759.h | 176 ++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 230 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
>> index a7efe233ec8c..288746f675b8 100644
>> --- a/drivers/mfd/max77759.c
>> +++ b/drivers/mfd/max77759.c
>> @@ -201,8 +201,24 @@ static const struct regmap_config max77759_regmap_config_charger = {
>>    *         - SYSUVLO_INT
>>    *         - FSHIP_NOT_RD
>>    *     - CHGR_INT: charger
>> - *       - CHG_INT
>> - *       - CHG_INT2
>> + *       - INT1
>> + *         - AICL
>> + *         - CHGIN
>> + *         - WCIN
>> + *         - CHG
>> + *         - BAT
>> + *         - INLIM
>> + *         - THM2
>> + *         - BYP
>> + *       - INT2
>> + *         - INSEL
>> + *         - SYS_UVLO1
>> + *         - SYS_UVLO2
>> + *         - BAT_OILO
>> + *         - CHG_STA_CC
>> + *         - CHG_STA_CV
>> + *         - CHG_STA_TO
>> + *         - CHG_STA_DONE
>>    */
>>   enum {
>>   	MAX77759_INT_MAXQ,
>> @@ -256,8 +286,38 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
>>   };
>>   
>>   static const struct regmap_irq max77759_chgr_irqs[] = {
>> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
>> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_AICL, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_AICL),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHGIN, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_CHGIN),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_WCIN, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_WCIN),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHG, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_CHG),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BAT, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_BAT),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_INLIM, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_INLIM),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_THM2, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_THM2),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BYP, 0,
>> +		       MAX77759_CHGR_REG_CHG_INT_BYP),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_INSEL, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_INSEL),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO1, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO2, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_BAT_OILO, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_BAT_OILO),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CC, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CV, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_TO, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO),
>> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_DONE, 1,
>> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE),
>>   };
>>   
>>   static const struct regmap_irq_chip max77759_pmic_irq_chip = {
>> @@ -302,6 +362,7 @@ static const struct regmap_irq_chip max77759_chrg_irq_chip = {
> Minor nit: The new code in this patch consistently uses "chgr" as the prefix
> for charger-related names. To improve consistency, how about we rename this
> struct to `max77759_chgr_irq_chip`?

Sure I can rename it for the goal of maintaining consistency.


>
>>   	.domain_suffix = "CHGR",
>>   	.status_base = MAX77759_CHGR_REG_CHG_INT,
>>   	.mask_base = MAX77759_CHGR_REG_CHG_INT_MASK,
>> +	.ack_base = MAX77759_CHGR_REG_CHG_INT,
>>   	.num_regs = 2,
>>   	.irqs = max77759_chgr_irqs,
>>   	.num_irqs = ARRAY_SIZE(max77759_chgr_irqs),
>> @@ -325,8 +386,22 @@ static const struct resource max77759_gpio_resources[] = {
>>   };
>>   
>>   static const struct resource max77759_charger_resources[] = {
>> -	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_1, "INT1"),
>> -	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_2, "INT2"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_AICL,         "AICL"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHGIN,        "CHGIN"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_WCIN,         "WCIN"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHG,          "CHG"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BAT,          "BAT"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_INLIM,        "INLIM"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_THM2,         "THM2"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BYP,          "BYP"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_INSEL,        "INSEL"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO1,    "SYS_UVLO1"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO2,    "SYS_UVLO2"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_BAT_OILO,     "BAT_OILO"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CC,   "CHG_STA_CC"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CV,   "CHG_STA_CV"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_TO,   "CHG_STA_TO"),
>> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_DONE, "CHG_STA_DONE"),
>>   };
>>   
>>   static const struct mfd_cell max77759_cells[] = {
>> diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
>> index c6face34e385..fd5aea21ab2e 100644
>> --- a/include/linux/mfd/max77759.h
>> +++ b/include/linux/mfd/max77759.h
>> @@ -59,35 +59,65 @@
>>   #define MAX77759_MAXQ_REG_AP_DATAIN0            0xb1
>>   #define MAX77759_MAXQ_REG_UIC_SWRST             0xe0
>>   
>> -#define MAX77759_CHGR_REG_CHG_INT               0xb0
>> -#define MAX77759_CHGR_REG_CHG_INT2              0xb1
>> -#define MAX77759_CHGR_REG_CHG_INT_MASK          0xb2
>> -#define MAX77759_CHGR_REG_CHG_INT2_MASK         0xb3
>> -#define MAX77759_CHGR_REG_CHG_INT_OK            0xb4
>> -#define MAX77759_CHGR_REG_CHG_DETAILS_00        0xb5
>> -#define MAX77759_CHGR_REG_CHG_DETAILS_01        0xb6
>> -#define MAX77759_CHGR_REG_CHG_DETAILS_02        0xb7
>> -#define MAX77759_CHGR_REG_CHG_DETAILS_03        0xb8
>> -#define MAX77759_CHGR_REG_CHG_CNFG_00           0xb9
>> -#define MAX77759_CHGR_REG_CHG_CNFG_01           0xba
>> -#define MAX77759_CHGR_REG_CHG_CNFG_02           0xbb
>> -#define MAX77759_CHGR_REG_CHG_CNFG_03           0xbc
>> -#define MAX77759_CHGR_REG_CHG_CNFG_04           0xbd
>> -#define MAX77759_CHGR_REG_CHG_CNFG_05           0xbe
>> -#define MAX77759_CHGR_REG_CHG_CNFG_06           0xbf
>> -#define MAX77759_CHGR_REG_CHG_CNFG_07           0xc0
>> -#define MAX77759_CHGR_REG_CHG_CNFG_08           0xc1
>> -#define MAX77759_CHGR_REG_CHG_CNFG_09           0xc2
>> -#define MAX77759_CHGR_REG_CHG_CNFG_10           0xc3
>> -#define MAX77759_CHGR_REG_CHG_CNFG_11           0xc4
>> -#define MAX77759_CHGR_REG_CHG_CNFG_12           0xc5
>> -#define MAX77759_CHGR_REG_CHG_CNFG_13           0xc6
>> -#define MAX77759_CHGR_REG_CHG_CNFG_14           0xc7
>> -#define MAX77759_CHGR_REG_CHG_CNFG_15           0xc8
>> -#define MAX77759_CHGR_REG_CHG_CNFG_16           0xc9
>> -#define MAX77759_CHGR_REG_CHG_CNFG_17           0xca
>> -#define MAX77759_CHGR_REG_CHG_CNFG_18           0xcb
>> -#define MAX77759_CHGR_REG_CHG_CNFG_19           0xcc
>> +#define MAX77759_CHGR_REG_CHG_INT                      0xb0
>> +#define   MAX77759_CHGR_REG_CHG_INT_AICL               BIT(7)
>> +#define   MAX77759_CHGR_REG_CHG_INT_CHGIN              BIT(6)
>> +#define   MAX77759_CHGR_REG_CHG_INT_WCIN               BIT(5)
>> +#define   MAX77759_CHGR_REG_CHG_INT_CHG                BIT(4)
>> +#define   MAX77759_CHGR_REG_CHG_INT_BAT                BIT(3)
>> +#define   MAX77759_CHGR_REG_CHG_INT_INLIM              BIT(2)
>> +#define   MAX77759_CHGR_REG_CHG_INT_THM2               BIT(1)
>> +#define   MAX77759_CHGR_REG_CHG_INT_BYP                BIT(0)
>> +#define MAX77759_CHGR_REG_CHG_INT2                     0xb1
>> +#define   MAX77759_CHGR_REG_CHG_INT2_INSEL             BIT(7)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1         BIT(6)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2         BIT(5)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_BAT_OILO          BIT(4)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC        BIT(3)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV        BIT(2)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO        BIT(1)
>> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE      BIT(0)
>> +#define MAX77759_CHGR_REG_CHG_INT_MASK                 0xb2
>> +#define MAX77759_CHGR_REG_CHG_INT2_MASK                0xb3
>> +#define MAX77759_CHGR_REG_CHG_INT_OK                   0xb4
>> +#define MAX77759_CHGR_REG_CHG_DETAILS_00               0xb5
>> +#define   MAX77759_CHGR_REG_CHG_DETAILS_00_CHGIN_DTLS  GENMASK(6, 5)
>> +#define MAX77759_CHGR_REG_CHG_DETAILS_01               0xb6
>> +#define   MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS    GENMASK(6, 4)
>> +#define   MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS    GENMASK(3, 0)
>> +#define MAX77759_CHGR_REG_CHG_DETAILS_02               0xb7
>> +#define   MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS   BIT(5)
>> +#define MAX77759_CHGR_REG_CHG_DETAILS_03               0xb8
>> +#define MAX77759_CHGR_REG_CHG_CNFG_00                  0xb9
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_00_MODE           GENMASK(3, 0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_01                  0xba
>> +#define MAX77759_CHGR_REG_CHG_CNFG_02                  0xbb
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC          GENMASK(5, 0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_03                  0xbc
>> +#define MAX77759_CHGR_REG_CHG_CNFG_04                  0xbd
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM     GENMASK(5, 0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_05                  0xbe
>> +#define MAX77759_CHGR_REG_CHG_CNFG_06                  0xbf
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT        GENMASK(3, 2)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_07                  0xc0
>> +#define MAX77759_CHGR_REG_CHG_CNFG_08                  0xc1
>> +#define MAX77759_CHGR_REG_CHG_CNFG_09                  0xc2
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM     GENMASK(6, 0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_10                  0xc3
>> +#define MAX77759_CHGR_REG_CHG_CNFG_11                  0xc4
>> +#define MAX77759_CHGR_REG_CHG_CNFG_12                  0xc5
>> +/* Wireless Charging input channel select */
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL        BIT(6)
>> +/* CHGIN/USB input channel select */
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_12_CHGINSEL       BIT(5)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_13                  0xc6
>> +#define MAX77759_CHGR_REG_CHG_CNFG_14                  0xc7
>> +#define MAX77759_CHGR_REG_CHG_CNFG_15                  0xc8
>> +#define MAX77759_CHGR_REG_CHG_CNFG_16                  0xc9
>> +#define MAX77759_CHGR_REG_CHG_CNFG_17                  0xca
>> +#define MAX77759_CHGR_REG_CHG_CNFG_18                  0xcb
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN          BIT(0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_19                  0xcc
>>   
>>   /* MaxQ opcodes for max77759_maxq_command() */
>>   #define MAX77759_MAXQ_OPCODE_MAXLENGTH (MAX77759_MAXQ_REG_AP_DATAOUT32 - \
>> @@ -101,6 +131,94 @@
>>   #define MAX77759_MAXQ_OPCODE_USER_SPACE_READ     0x81
>>   #define MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE    0x82
>>   
>> +/*
>> + * Charger Input Status
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
>> + *     Charger input voltage (Vchgin) < Under Voltage Threshold (Vuvlo)
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE: Vchgin > Vuvlo and
>> + *     Vchgin < (Battery Voltage (Vbatt) + system voltage (Vsys))
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
>> + *     Vchgin > Over Voltage threshold (Vovlo)
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
>> + *     Vchgin > Vuvlo, Vchgin < Vovlo and Vchgin > (Vsys + Vbatt)
>> + */
>> +enum max77759_chgr_chgin_dtls_status {
>> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE,
>> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE,
>> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE,
>> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID,
>> +};
>> +
>> +/*
>> + * Battery Details
>> + * @MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
>> + *     No battery and the charger suspended
>> + * @MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY: Vbatt < Vtrickle
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
>> + *     Charging suspended due to timer fault
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
>> + *     Battery okay and Vbatt > Min Sys Voltage (Vsysmin)
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
>> + *     Battery is okay. Vtrickle < Vbatt < Vsysmin
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
>> + *     Battery voltage > Overvoltage threshold
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
>> + *     Battery current exceeds overcurrent threshold
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
>> + *     Battery only mode and battery level not available
>> + */
>> +enum max77759_chgr_bat_dtls_states {
>> +	MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP,
>> +	MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_OKAY,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT,
>> +	MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE,
>> +};
>> +
>> +/*
>> + * Charger Details
>> + * @MAX77759_CHGR_CHG_DTLS_PREQUAL: Charger in prequalification mode
>> + * @MAX77759_CHGR_CHG_DTLS_CC:      Charger in fast charge const curr mode
>> + * @MAX77759_CHGR_CHG_DTLS_CV:      Charger in fast charge const voltage mode
>> + * @MAX77759_CHGR_CHG_DTLS_TO:      Charger is in top off mode
>> + * @MAX77759_CHGR_CHG_DTLS_DONE:    Charger is done
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_1:  Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:   Charger is in timer fault mode
>> + * @MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
>> + *     Charger is suspended as bettery removal detected
> Typo here, s/bettery/battery/.

Will fix.


>
>> + * @MAX77759_CHGR_CHG_DTLS_OFF:
>> + *     Charger is off. Input invalid or charger disabled
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_2:  Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_3:  Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
>> + *     Charger is off as watchdog timer expired
>> + * @MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:    Charger is in JEITA control mode
>> + */
>> +enum max77759_chgr_chg_dtls_states {
> Just a small style suggestion, could you please align the descriptions in this
> kerneldoc block? It improves readability. Using a consistent number of spaces
> or tabs after the colon helps.
>
> Feel free to use up to 100-chars if it improves readability.

I will try to align the descriptions for enumerators inside each enum. 
Since I can use 100 chars I can try to fit the descriptions in a single 
line for this and  `enum max77759_chgr_bat_dtls_states` as well. Hope 
that's okay?


BR,

Amit

