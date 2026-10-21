Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599366;
	b=Ic23nU3E33Gtb9hLf9GrTauEjWtXy7COeQT6mLKU+wI3g5ZTZ6WqdYcTapaEfSpiYvnW
	 a6L4UTypwEwxPCpqR5fHvJW7VNWSGUfkI7OQSlkSfz+wktgM8OtBlPQwCkYaLWgoiTMws
	 vdTs1gp6xALMfe0sN/c3gqcOMQmeSoWgReSROBfIg6Qf2CmmrIUNXVPeNOU8H5rODnf+5
	 PC04R7z3IqEBhjPOd82NNa9ymu3IbyhOjoQc9P5UcbFvzhrOJUaCt1oZ9AEYkNvOh/oGY
	 IaCM6p8RKUMyaVsgtuuq15arfVFRab/MD2Q+dFyAWPAQGinTP5XOuLgKh/S3gTnf/jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599366;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2XLD1DQ6Ca8oIEwz6TEOqoZWn2dP8yf2ezn0GD8RDb4=;
	b=zErKeEUNR1h2cs96G3F8OhMMutbztYdiqJ4WicEeXKYkmFSsoZTBx0ik2ySj3qAUlOUR
	 llMw9saerGgSl9a+iDSoLjLo0LKMn0EndAjVm4VY3pqkzYBHIm1vBhHCea69dVTVG2eno
	 BylpCBVBufFLEYax3g9oabOYVrxkzzw4lL+lxkVOMe1f5NHNYD1l4Pzf5cOIXxRukjOdP
	 6f0jmcK5r/PGe+qrGuzvAC17Q4DMAQTgnWf7SsrN//n7ZXSPFBrPXXSYbB8avipxFcJlI
	 gWigPwxxR6j3Tdx9Ap13SIhpw+ERRaMgd22XBK/ZY0hmwn66oQnckKk6H446meyCrkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ewSgweBY;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B206606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B206606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ewSgweBY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792599365; x=1824135365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/LdbR4CCoTvEPqmzRH3d3n8B2KCkxBwfsuGTp0TkjQ=;
  b=ewSgweBYMssaf882qgYXjPxIo/5BNgbFP4AuvhjnBYkiSDnWq/N9BZmP
   U+cjW+77lDc34FXG6swKv1TY9qEf43TCs7yvuUu6EiLt/Y0p6wD6SQh2H
   jfmwLT5/OTkY8xfWdWlny918H6pQGB8Vw5hk48NwI7IiFFr4XFD1EXs6L
   hYetE2B48TAwquHDqveXdOMLTbPtuKyp5Y2Jct7RXOPZehsX6b0sbrGtx
   /BYQuPP7TwzlkPmf3uc3mg1718hAXSBLt5AmSiG7QJzjUQbilqhOmYW+B
   GhqHWegYJyxVxI++IQljXUjPpf5AhQsZvx/TLU3EVsUf3DfOPBc5jeIQP
   A==;
X-CSE-ConnectionGUID: tXJF7BTyR7+3einiUh/WYw==
X-CSE-MsgGUID: 9Gb4noRwQlW6ATSQQJU7OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1218781"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1218781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:16:05 -0700
X-CSE-ConnectionGUID: MJ9tW4lYSHKDvbK01GUI9g==
X-CSE-MsgGUID: p0gzYQzKT32ZuFVBdMc1PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3470958"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:16:04 -0700
Date: Wed, 21 Oct 2026 19:16:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 10/18] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
Message-ID: <atjlQe1C-xU9fYuG@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <a6aebf7e2c69130fd8be86c8dd763abad28d5d7b.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <a6aebf7e2c69130fd8be86c8dd763abad28d5d7b.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:31PM -0400, Len Brown wrote:

> Replace the hardcoded value 100 with a named symbolic constant BCLK_MHZ in
> ratio_2_sysfs_khz() to document the assumed bus clock frequency.

...

> +/* Nominal bus clock frequency in MHz - assumed for all HWP systems */
> +#define BCLK_MHZ 100

Perhaps also

#define KHZ_PER_MHZ	1000

...

>  int ratio_2_sysfs_khz(int ratio)
>  {
> -	int bclk_khz = 100 * 1000;	/* 100,000 KHz = 100 MHz */
> +	int bclk_khz = BCLK_MHZ * 1000; /* Convert MHz to KHz */
>  	return ratio * bclk_khz;

	return ratio * BCLK_MHZ * HZ_PER_MHZ;

?

>  }

...

Also not sure why not define it directly in KHz?

-- 
With Best Regards,
Andy Shevchenko


