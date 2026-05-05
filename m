Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C753D565E;
	Tue,  5 May 2026 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968986; cv=none; b=pBkNEz8PgeBHn/20xvPkt/wD+K9QUwmnZX0q85weZlucE8PZS8Rq1xOzXtIG2p2ViGSw1jCUuAFRrj86rjA1TPF+1CKdD/aWjT/cddBx7iMU+szxSozRbF7nZpOQwxkIroHSqTh7dgrG4Msixm7VMADfu5jLJ22LSQFSp5Ql5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968986; c=relaxed/simple;
	bh=g+zxFimWOaIqhOyLpJlxgYGzOopzI118ke5hAnL5GcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azBDZLSW6yYvp9lqYTQEmWCHMyzf5EV51ZRi5Om7jxKyAyqLWWJ7b3zQ4F2/94eFJdYTxzLTNzsHSbCDAdVN4qgtLRl+0VoBRwH709wCDD9QwEqBFR9BqryZKW2/2YYnBCTonjVugbFUbccszPCkgCXk1geJYPjxdHn9ezGjuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTxNnaHi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTxNnaHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777968984; x=1809504984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+zxFimWOaIqhOyLpJlxgYGzOopzI118ke5hAnL5GcU=;
  b=UTxNnaHiwgb2rhUflZ8+ScVBiUN87M6CQEtyS6tKFNATq5mTuEOD9HYB
   ZXOxpyfIkapkBG/At4S7l4VNBoknyyP6zW4MF1aCIAsIrE9Yk2Nnv9cHL
   TW1FRDWfXmmSrj9z6ZgFUW4HImYLatm2eYkPQgbeceiZsR/UuFu785GfX
   fukZ7wPXX/JZox+y3Cx4nEmC2l1REJObXRK/AA5BzS66dIv/EjuovNoxy
   CJkLvEe75mrmeuEu7QFdg1hvJN1/R2fEJYx9/wsvRbHvhKYMnZccm7hn4
   TSugKeQXT8Yn/0E+dWJXA+cz2pLWzNE8IoN5EgC7EYx5CcKgCjtznecDg
   Q==;
X-CSE-ConnectionGUID: nsnAEIfvQk+WTLyWC7sbKQ==
X-CSE-MsgGUID: LlgKYobcQ+OhAVOHNRUHZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96260436"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="96260436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:16:24 -0700
X-CSE-ConnectionGUID: 8IcJ58BYROusM7pCtr2zYg==
X-CSE-MsgGUID: 1HuvudfwSVqCuBtHxLSekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259425562"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:16:19 -0700
Date: Tue, 5 May 2026 11:16:16 +0300
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
Subject: Re: [PATCH 06/13] thermal: mediatek: add pmic thermal support
Message-ID: <afmnUG8dG0N0HpV6@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-6-799b58b355ff@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-mt6323-v1-6-799b58b355ff@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 09:24:58PM +0300, Roman Vivchar via B4 Relay wrote:

> Add a new driver to support thermal monitoring on MediaTek PMICs.
> 
> The driver retrieves calibration data from EFUSE, calculates the
> temperature using a linear interpolation, and registers the device with
> the thermal framework.
> 
> Initial support is added for the mt6323 PMIC.

First of all, please take into account the comments given against previous
patches.

...

> +config MTK_PMIC_THERMAL
> +	tristate "AUXADC temperature sensor driver for MediaTek PMICs"
> +	depends on MFD_MT6397
> +	help
> +	  Enable this option if you want to get PMIC temperature
> +	  information for MediaTek platforms.
> +	  This driver configures thermal controllers to collect
> +	  temperature via AUXADC interface.

Don't we want to tell user how the module will be called in case of M choice?

...

> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>

> +#include <linux/kernel.h>

No way your driver uses this header.

> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>

Please, follow IWYU.

> +#include <linux/mfd/mt6323/registers.h>

...

> +#define MT6323_TEMP_MIN			-20000
> +#define MT6323_TEMP_MAX			150000

Don't you want to use units.h multipliers?

...

> +/* Layout of the fuses providing the calibration data */
> +#define CALIB_BUF0_VTS(x)		(((x) >> 8) & 0xff)
> +#define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 2) & 0x3f)
> +#define CALIB_BUF0_ADC_CALI_EN(x)	(((x) >> 1) & 0x1)
> +
> +#define CALIB_BUF1_ID_20(x)		(((x) >> 14) & 0x1)
> +#define CALIB_BUF1_ID_10(x)		(((x) >> 12) & 0x1)
> +#define CALIB_BUF1_O_SLOPE_20(x)	(((((x) >> 11) & 0x7) << 3) + (((x) >> 6) & 0x7))
> +#define CALIB_BUF1_O_SLOPE_10(x)	(((x) >> 6) & 0x3f)
> +#define CALIB_BUF1_O_SLOPE_SIGN(x)	(((x) >> 5) & 0x1)
> +#define CALIB_BUF1_VTS(x)		((((x) >> 0) & 0x1f) << 8)

Why not use BIT() and GENMASK() as appropriate? But better, why not use
bitfield.h APIs?

...

> +struct mtk_thermal_data {
> +	const char *const *sensors;
> +	s32 num_sensors;

> +	const int cali_val;

What exactly does 'const' benefit here with?

> +	int (*extract_efuse)(struct mtk_pmic_thermal *mt, u16 *buf);
> +	void (*precalc)(struct mtk_pmic_thermal *mt, s32 vts, s32 degc_cali,
> +			s32 o_slope, s32 o_slope_sign);
> +};

...

> +struct mtk_pmic_sensor {
> +	struct mtk_pmic_thermal *mt;
> +	int id;
> +	struct iio_channel *adc_channel;
> +	struct thermal_zone_device *tzdev;
> +};

Can you confirm with `pahole` that this is the best layout (taking into account
the use in the below data structure)?

> +struct mtk_pmic_thermal {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mtk_pmic_sensor sensors[MAX_SENSORS];
> +
> +	s32 t_slope1;
> +	s32 t_slope2;
> +	s32 t_intercept;
> +
> +	const struct mtk_thermal_data *data;
> +};

...

> +static int mtk_pmic_read_temp(struct thermal_zone_device *tz, int *temperature)
> +{
> +	struct mtk_pmic_sensor *sensor = thermal_zone_device_priv(tz);
> +	int ret, raw, temp;
> +
> +	ret = iio_read_channel_processed(sensor->adc_channel, &raw);
> +	if (ret < 0) {
> +		dev_err(sensor->mt->dev, "failed to read iio channel: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	temp = sensor->mt->t_intercept +
> +	       ((sensor->mt->t_slope1 * raw) / sensor->mt->t_slope2);

Too many parentheses.

> +	if (!mtk_pmic_thermal_temp_is_valid(temp))
> +		return -EINVAL;
> +
> +	*temperature = temp;
> +	return 0;
> +}

...

> +static void mtk_pmic_thermal_precalc_mt6323(struct mtk_pmic_thermal *mt,
> +					    s32 vts, s32 degc_cali, s32 o_slope,
> +					    s32 o_slope_sign)
> +{
> +	s32 vbe_t;
> +
> +	mt->t_slope1 = 100 * 1000;

magic1 * magic2...

> +	if (o_slope_sign == 0)
> +		mt->t_slope2 = -(mt->data->cali_val + o_slope);
> +	else
> +		mt->t_slope2 = -(mt->data->cali_val - o_slope);
> +
> +	vbe_t = -1 * (((vts + 9102) * 1800) / 32768) * 1000;

More magics...

> +	if (o_slope_sign == 0)
> +		mt->t_intercept =
> +			(vbe_t * 100) / -(mt->data->cali_val + o_slope);
> +	else
> +		mt->t_intercept =
> +			(vbe_t * 100) / -(mt->data->cali_val - o_slope);
> +
> +	mt->t_intercept += (degc_cali * (1000 / 2));

Too many parentheses.

> +}

This entire function misses a lot of comments and formulas with the references
to the datasheet.

...

> +{
> +	struct nvmem_cell *cell;
> +	void *buf;
> +	size_t len;
> +	int ret;
> +
> +	cell = nvmem_cell_get(dev, "calibration-data");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	if (len < 2 * sizeof(u16)) {
> +		dev_warn(dev, "invalid calibration data length\n");

And? Is it fatal error or not?

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = mt->data->extract_efuse(mt, buf);
> +	if (ret) {
> +		dev_info(dev, "device not calibrated, using default values\n");
> +		mt->data->precalc(mt, 3698, 50, 0, 0);
> +		ret = 0;
> +	}

> +out:
> +	kfree(buf);
> +	return ret;

Why not use __free() from cleanup.h?

> +}

...

> +static int mtk_pmic_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_pmic_thermal *mt;
> +	int i, ret;
> +
> +	mt = devm_kzalloc(dev, sizeof(*mt), GFP_KERNEL);
> +	if (!mt)
> +		return -ENOMEM;
> +
> +	mt->regmap = dev_get_regmap(dev->parent->parent, NULL);
> +	if (!mt->regmap)
> +		return dev_err_probe(dev, -ENODEV, "failed to get regmap");
> +
> +	mt->dev = dev;
> +	mt->data = of_device_get_match_data(dev);

property.h instead of of.h and use just device_get_match_data().

> +	ret = mtk_pmic_thermal_get_calib_data(dev, mt);
> +	if (ret)
> +		return ret;

> +	for (i = 0; i < mt->data->num_sensors; i++) {

'i' is not used outside the loop:

	for (unsigned int i = 0; i < mt->data->num_sensors; i++) {

> +		struct mtk_pmic_sensor *sensor = &mt->sensors[i];
> +
> +		sensor->id = i;
> +		sensor->mt = mt;
> +
> +		sensor->adc_channel =
> +			devm_iio_channel_get(dev, mt->data->sensors[i]);
> +		if (IS_ERR(sensor->adc_channel))
> +			return dev_err_probe(dev, PTR_ERR(sensor->adc_channel),
> +					     "failed to get channel %s\n",
> +					     mt->data->sensors[i]);

> +		sensor->tzdev = devm_thermal_of_zone_register(
> +			dev, i, sensor, &mtk_pmic_thermal_ops);
> +		if (IS_ERR(sensor->tzdev))

> +			return dev_err_probe(
> +				dev, PTR_ERR(sensor->tzdev),

What a broken indentation in the whole stanza...

> +				"failed to register thermal zone %d\n", i);
> +	}

> +	return 0;
> +}

...

> +static const struct of_device_id mtk_pmic_thermal_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-thermal",
> +	  .data = &mt6323_thermal_data },

> +	{ /* sentinel */ },

Nonsense trailing comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


