Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599068;
	b=vhpASCwD9uVGm6sbg5AS0iFwj2VseT2T+22ZuIT+aAd6ZX5yJ+tgpRU0pa8PdyXbBLXW
	 kLLaVprZh0EyVhTEtCa7n9hjcQUFrOUYLP/4ytQpMtZ3yrR4MqUnCLFA0FjWaSkTaHWoz
	 epOdpaRaXdpAZrse05Mdcsi4UCkfqOVZvOqbbUeZeuUUAY+sAoiqCwT1zEtEfZIAd7MWJ
	 ZrCd3t74djV8U8lOCUY4IvlLPQFG3rVQ+1hp028k8HiCQ7Exf02sZmX98xngF4EABK3dc
	 /44E0GJBvdVckgtgG5jTaXLH0SGbPo1mFPEAOwlQGlLy6b9Ty/jbBoFVgsZyqlSQfpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599068;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4SGfY1cm15sp0C8xDKx3UbaSEPi9xht+yYMr0cmzl+c=;
	b=KZ472B+0EOlOJ0JgTSlQsvjTSLF7RAygPfcsf1r09JRoF9oBX2cq8a6D6I2VubKz4vH9
	 rV1+ZBkX+sEjk+tCHPE4vgNAM64k8ZMBeNqt932tAZW467pJumNCXixwigDzGtM0VlrFi
	 sA9/nPFfzdZzdsCI7+jafq+wrUf+x8eoK4XWviYp7oEFyLMLUqK6dA5tQ4G6GgOBl7XJg
	 +nRxZ+pZwuzRbdYOAauVUnJ8IWp4vK15uroG4skC+c153VCdx/lN89v5AUQrmG9bwm586
	 JeAIOMRqpKbnfK8TkTlicxT0K7HW13JugnhPaXTyx5Lj0jWfSy6pq6iaHGnwhloxPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=epQHF1kC;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EF606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=epQHF1kC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792599067; x=1824135067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ThWCXahzB9I9S2P3JrLe6ZOfZe1UrZNHBXwHl5UzqU8=;
  b=epQHF1kC/HE4Kr7nnddta60NBVW3NwzKlMDGNPhiRaPAfpoAqTbJ0UdA
   rJfrG+8NRVE3pPyZGbrRF2LcLDpaTZBYe73Yi3id2K0zKNphNoF0FDxDp
   DCWJxUWonb2fNyu8z2Yh99FJgP8I69fPOg3usfIsoNy1S0c5q6E/qhHqZ
   FdkKOcDdHfRQZRIdkQKhtdwxitBa8gk8bYWhVi9mJ51lHY5q3O1mZNJWN
   f7xv04dD6vFVcme0lrV/asqU9/AOv9lfzBZP4OcsAiPZhlNc46kh1Jvz5
   vlfdCkam8bGw24nHvhHWBsyPawRo/WDFy4GlY+JhiMCZK9OrTV52YDdlt
   g==;
X-CSE-ConnectionGUID: NdrBqZjfQgSQNG5g7dAYwQ==
X-CSE-MsgGUID: 7lhM3Q8MRUaURTGluCnqCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1205636"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1205636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:10:56 -0700
X-CSE-ConnectionGUID: 4UFP1AS0T8yiOBtuN4KnZQ==
X-CSE-MsgGUID: nFaf6guJSbydP8vTXYrmiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3186544"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:10:55 -0700
Date: Wed, 21 Oct 2026 19:10:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 09/18] x86_energy_perf_policy: Cleanup: Define HWP window
 max
Message-ID: <atjkDC1oJ2BdLOYX@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <3936dd5ee21ebaf399846da53eec7d870a58651d.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <3936dd5ee21ebaf399846da53eec7d870a58651d.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:30PM -0400, Len Brown wrote:

> Replace all occurrences of the hardcoded magic number 1270000000
> with a named symbolic constant HWP_WINDOW_MAX_USEC to improve code
> readability and maintainability.

Yep, good one!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


