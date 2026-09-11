Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85B4A4839;
	Fri, 11 Sep 2026 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144364; cv=none; b=JFuVZt5Gzyuxsz4YQjqWNY3xtljJkFMjaV86kiHHzPRWBWJgNLRL63DMPKVDWs4MBfWZ+tGmDQL21Nray1dP7ClE2yVkz/qd6w4ggq5h3XRSd5U9u3NtvcXPqMaZseQmUkX9iAVLI5k7Gf+oc0XZjRgdrWeWut67S8ll7t8nS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144364; c=relaxed/simple;
	bh=vWlL7Yc7fRS8E4xC9N90Lwyz026gOKY3bS2GTgygApM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3cqvhQ8EE9R5x9NLP46n/Io/Yk/k9UvzQsVHjUnA8mZI0LHa+1VdbwxWAUyduVf0PUMScMbv/YHq3rUBuA7cvPKfXiGuKlt6BzWSLfp8r2VCe7Ko58yI1AEtDUCfoW/refoGxzyUjZprfz1CxqS6ctnLgLvZfd4nPuYljgsXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHAyED/5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHAyED/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789144361; x=1820680361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWlL7Yc7fRS8E4xC9N90Lwyz026gOKY3bS2GTgygApM=;
  b=cHAyED/5FtSP3qS7n22EZAUl6jdiw9wDPdmE1rrj0BXAKysEAip8/CD/
   Qy5FyYLWd4WRnhy2odLb5M0h3N3S+NEupk7vCJrfKfsmKtCIeXs9M5zCy
   QQM5oC+7C9t/9tg0I46xb5ZwYBsldVkBl35ibZL99u7zC3tyKCTBhS4VH
   w8RVYOu26sb4uS+iLWeeKaXCvHZoWzGdOpKJlqHkukWb4crThs/YT6MCc
   Fw23YCVwicfDP4lpgi5z07Zx++j5lDrxJpRDBb8fhkwfUqKA6ZkMTdDkF
   5wq4No7VvPjnga8rXvV0R/V3TFafO18HYl2hyOHfPHY/YxFRm4MAAn+8a
   w==;
X-CSE-ConnectionGUID: m1sy8DUaSPWIp2RLYDJ/rg==
X-CSE-MsgGUID: Bf62T6UMTgCpT2/Z++TbgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="115147958"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="115147958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:32:36 -0700
X-CSE-ConnectionGUID: h2rd0FdhTBOEnW0a6D8xXA==
X-CSE-MsgGUID: 3E7sRbJfQ7ep6+lphOwUpg==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:32:34 -0700
Date: Fri, 11 Sep 2026 19:32:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
Message-ID: <aqQtIMm-gdJoZAsq@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2362345.iZASKD2KPV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:

> Instead of using thermal_cooling_device_register() for registering
> a cooling device in the ACPI processor driver, make it use
> thermal_cooling_device_create() and pass a pointer to the processor
> device representing the given CPU to that function as the cooling
> device's parent.  That will cause the cooling device's sysfs directory
> to be created under the parent's sysfs directory (among other things).
> 
> Since creating a class device under a parent causes a "device" symbolic
> link from the sysfs directory of the class device to the sysfs directory
> of the parent to appear automatically, remove the code creating the
> "device" symbolic link from the sysfs directory of the cooling device
> in question to the sysfs directory of the parent's companion ACPI
> device.  That ACPI device is reachable through the "firmware_node"
> symbolic link in the parent's sysfs directory regardless.
> 
> Moreover, since the cooling device is now located in sysfs under its
> parent and it can be easily identified as a cooling device, there is
> no need to create a "thermal_cooling" symbolic link from its parent's
> ACPI companion to it.  Accordingly, also remove the code creating that
> symbolic link.
> 
> While at it, check for error pointer values in addition to checking
> for NULL in acpi_processor_thermal_exit() to avoid dereferncing them

Typo: dereferencing

> mistakenly.

...

Is any user space ABI breakage expected as an outcome of this change?

-- 
With Best Regards,
Andy Shevchenko


