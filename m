Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598805;
	b=vv4ggf464hBVRj3bCeVNWLJ42TTakGhWpjyUGRP/5ZY3cD1oZ2TCg4TYbjpZng/5s2a5
	 pZN9QIu5VeTo44a8P68QbFj53F3JxGPVv1kgr6ZhG0VDYVeUnclXkr8pqVuFQedeejKwT
	 cUqGhwryQmQ9c6AoNwN+cMfjGkdCCqHetmPSuEjyY22YMvfYiao8MS6sA1RwjGAJj1qah
	 XjL+XKLooqCZ+f9YZ802fhI4WptsPIT9PA5f8aHbQxUQoXdyZ58oHXpsxJV6GJnWOkJR0
	 yZ2+jF54z5yfApyrbdGRLWzceP4VtFm6Mc39QpCduAImeIHvRP1Eyfsom8UwhlB/iHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598805;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QQwdygHlH+crYwYHwqTCIWL0QUFIQa/RnwZs1b/1VmE=;
	b=2ydWMvyNl9Nko6yk9psu5zlKQP7pxOSVd/b5aWfQCIXtkxR9KGcGVH9JokrimKRjg1JU
	 VUZ7qs7PDkXMUcKQM6ogBE/ijBHfIFQGqJBE/Zbw4+QpNfQgwqYxmw9f2twbfYRLNPKap
	 qvtKYm7xSzDLgJO+HiZgSXXBBzPX45dVeuuwyHpEQekp6f0jCdAEEkV7N7Q6CVhNs5oWy
	 Lr5A35I+wIjepu75zca4vRLKdBSmBghpnLU73nUNNduAMAqRtV71oCr+x7ZbMsfFlOCYF
	 qIT571HBrqVV46IGeeTuHv6pHSssZxZuLJ0hwfreoL+/eZg4a2tncc2nFbJSLR/JwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b0RH0OOz;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F26606A31D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F26606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b0RH0OOz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598804; x=1824134804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J+WlNwWuoKeWuCkyhVa4PdEgoH8gcbtu2lIDA8Fudik=;
  b=b0RH0OOz0nsbIMpjx1Gsj9cHIt9875YmX0+a4NTvFh7ob8KzfsRVkFer
   QIv7/I7Rz3H+wOvzaMtgJ7KCdcDRBIhPpJ5rple5UvWqp0tIldobum+1e
   Db3ZbSIKoDhgdyYwlei0pfqRV41tD1mGDX+dSlhlMEIBKpS5GJAzsYVuD
   dwZxj6girhdlypjOcUEJsZWfXPc38lLEmtZ5KtBLFCIa/Kq/oAXQ0378z
   C2C6xrDFtmJ7RK5slz5n9YUAuhiJscwR7xt4K/Qc1o/Nk2l4x/ed8oXFF
   t81UgIZn8seOf4NbWhJxzz8RR5HKJ8VdEwPlxVTnisYFJBuwD7e8VDMnc
   g==;
X-CSE-ConnectionGUID: dnLa+27RSgaoTeB86+sqzg==
X-CSE-MsgGUID: dp9GzKM2Q4CBhYTCJsLoAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1217846"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1217846"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:06:43 -0700
X-CSE-ConnectionGUID: b0jlRbXyQhe9z6oqLooT4w==
X-CSE-MsgGUID: A5Fw+wnpTgOb6I5YjIWx0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3057252"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:06:43 -0700
Date: Wed, 21 Oct 2026 19:06:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 07/18] x86_energy_perf_policy: Cleanup: Fix potential
 ratio overflow
Message-ID: <atjjEDqQ35WUrihd@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <48429f39fed0928a54620f2ae830d6395088f853.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <48429f39fed0928a54620f2ae830d6395088f853.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:28PM -0400, Len Brown wrote:

> Prevent integer overflow in ratio_2_msr_perf() by using 64-bit
> arithmetic for the intermediate multiplication calculation.

I assume this even compiles on 32-bit due to __udivsi3 present in the compiler
libraries.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


