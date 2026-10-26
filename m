Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009390;
	b=uGh00BhAm42GK9d11u01ww/joCihtt5XaKp6IHA81dddWg0JbW4MbJbNYpPgUcPSQqmB
	 0gKX9L9u3SHGpIu4ErWvqwCqVaK/mo9VUEl1Gw/7g6v4QB5ntgdDmnd7Vv3dhaw5ARWED
	 9fW6grcEghnfA4HHYaJ4H4CjksDhS4zrfmxXmCsRAt63nwIonP2kobRqAjq/r8i/XTgoR
	 4GOlpt+8d+T2IwF8PxxiFtAal5qp32I4k8yNXGMKfTL+QlDikxJBagh/jvLfVlm94VAqX
	 3q4isUR6dYZI1OEGKBDMjJDlpAsOV+4CiZSGBcliXG20WgN01DYXr+H+sHUrcjrr5QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009390;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jm1644hOM8KkSEBC15KSWMNNpNyH5zjpP4wtWkVGhZg=;
	b=DEWObexD8B7Op7rwe4K00qeHx3sb3oCC/vylSaYvtmz/0BxBIg27KM6e+fVVQ7xNQaNK
	 yAYM2cIrP3LxYE5zwqo01Edmsrav+w2vTSESSCKkMINSqlQ+aOwXFcivDWYcD0adEmh6w
	 NnsyF7wo9Sqewef3GtR3KftAGr2NfwEAVcBnMzv1EiidJtyJYZj4Vp9hp9oyoBHFKFynp
	 hO6PQy6SMXE1QW+PchrBUpP7FF7dZCbD/LiWE/JixnMgsqWsA/DNlv/QxSuy3S8qq0KPD
	 t/mP+WSy7YlrUAf1qpkj9RzPmQFACS/2kSTwy4IrpGavSsp+HprN7uezBu6soP8arDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z7UvKObN;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB8606A31B;
	Mon, 26 Oct 2026 10:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70BB8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z7UvKObN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793009389; x=1824545389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gvew9ukDl86S2wPT8y+Epku1wylXdvEYqLb+6NuMHmA=;
  b=Z7UvKObNaKsa6GYgIpTeB35ROw+pdkxkczDHL1TimKDhy5Bk1TuqQfPi
   oDtfuiLHVHVkL1IREifoA2UIIeXMimJj7MHevV3I2ul2O6ZhpWjaWQA9R
   zyHXNMUDizw7XsCR44qDl5po78mE8+guBPU4rfQ2N12SMyjkxzOK5ikzp
   DJtFnWIZbI/XGERL5XEb54tfdarlcl9RcSJZjQBsHYJlwZV34ngIPA86d
   tAP6e4x+oOBErX/+/nPfCktE0scWqX/dUTa1amSIGD4OiKN1TADk9rQfk
   Fjy3sqfBAGkXZ7PVjtcPWc7gcx2RHm8uqiOlPqAYEp2P129wyRV3Qbg5G
   w==;
X-CSE-ConnectionGUID: E5Cn5DZ7QMaE4EHG4oJ4Bw==
X-CSE-MsgGUID: NqmQPli5RhmfjoKO6DFGMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1676022"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1676022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:09:48 -0700
X-CSE-ConnectionGUID: i6Wd1/cYSMG2sHMf1DEEKQ==
X-CSE-MsgGUID: DASe3UZ7RdKZU9M9ALeONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4327858"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:09:44 -0700
Date: Mon, 26 Oct 2026 12:09:42 +0200
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
Message-ID: <at8m5q1B62hPxvSv@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
 <atpMNk6ymCpC5BL_@google.com>
 <atsEql7X20hGytXv@ashevche-desk.local>
 <atuOysdhmPRA7Waf@google.com>
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
In-Reply-To: <atuOysdhmPRA7Waf@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 09:43:54AM -0700, Brian Norris wrote:
> On Fri, Oct 23, 2026 at 09:54:34AM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 22, 2026 at 10:47:34AM -0700, Brian Norris wrote:
> > > On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> > > > After three patches I stopped because it seems more works needs in each of
> > > > the individual drivers. Yes, the series can be applied as is in exchange for
> > > > a bigger additional churn in the future. My preference is to see everything
> > > > settled down in a single step.
> > > 
> > > There are limits in how much work I'm willing to do on a bunch of
> > > drivers I don't use, can't test, and frankly have no actual interest in.
> > > I'm sure if I spent a few more minutes on each driver, I could find
> > > another dozen things to try to improve.
> > > 
> > > I can go back to the v1 approach (fix only what I came to do) if you'd
> > > prefer.
> > > 
> > > Or, I'd prefer to stick with the sentiment Jonathan expressed in
> > > optionally requesting additional refactoring:
> > > https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
> > > that most of these changes are optional, and that fixing 1 thing is not
> > > a subscription to fixing everything.
> > 
> > Right, but my concerns is that in (some) cases you can do one step further and
> > use PM_RUNTIME_ACQUIRE*() instead of putting first the explicit calls in this
> > series and makes someone to basically do the same again.
> 
> I'm not making anyone do anything except stop looking at the return code
> for pm_runtime_put_autosuspend(). Those cleanup-based helpers are
> totally optional, and are not always all that helpful. In fact,
> sometimes they introduce more problems than they're worth.

And I'm not telling to go there in every driver you touched!

> > To me it sounds like
> > a double effort. Yes, that is_active thing perhaps to much to follow, but even
> > there it can be refactored to something like
> > 
> > 	if (is_active) {
> > 		ret = regmap...
> > 	} else {
> > 		PM_RUNTIME_ACQUIRE*();
> > 		...
> > 		ret = regmap...
> > 	}
> > 
> > without changing the driver logic.
> 
> Well, IMO, this is adding more trickiness about the scoping, precisely
> because all these drivers have strange logic. Here, it may or may not be
> obvious to someone that the runtime PM acquisition goes out of scope at
> the end of the 'else' and so drops the refcount. Then you have to reason
> about, "what does the rest of the function do?" -- hopefully nothing
> relevant, but that may not always be the case.

Scope is a fundamental thing in C programming language, I believe with OOP
staying with us for already somewhat 40 years we should have learnt that
scope may be associated with the local references be dropped.

> Don't get me wrong, I think the cleanup helpers are great for many
> things, and especially for well-structured code. But they're optional,
> and have their own downsides and risks, especially for unfamiliar
> people.

Yes, but doing only one thing at a time has its own downsides as well.
As long as it makes the same or similar churn in the future while being
tighten (I mean touching runtime PM calls but not converting in some
cases to cleanup versions) it makes a lot of sense to me to kill two birds
with one stone.

> Anyway, I disagree with piling your personal desires on a submitter to
> "fix" when they're unrelated, unnecessary, and may cause more work and
> problems of their own (or any combination of those 3).

And I definitely disagree on the inducing a potential unneeded churn
in the future.

> > Whatever, I am not a maintainer here, so if Jonathan is okay with this churn,
> > then it's fine.

But as I said... ^^^

-- 
With Best Regards,
Andy Shevchenko


