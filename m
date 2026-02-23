Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC534DCDF;
	Mon, 23 Feb 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837090; cv=none; b=pjA7BOrslx3gpZQijCCoIDYzdxmIrPL/wWlv+nwGFdd6pVBTd9/0/mxaGEpAA2oJOYGW3anXtoCEs/wlTk9yZumu6S6nGdIpJNzdTqqaKttQPN1qwg0POr3RGH7EaZHuAhF8Q621fehoQO5lreP7LU2khBYrC4dwNggdrSY15+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837090; c=relaxed/simple;
	bh=Ngc0//nsKMhxzUW0W1XhdpkPjpuyDMO5L5jYaVXufF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcKsRPISnoZhiRsukktBxPsSAwRG+efuxYyo/wKZwMaPfMweYQFZrhX6WLZeCKrM4Q421Xuts4Xs1v6zEYfM1AesYusV+DZfKDClwM4YD2RNIi5LTpu4RKrVYsc7d9+lqQkAWat+NAGkxmr4xLEwKvEIxdtOdfWLdc93wzUmlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfT4Z6Gn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfT4Z6Gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771837089; x=1803373089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ngc0//nsKMhxzUW0W1XhdpkPjpuyDMO5L5jYaVXufF8=;
  b=VfT4Z6GnfkciudcbHnfsuotZcM4JyZKdgQI/fv7GhpFyPcWTSA/E9gO9
   KM8o4RQtjVbvhJ/G/rC4jeIsFddMsMznnlWdJkrs3zxHY6yz+zNo9GQfw
   o3RMmWKQH5hr1kuuRXDsi9wT8XPd0g39VrFE+x5IfpnHok0kJhJverzZ2
   Bk1ReoJqBa30LJwaVq4/ZGC+3sT0kA5nTejSm/J8e25Ppy9mIqMpVaMr4
   ESk/X1p1V7TYmA8AhCobkRPOJ+YWBpzMW9msJ0c2GC4/qjc41OzNKcSZF
   EPStrof4M91v0C8YjGxmM4k6Imvd8lHfeyMpjba6o3od0B5aIdIGZULIk
   w==;
X-CSE-ConnectionGUID: XNajc0Q1QASTcMuqrPIrDQ==
X-CSE-MsgGUID: lTdWyfgCSbisVK1dVaYjzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="84188581"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="84188581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:58:08 -0800
X-CSE-ConnectionGUID: 6dbkBlWcQpekmjJk8Yu6Xw==
X-CSE-MsgGUID: LIs0ElR+SfGL2UTDHKAZ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="219617271"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:58:02 -0800
Date: Mon, 23 Feb 2026 10:57:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/9] power: supply: max77705: Free allocated workqueue
 and fix removal order
Message-ID: <aZwWl57oJln1xH5m@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-3-10b3a6087586@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-workqueue-devm-v1-3-10b3a6087586@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:27:31AM +0100, Krzysztof Kozlowski wrote:
> Use devm interface for allocating workqueue to fix two bugs at the same
> time:
> 
> 1. Driver leaks the memory on remove(), because the workqueue is not
>    destroyed.
> 
> 2. Driver allocates workqueue and then registers interrupt handlers
>    with devm interface.  This means that probe error paths will not use a
>    reversed order, but first the destroy workqueue and then, via devm
>    release handlers, free the interrupt.
> 
>    The interrupt handler schedules work on this exact workqueue, thus if
>    interrupt is hit in this short time window - after destroying
>    workqueue, but before devm() frees the interrupt, the work scheduling
>    will lead to use of freed memory.

...

>  	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
>  					NULL, max77705_chgin_irq,
>  					IRQF_TRIGGER_NONE,
>  					"chgin-irq", chg);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");
> -		goto destroy_wq;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");

This should be just

		return ret;


devm_*_irq() prints the message. No need to repeat this in the caller(s).

...

>  	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_AICL_I),
>  					NULL, max77705_aicl_irq,
>  					IRQF_TRIGGER_NONE,
>  					"aicl-irq", chg);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");
> -		goto destroy_wq;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");

Ditto.

-- 
With Best Regards,
Andy Shevchenko


