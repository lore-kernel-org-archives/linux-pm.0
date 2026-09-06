Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840503E1D13
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788685064; cv=none; b=OebKVRrafTU3AnKTlvgo8Knbi5HImlicMm4bS86mxrriOqIeQJNQm1siL+n0myiWd/necvm+X0ID82N2OFoEoIf6tGQ9DLpaATEvwcZYrdRLTfK6Y30bJO1FM0Ovd5OriKPNT5PQqf6UL1yxcFnRiCBEoDyTeXNbHh860WCvokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788685064; c=relaxed/simple;
	bh=69nh8IaOIKzC26cw1mZ4EAY2yfa9A/nvDeJqDe2J3iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpctbUul3uSL0sIFY+5wR2GFJqmPrejcSqoghxEbev93owgi2eSVIegYfBDm6j1IZ96+SZUlAJAnLnykTFSjrJ/eed8NCEJj6QbOzHefoxJl3NDWzLJtLMCHJPmom+YsC+Tai6hRNfr9QVnb2c/Tl5odQ7Xa76g7QAVuzO8KZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXgzcXNT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXgzcXNT"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so2803206a12.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788685062; x=1789289862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eINHlrHkYMRasqID9eglHfotXq/uGSEFKbI4CEPXV5Y=;
        b=KXgzcXNTH6M0tMf7qXuf1uyRr+TRmYbk2W0Z7g6u/jM/QcDKqwpAubwKJBsWGL1Wtc
         Hmd8uNFUeS0WO/kDfdwYEGq/Hs4IdzssWygW5hkudyHbSaLGUXALcOjOSJJtjbe7NKH/
         KH7Fdq54zzL+19SSXfHji5V4dpk3VTseG0bfe3cCeQVhU5VLiJfevqd4DQT1Zmp7eGUc
         ml0n42pbYWgLJnBjHSQSbbNvMzzFxfUPEiuoKekKZpsyt33d1ijL0ZQqVfs8Y74jKIl6
         yH/r/KJ4+J6zAvWOgy39SnfNsvE1a7946Z5uFbZqP93I6vGSBNsOawKGYo0ObNHN8THo
         Lrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788685062; x=1789289862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eINHlrHkYMRasqID9eglHfotXq/uGSEFKbI4CEPXV5Y=;
        b=gt8drsmJrn1n9MN4foUMjPE8Gn+1lMeFqo1uyHd3XNU4EnII3msHx/3ls/bEu851Jj
         mofDjwlrncDqZVJIAT//TW1Rf8MRRmKI3DJV2C8J6d5qGHAzAyxUkmXKdvwEQhqM1ahj
         61ThI8MzEmn0oxoLVRR5f25OAL18KcCaiLYHGB1lRdQ+eXJVhFHScRBYvf4vrbsTDaX+
         Pdb4gxZYtKOg3nEXkAUF6htsOb9VMVm96wTn1YBHVM/A0IWRHBuQWErENKpi8I8CLAYr
         VuFPiUlp2CbdWYa1sacdYonFvX5FuH3gvNVEOPzlaIwuK0lWVOqXZITBPvzqtuKtTtdP
         l6mg==
X-Forwarded-Encrypted: i=1; AKwUvByFdPLJMwk0bObz90pQi516/wBCunUWWrkBRuEJRQzFYInadZt8JqzgXZu8UElc6yOsbUgBAoEmKw==@vger.kernel.org
X-Gm-Message-State: AFuF++lpy0H1rkj4UJj3EIxT1HPrOYsuz7TwFcmBrqjjbSrl069cHZm8
	B24yNw2TKUwbniNnhXYbi8zYiO218McJwF98GcUOus0R+8Sr9MCWr3j1
X-Gm-Gg: AYBFou3VGX/cINzXmAUi5hv40QR6MPgzTpaJPqJ0DnUHJcZZ7OdFDGK1snSqgzqpOpo
	bG31CUd7wvyqibApFZDMo90V3hkvM+bXIUp/91M0MlLdt/j+54EwnYsXF8enF5W3Vlj6022/qu7
	pLL3hsr5EJdQ5HW6CRF1aIg+6G7rUw1w8T/aToWfUtDv+BKUPBiiUdeGCF4s7VlLMs0uQEXaPNQ
	jAzUAyVrrEfGttBap+JQXe7MUJaCm+uiexGWtw8Znf4cPSCdzrEYgm2UFQb/BZQFATDtDNWpbFX
	zWMHTiirWTSF8ZigRPafW83wsG1CJAelre2vo1n0U42vxzB2vIWKHqNS0HvapZAWefFdJOS/tLV
	EH/MtpyhlHNqLehJqh2ytW+oAYZGpSqKgw/VMDJJ0OseFC6tJoRvz2NxKea1AfIwfKyt/4LfLUD
	BrbwcPOGnzCKaJ5ImOYIW8avV/ynQ9zN2b50T6a9s+XRZBwgcqlQTYCVl+U0S227YM
X-Received: by 2002:a05:6a20:1609:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3da39fef371mr30083031637.18.1788685061709;
        Sun, 06 Sep 2026 01:57:41 -0700 (PDT)
Received: from [192.168.101.188] ([207.90.239.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm14968056eec.4.2026.09.06.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 01:57:41 -0700 (PDT)
Message-ID: <f3b6c6f4-2be9-4eab-b4ba-970cae865753@gmail.com>
Date: Sun, 6 Sep 2026 16:57:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] thermal/drivers/sun8i: Add support for A523 THS0/1
 controllers
To: wens@kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260704171411.1413349-1-iuncuim@gmail.com>
 <20260704171411.1413349-5-iuncuim@gmail.com>
 <CAGb2v67Z0g37Wyvd=xaMGkLHt09qqqJnufsxKdG0nO_C2QmOGA@mail.gmail.com>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <CAGb2v67Z0g37Wyvd=xaMGkLHt09qqqJnufsxKdG0nO_C2QmOGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/26 23:23, Chen-Yu Tsai wrote:
> On Sun, Jul 5, 2026 at 1:15 AM Mikhail Kalashnikov <iuncuim@gmail.com> wrote:
>>
>> The A523 processor has two temperature controllers, THS0 and THS1.
>> THS0 has only one temperature sensor, which is located in the DRAM
>> controller. THS1 does have 3 sensors:
>> ths1_0 - "big" cores
>> ths1_1 - "little" cores
>> ths1_2 - gpu
>>
>> The datasheet mentions a fourth sensor in the NPU, but lacks any registers
>> for operation other than calibration registers. The vendor code reads the
>> value from ths1_2, but uses separate calibration data, so we get two
>> different values from real one.
> 
> Are you sure? The calibration data is written to the sensor register.
> 
> The BSP simply reads the sensor data from the GPU sensor, and passes it
> off as the value for the NPU sensor. No extra calculation involving the
> calibration data is done.
> 
Yes, I think you're right. And as Juan pointed out, my current
implementation doesn't match the BSP, since:

#define SUN55IW3_GPU_SENSOR_ID (2)
#define SUN55IW3_NPU_SENSOR_ID (3)
...
/* use NPU sensor data instead of GPU */
if (id == SUN55IW3_GPU_SENSOR_ID) {
     id = SUN55IW3_NPU_SENSOR_ID;
     ...
}

In other words, in the BSP driver, the NPU sensor is used for the GPU. 
However, based on the A523 user manual—which describes registers for
only three sensors, I had argued the opposite. The user manual for the
T527 includes a description of a fourth sensor.

Thus, it seems that all four sensors are working, but the purpose of
this workaround in the BSP remains unclear to me.

>>
>> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>> ---
>>   drivers/thermal/sun8i_thermal.c | 133 ++++++++++++++++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>
>> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
>> index 3bdd62aa8..f48ed9eae 100644
>> --- a/drivers/thermal/sun8i_thermal.c
>> +++ b/drivers/thermal/sun8i_thermal.c
>> @@ -59,6 +59,12 @@
>>   #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)                ((GENMASK(19, 0) & (x)) << 12)
>>   #define SUN50I_H6_THS_DATA_IRQ_STS(x)          BIT(x)
>>
>> +#define SUN55I_A523_DELIMITER                  0x7c8
>> +#define SUN55I_A523_OFFSET_ABOVE               2736
>> +#define SUN55I_A523_OFFSET_BELOW               2825
>> +#define SUN55I_A523_SCALE_ABOVE                        74
>> +#define SUN55I_A523_SCALE_BELOW                        65
>> +
>>   struct tsensor {
>>          struct ths_device               *tmdev;
>>          struct thermal_zone_device      *tzd;
>> @@ -114,6 +120,15 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
>>                  return -1590 * reg / 10 + 276000;
>>   }
>>
>> +static int sun55i_a523_calc_temp(struct ths_device *tmdev,
>> +                                int id, int reg)
>> +{
>> +       if (reg >= SUN55I_A523_DELIMITER)
>> +               return SUN55I_A523_SCALE_ABOVE * (SUN55I_A523_OFFSET_ABOVE - reg);
>> +       else
>> +               return SUN55I_A523_SCALE_BELOW * (SUN55I_A523_OFFSET_BELOW - reg);
>> +}
>> +
>>   static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
>>   {
>>          struct tsensor *s = thermal_zone_device_priv(tz);
>> @@ -299,6 +314,97 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>>          return 0;
>>   }
>>
>> +/*
>> + * The A523 nvmem calibration values. The ths1_3 is not used as it
>> + * doesn't have its own sensor and doesn't have any internal switch.
>> + * Instead, the value from the ths1_2 sensor is used, which gives the
>> + * illusion of an independent sensor for NPU and GPU when using
>> + * different calibration values.
>> + *
>> + * efuse layout 0x38-0x3F (caldata[0..3]):
>> + *     caldata[0]      caldata[1]      caldata[2]      caldata[3]
>> + * 0               16      24      32  36          48          60 64
>> + * +---------------+---------------+---------------+---------------+
>> + * |               |       |   temp    |  ths1_0   |  ths1_1   |   +
>> + * +---------------+---------------+---------------+---------------+
>> + *
>> + * efuse layout 0x44-0x4B (caldata[4..7]):
>> + *     caldata[4]      caldata[5]      caldata[6]      caldata[7]
>> + * 0           12  16      24      32  36          48             64
>> + * +---------------+---------------+---------------+---------------+
>> + * |  ths1_2   |  ths1_3   |    ths0   |           |               +
>> + * +---------------+---------------+---------------+---------------+
>> + */
>> +static int sun55i_a523_ths_calibrate(struct ths_device *tmdev,
>> +                                    u16 *caldata, int callen)
>> +{
>> +       struct device *dev = tmdev->dev;
>> +       int i, ft_temp;
>> +
>> +       if (!caldata[0])
>> +               return -EINVAL;
>> +
>> +       ft_temp = (((caldata[2] << 8) | (caldata[1] >> 8)) & FT_TEMP_MASK) * 100;
>> +
>> +       for (i = 0; i < tmdev->chip->sensor_num; i++) {
>> +               int sensor_reg, sensor_temp, cdata, offset;
>> +               /*
>> +                * Chips ths0 and ths1 have common parameters for value
>> +                * calibration. To separate them we can use the number of
>> +                * temperature sensors on each chip.
>> +                * For ths0 this value is 1.
>> +                */
>> +               if (tmdev->chip->sensor_num == 1) {
>> +                       sensor_reg = ((caldata[5] >> 8) | (caldata[6] << 8)) & TEMP_CALIB_MASK;
>> +               } else {
>> +                       switch (i) {
>> +                       case 0:
>> +                               sensor_reg = (caldata[2] >> 4) & TEMP_CALIB_MASK;
>> +                               break;
>> +                       case 1:
>> +                               sensor_reg = caldata[3] & TEMP_CALIB_MASK;
>> +                               break;
>> +                       case 2:
>> +                               sensor_reg = caldata[4] & TEMP_CALIB_MASK;
>> +                               break;
>> +                       default:
>> +                               sensor_reg = 0;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
>> +
>> +               /*
>> +                * Calibration data is CALIBRATE_DEFAULT - (calculated
>> +                * temperature from sensor reading at factory temperature
>> +                * minus actual factory temperature) * X (scale from
>> +                * temperature to register values)
>> +                */
>> +               cdata = CALIBRATE_DEFAULT -
>> +                       ((sensor_temp - ft_temp) / SUN55I_A523_SCALE_ABOVE);
> 
> The BSP version works out to:
> 
>      cdata = CALIBRATE_DEFAULT -
>              (sensor_temp - ft_temp - 5000) / SU55I_A523_SCALE_BELOW
> 
> Any particular reason why it's different?

In the early versions, I didn't use 'define' for constants, but later
added them based on the logic of the value read from the register: a
value below the threshold is 'BELOW', and a value above is 'ABOVE'. The
BSP driver uses a name for the temperature, but the temperature
decreases as the value read from the register increases; therefore, the
formula uses SCALE constants with different names but identical values.

In the next version, I’ll align them with the BSP values and add a 
comment explaining that the constants refer to the final temperature 
value, not the value read from the register.

Regarding SUN55IW3_CAL_COM 5000 — when I first looked at the driver
code, it seemed to me that this was the value intended for ft_deviation,
but now that I’ve double-checked, the version of the calibration formula
with SUN55IW3_CAL_COM and without ft_deviation gives the same result as
the version without SUN55IW3_CAL_COM but with ft_deviation=5000.

But if you'd rather I match BSP literally (5000 in the calibration
numerator, ft_deviation = 0), I can do that instead.
> 
>> +               if (cdata & ~TEMP_CALIB_MASK) {
>> +                       /*
>> +                        * Calibration value more than 12-bit, but calibration
>> +                        * register is 12-bit. In this case, ths hardware can
>> +                        * still work without calibration, although the data
>> +                        * won't be so accurate.
>> +                        */
>> +                       dev_warn(dev, "sensor%d is not calibrated.\n", i);
>> +                       continue;
>> +               }
>> +
>> +               offset = (i % 2) * 16;
>> +               regmap_update_bits(tmdev->regmap,
>> +                                  SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
>> +                                  TEMP_CALIB_MASK << offset,
>> +                                  cdata << offset);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int sun8i_ths_calibrate(struct ths_device *tmdev)
>>   {
>>          struct nvmem_cell *calcell = NULL;
>> @@ -717,6 +823,31 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
>>          .calc_temp = sun8i_ths_calc_temp,
>>   };
>>
>> +/* The A523 has a shared reset line for both chips */
>> +static const struct ths_thermal_chip sun55i_a523_ths0 = {
>> +       .sensor_num = 1,
>> +       .has_bus_clk_reset = true,
>> +       .has_mod_clk = true,
>> +       .ft_deviation = 5000,
> 
> In the BSP this is 0.

> 
>> +       .temp_data_base = SUN50I_H6_THS_TEMP_DATA,
>> +       .calibrate = sun55i_a523_ths_calibrate,
>> +       .init = sun50i_h6_thermal_init,
>> +       .irq_ack = sun50i_h6_irq_ack,
>> +       .calc_temp = sun55i_a523_calc_temp,
>> +};
>> +
>> +static const struct ths_thermal_chip sun55i_a523_ths1 = {
>> +       .sensor_num = 3,
>> +       .has_bus_clk_reset = true,
>> +       .has_mod_clk = true,
>> +       .ft_deviation = 5000,
> 
> In the BSP this is 0.
> 
> 
> ChenYu
> 
>> +       .temp_data_base = SUN50I_H6_THS_TEMP_DATA,
>> +       .calibrate = sun55i_a523_ths_calibrate,
>> +       .init = sun50i_h6_thermal_init,
>> +       .irq_ack = sun50i_h6_irq_ack,
>> +       .calc_temp = sun55i_a523_calc_temp,
>> +};
>> +
>>   static const struct of_device_id of_ths_match[] = {
>>          { .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
>>          { .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
>> @@ -727,6 +858,8 @@ static const struct of_device_id of_ths_match[] = {
>>          { .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
>>          { .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
>>          { .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
>> +       { .compatible = "allwinner,sun55i-a523-ths0", .data = &sun55i_a523_ths0 },
>> +       { .compatible = "allwinner,sun55i-a523-ths1", .data = &sun55i_a523_ths1 },
>>          { /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_ths_match);
>> --
>> 2.55.0
>>

