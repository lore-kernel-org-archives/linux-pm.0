Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97D428474;
	Wed,  6 May 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073986; cv=none; b=WQVwBnMWyVw/DZJYu21tlhRd1BBRJh81gWeyuRikPqkFf+TjKwsHG1gUjIQmbssoXiGqQyNYyLnPHSHO1V/63ReflsidRNCWe8WDzv6++Di4WeKZzoUYiHHNxzBsXt0AxhucdoFxP0RyQC4wp4aL7oM2czo4HM5DJQJHMvbWqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073986; c=relaxed/simple;
	bh=xaKcmCC+I9v/E09bRdoBMaTkVzosR8rUiWNrEUV6lAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5sH5Dg06AAqC0YrR6dD4UQIBP7m/OJ7W0WFoi1/EXzzaT7KmbGwRadrRsa+kWyypFPB3Pbho/OqyPSgMqZ6C9qYcbtGFZRbnAUMUVrBQPIT03BAmaZaYcErfcpNoyKJs6yxwZ6y8YXDXKigp2BpdLEeklUpJ1vxM/K3Pogm3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kn+Nojck; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn+Nojck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778073984; x=1809609984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xaKcmCC+I9v/E09bRdoBMaTkVzosR8rUiWNrEUV6lAg=;
  b=Kn+Nojck1aQDpvDs6sZpBe+keJhErcrZLKGJxT+oyOMP0h0IOBHqxV1p
   1Tk05lqs4qKHuQxX09uG1Pejy/q53jcEQWdeRE1qBRsvkBcqHv01hZVwj
   B//qJvxTZqZH+7omXrQbztU+Zel4Qd79zqEvbPWwloVTfHNGX8fMXdZox
   UGCQ4PNCXDWZJp7zuekqY8BwTUmdB6vaXmcrXl8oIzqNq1ZfWoAtpg19f
   J7uTQkp/+NdPB47QXfw8T+LRwY/p4NfcKF8fli2KB41Dz7zGumCkfukx+
   xMZg4kBq2DlVqkoJDXbFU5DK6V3exKq0yrkjxSUjwEDTfEinlEd0qaqlE
   g==;
X-CSE-ConnectionGUID: G6eMnH1hTYuQP1PlIslZHA==
X-CSE-MsgGUID: 62NSLGv9QwikO+m2V57evA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89312838"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89312838"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:26:23 -0700
X-CSE-ConnectionGUID: 1H3000o9TMadDzDQXXLY9Q==
X-CSE-MsgGUID: tL+QbN0HRuqstpiz/lB/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235306952"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:26:19 -0700
Date: Wed, 6 May 2026 16:26:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Vivchar <rva333@protonmail.com>
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
Message-ID: <aftBeFbVIap59FFS@ashevche-desk.local>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
 <20260504-mt6323-v1-6-799b58b355ff@protonmail.com>
 <afmnUG8dG0N0HpV6@ashevche-desk.local>
 <cgsML96DsJh_Ow9XsSnyrZ3NhlCnNj1rKegzYNR3eQzkWoF5xQB5-aU6Zi7pKcT8GfUnO3B-D71je60APUtorB7p_A3GtUCp2oer3KYLn6k=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cgsML96DsJh_Ow9XsSnyrZ3NhlCnNj1rKegzYNR3eQzkWoF5xQB5-aU6Zi7pKcT8GfUnO3B-D71je60APUtorB7p_A3GtUCp2oer3KYLn6k=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:22:15AM +0000, Roman Vivchar wrote:
> On Tuesday, May 5th, 2026 at 11:16 AM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, May 04, 2026 at 09:24:58PM +0300, Roman Vivchar via B4 Relay wrote:

...

> > > +struct mtk_pmic_sensor {
> > > +	struct mtk_pmic_thermal *mt;
> > > +	int id;
> > > +	struct iio_channel *adc_channel;
> > > +	struct thermal_zone_device *tzdev;
> > > +};
> > 
> > Can you confirm with `pahole` that this is the best layout (taking into account
> > the use in the below data structure)?
> > 
> > > +struct mtk_pmic_thermal {
> > > +	struct device *dev;
> > > +	struct regmap *regmap;
> > > +	struct mtk_pmic_sensor sensors[MAX_SENSORS];
> > > +
> > > +	s32 t_slope1;
> > > +	s32 t_slope2;
> > > +	s32 t_intercept;
> > > +
> > > +	const struct mtk_thermal_data *data;
> > > +};
> 
> On the ARMv7 it shouldn't be an issue, because pointer size equals to
> the s32 or int. However, I've reordered the fields to group pointers
> and integers together.
> 
> struct mtk_pmic_sensor {
> 	struct mtk_pmic_thermal *  mt;                   /*     0     4 */
> 	struct iio_channel *       adc_channel;          /*     4     4 */
> 	struct thermal_zone_device * tzdev;              /*     8     4 */
> 	int                        id;                   /*    12     4 */
> 
> 	/* size: 16, cachelines: 1, members: 4 */
> 	/* last cacheline: 16 bytes */
> };
> 
> struct mtk_pmic_thermal {
> 	struct device *            dev;                  /*     0     4 */
> 	struct regmap *            regmap;               /*     4     4 */
> 	const struct mtk_thermal_data  * data;           /*     8     4 */
> 	s32                        t_slope1;             /*    12     4 */
> 	s32                        t_slope2;             /*    16     4 */
> 	s32                        t_intercept;          /*    20     4 */
> 	struct mtk_pmic_sensor     sensors[1];           /*    24    16 */
> 
> 	/* size: 40, cachelines: 1, members: 7 */
> 	/* last cacheline: 40 bytes */
> };
> 
> The compiler will still add some padding on the AArch64 though.
> 
> struct mtk_pmic_sensor {
> 	struct mtk_pmic_thermal *  mt;                   /*     0     8 */
> 	struct iio_channel *       adc_channel;          /*     8     8 */
> 	struct thermal_zone_device * tzdev;              /*    16     8 */
> 	int                        id;                   /*    24     4 */
> 
> 	/* size: 32, cachelines: 1, members: 4 */
> 	/* padding: 4 */
> 	/* last cacheline: 32 bytes */
> };
> 
> struct mtk_pmic_thermal {
> 	struct device *            dev;                  /*     0     8 */
> 	struct regmap *            regmap;               /*     8     8 */
> 	const struct mtk_thermal_data  * data;           /*    16     8 */
> 	s32                        t_slope1;             /*    24     4 */
> 	s32                        t_slope2;             /*    28     4 */
> 	s32                        t_intercept;          /*    32     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */

^^^^

> 	struct mtk_pmic_sensor     sensors[1];           /*    40    32 */
> 
> 	/* size: 72, cachelines: 2, members: 7 */
> 	/* sum members: 68, holes: 1, sum holes: 4 */
> 	/* last cacheline: 8 bytes */
> };
> 
> Is this good enough?

In the last it seems moving the s32 members to be the last will removes
the 4-byte hole.


-- 
With Best Regards,
Andy Shevchenko


