Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E98404BCF;
	Thu, 11 Jun 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204023; cv=none; b=j+tr/fNynsn/fvtlHnxsd3VustRZ4f/iYsXDpnw7q67ZC56+axvoYrv2f4SZU28ZToFRGvr+TORv7IfyLfXHsBNirwS0ai77VZFtP0v6Yq5H8YQrQ9cClAv4OYba0QWVvG7Z3UpBNnxKCoHVhclGUj55av8TLV7Uwj6hozyq4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204023; c=relaxed/simple;
	bh=23V39ldrqwWRAB/niUph+06vp/6uCDNAdAo0YdkcaPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6T4XbO4+QM6ZYayuA4VYMrH1yo0xevQ9SqruJkxKGw8MXohxdHM15bN4GcH3ViF6Q6DD9IHhrcFR8waaCmk2uyenLMzVv8fqBLpHBhOBDPkfQNQIXv8yfMQTiWUbty4XD2VZdCfqt+EicQ95KuciJMleA9Z6VM3dk2yYpdNYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfHEFl7D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfHEFl7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781204021; x=1812740021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=23V39ldrqwWRAB/niUph+06vp/6uCDNAdAo0YdkcaPE=;
  b=nfHEFl7DX1NLvK1lKJM1V37bbDDHeW6Pa67vK780lqcbi96UNVM1ZZyF
   ZI/x2KCC7Llms2eJ3flBhj0SlW48ffa+vZyc+DdmaJjthMi3+RuaEX9hJ
   RGJyiYBbnbzt1I0Wkxqw77onw4/uYz8dzwHpg57paiSx6vRH17q31kIEn
   vi88fouk+iaV5GI1Hf+NdgPJbCSxu7Yv8RCLbWh4t83t7Lck9TCXHoULD
   ZXQOJozGnjvjEYa5HDm8ksPY9Q5qLwO5PbSqhXKx3882BRmQ73zqg+HdC
   9RmOUNeinP3tLvdtZ58M5K+m5WBGJaD8Lg3kblpwgQjBl752kKkdnaV9g
   g==;
X-CSE-ConnectionGUID: 5A+9LAtOSFWxWNjW6G3Z7A==
X-CSE-MsgGUID: 4/k0kTyTTKmBVKv/bmK5XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85658020"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="85658020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:53:40 -0700
X-CSE-ConnectionGUID: 4DcHKMqVSvCRPyH3Ekivlw==
X-CSE-MsgGUID: I93WhNpvQnGs3+X+1wm2ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242446551"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:53:35 -0700
Date: Thu, 11 Jun 2026 21:53:33 +0300
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
Message-ID: <aisELR6v1EWGcmqb@ashevche-desk.local>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
 <ah9ouLQFI7VtHCWL@ashevche-desk.local>
 <20260604114630.23ca427a@jic23-huawei>
 <aiGPMqHcz_AkUezI@ashevche-desk.local>
 <d095233e-ac2a-4b50-8a62-29fe1e36c2d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d095233e-ac2a-4b50-8a62-29fe1e36c2d1@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 04:13:07PM +0530, Jishnu Prakash wrote:
> On 6/4/2026 8:14 PM, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 11:46:30AM +0100, Jonathan Cameron wrote:
> >> On Wed, 3 Jun 2026 02:35:20 +0300
> >> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >>> On Tue, May 26, 2026 at 04:26:09PM +0530, Jishnu Prakash wrote:

...

> >>>> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> >>>> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
> >>>> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> >>>> +					adc);
> >>>>  	if (ret)
> >>>>  		return dev_err_probe(dev, ret,
> >>>>  				     "Failed to request SDAM%d irq\n",  
> >>>
> >>> Also add a patch to drop this duplicate message.
> >>
> >> There is another thread going on this.  It might not be duplicate
> >> if -EPROBE_DEFER is returned.  The message won't be printed but it
> >> will be logged for helping debug deferred probe reasons.
> > 
> > Yes, and I explained that it is duplicated as long as I understand current
> > code base.
> 
> After I checked for Andy's first comment, my understanding was that
> devm_request_threaded_irq would internally call dev_err_probe in case
> of an error, so this dev_err_probe print above would not be needed.

Correct.

> Please let me know if it's better to keep or remove this print.

You already know my position here :-)

> And if I make the change, shall I add it in a separate patch
> before or after this patch in the next series?

The rule of thumb is to make sure your series won't do ping-pong type of
changes: when one patch introduces (or moves) some code that is removed or
modified in different way by another patch in the same series.

> >> So maybe we have been a little too energetic in removing these.
> > 
> > Or maybe sashiko consumed a bit of LSD :-)

-- 
With Best Regards,
Andy Shevchenko


