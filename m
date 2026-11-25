Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627376;
	b=1+VLPp53ROGYAfI2iPMnMIL+c/oNG+bERB/W7mYmmPFzayS6MFG0NsOlVWYoUPkWrfYQ
	 0P2VMoVNwGdpGANqw0Iw8yj4zu3SmN1MYf9RxIFaEdyMShAvVr5mLH02djZjBxLWVKxy+
	 m7Cc+uUp3Ail3nEusJHcKI9f5yO97B1XRFmOryGAT0uTSHtYOgmoZJU21yqB4AWtBWcMC
	 6HdTvyz8b6V81icqu2sLay7XtllEpyrte4KiGSOXvopDzkzyxOHYnomFjxrYc9yADSVM8
	 bCJ0RnXlTvo1Om4I0mILsJYotqdjaJPqXeYpcHUOUzartxbi75Y5ye8WH4uZn18VXag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627376;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Gwp7COi8aH0WKS2vOklOD3qltSEOsEgVZ6Ai5R89emg=;
	b=BDPSazVp3MVEqlidzT3kUOwQ5rWowpT4M2iXyIPBtaH0e3a/NJ9hyCNCTbcKdLNoyjd6
	 aZdwXKQyMweUyHdqZRe0jh5bpgKYI6l0+0wli96OCSIdUH6P7GnslavgV53571tGvX1fJ
	 Lc2VaiKv/JoElTSyo32TVC+FaH3xft2U0PBPB5FSVLY4s9PTBzm2lijud0IXfOU+aSKMh
	 sO75ruzos10Mp2nyQA0+OKLlI9cGskrujzGdnzrKcW5q87BECYk2JEs0jJ2TcxqNkMr08
	 h7J0f/2XOdLhGgHjaPoNvB+TgOzr99QT51wQxy9alQGPe4+xe6vZcwpplw4+bKAPt5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gDpeDhd8;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B5606A323;
	Wed, 25 Nov 2026 17:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1B5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gDpeDhd8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795627376; x=1827163376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwNOLE5dKieH7P65p0sz5Ql7CO+aAYr55/SBEEgUlc4=;
  b=gDpeDhd8tzTSrde850S7c6QlGDkeLeRC3cGSHWah+K0yV5JXOYyti1DM
   P56gy7zbZMxbRqn1UBIUlRVuHfuD9Bc6lyUw8Ip6MBn9bWWrLR4cCoMQW
   1/LjuZX361yi/tAyAjo7z96zIZvUDUTQfA9BIqgSwoxgSdiOoMj3OtDXc
   OtpiIITq9NbLHiDDSMmkqzEV6MgoSJDvW27SHQeDM2NgyWQDOiyc8zo6O
   0DhExtvngf7t2J2GWBWy5SCm7MJ0yvtGfD138yAxlmOZcI8wU94lA1rpa
   FDGw71Yfibe029AAPAwJViuup557ItgTS3u/FkkRUjYenEdxG1GnsKMeY
   A==;
X-CSE-ConnectionGUID: cFNUJ4ZvRtq+gm21tNBIxA==
X-CSE-MsgGUID: HJ4VpjA2Q82F69qQ+DHing==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4455002"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4455002"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:22:55 -0800
X-CSE-ConnectionGUID: 8wpN/hBdSTqgZp/XfF47rg==
X-CSE-MsgGUID: yj9tOweNRze8zDzR2Lh7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12508058"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:22:53 -0800
Date: Wed, 25 Nov 2026 19:22:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v2 3/5] ACPI: fan: Adjust driver removal code ordering
Message-ID: <awcZa3sMlXv5bUBB@ashevche-desk.local>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <3445012.aeNJFYEL58@rafael.j.wysocki>
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
In-Reply-To: <3445012.aeNJFYEL58@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:08:48PM +0100, Rafael J. Wysocki wrote:
> 
> Change the ordering of acpi_fan_remove() code so that it reflects the
> ordering of the rollback path in acpi_fan_probe() where the sysfs
> attributes are removed when the thermal class cooling device is not
> there.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


