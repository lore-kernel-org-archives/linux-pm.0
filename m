Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3834CFC2
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693949; cv=none; b=Af2qm+r2gnhI0C+xRR5eNZIm1ZYqQVs0dE/I57mFFRiPZ8+9fHZyTqAzNMAnFH+khqrDG9ATX3QNiUnuKAdGDzjbV+yJuyl0Cvdrn4kKUNSLeaTyW/PJ3kZMvBPkAq+LPmVUlpdlwRkTnlpR3RpwFy8aPoRnoo4BXke9NsZy1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693949; c=relaxed/simple;
	bh=34Q8CPQ8Lo61DRCeyTpcD9vOwlejaU/j1ICNvnMwO+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOfEFcZ4ticq6ymp8CNq4bxI+Qx83wnlnfZc/PSIInbY0LS/KpNLpKDkBOOYISkaXmOEzrW2VYe+xWIkcLXzDi4Zhldc0K3zlwunEGV3s1JX7vOSNKrz/oyLKn6NESOcj77DN7oB++OvJwbA6p42hvmzz/Tdnl0+AFcU/xWJdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlhUiSOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlhUiSOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271311F00ACF
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693948;
	bh=tyJsuc9PaPdLgORfT3uiTThaK4L4eJX6fQzE7ImmQXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YlhUiSOSzGmf+rSOaKj0ZiAEFOTKU943wfmGijsjdjeUx9xne3kICWyWgBvyJZYR3
	 rlaqAlw1hg8myKy/Ni6IrqqasyD433iiRaUIHKNrjTxi/23j9luXFDRtTM4TX3CH7i
	 5eJRin/f/mLxksjKGGIfTZGYvRfVVzsEoSbRL/4VrQp0LWFUcoQhzLSvRGHm5CEV6h
	 MB0ji3+FvCpRKDi3iqQd3nKqwgLCmlIrfQIRKyPpz5veAwoyAaIy9D+EjXSZbKJUg1
	 aKwslhcXEcegGFiV2HN7Hso2dDMqpzANeczvSHlisf+e+P39d6fSwH3FKzHu8erNl5
	 OHIuCFOf81evA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1634119a12.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 07:32:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpuEEmXnvvRs6OVJhN5i7aTOt/4k+6IzIyFw638sTufahieGwbNGJsbU2pjHkyWFkSiu26xWC8KFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkn7Xxk0wtYo0da5ri5iWZtaOtepvuFgymZuCxH10wmWZLirG8
	Sf7fvOuGsJTMF6JRZdVOS2sfzSv9XDrbt4A1prezpuR/LdU1+O6VbTKA63YJvRv569PMuHz1fVq
	s91q/RlcMg8G7zT31bfCBAEsVkgNn3Ac=
X-Received: by 2002:a05:6402:254a:b0:698:be17:3790 with SMTP id
 4fb4d7f45d1cf-69ab44c57e4mr4834940a12.37.1783693946694; Fri, 10 Jul 2026
 07:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783670011.git.zhoubinbin@loongson.cn> <e5a574b2ae0e5e0ec32fe81c0ccd03eb3ad5a164.1783670011.git.zhoubinbin@loongson.cn>
In-Reply-To: <e5a574b2ae0e5e0ec32fe81c0ccd03eb3ad5a164.1783670011.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 10 Jul 2026 22:32:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Ae=J9a6y6C9WE-sfUJnrypWpc8e01VHJ3ndVt-F+RXA@mail.gmail.com>
X-Gm-Features: AUfX_mziIzRPDFM4jEXixCD6AJpuR4HyI52Kf5Ge1o84mQHZXbLbTaz_oreouGE
Message-ID: <CAAhV-H6Ae=J9a6y6C9WE-sfUJnrypWpc8e01VHJ3ndVt-F+RXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal/drivers/loongson2: Add thermal driver support
 for Loongson-2K0300
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Fri, Jul 10, 2026 at 4:25=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> The Loongson-2K0300 SoC uses a new thermal sensor that requires reading
> a separate CPU ID register to obtain hardware version information. This
> version info is used as a correction factor (fix_data) in the
> temperature calculation formula.
>
> Its thermal sensor requires the following hardware-specific handling:
>  - Read chip ID register (offset 0x0 and 0x4) to get the compensation
>    value (comp_val). The value is stored in either bits [31:20] of the
>    ID0 register or bits [15:0] of the ID1 register, depending on the
>    EXTERN_ID bit.
>
>  - The compensation value is a signed 15-bit field; extract the value
>    and apply sign accordingly.
>
> Additionally, some early Loongson-2K0300 chips may have an old fuse that
> yields invalid temperature readings outside the -55 to 125 range. In
> such cases, the driver falls back to a simplified formula (raw * 569 -
> 394700) and logs a warning, ensuring the system can still function
> without crashing.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/thermal/loongson2_thermal.c | 83 ++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongs=
on2_thermal.c
> index ea4dd2fb1f47..a7eb87070aa9 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -2,9 +2,11 @@
>  /*
>   * Author: zhanghongchen <zhanghongchen@loongson.cn>
>   *         Yinbo Zhu <zhuyinbo@loongson.cn>
> - * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + * Copyright (C) 2022-2026 Loongson Technology Corporation Limited
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/minmax.h>
> @@ -23,27 +25,44 @@
>  #define LOONGSON2_THSENS_CTRL_LOW_REG  0x8
>  #define LOONGSON2_THSENS_STATUS_REG    0x10
>  #define LOONGSON2_THSENS_OUT_REG       0x14
> +#define LOONGSON2_THSENS_CFG_REG       0x18
>
>  #define LOONGSON2_THSENS_INT_LO                BIT(0)
>  #define LOONGSON2_THSENS_INT_HIGH      BIT(1)
>  #define LOONGSON2_THSENS_INT_EN                (LOONGSON2_THSENS_INT_LO =
| \
>                                          LOONGSON2_THSENS_INT_HIGH)
>  #define LOONGSON2_THSENS_OUT_MASK      0xFF
> +#define LS2K0300_THSENS_OUT_MASK       GENMASK(10, 0)
The naming is a little strange, maybe use LOONGSON2_THSENS_OUT_8B_MASK
and LOONGSON2_THSENS_OUT_10B_MASK?

> +
> +#define LS2K0300_CHIP_ID1              0x4
Also define LS2K0300_CHIP_ID0 here?

> +#define LS2K0300_EXTERN_ID             BIT(4)
> +#define LS2K0300_ID0_VAL_MASK          GENMASK(31, 20)
> +#define LS2K0300_ID1_VAL_MASK          GENMASK(15, 0)
> +
> +#define LS2K0300_COMP_VAL_MASK         GENMASK(14, 0)
> +#define LS2K0300_COMP_SIGN_BIT         BIT(15)
> +
> +#define LS2K0300_LOWEST_VALID_TEMP     (-55000)
> +#define LS2K0300_HIGHEST_VALID_TEMP    (125000)
>
>  /*
>   * This flag is used to indicate the temperature reading
>   * method of the Loongson-2K2000
>   */
>  #define LS2K2000_THSENS_OUT_FLAG       BIT(0)
> +#define LS2K0300_CHIP_ID_FLAG          BIT(1)
>
>  struct loongson2_thermal_chip_data {
>         unsigned int thermal_sensor_sel;
>         unsigned int flags;
> +       const struct thermal_zone_device_ops *thermal_ops;
>  };
>
>  struct loongson2_thermal_data {
> +       struct device *dev;
>         void __iomem *ctrl_reg;
>         void __iomem *temp_reg;
> +       void __iomem *id_reg;
>         const struct loongson2_thermal_chip_data *chip_data;
>  };
>
> @@ -71,6 +90,38 @@ static int loongson2_thermal_set(struct loongson2_ther=
mal_data *data,
>         return 0;
>  }
>
> +static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, int=
 *temp)
> +{
> +       struct loongson2_thermal_data *tdata =3D thermal_zone_device_priv=
(tz);
> +       int calib_data, calib_offset, temp_mc, raw_adc;
> +       u32 chip_id0, chip_id1;
> +
> +       raw_adc =3D FIELD_GET(LS2K0300_THSENS_OUT_MASK,
> +                           readl(tdata->ctrl_reg + LOONGSON2_THSENS_OUT_=
REG));
> +       chip_id0 =3D readl(tdata->id_reg);
> +       chip_id1 =3D readl(tdata->id_reg + LS2K0300_CHIP_ID1);
> +
> +       if (chip_id0 & LS2K0300_EXTERN_ID)
> +               calib_data =3D FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id1)=
;
> +       else
> +               calib_data =3D FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id0)=
;
> +
> +       calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_data);
> +       if (calib_data & LS2K0300_COMP_SIGN_BIT)
> +               calib_offset =3D -calib_offset;
> +
> +       temp_mc =3D (raw_adc + calib_offset) * 570 - 394700;
> +
> +       /* For old fuse which can not read right thermal data */
> +       if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_HI=
GHEST_VALID_TEMP) {
Is there a better way to detect the old fuse? Because I think temp_mc
between LS2K0300_LOWEST_VALID_TEMP and  LS2K0300_HIGHEST_VALID_TEMP is
also not valid for the old fuse.

Huacai

> +               dev_warn_once(tdata->dev, "It's an old fuse, thermal %d i=
s not right\n", temp_mc);
> +               temp_mc =3D raw_adc * 569 - 394700;
> +       }
> +       *temp =3D temp_mc;
> +
> +       return 0;
> +}
> +
>  static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int=
 *temp)
>  {
>         int val;
> @@ -112,6 +163,11 @@ static int loongson2_thermal_set_trips(struct therma=
l_zone_device *tz, int low,
>         return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
>  }
>
> +static const struct thermal_zone_device_ops loongson2_2k0300_of_thermal_=
ops =3D {
> +       .get_temp =3D loongson2_2k0300_get_temp,
> +       .set_trips =3D loongson2_thermal_set_trips,
> +};
> +
>  static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_=
ops =3D {
>         .get_temp =3D loongson2_2k1000_get_temp,
>         .set_trips =3D loongson2_thermal_set_trips,
> @@ -124,7 +180,6 @@ static const struct thermal_zone_device_ops loongson2=
_2k2000_of_thermal_ops =3D {
>
>  static int loongson2_thermal_probe(struct platform_device *pdev)
>  {
> -       const struct thermal_zone_device_ops *thermal_ops;
>         struct device *dev =3D &pdev->dev;
>         struct loongson2_thermal_data *data;
>         struct thermal_zone_device *tzd;
> @@ -134,6 +189,7 @@ static int loongson2_thermal_probe(struct platform_de=
vice *pdev)
>         if (!data)
>                 return -ENOMEM;
>
> +       data->dev =3D dev;
>         data->chip_data =3D device_get_match_data(dev);
>
>         data->ctrl_reg =3D devm_platform_ioremap_resource(pdev, 0);
> @@ -145,10 +201,13 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
>                 data->temp_reg =3D devm_platform_ioremap_resource(pdev, 1=
);
>                 if (IS_ERR(data->temp_reg))
>                         return PTR_ERR(data->temp_reg);
> +       }
>
> -               thermal_ops =3D &loongson2_2k2000_of_thermal_ops;
> -       } else {
> -               thermal_ops =3D &loongson2_2k1000_of_thermal_ops;
> +       /* The chip id register is needed for Loongson-2K0300 */
> +       if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
> +               data->id_reg =3D devm_platform_ioremap_resource(pdev, 1);
> +               if (IS_ERR(data->id_reg))
> +                       return PTR_ERR(data->id_reg);
>         }
>
>         irq =3D platform_get_irq(pdev, 0);
> @@ -160,7 +219,7 @@ static int loongson2_thermal_probe(struct platform_de=
vice *pdev)
>         loongson2_thermal_set(data, 0, 0, false);
>
>         for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> -               tzd =3D devm_thermal_of_zone_register(dev, i, data, therm=
al_ops);
> +               tzd =3D devm_thermal_of_zone_register(dev, i, data, data-=
>chip_data->thermal_ops);
>
>                 if (!IS_ERR(tzd))
>                         break;
> @@ -181,17 +240,29 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
>         return 0;
>  }
>
> +static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k03=
00_data =3D {
> +       .thermal_sensor_sel =3D 0,
> +       .flags =3D LS2K0300_CHIP_ID_FLAG,
> +       .thermal_ops =3D &loongson2_2k0300_of_thermal_ops,
> +};
> +
>  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k10=
00_data =3D {
>         .thermal_sensor_sel =3D 0,
>         .flags =3D 0,
> +       .thermal_ops =3D &loongson2_2k1000_of_thermal_ops,
>  };
>
>  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k20=
00_data =3D {
>         .thermal_sensor_sel =3D 0,
>         .flags =3D LS2K2000_THSENS_OUT_FLAG,
> +       .thermal_ops =3D &loongson2_2k2000_of_thermal_ops,
>  };
>
>  static const struct of_device_id of_loongson2_thermal_match[] =3D {
> +       {
> +               .compatible =3D "loongson,ls2k0300-thermal",
> +               .data =3D &loongson2_thermal_ls2k0300_data,
> +       },
>         {
>                 .compatible =3D "loongson,ls2k1000-thermal",
>                 .data =3D &loongson2_thermal_ls2k1000_data,
> --
> 2.52.0
>
