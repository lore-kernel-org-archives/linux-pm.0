Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847866;
	b=uMl4g/6GPmEgNrtGALQK5+VKMQ+rVg8BD0eD/0W7562tSWfv/db7QsBq5dK8l9IsVcCO
	 P2jWgDmgN9/VkiBqG9Mt2vE4JagjwBwMIRLczrUAo5A8QGeGnDQMM6PrMkN1GXDm0TOY/
	 qP3AwZV2riiB64dSzQIFJBWsWtns5ftI0l1eBRnEDG5RwKyKyNpw8GGVRAbgpk+ysB12i
	 BF+A5M05zccGNk1lJI8L6k2xwyLHgDE+Sq5J/ju5M7TNn2hw75Cla+y+W/vAg65Awc0ky
	 N89RgI9cHxiXIX3Wzuhrowpp10FI9L88FQKWP942SuIfDq8bVhuv32xnNcE7YdOpoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847866;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=niX0/7kWjmLy1DxMm+YmwH5Ftvq6nAr9bzoEqjR0tSE=;
	b=1tvD4W3iGJeFyrM6uQAN1vf7zJikJqMIqK1pUhYdppmXPEtIjn/LXSgqaBoQATQJjfmt
	 7CaQHO/yqw9mUC7czJ1IuiUX+SrfB90+HSVnbto1TEQ6VtTPCmzD4jduoZJ6PCwbb+N8Y
	 9Hvah13NRYVX6wqkrVO3LvFkLHqjjXOSVK5DwjFcedF5z+33rn6aCHzACr5DT1xyhqRtw
	 xhGIDzlWylK1V1kMO4iZQmiQL9xMoxJH/I6BEMRSkq1jfB/Y2XGDU4UHKvkdDZjfQoO/t
	 L0rxR17gfVTRl4AWefJgom3THEHS8kC4EoHRZ0cAmI8H0kbb1Hts/sQb0KkHQsW4u9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="kwFoi3/9";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C90606A322;
	Mon, 16 Nov 2026 16:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C90606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kwFoi3/9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794847866; x=1826383866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=toMRuYLNs5jiuk2i/De6hLDe9tSlhsjDdzmsxSWix6E=;
  b=kwFoi3/9h0RPo4joQTAVXBoc4WBNbkZXU0mTuaoWp8Sl/novtlTTx21B
   W0C89lMfO5DHU78VqTWRkXBiME+Z6nQHQrVyw6MG7/S1pBJI/0op87UtP
   pnA8F16dlwiOspovQfpUYBjr0rEwb+E1+7PBfqDFOp1VSQEWSzS+NGzy1
   SoNkbfw6a9uS+LjvqbxdQo/pgyChayIRml8Jz26Eh4aW2eriCr3znnkvP
   sBYBCqLoGT1u4RqJODrGCqr21NQcgOiMVH8IvrJhKVe/HoMiAVCDaTK5f
   yrT7gHb2qg+l4V8sfNXwg7z8XILSq6+7oTIKonVYjRFwJFlqrOkW5hxpM
   w==;
X-CSE-ConnectionGUID: 7eF3vCsSSTCV1d7WEaPREw==
X-CSE-MsgGUID: sZ0HgaggSH6JTAQMXcedMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3500091"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3500091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:51:05 -0800
X-CSE-ConnectionGUID: wAcIHMRTTfyy8TESlIw1MQ==
X-CSE-MsgGUID: /5Xe1gOQRLyo46MHLbBr7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9762467"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:50:59 -0800
Date: Mon, 16 Nov 2026 18:50:57 +0200
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
Message-ID: <avs0cThxYLWyXE-X@ashevche-desk.local>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
 <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
 <avc5rnvIAEmZbyE1@ashevche-desk.local>
 <DMWR1CJJRHMF.33YRRRDXPMBDW@fairphone.com>
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
In-Reply-To: <DMWR1CJJRHMF.33YRRRDXPMBDW@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 04:43:49PM +0100, Luca Weiss wrote:
> On Fri Nov 13, 2026 at 5:24 PM CET, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2026 at 04:56:42PM +0100, Luca Weiss wrote:

...

> >> +static int qcom_vadc_scale_hw_calib_therm_volt(
> >
> > This is broken indentation. Was `clang-format` being used to achieve that?
> 
> This is how the rest of the file is formatted, I didn't deviate from
> that.

Oh, I see, that's unfortunate.

> >> +				const struct u32_fract *prescale,
> >> +				const struct adc5_data *data,
> >> +				u16 adc_code, int *result_uv)
> >
> > result_uV
> 
> As Sashiko pointed out, this is labelled wrong, the result is millivolt.
> 
> The rest of the driver consistently uses "mv" for that, should I deviate
> and use result_mV?

In that case _mV, yes.

> >
> >> +{
> >> +	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
> >> +				prescale, data, 1000);
> >
> > 1000 is odd, can you use something from units.h or combination of those
> > to show what this multiplier is for?
> 
> This is converting microvolt to millivolt.
> 
> Shall I use "(MICRO / MILLI)" as used in plenty other drivers?

Yes.

> Two drivers in the tree also have "#define MILLI_TO_MICRO 1000"

They should rather name it explicit with VOLTS inside. So, not a good
example.

> >> +	return 0;
> >> +}

-- 
With Best Regards,
Andy Shevchenko


