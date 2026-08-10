Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4753FFFB3;
	Mon, 10 Aug 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382325; cv=none; b=dQeBxSr0vFx8AP6bseDlZ5OJ6PZwxKOZpVGWZ+5u53wnshRZtLdeJBrzuZIE14hB0FdBlztnrwLToyNz14WQf7Unp21kgxvme3eTJSTKWXn9RW70p8i8eL5TDWhRF8zdgiFkqPn3+AECSK3l1Lw4vEgVtrrxs62bG4nDr7qmIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382325; c=relaxed/simple;
	bh=S5ZD5YsSY1Vgs0F5qlH0UubxsVw3YgclqQAjn79NzCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYXANtRyfzVUnaV9Xh933XTZQzXl2fEop3LH0A5xMRpMxWoKBHdiYiI5sWBkvt2n6zF56B32KUv3X2rMLLZ6YY5GXAAlxzO+uVh2AxJ7w61s/Isk5xRdRl80gIMdM3LEvz975Snr3lEWjsKOA6AorX+wBefGvN67ezH1Gi/5QdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPeu+e/2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPeu+e/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786382323; x=1817918323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5ZD5YsSY1Vgs0F5qlH0UubxsVw3YgclqQAjn79NzCc=;
  b=RPeu+e/2lppcKjLFDRChtYzRhWEnRbyzqnpeVjCaYyr1od0Ba5HQVL94
   IC8K/E4/Ob3UKl7XPn5l5i6J8egzZ4EfRxqjV2Z3nDZPWKBf4a83BJtfG
   7P5KGTbnmkTQ8WvPX1u3fwbUU7uVkBwnujngPrjNryKzlGe4lF3VJayir
   RciYttRPegvlZYtvHPeat6Ux1iMQ0mdEruVkPGCtLivHrb4kx8rZBbW7x
   PwlZTxclw6qfu6+Qiv62f6dwnY6+Rt4I98wXr0TLYJfr86E7uUxOeqLHy
   0jiFx4Lhaw+P7M/X0hHX7OEqUirMidx+ZCSEymPGoNrALrgAQLCzISebk
   A==;
X-CSE-ConnectionGUID: IOxBjIzvRGWTswX1ML9Tpw==
X-CSE-MsgGUID: Sf9m+E0gT7adKduCGKr1mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90717903"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90717903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:18:42 -0700
X-CSE-ConnectionGUID: Cd7VPktiRRu7efXnPRGyPw==
X-CSE-MsgGUID: Lx2pwkMDRzq96sk0NBOX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="261806203"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:18:39 -0700
Date: Mon, 10 Aug 2026 20:18:36 +0300
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
Message-ID: <anoH7BweSt-ZPAe0@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:09:07PM +0300, Matti Vaittinen wrote:

> Both the current and the average current registers contain same
> 'direction' -bit to denote the direction of the current. The code
> reading these registers incorrectly caches the direction read from the
> first register, and uses it also for the second.
> 
> Fix this by initializing the direction bit for both register reads.

...

> static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int

>  {
>  	__be16 tmp_curr;
>  	char *tmp = (char *)&tmp_curr;
> -	int dir = 1;
>  	int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
>  	int *vals[] = { curr, curr_avg };
>  	int ret, i;

> -	for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {


While at it

	for (unsigned int i = 0; i < ARRAY_SIZE(regs); i++) {

> +		int dir = 1;


...and drop it from the top declaration.

-- 
With Best Regards,
Andy Shevchenko


