Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600786;
	b=H+gbemK9QS7pkQlSgOVgARR6pLurPu185zo/4oyTXZWMEjyjHk4z4EzLzK+MFsM83CUg
	 +2fqt3/m/m8cFWoPZXVgQu4fba543WC3zjuAwRDKVTwDwq03oo6GAQDN5qQcaFrEH3n34
	 CmqI8p1Y8tePQvitoXk6nGOzG53FdBilzVopI5b5avXbcho0/+pIeo2Rs35SI7PEtNpYO
	 DWPo8QnvSqnJCQqogI+e01LVNlGYIwCieqPlYY2GnRaGImWg1EqjjD9iUtwYnUzUO7Yjm
	 YJyhJvGfvBt+Nl0He29TysqnomRfUBzCyP2zCtlteepxS17/FFajzERABPHH69MgMTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600786;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LsPcV0Eju6cuax+EIlw2g2HpvL58MMrMx7rim+08UDM=;
	b=AkgLLClvqCYxtlVKn+7X4Tkz7aRiJvM6pnZXVz+bwA5D2TqVSQqLZdQZdeiD/88jS6yF
	 Rb8rc6C7D/JcgXWQWGE/ZG0IXZZxCuKRm1br4wJAaVgVbgYVkXgbrJA9rhp0voqmsREBp
	 H9yOwd10a2wkdB3vt8z7gRQ9Ajm5OgbBBoshTFyJs7fbKnW3/VlHC2oCdJt9yaYty1Zpr
	 gX4mz4ZTjUfamNiBOR+odrqeCRit6h2y7I3pGb3n00bC064no1B9MSgoBFDNC6gCjZsMu
	 0bKHD3Y1tknKnAScdTqUIeoRviC0oDEZ36F3j3PeZgIF5HxQee1MBhelt43QkniHzkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQv4Rri4;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007F606A31D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2007F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQv4Rri4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600785; x=1824136785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zL0+iBqkXXnKURSUP6ltkLlJwsiDBDAoNDfjpbMfj/Y=;
  b=HQv4Rri4H9OY9NrAfK/aXSQFlUczWg6gF2tfLxaantsFaEFFdiXHp3/e
   bQIIPTuTovnQk9dWcqvA8yOQ2lPnJ+C9kNIIP/AGAmjVIs8H2ECgm8M/L
   6crR9hNuie7OkBXj6vG+UULD6ZZRDw/u7l0sPjH3qbsOOfY+ujunPxDEN
   mPgr1QtkjN19OkVbVqQsxJDLiiJDuQ78UdJkRqoPtAOx8lYOCgNyYBt/3
   Tl0aOqlf4cERalXF8VQplrwxnB30lhjt7RCGz5ReH2E25USjjErsMpbrD
   add5O8Of0GPCqI+1RANcDXYk88MHOZdLOflzymqOTueHGwVgDtwCgb4XC
   w==;
X-CSE-ConnectionGUID: nS0/E0T9SNirZfg4yBUtKw==
X-CSE-MsgGUID: DwEgKAGMS+mcaTzgoW1gGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1337274"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1337274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:39:45 -0700
X-CSE-ConnectionGUID: 0CnYjacuSqq4JtPOXm/fVQ==
X-CSE-MsgGUID: 8t+85F/LQkOp09aIWZFxow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3456188"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:39:44 -0700
Date: Wed, 21 Oct 2026 19:39:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 15/18] x86_energy_perf_policy: Cleanup: Constify HWP
 strings
Message-ID: <atjqzZWQtjTll238@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <649a4580260df004c304c46da6cad8af1c609a11.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <649a4580260df004c304c46da6cad8af1c609a11.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:36PM -0400, Len Brown wrote:
> 
> Add const qualifiers to the string parameters of parse_optarg_string(),
> print_hwp_request(), and print_hwp_request_pkg() which are read-only.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


