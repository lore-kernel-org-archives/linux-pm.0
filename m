Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358D3AEF36;
	Mon,  6 Jul 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316665; cv=none; b=jo3i3ivHyLj8xGk1wwdNfAkquBkjtUhhydN8JpnW0VglIesGCK7dgwxy4DuTqd8s62tAklJ9QyA4WyzQEexDsJ0jwzvEuPCV/JUb/coFj9tYvzsCgpl6s8vcESeFGylzb6M82s+oVDxKvGrw+6TXN86VbRzHm/ISr/Ob/Iu3/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316665; c=relaxed/simple;
	bh=IrUMWPDZ/VCpuPUVVBVYqvMi5P3Rt+n7hhw8JrpkD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuaGLA4TX/8YWgvlsbfDCw/G91nZRpzhi2HZ0LXaEBGuTs4VfNHoKs/YcUukAX/Sg4p+Drc/iFRIdq29fkB9THanSCi+qRIdDxX6Kw1sLcvgn9TY991uNxtUH7T3lcwicnRRbJRiJylh9HHswUQzd5UTmbiuoc8MEuW3EGK/a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIEMZ9S9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIEMZ9S9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783316663; x=1814852663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrUMWPDZ/VCpuPUVVBVYqvMi5P3Rt+n7hhw8JrpkD0w=;
  b=jIEMZ9S9ODSVVxlDP3TrwZCSMmeowWKPPKL1OzT/KsYlLZoA0iwXmG++
   QITX2EzaZyqTFEznsqBhlYNUykAU6er6kcnCXayFe6fD2eg9i7v0sSTxV
   Tehfk6JFZlql4Kn+NkAxoMVmFc72iiFMTOz4nuLODEmHVk9hnZ49FAvM0
   7N1CA/GMsRvLyZ9oktu6rdChBaIOCv8EbGs+0Bg55K4GdfXmHOjBeOR1r
   xF5bHbCs7zkKzH4QPQrWFKLw8T6qEuBHBCduZRCZChyHxOlio8IA+M84Z
   K9o8LZQw1f5LdAmzNNbZtqt8mPImKLXsrsNKfJzNjA4OwYMIOTp/bp0GQ
   Q==;
X-CSE-ConnectionGUID: L5FBMgd4S82ZP7ydk2aCyg==
X-CSE-MsgGUID: a6XtVV5uSQ2vokAmmJLX3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83802674"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83802674"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 22:44:22 -0700
X-CSE-ConnectionGUID: hHhCO/19S3SGJ8Zo8luRZQ==
X-CSE-MsgGUID: GRBidsKSTbaofQnKNC5SYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="291766650"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 22:44:17 -0700
Date: Mon, 6 Jul 2026 08:44:15 +0300
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
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
Message-ID: <aktArynt5xftgij1@ashevche-desk.local>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 05, 2026 at 10:23:34PM +0530, Jishnu Prakash wrote:
> devm_request_threaded_irq internally prints an error message using

devm_request_threaded_irq()

> dev_err_probe in case of any errors. Remove the error print in the

dev_err_probe()

> devm_request_threaded_irq failure path as it is not needed.
devm_request_threaded_irq()

This patch should go first. The patch 1 is not marked as a fix and we don't
need this message to be printed even before the patch 1 of your current version
of the series.

With that being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Also note we refer to the functions as func(), id est mind the parentheses.

-- 
With Best Regards,
Andy Shevchenko


