Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC42E7F39;
	Fri, 11 Sep 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144571; cv=none; b=HPf8O0BtqBoN6ISWRJSjfFqehUJVl9ZisfL6hvce7CaIFUdjAOb/fBg0gdEu4lyMmh5iC9wdVraQ2TWiggf040EIvtHZgxEnTxjUDISDn0j1QPTLJgR3M/kluP+D51iLuvubihDG4f5bT95HCaKdlihRqAwEDlM5I1KC+0EhX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144571; c=relaxed/simple;
	bh=yz7jG0GQg2lxTBzG1jVrT2PvynMTR9zaPhSYUZPrHUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKOW3Y5KxKsEYIFos1tUOGPv/qivIYuHbSMTUmMPhJl4Mkrlhyn15QVqFnYWEU8VDk9S70J9IVE2VY3DJSwwMnnLu4RADl9vJ2Z3pVYDuMj+XrPtKGDkBq3GnEpn30U8nOjspuneYO6QwOdFs80IBzCVahzleaeBtBUDt5R8Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyfL15dd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyfL15dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789144569; x=1820680569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yz7jG0GQg2lxTBzG1jVrT2PvynMTR9zaPhSYUZPrHUg=;
  b=eyfL15dduASf6C/R3sK+xDUQA0GjVbIRcXjPpXZIIzggshc57V9IfE8o
   80BpyWCBtluYH4fQ0+7bXDFq1Zhkx9kYRsZKHu5xG5XXVXs0qcOx9RFfK
   cubDrGRDWlJRlR7dtX1NAHqb2q+3lUIvMeG3pet5zFf3jEL06mUIbpdSn
   X5hISQdTCE0JGOvfxmNVU1lTQ+0L04HwcO4d7sA9pIEcq+FTPo2JVM1j6
   VvUlYWmjndsGsK2f/+bTplCu2qHdqhsfi5rHsvT6Y6kxTShC1+tCG7+OE
   Uet9al5NiF1/ErwvZqzG7+j9h5Z5mPDHbhYDrll5HfJpAtKi6B0Tp2NV+
   g==;
X-CSE-ConnectionGUID: 7JhOpUmcQJmzbXY3tYPzkw==
X-CSE-MsgGUID: pGmimFhrRYiNGhJLMHoUDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="93478928"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="93478928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:36:08 -0700
X-CSE-ConnectionGUID: NxnlvRXQT7qrMwjZhXEZRw==
X-CSE-MsgGUID: ga2lvyo+ScyIWwNg0IeyIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="301873179"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:36:06 -0700
Date: Fri, 11 Sep 2026 19:36:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 07/10] ACPI: thermal: Use cooling device parent for
 thermal zone binding
Message-ID: <aqQt8-MlG3fiFw2-@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <9672996.CDJkKcVGEf@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9672996.CDJkKcVGEf@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 03:05:07PM +0200, Rafael J. Wysocki wrote:

> The ACPI thermal zone .should_bind() callback function,
> acpi_thermal_should_bind_cdev(), expects the given cooling device's
> devdata to point to an ACPI device object whose ACPI handle should be
> compared with ACPI handles in a list associated with the given trip
> point.  That is not particularly straightforward and it effectively
> requires the drivers of ACPI cooling devices to populate the devdata
> with addresses of the ACPI companions of the devices they bind to.
> Consequently, the devdata cannot be used by the driver for its own
> needs which is its intended purpose.
> 
> That can be overcome with the help of the observation that the
> ACPI device objects to be matched against the lists of ACPI handles
> associated with trip points are in fact the ACPI companions of the
> parents of cooling devices.  Thus instead of using the given cooling
> device's devdata, it is sufficient to obtain the ACPI handle of its
> parent and compare that ACPI handle with the ones in the list
> associated with the given trip point.

...

> +	parent_handle = ACPI_HANDLE(parent);
>  
> -		if (acpi_fetch_acpi_dev(handle) == cdev_adev)
> +	for (i = 0; i < acpi_trip->devices.count; i++) {
> +		if (acpi_trip->devices.handles[i] == parent_handle)

device_match_acpi_handle() ?

		if (device_match_acpi_handle(parent, acpi_trip->devices.handles[i]))

>  			return true;
>  	}

-- 
With Best Regards,
Andy Shevchenko


