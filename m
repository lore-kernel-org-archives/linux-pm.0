Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156782F7478;
	Tue,  2 Jun 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443328; cv=none; b=BueNHHmJKy6KN6hnSfyy60Yrs0bwQVlvx3hdUx1QG14mshT9q3gTo3Z4yYLMmZL7n1zTnwJ+Y9enA9ACDuXkRbqEntUEMFx7KWRRPLdgAHcBpVuQ2Wnh6ASH0zUFDczZ2TTuKd5WOwdTG6oMbWsyTDaUadP9hIqPSD5q7m0NQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443328; c=relaxed/simple;
	bh=CPp9mntO1Z8AhjLa62UOmTDu/vkEQOgFfpPOSYZt15s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0jEASzPfclECLWI0fUcMUejGZ36m9RKZVbKmS0tyimb9izI3p47BLm3mO8HG3Xu+P8zkN5XPUsKRYet3Tmfe8QNZxFrpDRfzH99iaOV1HlJrY1k3wBGTKQY+Z4G2ZRkPxfwgbRcUhPVGC4xkzPYbhDD/ph4Fe8BUAPqG3mejj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzkKhO/f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzkKhO/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443327; x=1811979327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CPp9mntO1Z8AhjLa62UOmTDu/vkEQOgFfpPOSYZt15s=;
  b=NzkKhO/fW/hpoozaXZ/zUtxmahicw8zwhCfCtltHb0itCY4dAzBdYtLZ
   YxcxC9krgMc7uIz9aI9C6OqyqaOoP+Y4ZnlLjpoZiPNs5AbbYip7hMxTA
   NF4sAR4M8T2rs5+hAaXBMYJQjerypP1Tc2sVGhU943Hvh2cGw6OA5QH/t
   85YqljIfNisacvfOy0Ejg7anHSzinEOK1NlpPwAz4oi2A+vtYRkeaNt7A
   FgDYRziXKrmJ0aIT1U3G56+41Yp+3BhzlsZ2Z8qAkN8CkQbdFapWjQGu6
   T++6RW4xelk3daOq+i0qxDJemfj7DK9ZXncvrhcIw7wssPDX944loc7Nd
   g==;
X-CSE-ConnectionGUID: IpI3nzZMQ4a623RUKtX+dw==
X-CSE-MsgGUID: 8jjomkLyRYuYtCWq+XY1FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369633"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369633"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:35:26 -0700
X-CSE-ConnectionGUID: B64CSb24SA2zGjQ1FyNgJA==
X-CSE-MsgGUID: KxNNY/SkSGC5FivD3At41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="267921782"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:35:22 -0700
Date: Wed, 3 Jun 2026 02:35:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
Message-ID: <ah9ouLQFI7VtHCWL@ashevche-desk.local>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 26, 2026 at 04:26:09PM +0530, Jishnu Prakash wrote:
> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
> immediate ADC reads done in this driver and for threshold violation events,
> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
> TM channels on the first SDAM.
> 
> At present, this interrupt is handled only in the ISR in the main ADC driver.
> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
> driver by calling a notifier callback exposed from it for this purpose.
> 
> To simplify the interrupt handling in both drivers, share the interrupt between
> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> the ADC_TM driver, so remove the notifier callback and all TM interrupt
> handling in the main ADC ISR.

...

> +	/*
> +	 * This interrupt is shared with the ADC_TM auxiliary driver, which
> +	 * is threaded and uses IRQF_ONESHOT. Since shared interrupts need
> +	 * to agree on IRQF_ONESHOT configuration and there is a kernel
> +	 * warning for using IRQF_ONESHOT with non-threaded interrupts,
> +	 * make this also a threaded IRQ.
> +	 */
> +
> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> +					adc);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to request SDAM%d irq\n",

Also add a patch to drop this duplicate message.

-- 
With Best Regards,
Andy Shevchenko


