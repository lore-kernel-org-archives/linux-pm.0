Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE84D8D83;
	Thu,  6 Aug 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048671; cv=none; b=fshSAT7Hf6cDa5VOih33b+zKaFMB2qC2BrGlVb/lM/EfDqjyx0kg1I0LTRJthj7ffF3A5s0wnHNo0RLjqEL78UW933FYrLybD8d2IlyEqGhys8eU7Q09CQiR/GDXsd7EXVNMMjhKl85yKCUI7NbGRpGthIt/owJ2hBsRb5aNbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048671; c=relaxed/simple;
	bh=IOESGkSsLU4PyPWlvlzUC1R3AN8DY4o7sxNHbJLa050=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGEQe+v4dnWh0NAYNgXlXRNVWRt0ltRkKLtgZ/vI2uhjDTSuiomZI3Fc981CrYC+nmGyD1OFBJ+Cq1SVJsfCTjANXp8lZbuhpDN2JYhQZSrH6A/dlsrRLDMueF9fN50dNrQUmnTM3yKwDONTwXopvQC98IrpH0lP6nz1JEfl6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW37gQry; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW37gQry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786048670; x=1817584670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOESGkSsLU4PyPWlvlzUC1R3AN8DY4o7sxNHbJLa050=;
  b=VW37gQryOtzCCOSrqQ+lqkrundzwAyN1j1RICwGtl/Qwm0u92mySRsTD
   5xiWM2dKPGRrc2WgaA9kcyrV0mmXZQfuLWKS8pjweak+oFgvjX4OE3g9k
   9OkLMtAIhjtycflfKAjiMmkQ31FyeIxzlirl9Rl7hvdKHoe6oW2ZICDJ9
   Hjn70J6uALDzHB//APKJLuiFtDp+MQWqUj2Pe0Y4i4lB4wDYBhs/A8B6h
   pLCxouVWNs0dry0+GtjHSejL3kQ/ebDH17mFW+ptcGhIbWFK5EbkwDU2d
   94+C6MQvrA11xYvlZWVA/dHMT7Sb1yPBMKGOuoQARuJN1+M5N0zVxT/Zv
   w==;
X-CSE-ConnectionGUID: 4PL9NcANQn6ykxVjppFB1Q==
X-CSE-MsgGUID: r9VwQ17GQPKVZLD0RgTX/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85778232"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85778232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:37:48 -0700
X-CSE-ConnectionGUID: oGMDPqi9SLa51YX2TB8p5A==
X-CSE-MsgGUID: hyzRh8rhQkuIImRFIZ2UAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260434897"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:37:43 -0700
Date: Thu, 6 Aug 2026 23:37:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v4 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <anTwleq7qTOBBr3U@ashevche-desk.local>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
 <20260722-gen3_adc_tm-v4-3-011981f756c8@oss.qualcomm.com>
 <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 05:43:22PM +0200, Daniel Lezcano wrote:
> 
> Andy ? Are fine with these changes ?

I think yes, sorry was on vacation. Will be at full speed somewhere next week.

> On 7/22/26 13:26, Jishnu Prakash wrote:

Formally you may use my
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

or wait for a better review (1400+ new msgs for 2 weeks of vacation in my mailbox).

-- 
With Best Regards,
Andy Shevchenko


