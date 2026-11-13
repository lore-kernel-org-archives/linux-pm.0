Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587303;
	b=uyFs6FIB6cUwvSHvxSAMzxUcGah+39BjzXmOLFiJ0Hhxm2zekQ+ZPr17NDv/yWpfuO6N
	 w43nHseP8rCDSMqtDuaTEi1w/HJbAmGLotInTGQu2ZVsxPTG7YcxuowxP3DfSVEeID8kw
	 8cr7MJuqi+TBXtPQAhi/ZYJchkTjydYf3VGCRh3YPU6hYXis4GubKflCqU3C2XGd2Ng+F
	 UnYqIoWZlLZcvYVbNOpvY6InAQCCIZ79Mo7Fpbn70bwBxvvQpIFeHDNjqK3w8iNxE2C+r
	 YT90Ff8FCD1Nf+YzrfimBaZiHJDJNI1wk0ij2nkTiRWihT2asB9O9r/Y0HCR4PDTqlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587303;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oVjHsSJnI32gsi62IORtdTOjPWH7UtaoD2O+G5+4p6c=;
	b=FXhmAgf1kYZ6PwFVstaQZqgDzSALhUg7wK/ggto8PSwxSNOUy+rF6+gsHlvoagAND6uj
	 9jHSVnooBW2JlptbiJ6xkm5F77OThJ9tHwvZOHGYB6t9Ejd+l4kvs8hKHql8RGSE9xKaG
	 Oinl7Aw/owX1EN5vTaRQ8CHRG/m+9CvV48GJy5wieBR2MKI90/tt5nK1a8EZV1AhvOy+4
	 VU7eCmQbB3y7l91l55UPEO6CH6v2kJSmwsyr3WqwunveyuEWEi/E9DVuSzEbUk4JYaQRx
	 /i8MHEr7/mMWqGdwc3iCA5IVIfot3tU8bitkybMwLUmalNGVKviIAcah2wlqPryJ+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k6J4Eiac;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F76606A323;
	Fri, 13 Nov 2026 16:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F76606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k6J4Eiac
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794587303; x=1826123303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rOUS3iehnNsPxQbbRnzZKCyix4huWoVr2RynSHzw+Y=;
  b=k6J4EiacdOP8a1nceXd8iDU+kzyc3cFzqb6l4Y6pJhcA0hr7AxyAayk7
   sAN+BS6nhnvxiek1OOisHgwBuV/lvDNlavrJabqLrWHXUjlBnzi/m6x0W
   yB3Dda5LFlxLIREsgEgbimETPjE9NI4g0fxpL9gADQKXZBQzHqCPacKN6
   lEnTGLnQTZ5uYEbVHFhbNja714XMY/YE/sVYHvpEmMyoAoIpvJoZKUL/c
   KDymzqXJgxhYv5w2gUZhKtg5NyIWQ3kexAg4tAwM64Cq8z14uKhqvcq6D
   W3lumWihbpE6xgg11F4JEUK8Rnrm2YW4JDZdOjVwUP7J3d7oigZAqjSnk
   A==;
X-CSE-ConnectionGUID: 5YCkNVdJScOfd6hcFcIrug==
X-CSE-MsgGUID: 5TkXX387RE6IAPqoh2HnlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3471713"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3471713"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:28:22 -0800
X-CSE-ConnectionGUID: 98uHgAxrRwuvD7TBI0jFoA==
X-CSE-MsgGUID: wiSuJyN9RiGKpAjmjTIesQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9277191"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:28:17 -0800
Date: Fri, 13 Nov 2026 18:28:14 +0200
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
Subject: Re: [PATCH v3 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Message-ID: <avc6niMcZC0TV4QD@ashevche-desk.local>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
 <20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
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
In-Reply-To: <20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:56:44PM +0100, Luca Weiss wrote:
> If the devicetree node is not referenced in a zone under /thermal-zones,
> devm_thermal_of_zone_register() will fail with -ENODEV.
> 
> Since the driver is now also registering as an IIO device[0], allow the
> probe to continue without the thermal zone.
> 
> We also can't use gadc_thermal_get_temp() anymore because we haven't
> necessarily initialized tz_dev.

...

>  	if (IS_ERR(gti->tz_dev)) {
>  		ret = PTR_ERR(gti->tz_dev);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Thermal zone sensor register failed: %d\n",
> -				ret);
> -		return ret;
> -	}
> +		if (ret != -ENODEV)
> +			return ret;
>  
> -	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);

> +		dev_info(dev, "Thermal zone sensor register failed: %d\n",
> +			 ret);

It fits one line.

> +	} else {
> +		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> +	}

Can we write it as

	ret = PTR_ERR_OR_ZERO(gti->tz_dev);
	if (ret == -ENODEV)
		dev_info(dev, "Thermal zone sensor register failed: %d\n", ret);
	else if (ret)
		return ret;
	else
		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);

?

-- 
With Best Regards,
Andy Shevchenko


