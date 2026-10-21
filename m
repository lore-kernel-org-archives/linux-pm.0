Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600718;
	b=dVgMszlBS/DVcBml0Ff8fk04koSmIct8vmz2lR1GF9FDWGuvCb0miHbKjN7uk6bO9HP/
	 se7+55Za+F8+a8cvU73I+xFyi2/Jp9KoA/ex0Bj/KlNlUysBkaCEw3/nmbigpFqsxNX4J
	 md+C7YkX/dpCeVCO2dBNWJrSEv8hiyHDkzAEwVchJxDlLX8FBBTkpKPQTAS58a/wBVCIn
	 WNt79DK0xL4ZT6aCrdKHfBCb0n9K7NZV+OUdjfORA/R4EpXl0foNhDO+jkbXHWoypgops
	 Z9lxZD0/37H3TUvReT/YQvh9xPEyh51tJqZNNEkHZTea/TdP+ybH0muI1bhCmxScq4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600718;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zEdVsuOhAZq+EAtF7YIko5fCc2Zw+mgba1dGuNXUiEw=;
	b=PAZkVWTZTgUKJVWQuC+J+L4UZ6bi53cbMGLK+qvTilDAlccMZ5dlwHIO9u5p/ye8fsAv
	 uLwuEb1jV5s05yMxQ7saDikSGqkpm5sIff+e8xjFtq11RUuwG8Quo7jqS5bqAagrmQwAz
	 FD8AgSiLDVqntN0tJM6220Z7wnNbZaFpqeU1pRo+zQagQOgl3ehMpdCHplElxDqekeoWz
	 CTWI0+UIHeoZ34cf7t3TaT+JjbLzP//ohvHfVOzMHvJPdq7rZKWRSeyF88vRJ7cHlUHKQ
	 Y/a83cANQYy2VxCV3Q1Y+vgctDr9EsWI8VbqSR4uIiTwfLjv4EewhzQ+K3h4Zh+X4tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5hZ0mcw;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E4606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031E4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5hZ0mcw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600718; x=1824136718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FdtdWD1VAFcQp98f6iWeFVZ13UBWc96LA07DLerLGXs=;
  b=c5hZ0mcwYwhEsrOqW7fItI+/vNMKGWtjD3Ng6HCmOzVIOHoaGdn6fmHu
   VObsp9iDyJDTU/ecQVWpY8J5S/gKwMzR0X3ZL56KXlwB2Y5RmSiyBzpdG
   v+ZQ5F+y8NnncRqXejXOASPn6ORRV1O6Z2OMDZxC23q7RSELboSbalHRD
   kAz3KaV4CXcUXEUW+UxwSAOZWGQYnUp5zrnXnYijuNcxdGx3choe+sll3
   QTHHchA7ltKxFpvnyV2o2hykclA12nNPLWVdGHZoHgwCQ8P++LNj+z8Hi
   qV+nBzmexZCjpw9vOee7IPQh7Byq9fKNFDFmJzBFkb2W4s0Sk8f/nSkL+
   g==;
X-CSE-ConnectionGUID: hL3vyW9oR++AvNFSsJ6D5g==
X-CSE-MsgGUID: fxKJfqhIRdGlO1gj8T6iVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1343855"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1343855"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:38:38 -0700
X-CSE-ConnectionGUID: RC4eFt5sQ5KqNgok/Z02rg==
X-CSE-MsgGUID: tV836O22TSSKtth0YZ7Uug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3476410"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:38:36 -0700
Date: Wed, 21 Oct 2026 19:38:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 13/18] x86_energy_perf_policy: Cleanup: Drop unused
 signal.h
Message-ID: <atjqiXqnY3ydRede@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <42318073092d4c428096f0d600a0297060abcf84.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <42318073092d4c428096f0d600a0297060abcf84.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:34PM -0400, Len Brown wrote:

> Remove unused #include <signal.h>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


