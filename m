Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600307;
	b=Q7YSQ7D3dP52HA4QYUxF56mhQ1Xb7crzhgkxFkFry7IcWIRBPDlzHQ6CRx/5iiBmosLh
	 WiCYKIhvPvFN4jy/kQaU/oP0HGm5kk2ikcR6DLcLkY0nOlmK3WdYiA8CrqW+eVI4h8s8f
	 9s0KzKQ8uSmwlS6e020da/JW+YrVCSGrOWC8xFylxtM4EUfSA+RY58NIzAg4Dk7WPuNx8
	 WRh5a8AOCsgPQWk+DoY9+kxz0vLtmGqwgBXVhZ4i+zNOU207HCHzWVhQiv3KGSlfnnUJB
	 Vfqvu3JzSy4IcVGxaz4cktLVdRoPRu8o3lWeBsBDWypJaFgf8xXSk6G/J88hAPnX+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600307;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=i3y8qMNqm6vc/1ESHiCXMa982SW9cw06Vn3mcf9auL4=;
	b=X0P92k9cSGFNCcHHRViwfzJ7Jv+3rn8bmmcs+5jB+UxP3mowJL1ngbKhAkjJfEZMQM5K
	 7eQkrpIhqur1a26b9rfkSvGS5cYQ6Fn3swKnHdKnS3J+ub4bpsE+zdOF25QNOpQL718Yb
	 S/x7JxAw+wK+mb8MEo9h/TkzQmSYk/8hOixMestWsWNmCX6HuLk/Og8i/BAnWE+S51PTE
	 +ZeT/DKjzfxMfnS9WojcHNJrdUl0VJuB44WPKUZguGkQPlxhKsBVOA2H6Cw4yFkijH+ML
	 +E5zhyfjErrgHzlOwlSL0MbcZrIbm2TvUBL/OoODuquFKgccMjhkwKoVZJpMZCVsG7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGuDAlRz;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309A606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9309A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGuDAlRz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600307; x=1824136307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aa12CviOaoNaa3ehlddFdZu8H4ZNV8XSFcoG9n/XCpU=;
  b=JGuDAlRz/WAlWFyFR43JANc3hL5iIWiks9asuP34qulsNy7THNRmYps2
   xqNXNi3l8vhIEUjyEmJcbkq1De6dt/Ny9Ox96oI+y3PDSkdSdKHOLmhMU
   7j6FWmt3chvH3tJgI6nnrHZJAbnwhdf3CWzSNRWhZodmfNAdrQvvYLplJ
   xRDFs09n5w13tAgpEyA3uMWywAniVZXcHWdEERggEmrLeeufCKxpdcrO6
   1WWaCcPdpOUhrvlnYElzRA4HeVrTfeVouW882LiP+37BXlLa8oAry76xc
   r9zR0a5OzHzYpmlgT0RPPF4yTN4Won+qWg3PH5qP3k5yEVW+iXA+17cku
   A==;
X-CSE-ConnectionGUID: cEjrAgxbSMGW8yqEPw16yg==
X-CSE-MsgGUID: XeIr4h5cSgm3RMuWqHGrWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1331419"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1331419"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:31:38 -0700
X-CSE-ConnectionGUID: P7oNvVpkT1m8YgCHOsSvzA==
X-CSE-MsgGUID: zOLiQ39yTHC+DZVJEHNr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3547911"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:31:36 -0700
Date: Wed, 21 Oct 2026 19:31:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 12/18] x86_energy_perf_policy: Document MSRHEADER
Message-ID: <atjo5aA3GcDxnSIj@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <092ee1bb0e6553dfb7234ef40e0cb82e684f2541.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <092ee1bb0e6553dfb7234ef40e0cb82e684f2541.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:33PM -0400, Len Brown wrote:

> Add comprehensive comments documenting the MSRHEADER macro usage and
> expected build system configuration.
> 
> The MSRHEADER macro is not defined in the source file and must be
> provided by the build system (typically as
> -DMSRHEADER=\"msr-index.h\" or similar). This can be confusing for
> developers building the code independently.
> 
> Adding documentation clarifies:
> - That MSRHEADER is a macro expected to be defined externally
> - What types of headers are typically used
> - Example build flags showing how to define it
> 
> This prevents build failures and confusion when compiling without
> the proper build system context.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


