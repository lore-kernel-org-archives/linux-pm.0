Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169674;
	b=fAyjBh7kyJFh8uex8oJGM6uRQI65Q8ZbyIIS6DxmZW/dhftFklVZYSSJ/oFghvgSNWHx
	 jgOFVnrZQk4KFvWkzLdeLr6Qr/UbcA1avcXq/B8VByrDSWKnzK0g88mDwcNxFr1Bp6G2D
	 8pLoKpzmuYSfOXLV4EYMfWRH6YcBdOIvDIj94hiD6ZRyN+fl1841iVc0MAR5gX9SdFwyV
	 h0gOeNDIpODFGiG4tS+hpdJ5iVOEumEyZE4uhMFxEyeFzDlxTU5n409KFVdiSFfmao8x8
	 sfgZcBPvA4s5ykqRjydecWTlCuf/G8YaZeMFG/7/QLOOvqEfMFdR66xGOR3gB6NOymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169674;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2wpTZnwZrQmAs5yJo+iPoPh+BVh2rblZj2xJOy1LmjY=;
	b=fSEMKOU8Uu69NY7J3n+PJO8khZFQSDwB+ER/g5+TdpMy80nYHtIMPMf6N79s74/vzBzA
	 R3rKGdABLw724np2jcjpdeAVA592jEtJzu0K8A01/NWVJVwUCUsoLy44QABrGw55yV1UI
	 6+amWpTt+jnFR3Jn9MEBJgr/AJksTcbR9VUqQCZ6VtjOWYN00y0pA7u/S5TJZbseo7eSe
	 10KkmHcQen9TsQ263qtKiA+H1Q9VC4K5lgKVoiygJnRJlZ8uZQkf1EEVYo81+EqknTCQL
	 JIjykyzt9LwktdMIXMH4KCNHarFF1OMPkUUE073IFNAXG+HV/WreP0GRF4wUKq00Khg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g4x90yCK;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB6606A320;
	Fri, 20 Nov 2026 10:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BB6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g4x90yCK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795169673; x=1826705673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtPSTbj/PV9cC6IAIY1CIdaxj+4MfBZB2XFfEOoQC+M=;
  b=g4x90yCKe3ML0PQBUUWW2Y3N4Qr6qQmJHAR1PVdYeM97Ul3B14jgJQ2S
   Zh8g/iBRfeDL2bbliFwZtyIIrg5akhsRLjnvFQ7o7USTvU5dqgqSQV8ab
   dcpQevIsF9f/3wP4eFiX5Kmd5mma9sL5X58BdDFLXD/XougZMRVotMlOJ
   AfU+du9Y1Xv7U1gUCzyF/6j4iM+sgqY6tcoS77vmi3A1DXM+6E4eHaiUb
   uqHKC0VyJfK29g0bzfp66MC2x5QvzNYu2+ZaBP2tqA8CcFueI5TR5E8lF
   Oy+cq/j/rMq8BuFosojjGUtG5FLmcnJyP5NgfGylWvJiCsn+S6ZmOvsok
   w==;
X-CSE-ConnectionGUID: oNwb4+HUT7WXkZ+25M5uAg==
X-CSE-MsgGUID: CsaNoJO0RtWuMHNI269KpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3947417"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3947417"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:14:32 -0800
X-CSE-ConnectionGUID: yxyM0xK0TTC2TWFrLPHQfA==
X-CSE-MsgGUID: 38UGPLKAQMqh8ylx32iCVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10553858"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:14:27 -0800
Date: Fri, 20 Nov 2026 12:14:24 +0200
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
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
	Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/7] iio: adc: qcom-spmi-adc5-gen3: Add support for
 QCOM PMIC5 Gen4 ADC
Message-ID: <awAdgHggEZtBnyYK@ashevche-desk.local>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
 <20261120-pmic5_gen4_adc-v2-3-94d0e1fd6847@oss.qualcomm.com>
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
In-Reply-To: <20261120-pmic5_gen4_adc-v2-3-94d0e1fd6847@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 02:49:43PM +0530, Jishnu Prakash wrote:
> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits, so the maximum value of
> these measurements needs to be updated for Gen4. Add a new scaling
> function for thermistor channels which use this type of conversion.
> 
> It is possible that the master PMIC has ADC of one generation and it needs
> to communicate with another PMIC with ADC of a different generation. For
> example, on SM8750, PMK8550 is the master PMIC with Gen3 ADC and it
> communicates with PMIH0108, which has Gen4 ADC. Add a new DT property
> "qcom,adc5-gen4" to distinguish Gen4 channels under a Gen3 master, to
> ensure that their conversions are handled correctly.
> 
> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> under the PMIC arbiter and 32 PMICs under each bus. In order to
> support communication between ADC on the master PMIC and ADCs on any
> of the other PMICs, a field of width 2 bits is added for bus index
> and the bits for SID are extended from 4 to 5 bits, in the SID
> register. Add support for this.

...

> -	/* Write SID */
> -	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> +	/* Write SID and bus_id*/

Missed space.

> +	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->bus_index) |
> +		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->sid);

...

> -static const struct adc5_data adc5_gen3_data_pmic = {
> -	.full_scale_code_volt = 0x70e4,
> -	.adc_chans = adc5_gen3_chans_pmic,
> -	.info = &adc5_gen3_info,
> -	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> -			   { 85, 340, 1360 },
> -	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> -			   { 15, 100, 200, 300,
> -			     400, 500, 600, 700,
> -			     1000, 2000, 4000, 8000,
> -			     16000, 32000, 64000, 128000 },
> -};

Seems like this is existing piece and you moved it up. Please, split that part
to a separate prerequisite patch.

...

> +static int qcom_adc5_gen4_scale_hw_calib_therm(
> +				const struct u32_fract *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_mdec)

Even if the rest of the file uses this ugly indentation, correct it for a new code.
Not a problem if lines will be a bit longer.

> +{
> +	s64 resistance = adc_code;
> +	int ret, result;
> +
> +	if (adc_code >= RATIO_MAX_ADC5_GEN4)
> +		return -EINVAL;
> +
> +	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/

Again, missing space.

> +	resistance *= R_PU_100K;
> +	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);

I would put it like this

	resistance = div64_s64(adc_code * R_PU_100K, RATIO_MAX_ADC5_GEN4 - adc_code);

OR this

	resistance =
		div64_s64(adc_code * R_PU_100K, RATIO_MAX_ADC5_GEN4 - adc_code);

(but it still uses two lines, so I find the previous one slightly better).

> +	ret = qcom_vadc_map_voltage_temp(adcmap7_100k, ARRAY_SIZE(adcmap7_100k),
> +					 resistance, &result);
> +	if (ret)
> +		return ret;
> +
> +	*result_mdec = result;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


