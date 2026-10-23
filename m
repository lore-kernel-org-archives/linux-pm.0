Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738481;
	b=kNmqVg5e+zJGQvilgtE3iaVGVJY94a4KISwkQAD23ALZQY+yjNujHdWjYerlaQk38mu/
	 T+gzkN8+yY382wdIKQWPwGJ1uFSu3TQWi4PJq0Y2XCglInaiBJiL3ZPMMX1QrVJdxegl3
	 Xxv5B+GzUqbXlUSEo1JkhL7QtOCyxWysW8xw7XXsMveyCx4aXIv4c6hLX4URrCStI76rq
	 PMAB8/h5rvp955dISSWaEj78CGW5rTMxrZVMbj+7gxCMoKQ3bmu0eFMhtjNxoOuQH8f85
	 zg9PXI+fEn1QjS4ksO7Legfb2MPzEKv0+Kq4sRDB/dwnXCtsYe9palc9j5/mWi7EoWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738481;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8hvAczPVxFHsHRebSf3Lol2Zt9I+a7FbbQSRQrC7VAk=;
	b=l1NmMt4br90aqUomxM2GnjYuyL0Z6ZhTPkr94e065TiUeAUPjfTkq6bzskGO9jXiDQyg
	 22HA4lTNdUqsF6TDzETsPda5ZpjEP6GDnAArAL8I2seieskE5irQN7vnF1zIcBpb4n/rj
	 vmJhq/9dx9/A6C74T3vaV//GiXbcM+DeNKHDlBiOOLnyjcUiqlWiX6/yN7Kto6Q2KJ0Em
	 atjI5GpzmguDeOvj/86DWNb2vVK1+NYCXxdGT8kbsCkQu6Zd9EudVT2xylwBfNbUPGlYb
	 W+wtrBuPFVpQYHrBSA30WYtg6dSmtRSD6TJnQ197q3NfsiL+86hPITA4qDt/vadAurA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwFlGWyW;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC63606A31B;
	Fri, 23 Oct 2026 06:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC63606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwFlGWyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792738481; x=1824274481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4fYFw8sybPANT0pmg6TRi7WCeCgWOOdKQ2cph3BSk4U=;
  b=UwFlGWyWTZuzw1xgYVwdyDmvVofNJihelI6JM0B0SGMwNYA6wRUUMCMm
   pbnEwviCrjp+ajODAxuBi0Agg0PWrVeN1Zt/+iA+4Rbbi05fZGV4zJsL8
   uTbVua4Quz2Z0Egtn+G1pBOvuJIVGeeFNmSaE6Uz4429Alh2kL0V4VKWU
   orvz4lZ7o654nITPl4IdkAvHIV9mYc2rcRuG6RRJtUXKkX7439RkeU2C8
   KYxuMV0ixdAKgnfGnYThaJIKa+zNjZ/ssxs/jHORsPMN4ARyv4ARLxzUL
   bhsxo+Wi21Q5FnUqeL3IwOtGWTR4y9/dF2EtyxeSyGMLC0iD2F7Sj+wFo
   Q==;
X-CSE-ConnectionGUID: oqmRNvRwQg+Spjxky65obA==
X-CSE-MsgGUID: X/PiFiOZTG60WasN068DIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1370695"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1370695"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:54:40 -0700
X-CSE-ConnectionGUID: hTN0BJUnQ1yiGOW5M4cBhg==
X-CSE-MsgGUID: 6xhOWRCTTpOIfvZjuZBk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3556295"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:54:37 -0700
Date: Fri, 23 Oct 2026 09:54:34 +0300
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
Message-ID: <atsEql7X20hGytXv@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
 <atpMNk6ymCpC5BL_@google.com>
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
In-Reply-To: <atpMNk6ymCpC5BL_@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 10:47:34AM -0700, Brian Norris wrote:
> On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> > After three patches I stopped because it seems more works needs in each of
> > the individual drivers. Yes, the series can be applied as is in exchange for
> > a bigger additional churn in the future. My preference is to see everything
> > settled down in a single step.
> 
> There are limits in how much work I'm willing to do on a bunch of
> drivers I don't use, can't test, and frankly have no actual interest in.
> I'm sure if I spent a few more minutes on each driver, I could find
> another dozen things to try to improve.
> 
> I can go back to the v1 approach (fix only what I came to do) if you'd
> prefer.
> 
> Or, I'd prefer to stick with the sentiment Jonathan expressed in
> optionally requesting additional refactoring:
> https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
> that most of these changes are optional, and that fixing 1 thing is not
> a subscription to fixing everything.

Right, but my concerns is that in (some) cases you can do one step further and
use PM_RUNTIME_ACQUIRE*() instead of putting first the explicit calls in this
series and makes someone to basically do the same again. To me it sounds like
a double effort. Yes, that is_active thing perhaps to much to follow, but even
there it can be refactored to something like

	if (is_active) {
		ret = regmap...
	} else {
		PM_RUNTIME_ACQUIRE*();
		...
		ret = regmap...
	}

without changing the driver logic.

Whatever, I am not a maintainer here, so if Jonathan is okay with this churn,
then it's fine.

-- 
With Best Regards,
Andy Shevchenko


