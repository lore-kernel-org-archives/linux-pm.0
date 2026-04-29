Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC91D5CD1
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422601; cv=none; b=RMOvKFSXsbDWchX7bm4lMkq/dRx8M965rmZaKn0/u+JWwXjF+0ViulADVD05S14IoIES9FAINcFQvyFcRUSAIY5enq6/+5SLdRBn+r/NAZ3wWXOJfFFI7/xjljpd6/AINICQkNUfYxU9V45lCyRLuv4B90qbyBc5Y0Y1Rplbya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422601; c=relaxed/simple;
	bh=9XGL/PuNc3NuUpjzdaXa1S+JKaTCdyoNGlaialB1EgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRkIyr/8YdGQZvy3c+Rh1IVriOOu3IaZkhZvC/8R6TsHvNcxrqIwhXtogW7dP+b8pgyEuXopu6jBQilMDdM3EP4+t3QUvytV6/CVvCFatZFdlwPCn7fHAm+iJZYeq2zFXGxqlxv1hb4WGwb1vBGkBS4W+gnJ1Eskh7+fO4lvaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7+xFqwZ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7+xFqwZ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so17417895eec.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777422599; x=1778027399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Z8qrnrVCeVc0HrgkfQjkwuL6GmTTzRhQcFlk/a/CQc=;
        b=L7+xFqwZj2BST2eW/d/2zZ06NXocP8XsE46Rn874ZM6xz+Vhap8qoiX3n1L6ANAShT
         ZaMQlUVtlKy04HE5HP3EI/HHWySTqcJJGathzNQiw2ZW8Hsr0BvaM/ogI37inNOrzi1/
         sTRkOySGqIh0c9pSuA4+HtWInEaL3aDqNm+0Yy4P5YCES1N3GSIoD+bQCC4eqt7X/FFp
         BfuWtDDzWADW+JOTsM19c0R1u69xkcjH3vEIHAFl7wTT49TtGkhEi8a9WspcB0sIG702
         Jrgec4J/SXe+BvlYX691oFm5dZdf7ZNzvCwDMmcqf7yMDB5fWzukD7OLYVcwWjz93tX7
         CVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777422599; x=1778027399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z8qrnrVCeVc0HrgkfQjkwuL6GmTTzRhQcFlk/a/CQc=;
        b=jTXzytrPe29E256kEPKHRmyFzJs+ABVRM9lW0lPAJNmeA03cAnOiqUfOWYHDKxzPTT
         fNgwB7wjfpgzqG07sGxrAL6SbZzhGkHrFrp6u848mNPV8wHCfv0H0fghtHmRaPREi5EB
         pHXIzY+QcaTiiAQoFua+O6xDGALPntRIG+/IAdstbhxklPE1CmkZZNPU3At7S+/SDNlt
         ELPnXUnwtNPRhxoG0diBKDVo83jeD/m8xH4IWVBMIw5BgQ9lmUdNYGaNMkoH6JQkCiU/
         KzSwzNVaKLWPQPtA2gEjO1MJ93cAinaQ4xwBZm6vJ/8w7Q3SSbFyq8wNZSIoSJ92SvLz
         x96Q==
X-Forwarded-Encrypted: i=1; AFNElJ9sw2I3R97LLMbjtLxl/QPcOSCuLd+iI+5rH8etLkj8HmZMeArMrzyYnhyETzqlTfR0DlgAWyfPIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweeCqsoSZM9gPPnBInRuDyKqcyBJRAVOuHopLuLqxieTcibZ7q
	A5Q28t8+duTYHwzc7GwhkDAqF97vIyBGFGIq3F1dLlPLOVMGNHUr4eydQdWr13KJEdx79xaMLNv
	PywKsQXuZA9k=
X-Gm-Gg: AeBDiesxLU3kqqQ8oaeMfraW+m5ZPskQLD6ZUWNtF6npP9AumnQu7gCbB1n/4lUEkQT
	KCOjjUTqR0DitikWANoG7L00holWoc0iPF8EzTECelLgCXWnOCPyVwR19F+CJApcX5EvQBNXefX
	qGSS0h7NlIJDYAJ0695oylsylwOXahdcNP/s0HKm+hxdLXbVBrqpCvVHJEvlOM3vwBhzVpOCiKK
	iJlIF1GDzoc47xkOReTgnaFerREY2n7idvs7jcsSW85jMGlnBChS4ER2ec0WWgJI5DDkFkF7KSW
	GCg6da55wDH1Hm717TTT96FS8do1jZK7Ori7rH5qduto6GlNhK4S87c/FNaoQV21P2/BizLU0S9
	QlAq3hAORMaPs8t5zfr5JNDTTTmaYtTRs053T/VyRGN7j7fbIajLR3/2yf0x8xZ0sJCVTSkRPJ3
	6ShFq8sHveChQu3+2St7Cs+/jbKp8+s9oRYcOV3FpHkiVi+X6LSH6UFlSQE+SBuKpBJOiI0J97s
	UaE1Dm/RD57VEcwG4b7XvjoUB5Rtu85r6GygYt3ExWQ+Jo=
X-Received: by 2002:a05:693c:2b01:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-2ed197c14b2mr834939eec.11.1777422597943;
        Tue, 28 Apr 2026 17:29:57 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:9:fa97:3a7a:b601:9ff8? ([2a00:79e0:2e7c:9:fa97:3a7a:b601:9ff8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e77bsm412161eec.11.2026.04.28.17.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 17:29:57 -0700 (PDT)
Message-ID: <fc767096-f39d-4088-b3ad-cc85bdedf36c@google.com>
Date: Tue, 28 Apr 2026 17:29:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] mfd: max77759: add register bitmasks and modify
 irq configs for charger
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jagan Sridharan <badhri@google.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Reichel
 <sre@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-3-76f59233c369@google.com>
 <20260424082639.GI170138@google.com>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <20260424082639.GI170138@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lee,


Thanks for your review.


On 4/24/26 1:26 AM, Lee Jones wrote:
> On Tue, 31 Mar 2026, Amit Sunil Dhamne via B4 Relay wrote:
>
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add register bitmasks for charger function.
>> In addition split the charger IRQs further such that each bit represents
>> an IRQ downstream of charger regmap irq chip. In addition populate the
>> ack_base to offload irq ack to the regmap irq chip framework.
> Please reword this commit messages.
>
> Using 'In addition' twice in such close proximity reads a little awkwardly.

Thanks for pointing it out. Unfortunately, this commit is already part
of the linux and linux-next so I am not sure if I could fix the commit
message retrospectively.


>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: André Draszik <andre.draszik@linaro.org>
>> ---
>>  drivers/mfd/max77759.c       |  95 ++++++++++++++++++++++---
>>  include/linux/mfd/max77759.h | 166 +++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 222 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
>> index a7efe233ec8c..9fa6027a92c4 100644
>> --- a/drivers/mfd/max77759.c
>> +++ b/drivers/mfd/max77759.c
>> @@ -201,8 +201,24 @@ static const struct regmap_config max77759_regmap_config_charger = {
>>   *         - SYSUVLO_INT
>>   *         - FSHIP_NOT_RD
>>   *     - CHGR_INT: charger
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
>>   */
>>  enum {
>>  	MAX77759_INT_MAXQ,
>> @@ -228,8 +244,22 @@ enum {
>>  };
>>  
>>  enum {
>> -	MAX77759_CHARGER_INT_1,
>> -	MAX77759_CHARGER_INT_2,
>> +	MAX77759_CHGR_INT1_AICL,
>> +	MAX77759_CHGR_INT1_CHGIN,
>> +	MAX77759_CHGR_INT1_WCIN,
>> +	MAX77759_CHGR_INT1_CHG,
>> +	MAX77759_CHGR_INT1_BAT,
>> +	MAX77759_CHGR_INT1_INLIM,
>> +	MAX77759_CHGR_INT1_THM2,
>> +	MAX77759_CHGR_INT1_BYP,
>> +	MAX77759_CHGR_INT2_INSEL,
>> +	MAX77759_CHGR_INT2_SYS_UVLO1,
>> +	MAX77759_CHGR_INT2_SYS_UVLO2,
>> +	MAX77759_CHGR_INT2_BAT_OILO,
>> +	MAX77759_CHGR_INT2_CHG_STA_CC,
>> +	MAX77759_CHGR_INT2_CHG_STA_CV,
>> +	MAX77759_CHGR_INT2_CHG_STA_TO,
>> +	MAX77759_CHGR_INT2_CHG_STA_DONE,
>>  };
>>  
>>  static const struct regmap_irq max77759_pmic_irqs[] = {
>> @@ -256,8 +286,38 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
>>  };
>>  
>>  static const struct regmap_irq max77759_chgr_irqs[] = {
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
> Can I suggest using the 100-char limit to expand and neaten these up a bit.

Sounds good I will send a new "fixes" patch to address this.


>
>>  };
>>  
>>  static const struct regmap_irq_chip max77759_pmic_irq_chip = {
>> @@ -297,11 +357,12 @@ static const struct regmap_irq_chip max77759_topsys_irq_chip = {
>>  	.num_irqs = ARRAY_SIZE(max77759_topsys_irqs),
>>  };
>>  
>> -static const struct regmap_irq_chip max77759_chrg_irq_chip = {
>> +static const struct regmap_irq_chip max77759_chgr_irq_chip = {
> This is a sneaky change.  If you're going to bundle fixes like this, at
> least drop a mention in the commit message.

This wasn't part of the original commit but was pointed out during the
code review. While I captured this in the changlogs maybe I should have
added it in the commit msg. 

Unfortunately, this has the same issue as before, i.e., modifying commit
message after it has been applied.


>
>>  	.name = "max77759-chgr",
>>  	.domain_suffix = "CHGR",
>>  	.status_base = MAX77759_CHGR_REG_CHG_INT,
>>  	.mask_base = MAX77759_CHGR_REG_CHG_INT_MASK,
>> +	.ack_base = MAX77759_CHGR_REG_CHG_INT,
>>  	.num_regs = 2,
>>  	.irqs = max77759_chgr_irqs,
>>  	.num_irqs = ARRAY_SIZE(max77759_chgr_irqs),
>> @@ -325,8 +386,22 @@ static const struct resource max77759_gpio_resources[] = {
>>  };
>>  
>>  static const struct resource max77759_charger_resources[] = {
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
>>  };
>>  
>>  static const struct mfd_cell max77759_cells[] = {
>> @@ -567,7 +642,7 @@ static int max77759_add_chained_charger(struct i2c_client *client,
>>  					    max77759->regmap_charger,
>>  					    MAX77759_INT_CHGR,
>>  					    parent,
>> -					    &max77759_chrg_irq_chip,
>> +					    &max77759_chgr_irq_chip,
>>  					    &irq_chip_data);
>>  	if (ret)
>>  		return ret;
>> diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
>> index c6face34e385..ec19be952877 100644
>> --- a/include/linux/mfd/max77759.h
>> +++ b/include/linux/mfd/max77759.h
>> @@ -59,35 +59,65 @@
>>  #define MAX77759_MAXQ_REG_AP_DATAIN0            0xb1
>>  #define MAX77759_MAXQ_REG_UIC_SWRST             0xe0
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
> Should we ensure these comments are formatted as complete sentences with a full
> stop at the end, to comply with our documentation guidelines?

Sounds good I will add this fix in the new fixes patch.


>
>> +#define MAX77759_CHGR_REG_CHG_CNFG_13                  0xc6
>> +#define MAX77759_CHGR_REG_CHG_CNFG_14                  0xc7
>> +#define MAX77759_CHGR_REG_CHG_CNFG_15                  0xc8
>> +#define MAX77759_CHGR_REG_CHG_CNFG_16                  0xc9
>> +#define MAX77759_CHGR_REG_CHG_CNFG_17                  0xca
>> +#define MAX77759_CHGR_REG_CHG_CNFG_18                  0xcb
>> +#define   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN          BIT(0)
>> +#define MAX77759_CHGR_REG_CHG_CNFG_19                  0xcc
>>  
>>  /* MaxQ opcodes for max77759_maxq_command() */
>>  #define MAX77759_MAXQ_OPCODE_MAXLENGTH (MAX77759_MAXQ_REG_AP_DATAOUT32 - \
>> @@ -101,6 +131,84 @@
>>  #define MAX77759_MAXQ_OPCODE_USER_SPACE_READ     0x81
>>  #define MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE    0x82
>>  
>> +/**
>> + * enum max77759_chgr_chgin_dtls_status - Charger Input Status
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
>> + *     Charger input voltage (Vchgin) < Under Voltage Threshold (Vuvlo)
>> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE:
>> + *     Vchgin > Vuvlo and Vchgin < (Battery Voltage (Vbatt) + system voltage (Vsys))
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
>> +/**
>> + * enum max77759_chgr_bat_dtls_states - Battery Details
>> + * @MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:	No battery and the charger suspended
>> + * @MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY:	Vbatt < Vtrickle
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:	Charging suspended due to timer fault
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OKAY:		Battery okay and Vbatt > Min Sys Voltage (Vsysmin)
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:	Battery is okay. Vtrickle < Vbatt < Vsysmin
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:	Battery voltage > Overvoltage threshold
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:	Battery current exceeds overcurrent threshold
>> + * @MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:	Battery only mode and battery level not available
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
>> +/**
>> + * enum max77759_chgr_chg_dtls_states - Charger Details
>> + * @MAX77759_CHGR_CHG_DTLS_PREQUAL:		Charger in prequalification mode
>> + * @MAX77759_CHGR_CHG_DTLS_CC:			Charger in fast charge const curr mode
>> + * @MAX77759_CHGR_CHG_DTLS_CV:			Charger in fast charge const voltage mode
>> + * @MAX77759_CHGR_CHG_DTLS_TO:			Charger is in top off mode
>> + * @MAX77759_CHGR_CHG_DTLS_DONE:		Charger is done
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_1:		Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:		Charger is in timer fault mode
>> + * @MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:	Charger is suspended as battery removal detected
>> + * @MAX77759_CHGR_CHG_DTLS_OFF:			Charger is off. Input invalid or charger disabled
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_2:		Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_RSVD_3:		Reserved
>> + * @MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:	Charger is off as watchdog timer expired
>> + * @MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:		Charger is in JEITA control mode
>> + */
>> +enum max77759_chgr_chg_dtls_states {
>> +	MAX77759_CHGR_CHG_DTLS_PREQUAL,
>> +	MAX77759_CHGR_CHG_DTLS_CC,
>> +	MAX77759_CHGR_CHG_DTLS_CV,
>> +	MAX77759_CHGR_CHG_DTLS_TO,
>> +	MAX77759_CHGR_CHG_DTLS_DONE,
>> +	MAX77759_CHGR_CHG_DTLS_RSVD_1,
>> +	MAX77759_CHGR_CHG_DTLS_TIMER_FAULT,
>> +	MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM,
>> +	MAX77759_CHGR_CHG_DTLS_OFF,
>> +	MAX77759_CHGR_CHG_DTLS_RSVD_2,
>> +	MAX77759_CHGR_CHG_DTLS_RSVD_3,
>> +	MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER,
>> +	MAX77759_CHGR_CHG_DTLS_SUSP_JEITA,
>> +};
>> +
>> +enum max77759_chgr_mode {
>> +	MAX77759_CHGR_MODE_OFF,
>> +	MAX77759_CHGR_MODE_CHG_BUCK_ON = 0x5,
>> +	MAX77759_CHGR_MODE_OTG_BOOST_ON = 0xA,
>> +};
> Would it be safer to explicitly initialise 'MAX77759_CHGR_MODE_OFF' to 0 here?
> Relying on implicit zero initialisation whilst explicitly setting other values
> can sometimes lead to unexpected behaviour if new entries are added.

Sounds good. Will fix.


Best Regards,

Amit

>
