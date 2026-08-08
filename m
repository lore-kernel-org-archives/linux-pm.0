Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDCC37E5DB;
	Sat,  8 Aug 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786223218; cv=none; b=jvb6QVTqvuEDl9o6zR/Ew8T3cL15WeH280ZzTt1QkHVh+waCJqeXbN0dAn0bTY1LzXGKldIYaTUCY/FpNllPXhn1uLnUWj77fVII8172fsbcuwYF23nz0OiE7ngUuhQYeS3tVnx6HVG09jnoYKSmL9JvRMBPWmuv6JRh1R8KRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786223218; c=relaxed/simple;
	bh=3uaIIBiCU8ZU2xp1Kg6FoVtc0HMvElGXp9+wOyz+WT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li2mvTFAA/sqxWHu9NJ0Y7+xBYkn6+sqdCTu2sscQoiIqVFbKI7HPef2c7E00lh17/cCRVFeVkUUUg9T+1HyxKnvjNCxeLwNx56cN2NQDPMs/aUxA6CvktuK4dD/VMpF9WbSSqeT6cI+NG8Du105MwYVjavP/3ZduyPEryKGeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X52o9e3M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X52o9e3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786223216; x=1817759216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3uaIIBiCU8ZU2xp1Kg6FoVtc0HMvElGXp9+wOyz+WT0=;
  b=X52o9e3MngSS0AWFPwuPrm15jHtdN2Fc9TInpVIWhiy+gLwHOPraZ017
   rTvJtnN0O4b1HRQ4EfL1BYivkArR+o0B6vZcgTxVHkq9+E/405542IeWU
   ZWV0EfN0H8svww+Vgg82Ojf0FqnW0jVs2N8RpjLJPuYMbRwoEF2I2cKbA
   F6hSPvx3jy0y2OkBU3D2jnV90YywvvnyPm5Aws6EUXxRCpo/lPaRj0nXw
   lr30Y5qs7yIs6eKl41dknrOtKoiEDzcGLAbmJrBS6EVM+vJsscnxtyD8m
   mtn+MzAV1of9KWeV5t+qY93+5lo8V48llCBE6SKUOeS+50LCraahMhGYM
   A==;
X-CSE-ConnectionGUID: 5JQvV/7lQoG0YnnO6PskBA==
X-CSE-MsgGUID: 3+KRzg9/Qp2FYdXgvTWBFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86672656"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="86672656"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 14:06:55 -0700
X-CSE-ConnectionGUID: Y7Sn9Uc9RfqymAl2nC60yw==
X-CSE-MsgGUID: d7mDPEAGQHiTjs47ogbYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="259365082"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 14:06:51 -0700
Date: Sun, 9 Aug 2026 00:06:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
	Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
Message-ID: <aneaaJ_gmyyLh8mY@ashevche-desk.local>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 31, 2026 at 11:36:15PM +0530, Jishnu Prakash wrote:
> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits, so the maximum value of
> these measurements needs to be updated for Gen4. Add a new scaling
> function for thermistor channels which use this type of conversion.
> 
> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> under the PMIC arbiter and 32 PMICs under each bus. In order to
> support communication between ADC on the master PMIC and ADCs on any
> of the other PMICs, a field of width 2 bits is added for bus index
> and the bits for SID are extended from 4 to 5 bits, in the SID
> register. Add support for this.
> 
> In addition, it is possible that the master PMIC has ADC of one generation
> and it needs to communicate with another PMIC with ADC of a different
> generation. Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
> to distinguish Gen3 channels under a Gen4 master and Gen4 channels
> under a Gen3 master respectively, to ensure that their conversions are handled
> correctly.

...

> +static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
> +	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
> +						SCALE_HW_CALIB_DEFAULT)

Always nice to see a macro with the embedded comma...

> +	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
> +						SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
> +						SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN4_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1,
> +						SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN4_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
> +	[ADC5_GEN4_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +	[ADC5_GEN4_AMUX5_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
> +};

...

>  enum adc5_cal_method {
>  	ADC5_NO_CAL = 0,

(here as well, see below)

>  	ADC5_RATIOMETRIC_CAL,

>  };
>  
> +enum adc_generation {
> +	ADC5_GEN3 = 0,

Why is this assignment? What's wrong with the C standard?

> +	ADC5_GEN4,

If these are related to HW communication protocol or bit fields, all of them
must be explicitly assigned (to make code robust against changes in the middle
of enum).

> +};

-- 
With Best Regards,
Andy Shevchenko


