Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B03AE1A3;
	Wed, 12 Aug 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522665; cv=none; b=hJ0HaqH5+dU/MK69hYodC+mH6diStXKXPH5RluID9R4Yp6jWAyPehQWT2sw9kzLZcBvr6YRmWlFA3uDKpGZsnHo0K0rubxqH4QgztxJ19imGxdUOH6YESzlKJwPMEw2CeiJumcMGCK4G0CQYZFm2ank42b2UTRpymA33GMBaqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522665; c=relaxed/simple;
	bh=REdReiCJ/qUtA7lxHmFqPOdXaq6j7ayXb+i2R/r0yb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwVqPpMK14pwClfe8m+yFfPCuS2lr3WfJSlVmVl5/P3zdmZzAKiJMPnHo/kNC2xAvb+zORMO17fspadfr4juDXowH8vJK+GyDwFKWqVfn9GQ6vSix3+CNd/T3Wq46Q3kFQDLC4DfrFOb8YbNWcNzDlXalKAIuqsyYFD4xnK8Qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8AKT0WM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8AKT0WM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522662; x=1818058662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=REdReiCJ/qUtA7lxHmFqPOdXaq6j7ayXb+i2R/r0yb0=;
  b=m8AKT0WMbo8sMUswtc+j5We0U3sefBQywxHp+lM4IxbJqlrNPglWritx
   YRbVbuPVcHji0g62DrZTfVEdkArPMUhA+/swrQTvnSg5Fdc/5ut/8AYg7
   BJ5sJ6z8Pfk6rAClHRJk49+IMr0KeeZS7kYQfYEZi0a/q3v/FnhEhiWYC
   d9EfkntbgOGmv5yPhb+ysaHcChKqL/LPVTkP3TbldzkGOOEh/IejC/rDV
   9Lrocs0DfwCpxRM9yvDjHqobVMshEmOaQkJ+GRkj9QuySW1z2WTDbb47J
   CTTuQagu8FsSY5pgI2XkEKi9sFx4YWqGqU3knxqI3Sab/nOReCR2Jq6iY
   A==;
X-CSE-ConnectionGUID: /MZsWmKjT6q5YWCAXnWn3A==
X-CSE-MsgGUID: vxPae783SfmHeGzpnz+jOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86919396"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86919396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:17:41 -0700
X-CSE-ConnectionGUID: 1+mzkt+cTXGDHZ4o5NvoBw==
X-CSE-MsgGUID: lEADJDPCRXWcKtuqTqWDkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267430579"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:17:38 -0700
Date: Wed, 12 Aug 2026 11:17:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <anwsIK9ITpcDkZos@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <20260812101050.575c9bfb@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812101050.575c9bfb@kemnade.info>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
> On Mon, 10 Aug 2026 13:09:07 +0300
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

...

> That code is complicated. What about a generic 16bit non_2complemented sign
> to 2-complemented sign function/macro. Such would have prevented the error
> in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor

Do you mean existing sign_extend32() from bitops.h?

-- 
With Best Regards,
Andy Shevchenko


