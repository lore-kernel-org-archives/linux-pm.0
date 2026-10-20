Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488910;
	b=pgVNHufw52Kg49UNFWu2eEVlsT/eXxawG5lxk32KPXIDo6l0ri+IFnpG5SXrlwY5lU2c
	 7E221kc1xXz/D8t4qlm88iIoH5rv+Ax4hK6Vn4+XqGcO3q+8dBhu9f7TjkYHvD8grgEFi
	 juLT28FixbaDqMvO+3N/rDz7/D3PPpdP8VGz7EFE4Ne7hE0yRU5YJUBLenz9PCVyfmady
	 QIMmH/Vy2aGwcy1d0IIeHdgupdmB0+ixTLb7fd4BsvtmjdHz2TP0ESQl+Jd5Y5+baugU9
	 u+kVIeEAseEcS6qlt3iYZSIkRRwexLhT2LsIoyLiMcngHr7M7obBwes+hOH8MZcqffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488910;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1ftijkg6EHePtEa/x8AUsABCs4bu3bGYko4I/sxeWYg=;
	b=BLuG4hN0W4OGpV0Lo2MyQpoOk5uRF3IptzpKr3PIpxP2xkSPlovvNeWvjwfZFOoSW9wr
	 DlJPtOvFvO6wziG3M+5r7CaKRoNChaH1VkW8R5TQS74HwKVxMSAJtOTVsie06Ezyvry6c
	 8IemtIXIMxzh2AApyRWnOX4375JoQBvAgR7F6MTiuw3JFMEQIFkxAOELtZOVGPsLS8Bo3
	 BKeZyZNkz6fUsVRqrcV433Jm35YF65EDNCPPMKq3N7aRVZn4fO8Rjvsfwo7QWJcYpOGFi
	 BBG8Tzv4yso5RkbbabS2peg3whgba6TIpUYt8oWxEgq+1UglnWmfD5A7gIwkXtIy9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BgLha/1f";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1563606A31E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1563606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BgLha/1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792488909; x=1824024909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQea3jLUlj4SzAx/ucdfIFqSaKFuq6N8d0gWG4av4zE=;
  b=BgLha/1fYutFPJTNM7Eu5YkMqvarhhEp0wiig1lqhj6+dveNxZTMQENJ
   /bb7TF/ACMBtd3g8QxP+3M7bew20NOdIgmet+osu15Q/avN2H0teU/HKZ
   zAPSd7EjyLBVDUTaYwUKX6o4gfNXHgoEgvsTH7HFSwrq8S0aDQ2cnvTSE
   0fvnF7ZWVHTqD8QRclyNTjiWMrhyWv/47xGQ3Pu1Y4Cunn96Bk1Pmf3/7
   b8ot6lIE7e/lp4G1zt0PtznU9mJGSh5c29b3SlNQx6/DzzjOwmiy0olMe
   Oy/Qw5+88S8Os2Heds6IpYoZPI4t6OY20bysHs2TuKbkEpdwpYnDR7Fr6
   w==;
X-CSE-ConnectionGUID: TvbQNrSqQNq9H3j8IN6cmQ==
X-CSE-MsgGUID: HWxMKv5wT+y2FKjMymXCGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1089537"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1089537"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:35:08 -0700
X-CSE-ConnectionGUID: wwxpvNvwQdiezIxx6/nsIA==
X-CSE-MsgGUID: B28cvuxvQW2YmHr/yL2lAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3186617"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:35:07 -0700
Date: Tue, 20 Oct 2026 12:35:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 01/18] x86_energy_perf_policy: Create msr_path helper
Message-ID: <atc1yHAyKljYKz7c@ashevche-desk.local>
References: <20261019165156.42592-1-lenb@kernel.org>
 <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <atZikMYhGSu4OfC1@ashevche-desk.local>
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
In-Reply-To: <atZikMYhGSu4OfC1@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 09:33:55PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 19, 2026 at 12:43:22PM -0400, Len Brown wrote:

...

> > Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
> 
> In July IIRC the kernel documentation was updated to make the
> 
> Assisted-by: LLM
> 
> be a standard for the kernel contributions independently on the model(s) in use.
> Yeah, I only learnt like a month ago about this development.

Actually it gets a new development!
1e035297ffda ("docs: remove Assisted-by references")
I believe as you also consider that the tag is redundant.

-- 
With Best Regards,
Andy Shevchenko


