Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599592;
	b=gzaZG9/KTR1gW5NDmUi3431dBQZNiW35Okl0Wm+zpIdydTB9uFFdSHAIqsLZAxElGVmM
	 EtHrdEBLEltBgEY5dT99Oh1uFrFpQjTtk8833l+7mrnr1kHb+hhpPsFqUIfnY4oQywM75
	 bNTv7Dqi8zlra8B2p7sbvssyoERVqnNPuMi7tOGljX4/a9Nm4n5SYSNa8EEKhliC/hkMd
	 Fp4LQQ6C1B7tbM+YkklZElp2GFQ6SqsrCESZ0+VXbVeLivntHyZP4HQhfG05yi5bfVv5I
	 WsyGThq8OKmJeAoMDaJFGp6cIWdt0MCETojWnDmORBfh4eNdNZybLvsv3bB7CrF9A8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599592;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PIIF5Trljt383YJDo94CSEil/DGp1T+69iOsiqAWxKc=;
	b=2yK5rphNZo0IEsClLIf0l3ERIljSk/NymPN+xdl1ZcmRyyybevWumzrxLDxNpW1qeLTh
	 zUeDx90kWwUoyePihe84i95RkywRZ3pw8BG76MrULMmmBtlFdUHxtMXJfha+4lUGSwZOS
	 wQWCGY6YgxUVgtIvIhxSFi6zRlIC5br8yDu+S2enftrro4Y7o3GEgRkWQkbRHTSk7PlOT
	 KXJ09bHm2A2+J//n3T0jRUhVmX6h4OuxBg+OR7XHA2+AghishgYPLBSWUvLvur5yYHEu6
	 DMD5fDZoSUHd12vQqdnS2E5DSMZ1JCvAPxfoTnLDbAcGlJHB85jBGUI6Yg1gFKB8T7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WH58OTHC;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDD606A31F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DDD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WH58OTHC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792599592; x=1824135592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SaM20yesHaC31d4T2KOEvuHaXOAD1aYOLj+Xc9HplVM=;
  b=WH58OTHC4lwO+o6JW8gwCItuLlOQTkFA/z3mKB/JzFHF+7ylE2ueAR/B
   cTyNt6Gp7nbXdLNMEOPMQfEmWl1mPAa/a06somp0F+rZ4SS2g8LepwpqF
   QYgE6kNbEcSpxnatpKRpvjHsJ6v4OaUC5LGqS/6Dr2wQW4XZBeBHDXwOf
   zGqt5NzJ0DpSVKZ4zhAjXNIj/hoTUNfGMRJdZjupw+lxaYBHAGklYxRyD
   CPBs62rZnB1CVwz5Tj+sn97nrG+suTTDmKJkLAHHEPcUnNgU99phWwJFJ
   OqvJCW062mJnVT/fdyeCP8H0rjzZV2s7A3Ftb9aBkqMbiROlYikasyOgm
   g==;
X-CSE-ConnectionGUID: kSXRamc4TE2iCoMb1dKjSw==
X-CSE-MsgGUID: J3zv4fKhS/Ok0AkPVeOAyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1226805"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1226805"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:19:51 -0700
X-CSE-ConnectionGUID: YtQR/QpPTd2fq3IcpUc3VQ==
X-CSE-MsgGUID: 1zYhguuVRI25OffRp4Dr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3523566"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:19:50 -0700
Date: Wed, 21 Oct 2026 19:19:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 11/18] x86_energy_perf_policy: Cleanup: Check fseek() in
 VM path
Message-ID: <atjmI7mRNEDDxiGw@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <25c6883177af543bebaf92443c8cfe85b621ded2.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <25c6883177af543bebaf92443c8cfe85b621ded2.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:32PM -0400, Len Brown wrote:

> Add return value validation for fseek() and ensure consistent
> resource cleanup on all error paths in err_on_hypervisor().

Makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


