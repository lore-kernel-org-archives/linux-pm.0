Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587063;
	b=oxzwo7WCn7RbBkRL8re6k1+Pvdl2YEiXtn6bbqLUUflJU1k7JatyRPMFVPK4LohpT/MT
	 fC/c2hgmGRN5ttiN48tD55ZcgTJsYCD6AA89C3whki0gQCRPSPBMKuV21+FP8+MgQENwK
	 Zp4+mCinxXaZsFXZ/cFwfXtWPCJXJFZeQLTQQcUhhdorUGOqAzQ3hJNdQXGMR7srzFxZ3
	 iroomgv+/u1lWHPxFyubXN9uqtb8Z0SbSQ5KWJPNfJm477aF4h8IkJJlVZTYxfVOvBUt9
	 Jrfh9NF363Hy4hA+8bN3cv8FbRtkH5rs2nGNLytx69VETYHc2EGxhZXYnuiIA/noDzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587063;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1lnheyGukmqW0QueRw7bn0JUixIXN93gHyJq8/dxgYM=;
	b=dvUSNlAspPmggSue6Tcwxxg6sMY17gql8OO0FyLmTjUt7nyqtItNv/rF5fOyZFbCQHMo
	 4cJRVBUa/a5Ny1GXB2Ml2fhn1QrRAZZCK9GIgcJCQnvawFQ81iRfQskilcuRdyQqlKLVC
	 RP8jlERRYq/BWDazVGCuJ0zRDRbfbijZxh60wCDnrfErSIP0IfI+L37ORPn4+1PbNqZXl
	 +oiMtIombRxhiwkGmx0tEX8XIerr/PGUYkfoAIzrfRHFq+0sU5S/HzASPiqB5UbFPOoSq
	 H9xryhIL87sEm7jW/RRepiS30/0TbsxDQuKUhg0OWeAcRbwo3kzXH05XxA/o68cm/3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iCw42+xa;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7A606EB85;
	Fri, 13 Nov 2026 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE7A606EB85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iCw42+xa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794587063; x=1826123063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2l60HEJVY18DxVhS1G3+/e8gkR+sZ4DvH7z/CCA41FU=;
  b=iCw42+xaCgLw4m5QEHhnE1whNX9j4WSao0Kez/tGWs9p3YmZmEFXYnGe
   oAFDIytUtiOE9FxHohMRkGxJ4DlTNZFGSYhuObJ+3Q412vZkPiGII+MWr
   CgZS4gBM/TYuT2jdcm6Y7No2T5969eOfbmPoGKz89USw7gSDxAn75J/h4
   j/te8Y6Yrg0+6oym76PaoUGuAXH3UZ17B2XyjZcRts2MY5Nd4xSE0q13x
   hQoB+V9adZn8b8F/YIAruIy4RHQF12Lf7CLGLLljh5pbHcnKxOPuAsa2N
   Tg4GK6qyBYeAAF2ucxKIZWjSOv3db1FbI3bsYu/ga7fVee836jnNmlTGd
   A==;
X-CSE-ConnectionGUID: WUiNFYWzQ7it9Il9LK48PA==
X-CSE-MsgGUID: EcsAJeO8RWuGcMePmO3bww==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3496187"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3496187"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:24:22 -0800
X-CSE-ConnectionGUID: mNeTNJo8Tz28PN9K8rTAJA==
X-CSE-MsgGUID: oO/fIW3LQ9ikVA/GNiGl9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9043277"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:24:17 -0800
Date: Fri, 13 Nov 2026 18:24:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Reidel <adrian@mainlining.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Val Packett <val@packett.cool>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
Message-ID: <avc5rnvIAEmZbyE1@ashevche-desk.local>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
 <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:56:42PM +0100, Luca Weiss wrote:
> Add the BAT_THERM channels with millivolt as output, which can then be
> used along with information regarding the NTC in the battery, to get the
> actual battery temperature.
> 
> A static lookup table in the ADC driver won't work since different
> devices have different Ohm and Beta values in their battery NTCs, for
> example a NTC can be 10kOhm & B=3435K.

...

> +static int qcom_vadc_scale_hw_calib_therm_volt(

This is broken indentation. Was `clang-format` being used to achieve that?

> +				const struct u32_fract *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_uv)

result_uV

> +{
> +	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
> +				prescale, data, 1000);

1000 is odd, can you use something from units.h or combination of those
to show what this multiplier is for?

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


