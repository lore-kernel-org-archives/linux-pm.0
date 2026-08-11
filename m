Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEF429816;
	Tue, 11 Aug 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442682; cv=none; b=mzik9XA9sUeoU8JwuMfHd0OKiIAIHiMv1muQl6ZYNBZMLf0LqFU59O7dLZET1MTKMPbpCQ80T3iD/GJwvJ4cSggGusGYb/wh/tMCK1sFctEv3CQhowexDz0zfnepkkuk/MTfLyFjY3Hk61BKM5sPRsVHbfymZZ0x4LbK7TvEHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442682; c=relaxed/simple;
	bh=K+szDdxfIoDMTMtSk2zIs50WqcxlEglL+76hrTj3DSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Q1TTLjm3LTvMbJozBEHJP2L5p/K8joxKR6s47tPdgJjEtRVQYhQToosohEFjiz6EJ4m/tI87ydZk79lPwL37YgtxuI6ewsskFY1PJg0SUxnZiTKiE0GvH0MJP/ffvEIB9qsAkhFqM6kNU+ny0LXTeJrOZLAHVhYV42P4HAEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIe5lbzX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIe5lbzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786442679; x=1817978679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K+szDdxfIoDMTMtSk2zIs50WqcxlEglL+76hrTj3DSQ=;
  b=eIe5lbzXEg2IapG/xl0Le+n+8muoBXJjL4uUXugxqrTSBBdVsyYR43PJ
   fU9EUEfRAZ6Na4vKPQuDURBaz5jxDxIXPjpbPhOGnK3CGVIxjw2Vy9pNu
   +HyOoGy1iVcyBLGasjs2xJ2+LVWgqrGWshh5BjCdGOIzqKY5U7hN5MMxg
   87x2+623FsxZB4f+cnCExMYKlOyiUlGS+wkHyIwQafP8dNsLNrxOjM0EN
   +IRL25EjZ+Kgi8S1kSRBboXFiOeDFAyiZuw3ACKcx/iCmf3r0LMdV7gbX
   XKqkET/e1VOfm0/t01/n3hds4aNxy45r5NdEcgOYlVnLZVwXvXiAR/nXv
   g==;
X-CSE-ConnectionGUID: ydkjAQ8/QKqAVcmowRi0nw==
X-CSE-MsgGUID: zticXqlxSfOs95e6+VfOeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104360430"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="104360430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:04:35 -0700
X-CSE-ConnectionGUID: pZTq49wLQ++fkQnIGBmkwg==
X-CSE-MsgGUID: +S8XSvKOSHe6CqiXvT3eeA==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:04:31 -0700
Date: Tue, 11 Aug 2026 13:04:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Andreas Kemnade <andreas@kemnade.info>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <anrzrlmp7V_onPwo@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <anoH7BweSt-ZPAe0@ashevche-desk.local>
 <440e5deb-8a2c-4379-bc58-e838b427e48e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440e5deb-8a2c-4379-bc58-e838b427e48e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 11:46:59AM +0300, Matti Vaittinen wrote:
> On 10/08/2026 20:18, Andy Shevchenko wrote:
> > On Mon, Aug 10, 2026 at 01:09:07PM +0300, Matti Vaittinen wrote:

...

> > > static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int
> > 
> > >   {
> > >   	__be16 tmp_curr;
> > >   	char *tmp = (char *)&tmp_curr;
> > > -	int dir = 1;
> > >   	int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
> > >   	int *vals[] = { curr, curr_avg };
> > >   	int ret, i;
> > 
> > > -	for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
> > > +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> > 
> > 
> > While at it
> > 
> > 	for (unsigned int i = 0; i < ARRAY_SIZE(regs); i++) {
> > 
> > > +		int dir = 1;
> > 
> > 
> > ...and drop it from the top declaration.
> 
> Nope. I'm not a fan of introducing variables inside loop conditions. It's
> too easy for me to miss them. And, even if I liked the idea (and I don't),
> it is not a change related to the actual fix - and making it for this loop
> only would make the style inconsistent in this file.

This is a preferred style [1]. So, I would still do it independently on this
being a fix. This is practically a small change that's coupled with what you
are doing.  A separate patch would be an unneeded churn, indeed.

[1]: (sub-thread) https://lore.kernel.org/lkml/alCoTEDUY8AO9OzD@ashevche-desk.local/

-- 
With Best Regards,
Andy Shevchenko


