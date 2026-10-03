Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47518A93F;
	Sat,  3 Oct 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791040912; cv=none; b=BPfYk9208f48bzje5M8Fp79zvRevKA6wpvhEG1LdTayZGGg6ozT2k12L0Ao+DPgJcAAPsMB4wSq22ZLh7M3r7qucbsj4TLfZnehv8OEgWUOwzHFrBib3lABJI0oUcE1vZqnV27Epyt/m13w0Wmg/ARH6SvHB30NK7H0bccI+Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791040912; c=relaxed/simple;
	bh=/j9RNnRrsl73fLwVyVNDb/7A6HoUBrV9DU6bJoMj46o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdLatvwm0+MnJJ9D57MRlrg3zNOEDuiigoe766a4arFbqMO2ghXN4boQQ1ULUDOLosLdqdSafrvvhBTyqNnzyKW9JRecvNsrNWdMKHbUUrJ3OZxqWZxCoGQ1fmvL8FGWgAXvZbK1b80lVlzqlGh5M5QIfGlR2qrT+tgvB8F/zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu6pTDBN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu6pTDBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791040911; x=1822576911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/j9RNnRrsl73fLwVyVNDb/7A6HoUBrV9DU6bJoMj46o=;
  b=Yu6pTDBNYVn/yN8AhuxRAcGaI6YgCZXD2Nw0QoCwqZgnZaY9Ueofzj8D
   luhF1viEU1vQhFq0+2qKM4jzAHcJtEwR3dIesfi11JY2QGWVlPmQiwau8
   PVJBG4qefnE/FMxpO22fu639LOl421I+ryDs9XTpiUFccr1Inbix0KwYM
   KV6uPDKcONTtD175TvAWh+Y26rv8XeCnCCariTyYp1zuouKxKG+b6FYHR
   WpatvSEfNXkPXU/KqfLMI8i+DntMFy1ZQkTpb9GDh0u0fjllLxdRVNiMK
   OkugCwzqAiVn5Ojhc2KSRCpGLIu+/kjYIDD/aqvx+UZykY7kCbPac5UQI
   w==;
X-CSE-ConnectionGUID: S44+CQd/QwCiAUTJKSo5Tg==
X-CSE-MsgGUID: 4VD5DU+ETo2qJNUDoayukA==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="79337834"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="79337834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:21:50 -0700
X-CSE-ConnectionGUID: hnSRoQklRf6ym3VAg/jLOg==
X-CSE-MsgGUID: vBUrSaiBSwatowgH9UNQ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="280205801"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:21:47 -0700
Date: Sat, 3 Oct 2026 18:21:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] PM: runtime: Propagate last_busy from dependent to
 dependency
Message-ID: <asEdiIT7l49vhn7i@ashevche-desk.local>
References: <20261002230714.507921-1-briannorris@chromium.org>
 <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 04:03:07PM -0700, Brian Norris wrote:
> When a child device suspends, it does not update the last_busy timestamp
> for its parent. If that parent configured autosuspend and didn't
> otherwise maintain its last_busy timestamp, it may now be immediately
> eligible to suspend. This is probably not expected -- the parent should
> wait for its autosuspend delay before suspending.
> 
> The effect of this behavior is that a parent device may suspend sooner
> than its autosuspend delay, simply because its usage was accounted by
> its children, and not by direct references to the parent device.
> 
> This was noticed in several cases, and some have implemented
> workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> runtime autosuspend delay when slow polling"). At the same time, Ulf
> suggested these problems "should be solved in the runtime PM core".
> 
> Instead of working around the problem in drivers, we propagate last_busy
> timestamps from a dependent device to its dependencies any time it may
> allow a dependency to suspend -- i.e., when releasing a refcount for its
> parent or suppliers. We take care to only propagate the timestamp if it
> is larger than the existing busy timestamp.
> 
> Note that this works best if the dependent device is using autosuspend
> (and therefore updates its last_busy timestamps appropriately), but even
> for a non-autosuspend child, this is still somewhat useful --
> non-autosuspend devices still automatically update their last_busy every
> time they resume.

> Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/

Because Linus might complain on odd Link tags, please make sure you have a
reference to it in the text and place it in a form like

Link: $URL [1]

and respectively in the text use [1] as a reference.

> Cc: Ulf Hansson <ulfh@kernel.org>

Can go under the '---' cutter, so it won't pollute the commit message in the
Git history.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

 Cc: ...

...

> +/*
> + * Propagate last_busy timestamp from one device to another. This can, for
> + * example, prevent overactive suspend when a dependency's usage is primarily
> + * driven by one of its dependents.
> + */
> +static void rpm_propagate_last_busy(struct device *dev, struct device *target)
> +{
> +	s64 busy = atomic64_read(&dev->power.last_busy);
> +	s64 target_busy = atomic64_read(&target->power.last_busy);
> +
> +	while (target_busy < busy)

But here you already have an outdated ones, no? Why is this not a problem?

> +		if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
> +			return;
> +}

-- 
With Best Regards,
Andy Shevchenko


