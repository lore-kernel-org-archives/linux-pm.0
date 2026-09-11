Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504B348896;
	Fri, 11 Sep 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144176; cv=none; b=VnoLEelhkDy0erPHjRDNiwWDUEuRKcNV0J68gjdqlZ0UeYLtOdrRA/bVF5t6NFzqqkzX2C65lyK4whT68F9Vc5dUkrZlkspYkbZD9zuQSvNlrWIgq7v2UAJAtYGxYfvdu1nCC8z5d/Fx/6DrUTi9kEUtb5L2DiuDiad2isBVmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144176; c=relaxed/simple;
	bh=UIJINz+buXBzX2zcyYH6v+cSgpapEGobKPNfUU9dDzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klGdxDZJKTQS3NkvHknM/SVFnR11l/OC5IqNpJ40FCAmphbnlB3fgYTzFU/JIbd4vM6EAQ5h34VIWIMHXYP+fNoPoMzHfY+sDPhQGA1z32h582nwNLj9bmyKkuvLOO3Kv0+0P8pc73D24selp8cUQ7G7sB8co/yIdci4xTF/YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zh48SFkC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zh48SFkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789144175; x=1820680175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIJINz+buXBzX2zcyYH6v+cSgpapEGobKPNfUU9dDzE=;
  b=Zh48SFkCD+BQgm+BZ8nJNJgNI5w5Mr3um14NqV+tSYLmMkdwhXr7JaqY
   tp1ngP+7e4QmVzFuqN1jqG5eE+Nd+Zwum/kCbOOj8RWPYRzIswZrfyW4F
   IdwXGQe6iOwQcvmAJ1pwb4BCtS18Sef0f3Ayurawm3wJv04qrIGTlyfN5
   JwS9wVbBz5nIcwoMVdYufR7s4CQ1Zn19N2ibd3vVw7eWFWbd2f12KonG8
   fGoQkfdWhgZgp7akFFyps+dvqfpgusz05izaBVLZAoJuX121QWepv5bqd
   C0yr9FxM869s2jXLjDBDP6CLUYIcHyMZ9EilXbb8q3H9YsfdfoNUlkOlQ
   g==;
X-CSE-ConnectionGUID: WN16UD7fRDajqBJZC6sEew==
X-CSE-MsgGUID: PiImpiZOSqixxOeCfLfiSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89742210"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89742210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:29:34 -0700
X-CSE-ConnectionGUID: Nbr+8D1ZSXOIzptrq4fK0w==
X-CSE-MsgGUID: iwuFY/L0QkaLeWqa7H32yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="277222338"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:29:33 -0700
Date: Fri, 11 Sep 2026 19:29:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 01/10] ACPI: fan: Fix memory leak due to leftover
 devm_kcalloc() argument
Message-ID: <aqQsac65eDbHV_I_@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <14089663.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14089663.uLZWGnKmhe@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 03:00:51PM +0200, Rafael J. Wysocki wrote:

> An ACPI device object's dev field in passed as the first argument to
> devm_kcalloc() in acpi_fan_get_fps() which is incorrect and leads to
> a memory leak on driver probe errors and removal because the driver
> is not bound to that ACPI device.
> 
> Address this by replacing that pointer with a pointer to the device the
> driver is actually bound to.
> 
> While at it, drop a redundant error message after a memory allocation
> failure (that also gets printed relative to the ACPI device).

...

>  	fan->fps_count = obj->package.count - 1; /* minus revision field */
> -	fan->fps = devm_kcalloc(&device->dev,
> -				fan->fps_count, sizeof(struct acpi_fan_fps),
> -				GFP_KERNEL);
> +	fan->fps = devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps), GFP_KERNEL);
>  	if (!fan->fps) {
> -		dev_err(&device->dev, "Not enough memory\n");
>  		status = -ENOMEM;
>  		goto err;

I was about ranting on goto after devm_*(), but looking at the context,
I understand why it's not a problem. While at it, a side note: perhaps it makes
sense to use ACPI_FREE(obj) instead of kfree()? Or even better to have __free()
version of it, so we can declare the object with autoclean.

-- 
With Best Regards,
Andy Shevchenko


