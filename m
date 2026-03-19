Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347E25FA29
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896667; cv=pass; b=khrisKcISLR5xyNhGQImmTRGOAEts+g5PapC5t+2TLqloExb90IfCNnu4IWuZZZ1630JWgh0YD3Q8B8oB65O+yAlaqaGvmoKgQPVbUXbtEoUENtMXyul1BSz6xTCgMtEqd9bvMfZBP0cGq06fxkQAuIFKdBQiC8iM9DPmGp/eUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896667; c=relaxed/simple;
	bh=j4LwOfreD5riTsVaD7Gb/OCJFXpoD19garNTTqeXcII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klsxK1QN9/zfuHOowl+f3h/wQUC7xM5O9WS7KxQfokCPnATOKPx2rHuLWmJGaA4tMck29caWPhzV2AX/Hyumqhc4AHJ2Dmc7WY3owJk92fEOyfsl1oYNuP+TSHM+sLMtYLhUkQbOFjxkzfkIMlvpeMz26Ynjbo9J/GWdzZCZv0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFvVwijW; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFvVwijW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a67ce6969so461062b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773896665; cv=none;
        d=google.com; s=arc-20240605;
        b=Awb+6Gco+XzHT03yOX08fOafN+gX573qIORhbbmbIKEG+OVqzMcueyk7Oz+ajzQAn3
         9oX9+8qstIxPU9uAF6Q+o2SIf96xhbhtVETtvAEaeXdRcNGRYJiJOB4JzmSSPYmHsmKZ
         7c0B8NBQV3qMeJWgAcL9H4+bHC4JH0ZZrfeh+ew5wRRzLDsyIERdudLg4s0/lSEuCfkz
         uBkhFP9ZxlQv2BgyoViUPqweN6ePbHy1/TsG26Qm8E//qBA3hZ6h/DYnM+dkQgFLoV0T
         ZVYhWi9t2zoIpcldyn6Z/tovXBmBK93HBTmCF4dAzuXaUYETi5fmfdQU/OCfMkxN0Fqg
         XUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        fh=PB87e5FaTaMVj+rbvkAq3Bzb9z4dRxPNpzZ3JCdsiaQ=;
        b=Ra0GoWiGsu2KUhASYoz89rSr+VYl12gEz0lJLGwKjrAgQUDcJfsQ1jXiqxlvzkn9xa
         iE2Pw9DTQ8ukVWA4QCFnePqubax1znOz5MA/Fswp/pIdJ4lrMUaLk/Vg2g4zjgkbb12t
         YY3jccZqFcwDuOt1GteOjI5ehALWorfh6vq9ueTEjCpO5FC8roybejyq++MHOYZcZj0/
         WPFGcGdosaj8ssi7006a/I7BbQqKXVvudxd27ilHUJrCvbCr+u5aYVxIhiySwDvysKXD
         gcWdfRJGfUXymDb4QwwInaiBZs77EQexfYQNH5jDPaJ+azoLGoRLzYhl3+FF1Sp8d9NH
         VrPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773896665; x=1774501465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        b=mFvVwijWgEAUmOmrN9GTO2KGz6TN+4kkBF1VI6E8AHNsXxZmM+7ATzk2ztv1BYallv
         uEhw4T741OsHWwirqwkgsU8q4ukcueAMpTgP/z9a3BoTezfUw3NrXARVyT4i1X0kpdWE
         aCm42G/roXxS4ZMvbQkpxFLQXaedbgTebHKV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896665; x=1774501465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        b=PDvN8pB8dS2jNmTkUo39mXViz/nfMB7CdtWqHDViLMNt/1FSCFg+z0ivXNwIoFMgIp
         us+gcH31lhptagOrOc9DrjExAYaOX5imO2zxHvWMNc7arM8ds1yhfqu38SI/GAMrrRQL
         gmVQ9WfIuQ5nrdzbhVoSoTH/HiFqN/GoDdB7UJu4+d/I9QcFxz+azBJLMYDUVeW+K7Hf
         VBVbJiTT7Bas3R4HYnZ9EdW5rF1oiRn5GDIB2gA+72/fycrYmfN8uhcxS+raFAH2Q/TM
         +S4ZDDfCoDaojeBQWlgPJHPfCjyqeEuvR+x0NAoCjaISJXveuif0Nlecz83SUT9euroi
         cCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNrEI+PAn0qBiG/HJ+4OBsIDMtjafURllXJGHvsMEDBthx25QRxvTNIiu3Nw39SlvTFoJyC6N/nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsNNcpyvbRUqk+IOokxyqzJYOlkkZrzSnwxstlfIQCrWB+3tQ
	2S4ISK6RoVCBNzzkYjQq107SOz0WPgvZo6CWVfRtkRo+3rzjEAKtuGrbBiBDhfdCdW/8C794K7T
	qFT2kFPwSr2NpLxXqFubf94kNB3CCkks171TMxvf2
X-Gm-Gg: ATEYQzwwlp7YLccQEiI30ynlhAyfrY0OPgN6PqN3bzs6k9YyBQQmrwjXAuRkbkLZTNv
	voL8UEt2sNb5RgQ0sljVyWG4qwWlvOUm2zamR6iO956I4KTudcj/ZL+lBWBxedsl1DEjFJa15/o
	hi2wG4ronOMyEfrK+vFyd9GOnezXc4jyGX4lcEflQd4OF//dBvmKz8NeCrgePDSoIYbiWdg9nTN
	ZVKTvw34sD/t8LTCX4BommYio2oCjYf9gs6KfMAeadoQ14tXt6iS86xbd7XepV5vdlAZIcdQz/l
	ZlEQ9H5hwcPu467X6IWPQx+iUb6HrYeQtm4cizoJ2XqpO98/
X-Received: by 2002:a05:6a00:71cd:b0:82a:7046:86a0 with SMTP id
 d2e1a72fcca58-82a70468ac5mr3493177b3a.20.1773896664943; Wed, 18 Mar 2026
 22:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
In-Reply-To: <20260317184507.523060-8-l.scorcia@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Mar 2026 13:04:12 +0800
X-Gm-Features: AaiRm53-k1XiPsX8YHUI34_UU2ePBdJ9HT3Aqm47Bm64kJThrD_lG_tt8e77KjA
Message-ID: <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:46=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> From: Fabien Parent <parent.f@gmail.com>
>
> The MT6392 is a regulator found on boards based on the MediaTek
> MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
> connects as a slave to a SoC using SPI, wrapped inside PWRAP.
>
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Co-developed-by: Val Packett <val@packett.cool>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  drivers/regulator/Kconfig                  |   9 +
>  drivers/regulator/Makefile                 |   1 +
>  drivers/regulator/mt6392-regulator.c       | 487 +++++++++++++++++++++
>  include/linux/regulator/mt6392-regulator.h |  40 ++
>  4 files changed, 537 insertions(+)
>  create mode 100644 drivers/regulator/mt6392-regulator.c
>  create mode 100644 include/linux/regulator/mt6392-regulator.h
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index d2335276cce5..66876d730807 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -991,6 +991,15 @@ config REGULATOR_MT6380
>           This driver supports the control of different power rails of de=
vice
>           through regulator interface.
>
> +config REGULATOR_MT6392
> +       tristate "MediaTek MT6392 PMIC"
> +       depends on MFD_MT6397
> +       help
> +         Say y here to select this option to enable the power regulator =
of
> +         MediaTek MT6392 PMIC.
> +         This driver supports the control of different power rails of de=
vice
> +         through regulator interface.
> +
>  config REGULATOR_MT6397
>         tristate "MediaTek MT6397 PMIC"
>         depends on MFD_MT6397
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 1beba1493241..db5145cfcf36 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_REGULATOR_MT6360) +=3D mt6360-regulator.=
o
>  obj-$(CONFIG_REGULATOR_MT6363) +=3D mt6363-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6370) +=3D mt6370-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6380) +=3D mt6380-regulator.o
> +obj-$(CONFIG_REGULATOR_MT6392) +=3D mt6392-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6397) +=3D mt6397-regulator.o
>  obj-$(CONFIG_REGULATOR_MTK_DVFSRC) +=3D mtk-dvfsrc-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_LABIBB) +=3D qcom-labibb-regulator.o
> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 000000000000..50cc0019f48a
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 MediaTek Inc.
> +// Copyright (c) 2020 BayLibre, SAS.
> +// Author: Chen Zhong <chen.zhong@mediatek.com>
> +// Author: Fabien Parent <fparent@baylibre.com>
> +//
> +// Based on mt6397-regulator.c
> +
> +#include <linux/module.h>
> +#include <linux/linear_range.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6392/registers.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/mt6392-regulator.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
> +
> +/*
> + * MT6392 regulators' information
> + *
> + * @desc: standard fields of regulator description.
> + * @qi: Mask for query enable signal status of regulators
> + * @vselon_reg: Register sections for hardware control mode of bucks
> + * @vselctrl_reg: Register for controlling the buck control mode.
> + * @vselctrl_mask: Mask for query buck's voltage control mode.
> + */
> +struct mt6392_regulator_info {
> +       struct regulator_desc desc;
> +       u32 qi;
> +       u32 vselon_reg;
> +       u32 vselctrl_reg;
> +       u32 vselctrl_mask;
> +       u32 modeset_reg;
> +       u32 modeset_mask;
> +};
> +
> +#define MT6392_BUCK(match, vreg, min, max, step, volt_ranges, enreg,   \
> +               vosel, vosel_mask, voselon, vosel_ctrl,                 \
> +               _modeset_reg, _modeset_mask, rampdelay)         \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_range_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ((max) - (min)) / (step) + 1,            =
 \
> +               .linear_ranges =3D volt_ranges,                          =
 \
> +               .n_linear_ranges =3D ARRAY_SIZE(volt_ranges),            =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(0),                                 =
 \
> +               .ramp_delay =3D rampdelay,                               =
 \

Please add the supply names.

> +       },                                                              \
> +       .qi =3D BIT(13),                                                 =
 \
> +       .vselon_reg =3D voselon,                                         =
 \
> +       .vselctrl_reg =3D vosel_ctrl,                                    =
 \
> +       .vselctrl_mask =3D BIT(1),                                       =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,   \
> +               vosel_mask, _modeset_reg, _modeset_mask, entime)        \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_table_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ARRAY_SIZE(ldo_volt_table),              =
 \
> +               .volt_table =3D ldo_volt_table,                          =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_LDO_LINEAR(match, vreg, min, max, step, volt_ranges,    \
> +               enreg, enbit, vosel, vosel_mask, _modeset_reg,          \
> +               _modeset_mask, entime)                                  \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_ldo_range_ops,                     =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ((max) - (min)) / (step) + 1,            =
 \
> +               .linear_ranges =3D volt_ranges,                          =
 \
> +               .n_linear_ranges =3D ARRAY_SIZE(volt_ranges),            =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_REG_FIXED(match, vreg, enreg, enbit, volt,              \
> +               _modeset_reg, _modeset_mask, entime)                    \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_fixed_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D 1,                                       =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +               .min_uV =3D volt,                                        =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_REG_FIXED_NO_MODE(match, vreg, enreg, enbit, volt,      \
> +       entime)                                                         \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_fixed_no_mode_ops,                 =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D 1,                                       =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +               .min_uV =3D volt,                                        =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +}
> +
> +static const struct linear_range buck_volt_range1[] =3D {
> +       REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
> +};
> +
> +static const struct linear_range buck_volt_range2[] =3D {
> +       REGULATOR_LINEAR_RANGE(1400000, 0, 0x7f, 12500),
> +};
> +
> +static const u32 ldo_volt_table1[] =3D {
> +       1800000, 1900000, 2000000, 2200000,
> +};
> +
> +static const struct linear_range ldo_volt_range2[] =3D {
> +       REGULATOR_LINEAR_RANGE(3300000, 0, 3, 100000),
> +};
> +
> +static const u32 ldo_volt_table3[] =3D {
> +       1800000, 3300000,
> +};
> +
> +static const u32 ldo_volt_table4[] =3D {
> +       3000000, 3300000,
> +};
> +
> +static const u32 ldo_volt_table5[] =3D {
> +       1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 33=
00000,
> +};
> +
> +static const u32 ldo_volt_table6[] =3D {
> +       1240000, 1390000,
> +};
> +
> +static const u32 ldo_volt_table7[] =3D {
> +       1200000, 1300000, 1500000, 1800000,
> +};
> +
> +static const u32 ldo_volt_table8[] =3D {
> +       1800000, 2000000,
> +};

If this PMIC is anything like the MT6358, then it has 0.01V fine
tuning for most if not all the LDOs. It is sometimes needed as
a rail may have a 0.04V boost that would otherwise be invisible
to the system. And then if you have something like 3.04V set in
the DT constraints, you end up with something the regulator driver
doesn't support, but the hardware does.

Please see how it's done in the MT6358 driver. I spent a lot of
time on that driver to make it actually support the full range
of voltages, and describing the supplies.


ChenYu
