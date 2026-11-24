Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514003;
	b=zPuO/OIfTOVcnh7BRDWqJZeMg/XMkZZK3eqsFKS9D85iYuW0jHVQZrpxBVKJW/7CGCFX
	 Hnwk4l0I4KjkVZVwdUnjG5Cn6GCluF3YvJzI/0bwLRU0LC1Jsa6Ji9q0xjGPaVs5AX8uR
	 /h/yEvq8H5dWq+u/5Kt9yxljbbPrb/NPU+ZqJllASCaNNsqdoilkdofGHxsGWR1NlXOcG
	 axyBTpRBAfJhPR93ShJPpQTIi8i7b6wl/rnQ3FUa21M1IfaYzH5gAKaTI8/RqNeElVRea
	 BUFhJ+tWwMHXmvtEAoHZT1TLmM3M761Bd9vawFVcSVdSgkNVWTgH4s3rFrshv/vOMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514003;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=G2B3PXz2d/f4bHwViboEiMQwxd1eDk0zUDSOpThlHwQ=;
	b=jOqaVhmU1uxaqPBeQF5ifxkgI+p5h1uzcrwxfNsHe7NVj7oy94SanpBaOct1nbbhfrZi
	 9mp2IThNEMqRGb54QnPNseDFso5JJhHLlzpihr+Rh1NJrQX7sMcew+b68INJJhplHZhXw
	 j0NijBese/5EiWnqSVaERDCWdSC936WXwuQCmReax29JFMAVOHPNtXvOi8BUEpKkwMkbR
	 uyWkoiRuMmTbGDn1RrnxJBz5e3xL2Kyd7xbqQRud2hWdSebwMX1FLFbP3/aNxtHaRnZew
	 P1aFTXSPs8CYZyeIoora0DbbnWd2mzDC6FIfGkWjFsX25y7sySRnKtQ7u1NSYyuJUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjzRmLqw;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29512606A327;
	Tue, 24 Nov 2026 09:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29512606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjzRmLqw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795514002; x=1827050002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYrsAl676k8RliagPA6F0EN4aMPgS7arcYwLsWYXJ08=;
  b=jjzRmLqw/IQzI91m+Gm+SWUet5HFgDAzcfrn+Rdek8/3V1FmTUxvI8OM
   L5cw17+kta7TpUDhMRosi2cTEZufVIt81hAEsVPScOe7FQHUjXcok8FHZ
   SZj9javnLr5nwyVeIwe1ve6E+ZNLG1s1eNlEvC0+CPd4L4AetYJOz9Fxb
   Lo21AiHg98SbtgcprZ+xiu5asTb6q1MDf1W5x53DTWOsRpMHv38QxRZ3r
   8kEbJxLh+3lZi6WZuBkd1DU7zqNRGPleA/b4u1hb54BQcImllo8oRBbvo
   SU+F0CMbYUvZRTbDeVpBFdJXO2LilJ4O0z56YiPfU36KmcMeEhYiqXxO5
   w==;
X-CSE-ConnectionGUID: N7cG9+wtSwKbCsgX1XBK7w==
X-CSE-MsgGUID: tNjXEvPDRdavoM/FG5hp3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4222876"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4222876"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:53:21 -0800
X-CSE-ConnectionGUID: jjZGfFuVSiavu0FDtMnGtg==
X-CSE-MsgGUID: gnN+xDUAS4WteYVYL40Q0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11404701"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:53:18 -0800
Date: Tue, 24 Nov 2026 11:53:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH v3] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
Message-ID: <awVejPXcrT5k9n5j@ashevche-desk.local>
References: <20261124-adctm5_gen3_hardirq_removal-v3-1-c7923e9a54c1@oss.qualcomm.com>
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
In-Reply-To: <20261124-adctm5_gen3_hardirq_removal-v3-1-c7923e9a54c1@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 02:33:49PM +0530, Jishnu Prakash wrote:
> adc_tm5_probe() registers the ADC_TM interrupt with both a primary
> handler and thread function (adctm5_gen3_isr/adctm5_gen3_isr_thread)
> with IRQF_ONESHOT. The primary handler calls adc5_gen3_read(), which
> takes the SPMI regmap's lock (a regular, non-raw spinlock) from hardirq
> context. With CONFIG_PROVE_LOCKING enabled, this leads to a warning
> about an attempt to take a lock in an invalid wait context:
> 
>   swapper/0/0 is trying to lock:
>   ffff000b67201018
>   (qcom_spmi_pmic:259:(&spmi_regmap_config)->lock){....}-{3:3}, at:
>   regmap_lock_spinlock+0x20/0x40
>   other info that might help us debug this:
>   context-{2:2}
> 
>   Call trace:
>   regmap_lock_spinlock+0x20/0x40
>   regmap_raw_read+0x88/0x328
>   regmap_bulk_read+0x10c/0x340
>   adc5_gen3_read+0x38/0x50 [qcom_spmi_adc5_gen3]
>   adctm5_gen3_isr+0x90/0x130 [qcom_spmi_adc_tm5_gen3]
> 
> There is no requirement for any of the work done in the primary handler
> to run in hardirq context. Drop the primary handler and move all the
> actions in it to the threaded handler, which removes the invalid wait
> context warning.
> 
> Note that both handlers used a local variable to hold the index of the
> SDAM whose IRQ was triggered ('sdam_num' in the primary handler and
> 'sdam_index' in the thread function). These are the same value under
> different names and 'sdam_index' is kept now, since the variable
> represents an index, not a count.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Reported-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/1cb6d902-73f3-4d65-96f4-4b3c5217253c@oss.qualcomm.com/

You should probably get a formal Tested-by from the reporter before going
further.

-- 
With Best Regards,
Andy Shevchenko


