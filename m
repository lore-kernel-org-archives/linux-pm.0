Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652482;
	b=ax1RRcI4XNtTh81m19z9Hx5mdxTyMINOHoq5D90EAnB3okCLQ+8mAaeL4HLO30b64gNN
	 CsRRqJGtOX4B9q3t32gNid7Oo64UTC6mALADuqrFrAiB0bAfqmcKpQCclagO7j2EgpB5b
	 Cw17GQd7GALqWzyUDoEOm5D+UumtPd7kfuMatikZXLg6YSY3gJ1cWL7sVm4yCKGMPThd5
	 dtPp5u1NGzqMi3pdSE8jnCc+Fh7berY0LxnXPZpb+Ynm+wJr8YUYqV1KV4lEDbsSZK9Fn
	 w1ZIehlBf7dPssCqlJb6jp3Q5B/wZSAzVhgvf7J8KdPd7OiQyJYcLl+93eUcjTdIuMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652482;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ltUAnBtou90SNn5Ne2wUoBg+rS3tKtz8jx12czMY9Ds=;
	b=bjOV3z9pNU0ubrc4Pw2uYXhioQXrqYQShmS6u5c8hj+6jpAmTMC4p037T91Jpls4GFpp
	 nLc03FCTDP9bhaF+rhCcoYaqJwa2waRUyuQBEFUXanLKLtbKq/UbFwYFicJb+JVu70F9f
	 wXfhjO6UcRWAMRm7kYYdcahYUjIEGXlFC09SY9C4wVy9ugng6tR+whBd8yStENKeedWcl
	 h0hwKQ6WUlai5EzAS/MddzMHKzvQWNyMWUkWeDqDkK4TjrD3kkp6vStmLXMZXSaZN1PGa
	 D5kSHNwliy+VNZvWpmd/Jyde6z+xVaJ64FoemmFqXt37urQ4l0eJfoMrqb02Pnhn/ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnQq+LMS;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5145606A319;
	Thu, 22 Oct 2026 07:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5145606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnQq+LMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792652482; x=1824188482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sxCKi+fB6UvtVKaiMqUH73/SrcAlNTYOkHoZYOedpjE=;
  b=WnQq+LMSEiZYYwrkcAkBM5RibwrTzr3UE3tr3qVhu9KF9W29WhjmIQMA
   2XkNlfYGmNNjvrL/gBfrH2c8ZpNbjzq4RGXko0HqmJ5t2KBfKvfmvGXYH
   afoHjP2K+klwR1njYP6OVG5Zx2JbvtABtHfLcewpF3pKjq4o/XqT/H7YZ
   5h6FoDnL8+3ynnYR8V+CviK+3hLJkV5Gx1D0rEzSDdc3US9NNUpufxKSv
   JkdcWvfmeQmzaQX2n3N+WHUvpPNMsSzkhruwhFl/1iANIOZ7YKOkqoY5U
   8wh6jgoxWTcpgXtR7s5qoIOkD5zFLQu2jKH1FAIDQSmrOjs7003S6srdu
   A==;
X-CSE-ConnectionGUID: EXN/E/NyRwiJcGaxpsTm4w==
X-CSE-MsgGUID: QBecM9ucTa2IYUdUgGt8sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1292278"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1292278"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:01:21 -0700
X-CSE-ConnectionGUID: ygzg2km4Tc+VdCIJZWeZqQ==
X-CSE-MsgGUID: lbV0Lw9HSsa5obFnAv3qWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3692933"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:01:16 -0700
Date: Thu, 22 Oct 2026 10:01:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/17] iio: Stop looking at
 pm_runtime_put_autosuspend() return codes
Message-ID: <atm0umwtxZlQSAhy@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
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
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 04:57:01PM -0700, Brian Norris wrote:
> Similar to this effort:
> 
>   Subject: [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
>   https://lore.kernel.org/all/6245770.lOV4Wx5bFT@rafael.j.wysocki/
> 
> i.e., commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void") and friends.
> 
> As with pm_runtime_put(), there is very little value in return-code
> checking for pm_runtime_put_autosuspend().
> 
> Checking the return code is more likely to produce a race condition
> (fighting with user space writing "on" to the "control" attribute) than
> to tell a consumer useful info.
> 
> Because the IIO subsystem has the bulk of drivers that inspect
> pm_runtime_put_autosuspend(), and because those drivers have a lot of
> other issues touching the same code (which Jonathan suggested [1] I
> fix -- I fix some, but not all), I'm sending an IIO-specific series
> under a v2 label (since many of the changes are still borrowed from the
> earlier series).

After three patches I stopped because it seems more works needs in each of
the individual drivers. Yes, the series can be applied as is in exchange for
a bigger additional churn in the future. My preference is to see everything
settled down in a single step.

-- 
With Best Regards,
Andy Shevchenko


