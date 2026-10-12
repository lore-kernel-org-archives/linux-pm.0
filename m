Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDD396572;
	Mon, 12 Oct 2026 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837599; cv=none; b=cyrVdKAU9tWTeQ4EVWi4t/STYCezFhUW8iCkGKOgHFoFD6cJQzjGJm+H7waJw8Ibp3GNY5g9tefqBycqaiU/NbvF9aJ1HEsxkmpk9KKUVj0GGX/d8ObMf7taOBGU00WP9yG/CiNwsdXbeVIaPWiZCJMSD+svuXOUMnk/1ntxNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837599; c=relaxed/simple;
	bh=MzUUiGCFRJt6cRlGb1tQHLMgEAH7lmI7XLwnXzGRwhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNwQbtXPwlR/Jd4wTslikcdtISCH5q05MODd5Oielj+Fxo6og1KU9l7OzVy275U2ZcIOBlfe6ZmLe7hOIn97PqemAUioktbXmCMiMW1EPst2qZYciprhx2af/RS+DCRhYZwjkIekMaIy0uFygtCAw9o0BJalCbUWxNWBD6SE/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTCRAXzo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTCRAXzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791837597; x=1823373597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MzUUiGCFRJt6cRlGb1tQHLMgEAH7lmI7XLwnXzGRwhk=;
  b=lTCRAXzoFC8VwV5YdtkF5R1aIje1ZoMwNpA72aO0k20TJZ8btSfiOn6o
   fHo9/rbl9e/mYm1+DDg0wSG4sC1Dc1rmb4oSismUk5uGulCTHbcBR5Qyq
   52TAVC4FAbkkwi13f7YPeutivQmHHEuKC/QjScz1iguOOnWO7D0kLj4z7
   cxRmjAQhCW9NH1H4S0srOXdzYlxtmZhJ3CE5Odvsczdn3BBGSciJGcvXH
   8lM3816fVhSrHSJt+aeiAacxkNlrdZRPrGxU9c/HP/SsEjythYtKL4so1
   fApd4eJCAlNJ3mhkmyuiZ32Sriw1zIx1So6oUFq+KxmZMpOFxkMzRDWzl
   w==;
X-CSE-ConnectionGUID: rJ8vK3t8T961fyLATa3XJg==
X-CSE-MsgGUID: Nu2mMRx8T6WB1g2B/HyvBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="561325"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="561325"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:39:56 -0700
X-CSE-ConnectionGUID: aGYV5OLWTH6ErsLItGGwow==
X-CSE-MsgGUID: Xqov64zESPeQDj34v/WLxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="906656"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:39:53 -0700
Date: Mon, 12 Oct 2026 23:39:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <as1FllpmbCuwLaWi@ashevche-desk.local>
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 04:13:31PM -0700, Brian Norris wrote:
> Multiple IIO drivers inspect or propagate the return value of
> pm_runtime_put_autosuspend(), which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and change the return types
> of fxls8962af_power_off() and fxas21002c_pm_put() to void.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
but see below.

> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
> 
> I couldn't decide if I should split this up by individual driver, or
> just 1 for the whole drivers/iio/ subsystem. Many of these drivers have
> borrowed the same patterns, so I chose to just send 1. Let me know if I
> should split it up.
> 
>  drivers/iio/accel/bmc150-accel-core.c         | 14 +++++-----
>  drivers/iio/accel/fxls8962af-core.c           | 11 +++-----
>  drivers/iio/accel/kxcjk-1013.c                | 15 ++++++-----
>  drivers/iio/accel/mma8452.c                   | 15 +++++------
>  drivers/iio/accel/mma9551_core.c              | 15 +++++------

One patch (iio: accel: ...)

>  drivers/iio/adc/rcar-gyroadc.c                |  4 +--
>  drivers/iio/adc/ti-ads1015.c                  |  8 +++---

Second patch (iio: adc: ...)

>  drivers/iio/chemical/atlas-sensor.c           |  4 +--

Third patch (iio: chemical: atlas-sensor: ...)

>  .../common/hid-sensors/hid-sensor-trigger.c   | 14 ++++------

...and so on...

>  drivers/iio/gyro/bmg160_core.c                | 17 +++++-------
>  drivers/iio/gyro/fxas21002c_core.c            | 12 +++------


>  drivers/iio/imu/kmx61.c                       | 17 ++++++------



>  drivers/iio/light/apds9960.c                  |  2 +-
>  drivers/iio/light/isl29028.c                  | 15 +++--------
>  drivers/iio/light/pa12203001.c                |  3 ++-
>  drivers/iio/light/rpr0521.c                   | 15 +++++------
>  drivers/iio/light/tsl2583.c                   | 27 +++----------------
>  drivers/iio/light/us5182d.c                   |  3 ++-

So, I get 7 patches.

-- 
With Best Regards,
Andy Shevchenko


