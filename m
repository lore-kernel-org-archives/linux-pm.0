Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600750;
	b=FrBbBU3EZPLw3YNllVQBlIAV3I1/oJwMig/2PGlc0Wu/rm785/5pQGJijb6KmMc1fLqZ
	 VlPkU8sHTJCqAFDI2cIg9CPUWFnqhkUaT3OnMvjtOlGe2V2K8RCmOVqP+5+HM8L2oGRgV
	 x51pxrlnyKMq0hnibFTwzfDj6gsVba5Dc6l7lvgA+wwj7X/pCIadUSpaUxkKqww6YW1nU
	 v2q0DIBCmEp1tU9KiDJkEZJSDmuk5c6Ymbw9GBz42kD0WcyVdABxy8bdn1yNUfohkezXq
	 hyIadARsBp9k+5fLowc+CdbtXT/5GTTFWmt/pmFPvif7CIxwnmaOmjUYS1GcnvnBuHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600750;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VkN1V72QgBlgg0iS1jlcI90DiOvoSRijr75se0g8S24=;
	b=zAt6nHgu3WWwwwS3Q03qc1fDQgDazCqYHHJbnRD4aPSgJ1yCni5eMHZ8SmPZ3CbIQX9i
	 aklZh2OQKoxckKvgdlTJrMEFxFqcTsUFa79e2A1pGJkRR/AD+eSWA6zeWCKfXE9Kee+Xu
	 CvvXmkK4PddvYpfoyBlJhYVkdjYWxBpdbGNK5RvUS2U2aDr5BwYwM9MsLEnqDE1E9d6qI
	 yjVVJdlPt8Iq7OinHar0yEfEsI4MSJKBMmH45YxN8ueoeHIa1Rf8gU1UWeG35ZWnGNWAa
	 CO9HOrzaMGIzg7nfqnYu6OZODaNvBDBdkCJ4W948s9i2qHtBBqVRt1iU1lgUd9Bf8sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ktLnkhVE;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA0606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32FA0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ktLnkhVE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600749; x=1824136749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z3VJaoWJuZ8OyyCMVD70K+BgV+u3/dsf2m7eBIoaF80=;
  b=ktLnkhVE0PilGC1tH7fiq4hZAVIB2X880Hx3FbZgXNT1cUrnosUQIA1f
   2LQDgoFgj+NKPCeGdWrwdJaq4JRtwgWfc2KiIFH7lBo/lqPg/v92qAvVF
   OQXw0T8j7+5SsEPfCqi8RA1+JZL8NG5ysAkdMeCfe9Cboj002FnxbQB8p
   lO41GrTuLE4NMbDfQ4/YfiukOu5/WuA2QNorgOXQx3MhDUlKgoBVULm4z
   9yB82uInWBZjMQELGkM6LJbTLj+8ItjMBKJytFhMqbD1Q5h9vJbIEUR98
   kElHRTZOP99BNLFX7tNJuiBtVocvGw3jfNzxipF20XENxTrr8akpFs0Gm
   A==;
X-CSE-ConnectionGUID: 63ZjaoRbSG672mXSqd6rKg==
X-CSE-MsgGUID: Nm3GdLANQKmqV6zvy/k0Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1234742"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1234742"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:39:09 -0700
X-CSE-ConnectionGUID: Q/YRd+aYQfuT5CImd1ba6A==
X-CSE-MsgGUID: daSsZPVsQTKgpWPvpLIsjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3145236"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:39:07 -0700
Date: Wed, 21 Oct 2026 19:39:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 14/18] x86_energy_perf_policy: Cleanup: Constify profile
 name arg
Message-ID: <atjqqbkzxSpYs0pj@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <58f841cb19504f9d68057897c87cd2a3f4538264.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <58f841cb19504f9d68057897c87cd2a3f4538264.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:35PM -0400, Len Brown wrote:
> 
> Add const qualifier to the name parameter of
> platform_profile_name_is() which is read-only.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


