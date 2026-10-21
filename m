Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598298;
	b=EbCpnm4LRtamvAsQC8u5HEUk6iyHqnQgYOBk26ubjR/MePBrbhjD6RAYedciPZkJtVe3
	 RTG+vWZj0lGmkMKwLatVYChmFr1kHwZMUaB0u4KWKoqxMqPFObkmEQlSnIn6IKpDtqsIs
	 wKWBB7cMCkLdBBMajjGZMwDktIo+MbrwUFKchHDmzqM5ARK5QQUkXh7KwFln75T6YWl+v
	 ONZlbLJwu6WElUYUr/bqLzaegr0e9xOyZ8waownGVER/2SyoRlJccr5CxpkUMnLIcGUgb
	 bTknR3t8eDUmc8aB4MNJLH1WUPMb27S/S0dhVWHlOaFD5m4JMTDDWP+orkXG/u4w6TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598298;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=I0/4kLWQhtmGXdeC83LtaViwNApGwL2WvqX1RlazbYM=;
	b=S9fRARAQsC80faKd7kpaDWVoL7VnyXIRfC1P7NJE9BCcrUIHIXgPuulpR7CJCDf1v5KI
	 UxOwfCha5N0MdNcz87LxiTWWbuWOYCtob86bEojOjb9fLixl6w5cJ6ZjY7MFZT91DyC7R
	 yJl5Fo/ydnnv8b6yDCi2MA+s/HZt8OOpn1b98N8lzaS+QRgEJMXYxNTndgQetRrhaTIQk
	 b9JBDSJ/iRvRzl/Rb9xJtZNdj9lU+wyLlqDDTcSP+mKL6MdWZPEwHq5Jo2KwdYpvL/nw5
	 vxufkGPQM8RExxGZBzJD/HZrQfwy8S7/ymfY+JfA3IwatiKkDUxQhRZ4S2tK0wtEuDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nqu9L+QJ;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FC606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8FC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nqu9L+QJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598298; x=1824134298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XdzUuacJWPsxmAZ9eGWQlHgoP6+hcQsjsXcrVwxsWg=;
  b=Nqu9L+QJo9pMWrCwcQe+Xr+axiwHzqAmOufR1zVpYR968Bc8jIc2Ph0K
   h6KgGPp+FnAHWQh3wRVd85WMeAQfO2KwNbbZcbuZS7O5UCNFLmKHzdo4e
   gZrI5kc5+XcxF2d1JJ9654rv5BZ4SpsKQRyjc7+bmlB2AAp3GclgaSzfn
   12gUGoJDSgRhZy9Xvm6ZB5feFeoTjir7IzIzWG8HygiGEZOBD9rUJLKXM
   X0SVOcNAIqyHhgC6gvpGw1s1CtUQW5HzawU9BQClGhLXznn/0dtnD23u6
   NZ/MW7qWHy5T1A3uxtnMedbf8yKzpn3Y1n0Ra64FxTZqxT78jkTT1CBIN
   Q==;
X-CSE-ConnectionGUID: Rvjp3opBSa2RvU7fxBchag==
X-CSE-MsgGUID: CiZjBeKNRfmtnCN2+y5Ukg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1318525"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1318525"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:58:18 -0700
X-CSE-ConnectionGUID: WKTixqPcTM2JHKqYOenmrA==
X-CSE-MsgGUID: w3dk1F9lSkC1HkyVfBqE7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4962123"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:58:17 -0700
Date: Wed, 21 Oct 2026 18:58:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 06/18] x86_energy_perf_policy: Fix optarg keyword matching
Message-ID: <atjhFmRavZIP4MD0@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <9d79f74ed3e6f247542fed973c6c7ee3d27a9364.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <9d79f74ed3e6f247542fed973c6c7ee3d27a9364.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:27PM -0400, Len Brown wrote:

> Replace strncmp() with strcmp() for exact string matching in
> parse_optarg_string().  Exact keyword matching is safer and clearer.
> This prevents accidental matches with longer strings
> like "balance-power-extra".

Right.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


