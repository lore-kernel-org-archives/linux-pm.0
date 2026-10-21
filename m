Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598242;
	b=3DfzWvpukxQ9r2/gFOc+bwIDBwi6t8kyC2CUTolMJgZyKWzE+QeXzHgaxin6R/wp73sR
	 FUElq2ZcAnR8TltaVftLmIXKo6nubt4jLdDAi6XiXoCC0T4gC7f+wtGJ78qCFUTd1oQZH
	 781OCzyU1KRpsC0OAzHo3PMWjQfypgsOsLHjpmZx3ZgBb0DZh0FP8e100WyOgPu1opYeg
	 SlhhNMVvw2UQOS76aFMpTTihUJ+xdQecCHKG6FeeuqFQGjVse237PZAgS0cu0Ga78fwCr
	 Btb7wjf8/Hf4UIkDsYvsjwMx5ZM3UsZir4mjVKdMtyB4vnKPSV0MXAxhyHaVZZZyP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598242;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FGVpAT+K9upIjtv0qiFtNCUfVF97/mBZ2MFxYBgXzXc=;
	b=wNDjC43e9D6tcKOky85RyxZ87VLCgEjri8jXHgpeST6N8Rj97zNhtf+mZN8i2x+lH8iE
	 ju21vjPsgPdZn3nsq0FT7xOtkYrVLifF7qPpsgK1KcGb5LDx2G86W2iMqamOH43s8JIBN
	 qPtnH83TL0vH/Ji0K4SHfiPP8MYVcMENljNGGeicLqaAucg1o4JZn6OZJn/qO6cT6NOIa
	 9/PvqRZ0gkaEfGiUSYcK5MriKHLV8U4izemhUdVDvsLTaul53XvCDNaxiySCZBw3EtfWw
	 0I98JbF8EW/6uMvhjcu1O/Jgdudr6q/h5Sd4R6aDNGfF3CJjOyTwSHEAEEKbVQWJ+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=io5HQqvw;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE9606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDE9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=io5HQqvw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598242; x=1824134242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gl6KnONxBxEwEkuWgdlY6FiolQCIRZETCeU88TY2VgQ=;
  b=io5HQqvwiw9TAbha5n0ltpgKVE8dfwBStwsELBKl9yhiF7pcpD7+HfNn
   sfCcJqEtWJ4rIxKw/A+hqbmb9+Ui5H6/icvhWE+1XTzsEoOY+mucDtGJ4
   8EVX95W9+4BSw13BvSBFzRlMZnNTc40PgkjIKc/9ohHLaSoHSioIaut2e
   K6prCGrWJqPsezqfhQ6PR8UeWl9Sy8SENa47RRnn+hbFH5oSRt9Xjv+KI
   pBFvgVLfJe4hKN+HKiXMSA2IEK45HJNZNGF88uAMy1V6BHa8lbfJHY2V6
   +HGVM9WELd10LwtH0lOadpo9M1Xm3NetbqyeWNf4HBrE/tjr7mo/7mtlg
   g==;
X-CSE-ConnectionGUID: f+f6RlkuTs+4L15lpjf8Mg==
X-CSE-MsgGUID: 6FwmnFyvRcivV6h1YcofkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1207425"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1207425"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:57:21 -0700
X-CSE-ConnectionGUID: tcQNrviIRE6UsTn2EKc2Xg==
X-CSE-MsgGUID: t0T1/Y7CS46+d4HuzVPDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3185839"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:57:20 -0700
Date: Wed, 21 Oct 2026 18:57:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 05/18] x86_energy_perf_policy: Cleanup: Use snprintf()
 for platform-profile
Message-ID: <atjg3XnQTOwNu9zH@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <8879d2b05a53d7e5b892639bec502b875c690fc2.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <8879d2b05a53d7e5b892639bec502b875c690fc2.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:26PM -0400, Len Brown wrote:

> Better hygiene to use snprintf() instead of strcpy().

Yeah, since we don't have strscpy() 2-arg available in the user space tools.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


