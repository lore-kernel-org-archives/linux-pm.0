Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F843A6EFB;
	Wed, 13 May 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695502; cv=none; b=EchBVsMShqwuWpSSCOsuBX10kHOuTUdi70VoxmddlpBz/y/Zif19cqG9cDtO3y5O9aN9C7p2/Q9GZ8gfFUWe0W4gyPa+qroTWo9jng3UU5XhgMlmQMREqmTAu1jUguPwmg3VRqmSZN3xWUhrdijsghzIX+DnI/zibEkwgXN2+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695502; c=relaxed/simple;
	bh=yhiVvKVYnE4pSsybhm4bMdvTBloUMTYhEHFkSnUr74Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmImF/GxIvGFt/wG5MY6y8p0RsvmhF5MQz/o9aTfcv6t18ee4a7jhNhMigGu7zS3qTfiMssfl8sC+LiG6lv4ki6uG44rhuUabGSU5Xv2xDCNLTlsmyfPNd6l1qxvesWXleQugXnWCZKwgr84B/HS1mLbYyuUfplOKDxOwhiI6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOw7/PNJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOw7/PNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778695501; x=1810231501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhiVvKVYnE4pSsybhm4bMdvTBloUMTYhEHFkSnUr74Y=;
  b=JOw7/PNJKn1rBtmkJOHs7W3saBZbVNE302gC3ih5MAzC3XbEgxMm35Tq
   4a1OsyIbC0gzxPdMHtlFB3w3B92JtErna4RtjSgw9zazFXuY3OTgQVf5T
   D96AYYRCxhHUF+Q7zCMH9dybMNeM/sDpPlHn3EnxHZzrbRYTdgisFvA0t
   Cuyekiaf4qY7U6wKPfu/KRDZyEO8veC2IS7HDzThXEbs21MQhTfsWlaUr
   bHbCFhKI61GamMw8n/km3PcZV2BjKXFKiMpXhSXR+87r5fDOvksv3HiuA
   YQOctvHlA+BTJozE3uZJ9rvI6cOY6lQDyfEqmlk+fwKSe6uPOtRoSBSd+
   g==;
X-CSE-ConnectionGUID: yK/A8ya5SjKGnaURc6eYZQ==
X-CSE-MsgGUID: Tzx7tXb7TXquD1BsJbW93w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79748297"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79748297"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:04:59 -0700
X-CSE-ConnectionGUID: wT0TNYt/SjuaU0Dz0KFdlw==
X-CSE-MsgGUID: ARhHdZziQIeeuGgCC0lmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238044413"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:04:54 -0700
Date: Wed, 13 May 2026 21:04:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alex Tran <alex.tran@oss.qualcomm.com>
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 0/5] scmi: Log client subsystem entity counts
Message-ID: <agS9RGifDpgmgjfa@ashevche-desk.local>
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 10:16:53AM -0700, Alex Tran wrote:
> SCMI client drivers do not consistently log the number of supported
> entities discovered from firmware. This information is useful during
> debugging because it shows which domains or resources were exposed by
> firmware during probe.
> 
> Add logging of the number of supported entities to the SCMI cpufreq,
> pinctrl, reset, hwmon, and powercap client drivers after a successful
> probe. This aligns these drivers with the existing logging in the SCMI
> power and performance domain drivers.

Too quick between the series, the v1 discussion is still ongoing.
Hence this should not be applied (at least yet).

Read Submitting Patches and other process documentation that suggest at least
24h period for review and in patch series even week or so.

> ---
> Changes in v2:
> - Use dev_dbg instead of dev_info log level
> - Link to v1: https://lore.kernel.org/r/20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com


-- 
With Best Regards,
Andy Shevchenko


