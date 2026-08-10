Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDB14900E;
	Mon, 10 Aug 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384891; cv=none; b=ZuURX/l3/1587gUqncY7ch7z0GLFi8cuuBRKXhEYGGvrQSV+Ziwu+r4xTjzmqKmtsuhrvqED0eBKl3D/KE6q7fV1HVCFaYX0SNOKONBY9vxgBfTEfkINQ9OGGz02/OC6h6KWdgPOuQsdvkHvqFSyZBgKXEiHpQYpLwFqJv8mSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384891; c=relaxed/simple;
	bh=Mb4Df2+iaMeE0N/ZLdmadufa5b+Si/jrujRLGjDSYgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJKP+Cq11sGbijtRw5/3GD5Ou1QbzSaAV/qANRVTi7aean32/woT4LLv/jZ/LZqthKUMgFZx6lnsitEr4sXJA3BiKoGlU+wRQNTlV4H/BFkIRHsPvcnXRjtI1IQMEYYWciZ3oUmQsZf2ffyPTGHpfrIktU3ugHQXg1S9CoE5jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKOEtZcb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKOEtZcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786384890; x=1817920890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mb4Df2+iaMeE0N/ZLdmadufa5b+Si/jrujRLGjDSYgE=;
  b=cKOEtZcbWi4hkCIa8psAXHDapm9EjiZaUj1kFwuXYFxSR92qf+3gg3Z0
   okp/I/dsS1N/3Og5hHTtBqZjTh/F6OgjbAUZghBeqLyN6nzZlCW/C+H/c
   4Uht+0gR4SstSL/xaBUIvOKWJx7ir+N98/wMhAlXNvQ/EurJEMVhDQhba
   MV8+TTHCyTt26Bd5Uc3Fk/NyzpxnOXnuqBLF+bFkcOK8zi5QFcxUnw+Q8
   /8a/1DIj5QIlEbTy141MH1dvpcKf+vui8eSdo3uRRj66Hs7cgqvRtEIxz
   5Dj4U6DaAVRidWfzkt/8t5CfYCjVfkf2CxFWy7YUZVw+k/cHl5cQwWnsM
   A==;
X-CSE-ConnectionGUID: DHMRawxRQzuE31Nwm70oqw==
X-CSE-MsgGUID: mBhcd3aTSt2bBZpRCPUsAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104300697"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104300697"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:01:29 -0700
X-CSE-ConnectionGUID: 3YuXQOOCSSKwOKmzuQDeIQ==
X-CSE-MsgGUID: uJ1SX3aURp68FNULdurLGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="263704400"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:01:25 -0700
Date: Mon, 10 Aug 2026 21:01:23 +0300
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
Subject: Re: [PATCH 3/5] power: supply: bd71828: Drop duplicate power-supply
 property
Message-ID: <anoR83JC8UY-u7bl@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <518283ec9163943fcd1b53ad61fc3025fd346d83.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518283ec9163943fcd1b53ad61fc3025fd346d83.1786356145.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:09:25PM +0300, Matti Vaittinen wrote:

> The POWER_SUPPLY_PROP_HEALTH is added into property-array twice.
> 
> Drop the duplicate property.

From this commit message is not obvious why is this a fix. Perhaps elaborate
that the index is somehow related (or what is the reason behind)?

-- 
With Best Regards,
Andy Shevchenko


