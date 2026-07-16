Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D927F19F
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169100; cv=pass; b=P3jejW6Ol6e/vzahhUHgAFpP6Un75/BqazVixy/E5iycL/lsw7Afq9dbNUuPuhLAyCzPCs5g17/SpsfmppGOkMetKkxATsJLdZy4quQENDHlTgCXA7x0WTfgZZ3VzR8k1Y+zkyA/CjwiT014OsHnuGICA4kWrtJD1LG5ioQTKrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169100; c=relaxed/simple;
	bh=R12zT8nSn9I0UCnw+iJtdZou5moWo+Kod+zyFuStb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWcwzCL4YWFY8CLt6LdqeO4gcnlKgvvTBFD2XGMfv1dxV4LCiHW5IcV52Hc0sau8OB+Jc1SHBVhYJhoRniuMxzeZPajzGv/1bewOX0DVQJ3lJUNxiAl6WLGnaUi5Fw4vfrWdxErkM7yVv7XxgEJD5NXB59HN/SEl9fuDHZr360k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeYB+X+C; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeYB+X+C"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e2dab83eso436108466b.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 19:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784169097; cv=none;
        d=google.com; s=arc-20260327;
        b=PLb50P0jHwsljGsRLLxWuVfVCwxnZ3V1dZg0Qh8ST5Cvq36JesQ4R26tjjAtsa0Ixu
         ft5Bcp8c/NKII4QKx3VbJiDruTdI5ZQWvN5Ood8eff55HnCPMn7nQs25LPPrVnnAE+k9
         SkuAB0KWhDQCDneveic+uY7cswMCyhwxQ7SWJ8CnMNYjmTzqpRGAz52MfnJsqMTeBNqE
         /mNwL7RcPhNIHlEG3bYEsDkbNUqp3HGVAHYisczvr3HUOtAY8IkRz1a3py6OD7HXpXt+
         7UNR1xlWPI+K+YvyHd9LoaWyVnzOVv1g90nob7ZIuqGx5zgybApuFLh4+s3S8d9eW8aM
         ki3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9RYbpoJ3iiaewLH/Dkbk54m1hisFAlN4vItAzmGB5U=;
        fh=cS3kcDkWebZOe51KIxWBUAbnBuMZWMKhdFnwwu6mALU=;
        b=ZbDF+UKjTZMyZ6BtnKwd6A4n/HLj2yVUJbw8+kapC4wRe3R7ibUe5xfXrZ3CccLwF2
         MRoo8B2NVJA+YMtr9Zx/UY2al636K6e5x4zFgojb/Nozzuq/HTxqC8FW0MAOixssdyhS
         B10DGDZBHB/tRlLc4KMX9Ce9Mo4b0z826TxFcHpbZFcGEic7Lu8u/iQ9Qe6nc04M64w9
         uQbRaNBU6uN2+qM9Fo2kKoe2FpiBdwrmJaxdGF5iBj/6hc/wkM+OpvyxKsPT8VT48FLL
         WY46tVfac2KCdTwPUAj/us+l42qz1/vb2CWQGiqChSxxUJs2x/FcowfNAd016KNKaQgN
         TtWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169097; x=1784773897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9RYbpoJ3iiaewLH/Dkbk54m1hisFAlN4vItAzmGB5U=;
        b=jeYB+X+CVDujY8aoH46IalzhDJndXSNrzi8ug1VbOOby87bzUDjScfXRTNBzP57tUG
         FhKlAbLHkXpt19Z+iBVJjjji/LPUBVgzR6x7cwpuBne5XX8JGFxU3N0dvamNbz6ED5ln
         /lDXu6zgrnN7OR0z3TsgpwYfzbQwxjKorbX5RXdoE7MiZ/B7/DSq1rzlAKjYBIDTexBa
         1HDjUDTAefsCv6lS/SKuWO2Uv2L1jHAOax/sbm2CLZR64UQ+lZcgpCUXyB4vebToeABB
         iuYlnvuA7YWJeieK+V46oo98j06OZIQGBetSb1rCWjCP4yg7ua3rFUNymD1DFrR3fdmZ
         hY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169097; x=1784773897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9RYbpoJ3iiaewLH/Dkbk54m1hisFAlN4vItAzmGB5U=;
        b=kJF80JrRinMozU3KpKZovO+MFfQ/OntlGmwhV1Qv0gE8qbUd/7mt+/KitNLOGAL7T0
         cPAvK5k0M/ICLqp34f0dgLcEQvt1qOkX2VIWlh16qhbnTenYA6b/SZoKkDMhR9hBC2Am
         UbtcUJ68kc8/VQ4n8GHURpm9kEnMSfGlO2Fb8P9GjcU2NRmHHWtdePto21ke+HLEGJJm
         82E8OFKSJDR5z2wFNFVXR2SrOpDckDccTR1vx7lZhMBoG56qONTduv8DS19v/9oR2z5A
         2FES7X0yxPcWh6zsDe70iy5f8iLh4GcZS+mGPxvPGPHnY7dvoEQ0pcX0wmMp1nmwq3iF
         u4cw==
X-Forwarded-Encrypted: i=1; AHgh+RqTLXNUv7izuph2RYniw/ZQ2CqZSGWTefCuWibjrtwUuTKPD7eSSpDMkd84Pc7M1LkosICVxpxGRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwT+gWAK4XCxdlppUNELEoZilPBgpA3ZH/IcAG1G0RCaeAGjw
	Wg8jfml+4NXhWith+Rp9A2YRIUm1bz/Bay3cx27TUY2h1dgjACuXZmrMIuHQs4Bs5QfmUTnVJAa
	ypD7YpTn9+aZrvhZZ9nNq27d7JF+CSPQ=
X-Gm-Gg: AfdE7cnMj4bJu4a0293nHrQ596KcnGGxkpVVpjXJk4LBXvlF3kob5zfxrL4AgKy29w2
	1LkBtn/nl8QjC6a0jP9fJ4YNTh6y1BkVLfJs0IUgQMS3fINfn8t8Gk5cSetiMUw+EAIzwBC4IWl
	BAPUDnHyIct545s3mk5fhSnAEaSbyctpZVMGYWZwWenaIw88bzKMWnQWijoiepgSbcmtCcDx3g0
	pIrUtrawCiDzZIN5XQeXnrBHVm0AZlaSAIMuTjUJYzjOdXRDtCSKkauMXDQgH6v
X-Received: by 2002:a05:6938:a08e:20b0:c16:8931:245c with SMTP id
 a640c23a62f3a-c16893125d4mr103944966b.21.1784169096566; Wed, 15 Jul 2026
 19:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783670011.git.zhoubinbin@loongson.cn> <e5a574b2ae0e5e0ec32fe81c0ccd03eb3ad5a164.1783670011.git.zhoubinbin@loongson.cn>
 <CAAhV-H6Ae=J9a6y6C9WE-sfUJnrypWpc8e01VHJ3ndVt-F+RXA@mail.gmail.com>
In-Reply-To: <CAAhV-H6Ae=J9a6y6C9WE-sfUJnrypWpc8e01VHJ3ndVt-F+RXA@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 16 Jul 2026 10:31:23 +0800
X-Gm-Features: AUfX_mxc3FOZacVEQWuO-hOpQgpgQhvkeExldue96dEwy1_jdBhNox5YznqP9aE
Message-ID: <CAMpQs4JQTnP96akj9V8iHjnPSj10_zmv=0+0j-6RbUB304BF0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal/drivers/loongson2: Add thermal driver support
 for Loongson-2K0300
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi:

On Fri, Jul 10, 2026 at 10:32=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Binbin,
>
> On Fri, Jul 10, 2026 at 4:25=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.=
cn> wrote:
> >
> > The Loongson-2K0300 SoC uses a new thermal sensor that requires reading
> > a separate CPU ID register to obtain hardware version information. This
> > version info is used as a correction factor (fix_data) in the
> > temperature calculation formula.
> >
> > Its thermal sensor requires the following hardware-specific handling:
> >  - Read chip ID register (offset 0x0 and 0x4) to get the compensation
> >    value (comp_val). The value is stored in either bits [31:20] of the
> >    ID0 register or bits [15:0] of the ID1 register, depending on the
> >    EXTERN_ID bit.
> >
> >  - The compensation value is a signed 15-bit field; extract the value
> >    and apply sign accordingly.
> >
> > Additionally, some early Loongson-2K0300 chips may have an old fuse tha=
t
> > yields invalid temperature readings outside the -55 to 125 range. In
> > such cases, the driver falls back to a simplified formula (raw * 569 -
> > 394700) and logs a warning, ensuring the system can still function
> > without crashing.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/thermal/loongson2_thermal.c | 83 ++++++++++++++++++++++++++---
> >  1 file changed, 77 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index ea4dd2fb1f47..a7eb87070aa9 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -2,9 +2,11 @@
> >  /*
> >   * Author: zhanghongchen <zhanghongchen@loongson.cn>
> >   *         Yinbo Zhu <zhuyinbo@loongson.cn>
> > - * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> > + * Copyright (C) 2022-2026 Loongson Technology Corporation Limited
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/minmax.h>
> > @@ -23,27 +25,44 @@
> >  #define LOONGSON2_THSENS_CTRL_LOW_REG  0x8
> >  #define LOONGSON2_THSENS_STATUS_REG    0x10
> >  #define LOONGSON2_THSENS_OUT_REG       0x14
> > +#define LOONGSON2_THSENS_CFG_REG       0x18
> >
> >  #define LOONGSON2_THSENS_INT_LO                BIT(0)
> >  #define LOONGSON2_THSENS_INT_HIGH      BIT(1)
> >  #define LOONGSON2_THSENS_INT_EN                (LOONGSON2_THSENS_INT_L=
O | \
> >                                          LOONGSON2_THSENS_INT_HIGH)
> >  #define LOONGSON2_THSENS_OUT_MASK      0xFF
> > +#define LS2K0300_THSENS_OUT_MASK       GENMASK(10, 0)
> The naming is a little strange, maybe use LOONGSON2_THSENS_OUT_8B_MASK
> and LOONGSON2_THSENS_OUT_10B_MASK?
>
> > +
> > +#define LS2K0300_CHIP_ID1              0x4
> Also define LS2K0300_CHIP_ID0 here?
>
> > +#define LS2K0300_EXTERN_ID             BIT(4)
> > +#define LS2K0300_ID0_VAL_MASK          GENMASK(31, 20)
> > +#define LS2K0300_ID1_VAL_MASK          GENMASK(15, 0)
> > +
> > +#define LS2K0300_COMP_VAL_MASK         GENMASK(14, 0)
> > +#define LS2K0300_COMP_SIGN_BIT         BIT(15)
> > +
> > +#define LS2K0300_LOWEST_VALID_TEMP     (-55000)
> > +#define LS2K0300_HIGHEST_VALID_TEMP    (125000)
> >
> >  /*
> >   * This flag is used to indicate the temperature reading
> >   * method of the Loongson-2K2000
> >   */
> >  #define LS2K2000_THSENS_OUT_FLAG       BIT(0)
> > +#define LS2K0300_CHIP_ID_FLAG          BIT(1)
> >
> >  struct loongson2_thermal_chip_data {
> >         unsigned int thermal_sensor_sel;
> >         unsigned int flags;
> > +       const struct thermal_zone_device_ops *thermal_ops;
> >  };
> >
> >  struct loongson2_thermal_data {
> > +       struct device *dev;
> >         void __iomem *ctrl_reg;
> >         void __iomem *temp_reg;
> > +       void __iomem *id_reg;
> >         const struct loongson2_thermal_chip_data *chip_data;
> >  };
> >
> > @@ -71,6 +90,38 @@ static int loongson2_thermal_set(struct loongson2_th=
ermal_data *data,
> >         return 0;
> >  }
> >
> > +static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, i=
nt *temp)
> > +{
> > +       struct loongson2_thermal_data *tdata =3D thermal_zone_device_pr=
iv(tz);
> > +       int calib_data, calib_offset, temp_mc, raw_adc;
> > +       u32 chip_id0, chip_id1;
> > +
> > +       raw_adc =3D FIELD_GET(LS2K0300_THSENS_OUT_MASK,
> > +                           readl(tdata->ctrl_reg + LOONGSON2_THSENS_OU=
T_REG));
> > +       chip_id0 =3D readl(tdata->id_reg);
> > +       chip_id1 =3D readl(tdata->id_reg + LS2K0300_CHIP_ID1);
> > +
> > +       if (chip_id0 & LS2K0300_EXTERN_ID)
> > +               calib_data =3D FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id=
1);
> > +       else
> > +               calib_data =3D FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id=
0);
> > +
> > +       calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_data);
> > +       if (calib_data & LS2K0300_COMP_SIGN_BIT)
> > +               calib_offset =3D -calib_offset;
> > +
> > +       temp_mc =3D (raw_adc + calib_offset) * 570 - 394700;
> > +
> > +       /* For old fuse which can not read right thermal data */
> > +       if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_=
HIGHEST_VALID_TEMP) {
> Is there a better way to detect the old fuse? Because I think temp_mc
> between LS2K0300_LOWEST_VALID_TEMP and  LS2K0300_HIGHEST_VALID_TEMP is
> also not valid for the old fuse.

Try communicating in person; there=E2=80=99s no better way. The current
judgment criteria can only accommodate the standard temperature range.

Also, the `old fuse` refers to the very first batch of chips, so I
don=E2=80=99t think the scope of the issue will be very broad.
>
> Huacai
>
> > +               dev_warn_once(tdata->dev, "It's an old fuse, thermal %d=
 is not right\n", temp_mc);
> > +               temp_mc =3D raw_adc * 569 - 394700;
> > +       }
> > +       *temp =3D temp_mc;
> > +
> > +       return 0;
> > +}
> > +
> >  static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, i=
nt *temp)
> >  {
> >         int val;
> > @@ -112,6 +163,11 @@ static int loongson2_thermal_set_trips(struct ther=
mal_zone_device *tz, int low,
> >         return loongson2_thermal_set(data, low/MILLI, high/MILLI, true)=
;
> >  }
> >
> > +static const struct thermal_zone_device_ops loongson2_2k0300_of_therma=
l_ops =3D {
> > +       .get_temp =3D loongson2_2k0300_get_temp,
> > +       .set_trips =3D loongson2_thermal_set_trips,
> > +};
> > +
> >  static const struct thermal_zone_device_ops loongson2_2k1000_of_therma=
l_ops =3D {
> >         .get_temp =3D loongson2_2k1000_get_temp,
> >         .set_trips =3D loongson2_thermal_set_trips,
> > @@ -124,7 +180,6 @@ static const struct thermal_zone_device_ops loongso=
n2_2k2000_of_thermal_ops =3D {
> >
> >  static int loongson2_thermal_probe(struct platform_device *pdev)
> >  {
> > -       const struct thermal_zone_device_ops *thermal_ops;
> >         struct device *dev =3D &pdev->dev;
> >         struct loongson2_thermal_data *data;
> >         struct thermal_zone_device *tzd;
> > @@ -134,6 +189,7 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
> >         if (!data)
> >                 return -ENOMEM;
> >
> > +       data->dev =3D dev;
> >         data->chip_data =3D device_get_match_data(dev);
> >
> >         data->ctrl_reg =3D devm_platform_ioremap_resource(pdev, 0);
> > @@ -145,10 +201,13 @@ static int loongson2_thermal_probe(struct platfor=
m_device *pdev)
> >                 data->temp_reg =3D devm_platform_ioremap_resource(pdev,=
 1);
> >                 if (IS_ERR(data->temp_reg))
> >                         return PTR_ERR(data->temp_reg);
> > +       }
> >
> > -               thermal_ops =3D &loongson2_2k2000_of_thermal_ops;
> > -       } else {
> > -               thermal_ops =3D &loongson2_2k1000_of_thermal_ops;
> > +       /* The chip id register is needed for Loongson-2K0300 */
> > +       if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
> > +               data->id_reg =3D devm_platform_ioremap_resource(pdev, 1=
);
> > +               if (IS_ERR(data->id_reg))
> > +                       return PTR_ERR(data->id_reg);
> >         }
> >
> >         irq =3D platform_get_irq(pdev, 0);
> > @@ -160,7 +219,7 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
> >         loongson2_thermal_set(data, 0, 0, false);
> >
> >         for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> > -               tzd =3D devm_thermal_of_zone_register(dev, i, data, the=
rmal_ops);
> > +               tzd =3D devm_thermal_of_zone_register(dev, i, data, dat=
a->chip_data->thermal_ops);
> >
> >                 if (!IS_ERR(tzd))
> >                         break;
> > @@ -181,17 +240,29 @@ static int loongson2_thermal_probe(struct platfor=
m_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k=
0300_data =3D {
> > +       .thermal_sensor_sel =3D 0,
> > +       .flags =3D LS2K0300_CHIP_ID_FLAG,
> > +       .thermal_ops =3D &loongson2_2k0300_of_thermal_ops,
> > +};
> > +
> >  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k=
1000_data =3D {
> >         .thermal_sensor_sel =3D 0,
> >         .flags =3D 0,
> > +       .thermal_ops =3D &loongson2_2k1000_of_thermal_ops,
> >  };
> >
> >  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k=
2000_data =3D {
> >         .thermal_sensor_sel =3D 0,
> >         .flags =3D LS2K2000_THSENS_OUT_FLAG,
> > +       .thermal_ops =3D &loongson2_2k2000_of_thermal_ops,
> >  };
> >
> >  static const struct of_device_id of_loongson2_thermal_match[] =3D {
> > +       {
> > +               .compatible =3D "loongson,ls2k0300-thermal",
> > +               .data =3D &loongson2_thermal_ls2k0300_data,
> > +       },
> >         {
> >                 .compatible =3D "loongson,ls2k1000-thermal",
> >                 .data =3D &loongson2_thermal_ls2k1000_data,
> > --
> > 2.52.0
> >

--=20
Thanks.
Binbin
