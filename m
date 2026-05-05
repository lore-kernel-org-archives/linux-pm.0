Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259F3E4C90;
	Tue,  5 May 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968007; cv=none; b=ihIHZGzIwu0zzIzGcdJlRUPUGatOux4H1mEFBj1upk6C+TpWVvpmm2aZVXAyVlkfKJGcOmHPg5tt/VrWvfLV9yqKVwDE0zs5P2Q4a4WR0tRNwLBcnC8y+Jp36VJrxj9O1O4EpR6H/pNe4AeRhAdQO9aAD1cTvdpN8Ek760ek3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968007; c=relaxed/simple;
	bh=e5TdMMMshQ/NUER+c6FHekX5QCigzt9bH/+8TPl1gr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhjqfa3LbonOGQlL5CiwlIXgGNJGXrCUXM+8aL/NZg0E9Iyp2Dn5F7NyxEhWBvs1PBqF6B6nYw9qjCIdM7BnHJFVXfKlw5enLWh7Ia+suzpfLjBv6giFnZfa0ZbjGgYumI6JpeDInHqPXMSGl6tv+AR+fX/VLelXBMWiDI7zQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4BQMN2h; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4BQMN2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777968006; x=1809504006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e5TdMMMshQ/NUER+c6FHekX5QCigzt9bH/+8TPl1gr4=;
  b=Z4BQMN2hmXMORS68KZ8KCUEprpR/PpnfLOr8yEdpj2XvblgNFwiLPMjh
   IUOHYbTD6AYLlwHYA4safEkzA7BcwNeLR4u8Uw5VlwT3z+lemezxr+/tm
   L6ns8NIYdUmABW+sdKfwvAPFph6GquSCQkurNXU3oE3ZAftE00C+fXt0E
   FHpzonlzhPrGTCJWlBOv2KWNqjgsRPdGeL/xtbz/TqtQnc+Ed2qVkg96H
   +gX4udCE+ON110N5xVGLk/Dg74wIkhaL3jcnDSfZpP9VFi3oRFhPCo2yk
   2naHHkINDf4vpHesigXeiANfiD+HpkRXAb4SHYxs3KPjtsjTWVI3Mr4K2
   w==;
X-CSE-ConnectionGUID: LGWOY6Y8QweLtp++r5elIQ==
X-CSE-MsgGUID: SBuwGk9iSj+/dsDFL+riaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="101498993"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="101498993"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:00:06 -0700
X-CSE-ConnectionGUID: hxN2Bkm8R72rAe/47L/e8g==
X-CSE-MsgGUID: 9D/82zBaSFapcfnhxHpoQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="266089021"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:00:00 -0700
Date: Tue, 5 May 2026 10:59:57 +0300
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
Subject: Re: [PATCH 05/13] nvmem: add mt6323 PMIC EFUSE driver
Message-ID: <afmjfWtt7Vii6xfH@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-5-799b58b355ff@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-mt6323-v1-5-799b58b355ff@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 09:24:57PM +0300, Roman Vivchar via B4 Relay wrote:

> Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> thermal sensor calibration values.

Besides below comments, check for the similar issues that previous patches in
the series have.

...

> +#include <linux/device.h>

Not needed as platform_device.h implies this ("is this good or bad?" is a
different story).

> +#include <linux/io.h>
> +#include <linux/mfd/mt6323/registers.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

Follow IWYU. At least missing types.h.

...

> +struct mt6323_efuse {
> +	struct regmap *regmap;
> +};

Do you really need a custom wrapper data structure? Can't regmap be used
directly?

...

> +static int mt6323_efuse_read(void *context, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct mt6323_efuse *efuse = context;
> +	u32 tmp;

> +	u16 *buf = val;

Really? CPU order all the time?

> +	int i, ret;

Why is 'i' signed?

> +	for (i = 0; i < bytes; i += 2) {

sizeof()?

And since 'i' is used only inside the loop

	for (size_t i = 0; i < bytes; i += sizeof(*buf)) {

> +		ret = regmap_read(efuse->regmap,
> +				  MT6323_EFUSE_DOUT_BASE + offset + i, &tmp);
> +		if (ret)
> +			return ret;
> +		buf[i / 2] = tmp;
> +	}

+ blank line.

Isn't this reimplementation of bulk read? Why the latter may not be used?

> +	return 0;
> +}

...

> +static const struct of_device_id mt6323_efuse_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-efuse" },
> +	{ /* sentinel */ },

Having trailing comma in the terminator is nonsense. Do we expect anything
behind it?

> +};

-- 
With Best Regards,
Andy Shevchenko


