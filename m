Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434837;
	b=fHXGTOLFcHq8VXB4R/2qiYUGUXzdAG4hisiQbq10gDKIIFb1knsF/B8Ca0+aeXo7JjgP
	 OqP34R1xUSo/Ltz2a1HQ0x2Xg1X24F45CaDAztsA4gXP0vHXS6c5Mt7MjjH+Yw/o9N9iH
	 E2Z/ZnyWjVRdwBHK/SLkv3DyLSOxy5jggAamIHowP2VI+7vXuErQKNFes2bxE7l+T0WYT
	 FNTH+cDDBeOGrdYegxOE1LMgAIZYsJulzAaaXOVxopQLUejfTiXDS6PrBNNkGS3m1siyl
	 wq0fp2og1IzDWXTAJ/5bE90Spt+uYVe8zajqKNUvB2DVPQwSsBmRsHE0oGWl6kSW5uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434837;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=F0lyODHswWzFJcfyKObsPryv2od4m0HbjHTFneDvqFc=;
	b=DbkaoPhscUU9RT45tyBU8cwY0DA5ZOl4okBRxoA4HDl0Yvga0el7K5eZ+B7SMs9pcgAw
	 1UHUpAgE64Ned2j5YLcNaAmoErDgntvof2QcH4qsPmZkqrRXVBaw/i1mITdxnJDK7WNmL
	 VAQlnt+5E0u8n7XaeU12r2Fp5i2dY9sthXR5BL1thKYgpuS0nCsawNzrf3Rf1TmpLim7q
	 mUf8KJ5V299KGS07ltKDiq7RMJC10187Qf+9vs99D975CWoI1zRBj8xbxy3RL6EoobY0e
	 PMsUP9SD488JcPvgT2gcIUP0Sk3TBMIdbzAg3S1r94S7LcLyjRfOmvxU3gJNiohNePQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iSPVAcjh;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399D606A31A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6399D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iSPVAcjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792434836; x=1823970836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mj0M/edGiLIHfTETrcKucX66pYJdCBXigvzWTp38OPk=;
  b=iSPVAcjhJR7tCZzwWUX+gej4FRW4Z9ow+vosuZPATLnYk/3ekJYC1LO7
   ymge52KvB4Wn/Q9mw68SfhiZTIgGay51HrEaYHHPQoOq9xHUPa33Db2BF
   8OsX+Qo3lfNsG6+jhPPbSIkETesrWgCMkB0Lyq9CZTiDuL6uxJb7GwZL+
   XKcdVFEkMs6jfkdjlF4E7ib6DnkFSGua9lwslMkWU19p0S7eYeZP36lyT
   qNaRF1BMzKqYmYr8HisL93rSqv/k5xEnY26k7BWWWb5A83cvXFC9NcZpT
   QRMv1Z/p4v7EoH3RysdtTUJljyLgaWu4Zd867e0vgcVahPJm/VHMrzHZx
   Q==;
X-CSE-ConnectionGUID: FCK4IJFjTeK/iJUIXa1XOA==
X-CSE-MsgGUID: TdY7kOj1SIu0qDZKqPAFYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1231239"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1231239"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 11:33:56 -0700
X-CSE-ConnectionGUID: W0ImTK0bTQOKefEJNhr4EQ==
X-CSE-MsgGUID: J/OdswwaSOqpsY4g44m9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2596692"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 11:33:55 -0700
Date: Mon, 19 Oct 2026 21:33:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 01/18] x86_energy_perf_policy: Create msr_path helper
Message-ID: <atZikMYhGSu4OfC1@ashevche-desk.local>
References: <20261019165156.42592-1-lenb@kernel.org>
 <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:22PM -0400, Len Brown wrote:

> Factor out code that creates msr_path[].
> 
> No functional change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6

In July IIRC the kernel documentation was updated to make the

Assisted-by: LLM

be a standard for the kernel contributions independently on the model(s) in use.
Yeah, I only learnt like a month ago about this development.

> Signed-off-by: Len Brown <len.brown@intel.com>

The rest I have reviewed (as the tag above suggests).

-- 
With Best Regards,
Andy Shevchenko


