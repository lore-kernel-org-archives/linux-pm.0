Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731885;
	b=oiFRzPT/27fLQiiabyPqzqy2mFskqWMpQQoPsiXrVFkIih6ouJUWErYclezLlZIsoM30
	 Sa4h829PWuK9ypGOWtpLW2j+AHeZUl9dDhwTRf47sZdxsmjXXJKbboC6XWMhCVHk3DjvW
	 wShRT7T0LhjI1udayvcwQBWKhww8Wfruu+wp5GBZq0PXziC2jbBaa9z8PO0dWTSydUozx
	 KSN0krQdO2nCH83B8kBaSrwSVjFTt7p4yrm82GKtPMa3QwWLFl/Oxbyfvkyn0O+ctGQjo
	 XQjZP/KO8q0VD4eurlwKm94px7CxB4pS0cRM4wjk3cxQXSgspDQjm/R44wXCjz9EYtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731885;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=G2Si+IZmVdZqt2YaNnpDHgsTWGn1r9RrKHiePss1KvM=;
	b=ea4A/7EGJXPd2a1zijQ4yF9PBSB+dArn2cDRHEGo2nnYFVJXIQsjqQ0w7rga6uczdw75
	 EcKnHgXrbIuow8/qY3Al5NGKkQb/cfHceqv5Aq2clANemT18YlXVMJ1zrxfF9fEbIWAC7
	 pWYpNDUNVK2LueTKrvEhXeZt2RL+aLRkMzrRxxloUHtquQB0PBnl3+CIlw1ZXJBmNqC0S
	 8jpUTq99awlwDl0KyOX5vAWRro4q7YZPhhYZqvDhGoHRoMv+Ubv2+yNwiLZqi0dnS1Z4X
	 LEkJ1YSNFJxqf8OSIRLTSu/hT6a7KjVcYlknu1UiPvnktZdrz1/z6FRaCuTzEtesknw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="V/Sny8gZ";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200D606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 18:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E200D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V/Sny8gZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793731883; x=1825267883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RwOZjb3H5esnLUlqWzMc/b46n/a1uEGxirhNif8yCU4=;
  b=V/Sny8gZbOet3WksVhabzLmJCJF4xvfJEeJBQL9uawsFjJMxdAW3Va15
   tEZ9o1C32dUAIVnRwvs4jBIXx3Biji5V56YhKQJgmbU83rNUTvcjyJDmS
   JTOl01il2R5eFvYxxRJC4sr8FV3IEwSNfr3GClstVW6V0rTic4fbQu6dJ
   EEul6t58R90HI1kQQTx3Nu3Uz6hQLNNjDEK9Locl1vlulwWdtwhzjq3um
   IldQWjAI5VgHcfAoTdaL5anRP9BGvuVmYGntcoRMDErfceW1hsgq1tfVf
   rKubScOs11mCCGKlz4lLySi7jav2wyK8DwsYmTVslHfu9oBqoZwwLqAXB
   w==;
X-CSE-ConnectionGUID: XS1AcHg9QCWm3zEPjuZing==
X-CSE-MsgGUID: G0GEotW4T42Fbo/yIaNREg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2479152"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2479152"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:51:22 -0800
X-CSE-ConnectionGUID: HEEKThi2Qj2z/lDGFEdAMQ==
X-CSE-MsgGUID: 0eMlKsItRpCiyhAq5UcA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8278492"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:51:21 -0800
Date: Tue, 3 Nov 2026 20:51:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 09/16] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
Message-ID: <auotJnelSYkkSoDs@ashevche-desk.local>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
 <1b2cc9a8fcf2af42f0f8048fda4683bbd4563c86.1793124601.git.len.brown@intel.com>
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
In-Reply-To: <1b2cc9a8fcf2af42f0f8048fda4683bbd4563c86.1793124601.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:01:59PM -0400, Len Brown wrote:
> 
> Replace the hardcoded value 100 with a named symbolic constant BCLK_MHZ in
> ratio_2_sysfs_khz() to document the assumed bus clock frequency.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	int bclk_khz = 100 * 1000;	/* 100,000 KHz = 100 MHz */
> +	int bclk_khz = BCLK_MHZ * KHZ_PER_MHZ; /* Convert MHz to KHz */

Not sure if the comment brings any value. Should be obvious from the units
and multiplier.

-- 
With Best Regards,
Andy Shevchenko


