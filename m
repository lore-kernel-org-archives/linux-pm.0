Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735021;
	b=vTDE/dpvbp82noNaQE8H5dXInWFsw95OkV+FwXxWQTRQguqafwXFnYInUF8r3wC23BEk
	 hZmYKb46xvK0/i6+MlY5xFvdgHn2tJ2hRzEqq80w09bOM9ZgIC0HwJS71kOOn2fRVPx8G
	 GqpdGBHPuwJXFpBPfMIcK3C3GVJqrjBsJMBCQMwC8rOf/13qtYB0JfbEujuJfUfYY1nyw
	 nI8d06V517xwLoRsnHFTVLecbb5jVpIEvGRnRAcQX8iPOOJ/MzKpv0+Lulk/j/1NSwOQc
	 XgpfwAAVtfrkfFEpjfMhWVYqWKlSAY5yaV5MtLPCJXS11waJsT01iRysPNE0u2aDzbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735021;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=3NZT6BaJXMgVMWc2gjjWZR9V9CkTpcypwOd7Q1sDmjc=;
	b=YPyWvF+s+PUGPz/91NpWpyqthwfJO0N/bDG/lvmY7wZQysNgxysfyX2LWXQulF40IHlv
	 EIPbwHu+ZewrEObw3c9ivhfjXvv2qkyr91ZBhKlZcCGUJHisY2Ml6YIJPoF3gV8KUk9A5
	 Pq/SRVwZQTLGz4jmafa50LkjzEP7giw3t1IViQk22vhGq56TAkqFmOS+OUXGBb4brKuGC
	 9wAeskpY3JU9ic1lLv7WOYeRGGcWfkWhoBsRJeiDbEdjj+xLhignnL+zyUbWAxXupZ5SR
	 ubUREGMEMHrY9lm5w9aDQJj2npOvdv0/oX9sVDEKw5BeiEiA+iY1oOn6qsZlkeLdEjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aden5Pc6;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C54606A326
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C54606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aden5Pc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793735019; x=1825271019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAN1gY2IO6TqWx5nOoYHfX8gNp4z2sNHrmWznKyR6Cw=;
  b=Aden5Pc6ls3RlmLgFwuA5yjYOacUrJDF7lzm4qM+AA/NeBnBuGk++5HB
   z9dVe/VI2Mv7IrjEckhRLJ5259np98voOaTGlmx1o+jIyOAJzjo6N/EIu
   Oqptxmfes/oYs1OcaDexJrFpus0fLBlFwNBpUtYWlppJTcs7etku2AYPK
   oifnFK1vJmJSg7PefQRqZ2KHPtzpOwI19qBJo1v9rP5D71YcYC+biSG6H
   DJBVIMuCffJJ893PX8y/kdP4WEAmz0XcF0laOBJSURkIAD+RO7LHTklpZ
   dvTqDC77sjN98jaNuK6MKwos6LIsI1N2sxytju+TfCuMtcSKpEz/JOrXK
   w==;
X-CSE-ConnectionGUID: W+N2SnhqTtOSWFGYVU7GCw==
X-CSE-MsgGUID: g4fKQp3tSFmrnfD/88xiWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2483908"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2483908"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:43:39 -0800
X-CSE-ConnectionGUID: TUBUCdyuQ1K5IWSxclGoSA==
X-CSE-MsgGUID: mqDp8WaXSFO1YYadFigbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6634201"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:43:38 -0800
Date: Tue, 3 Nov 2026 21:43:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 03/16] x86_energy_perf_policy: Harden with strtol()
Message-ID: <auo5Z00UKXbAfNxn@ashevche-desk.local>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
 <9ba78b0197903c2191a047068ba13bd90ab13a73.1793124601.git.len.brown@intel.com>
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
In-Reply-To: <9ba78b0197903c2191a047068ba13bd90ab13a73.1793124601.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:01:56PM -0400, Len Brown wrote:
> 
> Replace atoi() with strtol() and proper error checking when parsing the
> --hwp-use-pkg command-line argument value, and other spots.
> 
> Add explicit check that value is in valid range [0, 1].
> 
> Update associated error message strings.
> 
> parse_optarg_string() now returns long, as returned from strtol().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


