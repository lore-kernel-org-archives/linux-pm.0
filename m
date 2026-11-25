Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631571;
	b=i9nxLk499RC5E5pF8Xu98TXUqxihzpxeuz5IzmYuxSTmQViBqmAjK4FagXSUXsd2Os0T
	 gpeqvrabeF/cojEiO5PCB0kNOR2fybQY7cjRoADVTjcf+0mOhac+1HsX9lNKXevBPKTxl
	 NKPtNuZRazPpgPl+y1DCO6me0cTV41QpVOTIdQfIGf1HmxK9iz0O9ptgBf/eTL+Zn6e7Q
	 NQnFU5309OGRRaZf7on4pkTIacxYThpdsziEFiyoKs5ki+HdVGvua3G2PtlHDQu44wpyD
	 0y3Fgk2HbI2yavH3cSeNplV3HBJAj4cqEo6khwP/Ljfj9S/TB+Fy5BdH9mXXtI1fVOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6vcYIopAlSdCBG3iij9ftYv4p2GVd8LK3oEq2Puz8Xk=;
	b=oflPrpzLSVivS8b8U6tGDKSCtvDgXc4qE3g9Hci4di5sdVMBShR+EBwAX9Xx+v9yWYCl
	 toPPUGznnF6nVXZl2x5g/y6IV3hE1AGGipmvzKExO+4A1aYjLW9rdXprT88XyP0Cxz7MP
	 PaRy52BsVgdEMnDyYfJCZKgS727w7S66jm8nhJ84jGbYGmc1AQFfjNiBWS2tQpeHWCZxw
	 VVcLxUNUUs9FjyuJVUCqnf4DC1TMiztLpKR7+5xaNYaIjIf0FI13ug0TivL5e3dkZi6jC
	 9MxHtqXMv+lXZmFEzn8JTaoV+NhGuq18aSrO66jL4uxWuWbhpVjSakWd308GSl5WwZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MTm9SYq2;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20343606A31E;
	Wed, 25 Nov 2026 18:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20343606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MTm9SYq2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795631570; x=1827167570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Pn0whqzXB7KGHuCEm8eiLKyaCLnKXiiHhwjUvWbWko=;
  b=MTm9SYq2UFg0s11uwY1QrVHGeLvDBZ87HXSw2aqCl15b2SEVAcVP6Dyg
   bvTDE7opXJjJT+JJz9Fjrzfk5BpcmFFJxhHZbr/qUibj6vvKs9AxHai0B
   u975E0u/rxsdBA78YXPu4Br4ARcL4Vh7OJ/vPdnBAmGc3ZxuVEevNDrvK
   FIEopQGGO5z1GsNPZMcqtr9U4TYI1uEW6micIpjnSIUa4uASMmg3ngMXs
   fLO3uFGQW1hq9ZYTbsL6oT+usL43SSy34n9TQ/K5N9lmGDyj1KA6J92oO
   yga2z4noRMiW0ypD1UtorTULdVrUPygiIoLcO+71l2p6kJ0GWs5wi6sk9
   A==;
X-CSE-ConnectionGUID: Pqy/ErmrSwO7hf04kr86DA==
X-CSE-MsgGUID: vG3LIUYnQMStaRpJlvZvHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4440062"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4440062"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:24:34 -0800
X-CSE-ConnectionGUID: Z/cYjMBLTJiKfDeepDWGxQ==
X-CSE-MsgGUID: idpXdOpbRyyWvdeafX7zVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="13719093"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:24:33 -0800
Date: Wed, 25 Nov 2026 19:24:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v2 4/5] ACPI: fan: Add local variable dev to
 acpi_fan_probe()
Message-ID: <awcZzgloUsysVO7s@ashevche-desk.local>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <8764237.T7Z3S40VBb@rafael.j.wysocki>
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
In-Reply-To: <8764237.T7Z3S40VBb@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:09:34PM +0100, Rafael J. Wysocki wrote:
> 
> In acpi_fan_probe(), use a new local variable called "dev" to store
> a pointer to the dev field in the platform device object passed to it
> and use that variable wherever the pointer held by it is needed.
> 
> While at it, adjust a leftover message printing statement that printed
> a message relative to the fan device's ACPI companion by mistake and
> remove a redundant error message after a memory allocation failure,
> also printed relative to the fan device's ACPI companion.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


