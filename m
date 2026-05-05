Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008947277B
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990991; cv=none; b=BhWdMbhUK2PUt7kYgIozQtOWJVqv0dh8Jl3syq5EVv732TMGyYyGcNCufn5g/5NpFFcPj+i78+tddPhzABBFAE9VcKYEnECiNI0jEz5o/6OMVFRx7dWP3MULMuO7pUhrPcmqkJRcp+HXgaQLvKNWnKnPAB/ZHGrEraYDD4LYId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990991; c=relaxed/simple;
	bh=HQZYBvl7+ZdVK9hmm8ojyOJt6oqctALFLglRGbD1qtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AP8/8guzG1M9gS9F4MZzEO2khMWFGK9ghixpJ6gUrRTVBJNBNL9FL2upO37XhjDBo9wqGgUZxhgyiOsIevTWvkkaaPkp6Zc2uqL0pWBqYtJqswjyLMJe2uFYFIe90Ho95Nnp9xQARqPK2Ppwu2njHhEQTtWaGWuS6GpnHVpO6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3pY+Vki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3pY+Vki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE318C2BD04
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777990990;
	bh=HQZYBvl7+ZdVK9hmm8ojyOJt6oqctALFLglRGbD1qtc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=u3pY+VkicQSkstCCYNbM8IM1G/jsPOzKFmutNJBvm1CNsoRYUmoEZrL4oPvW52U0X
	 Iuwq7HmqxN8/uQ96+m8jG98BbagZ4qiMvBEq+eAWs2YyLEYnWcxNpenh97GFNHHUdq
	 QsBka3fDG6JeBhC5biY2ksp7oxozqLnkPDTKE2KTph9/xhCqfiaJK3/cEHoSviatks
	 3dfrWre8X3r/p+v7fPH9GHXaRtZZPulpM9uoCExSrUZJ4clTh5FSMyoRjHLQEv0zCZ
	 wo9CRR8lonApJ3yejHq8w2maoQJlF0ugmdU16QbMMksqEO0BufGT+WQN9ut4lGSZjd
	 nXExBEL16eSXg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3870778358aso37341101fa.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:23:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/kz6P11VOQt2I3Jq/IA6DfYdpZ3HQfMKYv3ubAu8d0179V8iPm2LohvlOsZJwvX1duONfNt5RS4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznwswpd17+8wfv8EWMv18Nxsy3fdSPrw6Md3sepeAF/EqhYAx3
	lXuoFzlGLhtbaPq0xK1FY6rPOeNmIHXY1ozBhTJnJqPjOOIjEfP4wYkJ9i1ROzN60ElF8sloeiz
	4BnNliGo1zcpldybNK2HYQumlNv6I7n8=
X-Received: by 2002:a05:651c:41c8:b0:391:1570:b6c5 with SMTP id
 38308e7fff4ca-393784e0257mr46633361fa.17.1777990989183; Tue, 05 May 2026
 07:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050245.646078-1-iuncuim@gmail.com> <20260504050245.646078-5-iuncuim@gmail.com>
In-Reply-To: <20260504050245.646078-5-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 May 2026 22:22:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v67S7jYa5-pxE=VLjaSQb_SmqQiv3CEvH7h+EZk9dKMx2w@mail.gmail.com>
X-Gm-Features: AVHnY4JKSgfn-se-YEytQuckVs7_oUre-tJGFE7Sp6lhUi0lzQsj21ANm3z7qyY
Message-ID: <CAGb2v67S7jYa5-pxE=VLjaSQb_SmqQiv3CEvH7h+EZk9dKMx2w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:04=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> The A523 processor has two temperature controllers, THS0 and THS1.
> THS0 has only one temperature sensor, which is located in the DRAM.

in the DRAM controller.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> THS1 does have 3 sensors:
> ths1_0 - "big" cores
> ths1_1 - "little" cores
> ths1_2 - gpu
>
> The datasheet mentions a fourth sensor in the NPU, but lacks any register=
s
> for operation other than calibration registers. The vendor code reads the
> value from ths1_2, but uses separate calibration data, so we get two
> different values from real one.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 133 ++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index c4aaff8f7..3b73aafab 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -59,6 +59,12 @@
>  #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)                ((GENMASK(19, 0) =
& (x)) << 12)
>  #define SUN50I_H6_THS_DATA_IRQ_STS(x)          BIT(x)
>
> +#define SUN55I_A523_DELIMITER                  0x7c8
> +#define SUN55I_A523_OFFSET_ABOVE               2736
> +#define SUN55I_A523_OFFSET_BELOW               2825
> +#define SUN55I_A523_SCALE_ABOVE                        74
> +#define SUN55I_A523_SCALE_BELOW                        65
> +
>  struct tsensor {
>         struct ths_device               *tmdev;
>         struct thermal_zone_device      *tzd;
> @@ -114,6 +120,15 @@ static int sun50i_h5_calc_temp(struct ths_device *tm=
dev,
>                 return -1590 * reg / 10 + 276000;
>  }
>
> +static int sun55i_a523_calc_temp(struct ths_device *tmdev,
> +                                int id, int reg)
> +{
> +       if (reg >=3D SUN55I_A523_DELIMITER)
> +               return SUN55I_A523_SCALE_ABOVE * (SUN55I_A523_OFFSET_ABOV=
E - reg);
> +       else
> +               return SUN55I_A523_SCALE_BELOW * (SUN55I_A523_OFFSET_BELO=
W - reg);
> +}
> +
>  static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>         struct tsensor *s =3D thermal_zone_device_priv(tz);
> @@ -299,6 +314,97 @@ static int sun50i_h6_ths_calibrate(struct ths_device=
 *tmdev,
>         return 0;
>  }
>
> +/*
> + * The A523 nvmem calibration values. The ths1_3 is not used as it
> + * doesn't have its own sensor and doesn't have any internal switch.
> + * Instead, the value from the ths1_2 sensor is used, which gives the
> + * illusion of an independent sensor for NPU and GPU when using
> + * different calibration values.
> + *
> + * efuse layout 0x38-0x3F (caldata[0..3]):
> + *     caldata[0]      caldata[1]      caldata[2]      caldata[3]
> + * 0               16      24      32  36          48          60 64
> + * +---------------+---------------+---------------+---------------+
> + * |               |       |   temp    |  ths1_0   |  ths1_1   |   +
> + * +---------------+---------------+---------------+---------------+
> + *
> + * efuse layout 0x44-0x4B (caldata[4..7]):
> + *     caldata[4]      caldata[5]      caldata[6]      caldata[7]
> + * 0           12  16      24      32  36          48             64
> + * +---------------+---------------+---------------+---------------+
> + * |  ths1_2   |  ths1_3   |    ths0   |           |               +
> + * +---------------+---------------+---------------+---------------+
> + */
> +static int sun55i_a523_ths_calibrate(struct ths_device *tmdev,
> +                                    u16 *caldata, int callen)
> +{
> +       struct device *dev =3D tmdev->dev;
> +       int i, ft_temp;
> +
> +       if (!caldata[0])
> +               return -EINVAL;
> +
> +       ft_temp =3D (((caldata[2] << 8) | (caldata[1] >> 8)) & FT_TEMP_MA=
SK) * 100;
> +
> +       for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> +               int sensor_reg, sensor_temp, cdata, offset;
> +               /*
> +                * Chips ths0 and ths1 have common parameters for value
> +                * calibration. To separate them we can use the number of
> +                * temperature sensors on each chip.
> +                * For ths0 this value is 1.
> +                */
> +               if (tmdev->chip->sensor_num =3D=3D 1) {
> +                       sensor_reg =3D ((caldata[5] >> 8) | (caldata[6] <=
< 8)) & TEMP_CALIB_MASK;
> +               } else {
> +                       switch (i) {
> +                       case 0:
> +                               sensor_reg =3D (caldata[2] >> 4) & TEMP_C=
ALIB_MASK;
> +                               break;
> +                       case 1:
> +                               sensor_reg =3D caldata[3] & TEMP_CALIB_MA=
SK;
> +                               break;
> +                       case 2:
> +                               sensor_reg =3D caldata[4] & TEMP_CALIB_MA=
SK;
> +                               break;
> +                       default:
> +                               sensor_reg =3D 0;
> +                               break;
> +                       }
> +               }
> +
> +               sensor_temp =3D tmdev->chip->calc_temp(tmdev, i, sensor_r=
eg);
> +
> +               /*
> +                * Calibration data is CALIBRATE_DEFAULT - (calculated
> +                * temperature from sensor reading at factory temperature
> +                * minus actual factory temperature) * X (scale from
> +                * temperature to register values)
> +                */
> +               cdata =3D CALIBRATE_DEFAULT -
> +                       ((sensor_temp - ft_temp) / SUN55I_A523_SCALE_ABOV=
E);
> +
> +               if (cdata & ~TEMP_CALIB_MASK) {
> +                       /*
> +                        * Calibration value more than 12-bit, but calibr=
ation
> +                        * register is 12-bit. In this case, ths hardware=
 can
> +                        * still work without calibration, although the d=
ata
> +                        * won't be so accurate.
> +                        */
> +                       dev_warn(dev, "sensor%d is not calibrated.\n", i)=
;
> +                       continue;
> +               }
> +
> +               offset =3D (i % 2) * 16;
> +               regmap_update_bits(tmdev->regmap,
> +                                  SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4)=
,
> +                                  TEMP_CALIB_MASK << offset,
> +                                  cdata << offset);
> +       }
> +
> +       return 0;
> +}
> +
>  static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  {
>         struct nvmem_cell *calcell =3D NULL;
> @@ -722,6 +828,31 @@ static const struct ths_thermal_chip sun50i_h616_ths=
 =3D {
>         .calc_temp =3D sun8i_ths_calc_temp,
>  };
>
> +/* The A523 has a shared reset line for both chips */
> +static const struct ths_thermal_chip sun55i_a523_ths0 =3D {
> +       .sensor_num =3D 1,
> +       .has_bus_clk_reset =3D true,
> +       .has_mod_clk =3D true,
> +       .ft_deviation =3D 5000,
> +       .temp_data_base =3D SUN50I_H6_THS_TEMP_DATA,
> +       .calibrate =3D sun55i_a523_ths_calibrate,
> +       .init =3D sun50i_h6_thermal_init,
> +       .irq_ack =3D sun50i_h6_irq_ack,
> +       .calc_temp =3D sun55i_a523_calc_temp,
> +};
> +
> +static const struct ths_thermal_chip sun55i_a523_ths1 =3D {
> +       .sensor_num =3D 3,
> +       .has_bus_clk_reset =3D true,
> +       .has_mod_clk =3D true,
> +       .ft_deviation =3D 5000,
> +       .temp_data_base =3D SUN50I_H6_THS_TEMP_DATA,
> +       .calibrate =3D sun55i_a523_ths_calibrate,
> +       .init =3D sun50i_h6_thermal_init,
> +       .irq_ack =3D sun50i_h6_irq_ack,
> +       .calc_temp =3D sun55i_a523_calc_temp,
> +};
> +
>  static const struct of_device_id of_ths_match[] =3D {
>         { .compatible =3D "allwinner,sun8i-a83t-ths", .data =3D &sun8i_a8=
3t_ths },
>         { .compatible =3D "allwinner,sun8i-h3-ths", .data =3D &sun8i_h3_t=
hs },
> @@ -732,6 +863,8 @@ static const struct of_device_id of_ths_match[] =3D {
>         { .compatible =3D "allwinner,sun50i-h6-ths", .data =3D &sun50i_h6=
_ths },
>         { .compatible =3D "allwinner,sun20i-d1-ths", .data =3D &sun20i_d1=
_ths },
>         { .compatible =3D "allwinner,sun50i-h616-ths", .data =3D &sun50i_=
h616_ths },
> +       { .compatible =3D "allwinner,sun55i-a523-ths0", .data =3D &sun55i=
_a523_ths0 },
> +       { .compatible =3D "allwinner,sun55i-a523-ths1", .data =3D &sun55i=
_a523_ths1 },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);
> --
> 2.54.0
>
