Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0718A6CF;
	Tue,  5 May 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967609; cv=none; b=MlLkaZz3BpfP+XKmzjcEFt3V/B90AMnLnbcfunqbMb0w7EpTBbrJyfbqrkITf4PNkAvovUjp1K6E/zpg2xQ/AVFs1ScQcnkfVKlstIDVp9oVDATCS3CfN4COahoJLl1VZJv9i/Ujw2Mka7ZfrVuTvyvuxe6Swm78Gtte5qIcen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967609; c=relaxed/simple;
	bh=BrhuC8t53vfsZNJjtxaRQN0b4ACZgyma1EephQqZQUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHkSKyLdEU6xTS/+C/6Fst0YrAGnbtlGOkpfGKlvMpZFwBTgz1ZQpoR7Ix7+7YHD2jEPkxVjg72TSw5LBlmtXSFP1cl2eCk/TJfxrWgc7gGniGBVPyfJ2t4Z8mckogaK9IM828kX8AiQC42jPnn0z45LtxdDHLqrylO+1+Ec1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzpvzG52; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzpvzG52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777967608; x=1809503608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BrhuC8t53vfsZNJjtxaRQN0b4ACZgyma1EephQqZQUw=;
  b=fzpvzG52hRnE/F+t3YARJHiZ+A1zJwEKdZSI5OmR3hWYUFOy0cLQ9Dex
   fElvjWatSuFbGJlmQHcoDfvW4cUieD1yJzT/ZhGokWuCuki3JGCExLd46
   fzNNyjQwuYrOlBkgJkkzm8wRlSIBG0C8T0DpHubXZT4TOWwlJdb1Zr/eB
   wcOD9qKCyrTAS9/MHYD8djU0ekl7U4ZB4NIsyJ/Usld4pC1bCY/TrgrYR
   jb0DUPcCjYHhCti24vzas4xos1ki+MetXhgEyLSTE5iFt6YWENXJbYETD
   DIaD8Hb8u/RF/mkFpy20IYQZwYgpGXx/tmYQ2wD9XYHrgxo1f2SshwIjv
   Q==;
X-CSE-ConnectionGUID: xiAruK+YSPS6tqLtEmo5cA==
X-CSE-MsgGUID: nmas3IpdT8m4+tgze3xV/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82683925"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82683925"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:53:27 -0700
X-CSE-ConnectionGUID: /9NJwlwzR4Kea1pYqYJg7A==
X-CSE-MsgGUID: NwoG24f0TemA++QJBz92ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235614542"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:53:21 -0700
Date: Tue, 5 May 2026 10:53:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 04/13] iio: adc: mediatek: add mt6323 PMIC AUXADC driver
Message-ID: <afmh70niEmjl53g9@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-4-799b58b355ff@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-mt6323-v1-4-799b58b355ff@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 09:24:56PM +0300, Roman Vivchar via B4 Relay wrote:

> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

Follow IWYU. At least stringify.h is missing.

...

> +#define MTK_PMIC_IIO_CHAN(_name, _idx, _ch_type) \
> +	{ .type = _ch_type,                              \
> +	  .indexed = 1,                                  \
> +	  .channel = _idx,                               \
> +	  .address = _idx,                               \
> +	  .datasheet_name = __stringify(_name),          \
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +				BIT(IIO_CHAN_INFO_SCALE) }

Make {} each to occupy a single line.

...

> +/**
> + * struct mt6323_auxadc - Main driver structure
> + * @dev:           Device pointer
> + * @regmap:        Regmap from PWRAP
> + * @lock:          Mutex to serialize AUXADC reading vs configuration

 *
 * ...put struct decription here... See below why.
 *

> + */
> +struct mt6323_auxadc {
> +	struct device *dev;
> +	struct regmap *regmap;

Do you need both? Are they different? (I mean that regmap may be derived from
device and vice versa depending on the case.)

Ok, it seems the dev is the current platform device, while regmap comes from
parent->parent to it (2 levels up!). This needs a good comment in the struct
description explaining the hierarchy.

> +	struct mutex lock;
> +};

...

> +static int mt6323_auxadc_check_if_stuck(struct mt6323_auxadc *auxadc)
> +{
> +	int i, ret;

Why is 'i' signed?

> +	u32 val;
> +
> +	for (i = 0; i < 50; i++) {

Magic 50 and the whole thing is reinvention of something from iopoll.h.

> +		ret = regmap_read(auxadc->regmap, MT6323_AUXADC_CON19, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (FIELD_GET(AUXADC_DECI_GDLY_MASK, val)) {
> +			ret = regmap_read(auxadc->regmap, MT6323_AUXADC_ADC19,
> +					  &val);
> +			if (ret)
> +				return ret;
> +
> +			if (!FIELD_GET(AUXADC_ADC19_BUSY_MASK, val)) {
> +				ret = regmap_update_bits(

Bad indentation, there is a room for parameter on the previous line.

> +					auxadc->regmap, MT6323_AUXADC_CON19,
> +					FIELD_PREP(AUXADC_DECI_GDLY_MASK, 3),
> +					0x0);
> +				if (ret)
> +					return ret;
> +			}
> +		} else {
> +			return 0;
> +		}
> +
> +		fsleep(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

TL;DR: Find a suitable macro in iopoll.h and use it.

...

> +static int mt6323_auxadc_request(struct mt6323_auxadc *auxadc,
> +				 unsigned long channel)
> +{
> +	int ret;
> +	u32 pmic_val, adc_val;
> +
> +	if (channel < 9) {
> +		ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON11,
> +					 AUXADC_VBUF_EN, AUXADC_VBUF_EN);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(auxadc->regmap, MT6323_AUXADC_CON22,
> +				  &pmic_val);
> +		if (ret)
> +			return ret;
> +
> +		adc_val = FIELD_GET(AUXADC_LOW_CHANNEL_MASK, pmic_val);
> +		adc_val &= ~BIT(channel);

We also have FIELD_MODIFY(). Use it in all cases where appropriate.

> +		ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON22,
> +					 AUXADC_LOW_CHANNEL_MASK, adc_val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(auxadc->regmap, MT6323_AUXADC_CON22,
> +				  &pmic_val);
> +		if (ret)
> +			return ret;
> +
> +		adc_val = FIELD_GET(AUXADC_LOW_CHANNEL_MASK, pmic_val);
> +		adc_val |= BIT(channel);
> +
> +		ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON22,
> +					 AUXADC_LOW_CHANNEL_MASK, adc_val);

> +

Stray blank line.

> +	} else {

Redundant 'else' as this may be returned directly. So, refactor each branch to
a helper and use this as a small wrapper.

	if (channel < 9)
		return ...helper_for_chan_<_9...;

	return ...otherwise...;

> +		ret = regmap_read(auxadc->regmap, MT6323_AUXADC_CON23,
> +				  &pmic_val);
> +		if (ret)
> +			return ret;
> +
> +		adc_val = FIELD_GET(AUXADC_AUDIO_CHANNEL_MASK, pmic_val);
> +		adc_val &= ~BIT(channel - 9);
> +
> +		ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON23,
> +					 AUXADC_AUDIO_CHANNEL_MASK, adc_val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(auxadc->regmap, MT6323_AUXADC_CON23,
> +				  &pmic_val);
> +		if (ret)
> +			return ret;
> +
> +		adc_val = FIELD_GET(AUXADC_AUDIO_CHANNEL_MASK, pmic_val);
> +		adc_val |= BIT(channel - 9);
> +
> +		ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON23,
> +					 AUXADC_AUDIO_CHANNEL_MASK, adc_val);
> +	}
> +
> +	return ret;
> +}

...

> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +			      const struct iio_chan_spec *chan, int *out)
> +{
> +	int ret;
> +	u32 reg = mt6323_auxadc_channel_to_reg(chan->address);
> +	u32 val;
> +
> +	ret = regmap_read_poll_timeout(auxadc->regmap, reg, val,
> +				       (val & AUXADC_RDY_MASK), 1000, 100000);

Redundant parentheses, also use multipliers from time.h

	struct regmap *map = ... // use this trick elsewhere as well

	ret = regmap_read_poll_timeout(map, reg, val, val & AUXADC_RDY_MASK,
				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);

> +	if (ret)
> +		return ret;
> +
> +	*out = FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +	return 0;
> +}

...

> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan, int *val,
> +				  int *val2, long mask)
> +{
> +	struct mt6323_auxadc *auxadc = iio_priv(indio_dev);
> +	int ret, mult = 1;
> +
> +	if (mask == IIO_CHAN_INFO_RAW) {
> +		scoped_guard(mutex, &auxadc->lock)
> +		{

Why? It's not a switch-case, the guard()() should be fine.

> +			ret = mt6323_auxadc_check_if_stuck(auxadc);
> +			if (ret)
> +				return ret;
> +
> +			ret = mt6323_auxadc_request(auxadc, chan->address);
> +			if (ret)
> +				return ret;
> +
> +			usleep_range(300, 500);

We have fsleep().

> +			ret = mt6323_auxadc_read(auxadc, chan, val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		}
> +	} else if (mask == IIO_CHAN_INFO_SCALE) {
> +		if (chan->channel == MT6323_AUXADC_ISENSE ||
> +		    chan->address == MT6323_AUXADC_BATSNS)
> +			mult = 4;
> +
> +		*val = mult * 1800;
> +		*val2 = 32768;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	} else
> +		return -EINVAL;
> +}

...

> +	ret = regmap_update_bits(auxadc->regmap, MT6323_AUXADC_CON10,
> +				 AUXADC_TRIM_CH2 | AUXADC_TRIM_CH4 |
> +					 AUXADC_TRIM_CH5 | AUXADC_TRIM_CH6,
> +				 AUXADC_TRIM_CH2 | AUXADC_TRIM_CH4 |
> +					 AUXADC_TRIM_CH5 | AUXADC_TRIM_CH6);
> +	if (ret)
> +		return ret;

We have _set_bits()/_clear_bits()/_assign_bits() of regmap API. Use them here
and in many other cases in this driver (and probably in the entire series.
I'm not going to comment each of the cases.

...

> +static int mt6323_auxadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mt6323_auxadc *auxadc;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* mfd->pwrap regmap */
> +	regmap = dev_get_regmap(dev->parent->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "failed to get regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*auxadc));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	auxadc = iio_priv(iio);
> +	auxadc->regmap = regmap;
> +	auxadc->dev = dev;

> +	mutex_init(&auxadc->lock);

devm.

> +	ret = mt6323_auxadc_init(auxadc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize auxadc\n");
> +
> +	iio->name = "mt6323-auxadc";
> +	iio->info = &mt6323_auxadc_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = mt6323_auxadc_channels;
> +	iio->num_channels = ARRAY_SIZE(mt6323_auxadc_channels);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "failed to register iio device\n");

One line

> +	return 0;
> +}

...

> +static const struct of_device_id mt6323_auxadc_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-auxadc" },
> +	{}


IIRC we use { } (with space) in IIO for the terminator entry in ID tables.

> +};

-- 
With Best Regards,
Andy Shevchenko


