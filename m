Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247F37DAB5;
	Tue, 12 May 2026 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592587; cv=none; b=FOGwlkWvbNA38A44OObWkBmf5OBtqu73znH+ESYDU5hdAshqjjNYaOaYgS4+phZVOZ86htUp3jwyclCwlpu8Vd1d3+8vE1mXU1+J7QiAMAqYxEHYjE08lk4Un4OS/du4d8oi60fYYRpL1ItKcWiambc8eM3nbiNgtddLgoiBw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592587; c=relaxed/simple;
	bh=OE2XOA8Ys/J68M2y8Svmcp4K9BF42SihLc9PvIZ2c1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlJAIrRgDJ0t4+gLsQ41TbUVJjmETJc/7F8SMK8Q05yGGqUmu0OJeL45mbNHm/5V3IEXWTRe4h6yqbL1+GKHIotUNzFbP/ODBw+aNfxI1y7KQKEuqhSBdLv416KwW12LAG0TsTku835qBtDi3fRdDZk6Rkhf294tbbXD3bEg8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3bqYVgs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3bqYVgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD06C2BCF6;
	Tue, 12 May 2026 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592586;
	bh=OE2XOA8Ys/J68M2y8Svmcp4K9BF42SihLc9PvIZ2c1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m3bqYVgss5gGSLp+d7Jk7GkVsx9WevUkW0NCpmq904DyHvmgN774LUagw55vDZGyu
	 LFNVeRPgb3SGxxeC0uIzZco6gL3Ft1tWpZGWx0oINYONCbj04EL154U7vvLo/hn9mN
	 j+ZdFPGuVyOsF1VjQO7nz3Ic49b76nyCvnnizE48f9VGyApyCQx+fw+ot2QqJa3uoS
	 v4+ubQQhpwXR5P2rvgkUTS5OmYEexMko68cLgCXQtslT6heauPB8jNc6ZwN85IO/gZ
	 sYLoBwrfAhqkGgRYZy+SSc2r8atrc0fyKxPINOG5COJuZdKjWuLqwkdSpSoXUVfVNJ
	 xZxJOsN8dq/Sg==
Date: Tue, 12 May 2026 14:29:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 05/16] iio: adc: mediatek: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260512142932.5c6801d1@jic23-huawei>
In-Reply-To: <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 08:18:19 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
Hi Roman

Various comments inline - mostly naming related.

Jonathan

> diff --git a/drivers/iio/adc/mt6323-auxadc.c b/drivers/iio/adc/mt6323-auxadc.c
> new file mode 100644
> index 000000000000..2c2b495e3d38
> --- /dev/null
> +++ b/drivers/iio/adc/mt6323-auxadc.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 Roman Vivchar <rva333@protonmail.com>
> + *
> + * Based on drivers/iio/adc/mt6359-auxadc.c
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6323/registers.h>
> +
> +#include <dt-bindings/iio/adc/mediatek,mt6323-auxadc.h>
> +
> +#define AUXADC_RSTB_SEL		BIT(7)
> +#define AUXADC_RSTB_SW		BIT(5)
> +
> +#define AUXADC_CTL_CK		BIT(5)
> +
> +#define AUXADC_TRIM_CH2		(3 << 10)
> +#define AUXADC_TRIM_CH4		(3 << 8)
> +#define AUXADC_TRIM_CH5		(3 << 4)
> +#define AUXADC_TRIM_CH6		(3 << 2)
> +
> +#define AUXADC_VREF18_ENB_MD	BIT(15)
> +#define AUXADC_MD_STATUS	BIT(0)
> +
> +#define AUXADC_GPS_STATUS	BIT(1)
> +
> +#define AUXADC_VREF18_SELB	BIT(1)
> +#define AUXADC_DECI_GDLY_SEL	BIT(0)
> +
> +#define AUXADC_VBUF_EN		BIT(4)
> +
> +#define AUXADC_DECI_GDLY_MASK		GENMASK(15, 14)
Why you can it is much better to clearly associate a field mask
definition with which register it is in. Lets us quickly spot
if there is a missmatch.

#define AUXADC_CON19_DECI_GDLY_MASK  for example.

THough DECI_GDLY isn't exactly easy to understand as abbreviations
go!

> +#define AUXADC_ADC19_BUSY_MASK		GENMASK(15, 1)
> +#define AUXADC_RDY_MASK			BIT(15)
> +#define AUXADC_DATA_MASK		GENMASK(14, 0)
> +
> +#define AUXADC_OSR_MASK			GENMASK(12, 10)
> +#define AUXADC_DEFAULT_OSR		3
> +
> +#define AUXADC_LOW_CHANNEL_MASK		GENMASK(9, 0)
> +#define AUXADC_AUDIO_CHANNEL_MASK	GENMASK(8, 0)
> +
> +#define VOLTAGE_FULL_RANGE	1800
Probably better to have this inline - however if you do keep it
prefix t he define  VOLTAGE_FULL_RANGE sounds too generic!

> +#define AUXADC_PRECISE		32768
I'd put that inline.  Little benefit it in having it up here...
> +
> +#define MTK_PMIC_IIO_CHAN(_name, _idx, _ch_type)       \
> +{                                                      \
> +	.type = _ch_type,                              \
> +	.indexed = 1,                                  \
> +	.channel = _idx,                               \
> +	.address = _idx,                               \

Why put an index in address?  Seems to me that complicates things
vs putting the relevant register address in there.

> +	.datasheet_name = __stringify(_name),          \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE) \
> +}
> +
> +static const struct iio_chan_spec mt6323_auxadc_channels[] = {
> +	MTK_PMIC_IIO_CHAN(baton2, MT6323_AUXADC_BATON2, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(ch6, MT6323_AUXADC_CH6, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(bat_temp, MT6323_AUXADC_BAT_TEMP, IIO_TEMP),
> +	MTK_PMIC_IIO_CHAN(chip_temp, MT6323_AUXADC_CHIP_TEMP, IIO_TEMP),
> +	MTK_PMIC_IIO_CHAN(vcdt, MT6323_AUXADC_VCDT, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(baton1, MT6323_AUXADC_BATON1, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(isense, MT6323_AUXADC_ISENSE, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(batsns, MT6323_AUXADC_BATSNS, IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(accdet, MT6323_AUXADC_ACCDET, IIO_VOLTAGE),
> +};
> +
> +/**
> + * struct mt6323_auxadc - Main driver structure
> + * @regmap:        Regmap from PWRAP
> + * @lock:          Mutex to serialize AUXADC reading vs configuration
> + *
> + * The MediaTek MT6323 (as well as lot of other PMICs) have the following hierarchy:
> + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> + *
> + * Therefore, PWRAP regmap should be get using dev->parent->parent.
> + */
> +struct mt6323_auxadc {
> +	struct regmap *regmap;
> +	struct mutex lock;
> +};
> +
> +static u32 mt6323_auxadc_channel_to_reg(unsigned long channel)
> +{
> +	switch (channel) {
> +	case MT6323_AUXADC_BATON2:
> +		return MT6323_AUXADC_ADC6;

You should put these in chan->address perhaps to avoid
need for a separate lookup function.

> +	case MT6323_AUXADC_CH6:
> +		return MT6323_AUXADC_ADC11;
> +	case MT6323_AUXADC_BAT_TEMP:
> +		return MT6323_AUXADC_ADC5;
> +	case MT6323_AUXADC_CHIP_TEMP:
> +		return MT6323_AUXADC_ADC4;
> +	case MT6323_AUXADC_VCDT:
> +		return MT6323_AUXADC_ADC2;
> +	case MT6323_AUXADC_BATON1:
> +		return MT6323_AUXADC_ADC3;
> +	case MT6323_AUXADC_ISENSE:
> +		return MT6323_AUXADC_ADC1;
> +	case MT6323_AUXADC_BATSNS:
> +		return MT6323_AUXADC_ADC0;
> +	case MT6323_AUXADC_ACCDET:
> +		return MT6323_AUXADC_ADC7;
> +	default:
> +		return MT6323_AUXADC_ADC17;
> +	}
> +}

> +static int mt6323_auxadc_request(struct mt6323_auxadc *auxadc,
> +				 unsigned long channel)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	int ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON11, AUXADC_VBUF_EN);

As above. I'd like that field name to include which register it is in.
That makes it easier to spot mismatches.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(map, MT6323_AUXADC_CON22, BIT(channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(map, MT6323_AUXADC_CON22, BIT(channel));
> +}
> +
> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +			      const struct iio_chan_spec *chan, int *out)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	u32 val, reg = mt6323_auxadc_channel_to_reg(chan->address);

Don't mix elements that assign with ones that don't. Doesn't make for easy
to read code.

> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(map, reg, val, (val & AUXADC_RDY_MASK),
> +				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	*out = FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan, int *val,
> +				  int *val2, long mask)
> +{
> +	struct mt6323_auxadc *auxadc = iio_priv(indio_dev);
> +	int ret, mult = 1;
> +
> +	if (mask == IIO_CHAN_INFO_RAW) {
> +		guard(mutex)(&auxadc->lock);
> +		ret = mt6323_auxadc_prepare_channel(auxadc);
> +		if (ret)
> +			return ret;
> +
> +		ret = mt6323_auxadc_request(auxadc, chan->address);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(300);
> +
> +		ret = mt6323_auxadc_read(auxadc, chan, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	} else if (mask == IIO_CHAN_INFO_SCALE) {
Andy covered not having the else etc already I think. A switch might
work better though.
> +		if (chan->channel == MT6323_AUXADC_ISENSE ||
> +		    chan->channel == MT6323_AUXADC_BATSNS)
> +			mult = 4;
> +
> +		*val = mult * VOLTAGE_FULL_RANGE;
> +		*val2 = AUXADC_PRECISE;

IIO_VAL_FRACTIONAL_LOG2 probably more appropriate here
(which would be more obvious with the values down here.


> +
> +		return IIO_VAL_FRACTIONAL;
> +	} else
> +		return -EINVAL;
> +}
> +
> +static int mt6323_auxadc_init(struct mt6323_auxadc *auxadc)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	int ret;
> +
> +	ret = regmap_set_bits(map, MT6323_STRUP_CON10,
> +			      AUXADC_RSTB_SW | AUXADC_RSTB_SEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6323_TOP_CKPDN2, AUXADC_CTL_CK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON10,
> +			      AUXADC_TRIM_CH2 | AUXADC_TRIM_CH4 |
> +				      AUXADC_TRIM_CH5 | AUXADC_TRIM_CH6);

	ret = regmap_set_bits(map, MT6323_AUXADC_CON10,
			      AUXADC_TRIM_CH2 | AUXADC_TRIM_CH4 |
			      AUXADC_TRIM_CH5 | AUXADC_TRIM_CH6);
is fine.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON27,
> +			      AUXADC_VREF18_ENB_MD | AUXADC_MD_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON19, AUXADC_GPS_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON26,
> +			      AUXADC_VREF18_SELB | AUXADC_DECI_GDLY_SEL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(map, MT6323_AUXADC_CON9, AUXADC_OSR_MASK,
> +				 FIELD_PREP(AUXADC_OSR_MASK,
> +					    AUXADC_DEFAULT_OSR));
> +	return ret;

Might as well do
	return regmap_update_bits()

> +}
