Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540282;
	b=4NOYy/xY0e0Vs32ADEzwnOkw7y1JA+kq8Z5868T/EZuG3gOfhz1k4lKRtE9Td7fi//Or
	 Waj94voYquiFaLwRKrNyebntPV8UNzh6ZSG4xIS0wLWip6jkMYDPnkLzpu0Bxwtj5bxRV
	 83KJnlByIdYkt2f2lgLCvsjGzMNFhRvFb9rLkL8OuG9jBZF1wZsxelqXMa71IUhZNm4go
	 cObsjES6muM3ne2XiaWbWh9si5RLhs5+vN04c0mP2geaaqzytJsHdDhfw5zakpySHaG5v
	 Byg0KZudXOe3JDRUKsY3yiavz2XniNx0oUsEn18dQn5DTnp6FNsNdodSmHV3S6FTpMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540282;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AKD/72/EfVRdxYFvWuN05kqniSg0DYqRy/9GFlTCCAc=;
	b=eJaNTcau7l/WeZsyfoFPMoMWhMVarg/LQ1A2rzWf1W63c/P1w0+FjD+0kojWDCQzEDP6
	 TILSubVWoGAPD1V5ohsu2hsLpkE11oEtQa6RZruqyXQsZixxLPNMcC5BCCGhmJ0+Mh0ia
	 iseML6nI/+9lnFIbjXztuC8uyvaqiV9pyxxH60/Ddtxwj1yyfY2JqFtE94smOsXcHVM2g
	 rTnP6z44cxqyO41zmNwc4zXTIH8RXSxd6m1fQoOzZPCHVxego370OlqtRysPr8IteNveH
	 naHv2qRzr4qafHk5oJ9AlM8vaB14yv5C0uRn8GhiaPaY0Ql8coexQ+KtDDcTIzoiuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LW3wmbQv;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AF606A6B0;
	Tue, 24 Nov 2026 17:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 594AF606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LW3wmbQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795540282; x=1827076282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yA96lTi5CFzU5JH9oySsecnxSF0r2q51zcGonMA8scM=;
  b=LW3wmbQvXlAs0T9QcB0KxrU6iuLUfWDE3+tSyvTOXUYcEa/WOf3yQwGq
   XddKCtNz46uPAbZq7DGA2k+w0VqbAIPC70vauN+bjkv+7ru4p97mpRl3N
   pqvKS12ZTIhFURxq3MSERoOfMhMnRGGm4IFTD8oMxR00ENh6l+zPldbrI
   z0OWajf51cbh0NLqi7ruPYu2KJEPe3Fdq544FriIeiyfClxfh4sCYJkcc
   PVa1oftNwxLtjFER55hN+Vg1pAmT9Z/InEAqjlKHR6a1NmoMbxulrRnpq
   HKIG/xnTEUZBF0c/Pc0IxGYZXx0HEqxujgqUY//dHIuhc4Cc2nPCm688f
   A==;
X-CSE-ConnectionGUID: gJWDMhgYSAenjZdYWI7GQA==
X-CSE-MsgGUID: Qh+lqTFuS8WWhEZ4CAcoIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4242793"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4242793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:07:43 -0800
X-CSE-ConnectionGUID: xnenaHeCTvO9kEJmyVtN4A==
X-CSE-MsgGUID: GzWpVI1PSmO1nlagCqVqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11812462"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:07:42 -0800
Date: Tue, 24 Nov 2026 19:07:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 1/5] ACPI: fan: Pass struct acpi_fan pointers to
 functions
Message-ID: <awXEW2ZrwF3z1mec@ashevche-desk.local>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
 <9710131.CDJkKcVGEf@rafael.j.wysocki>
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
In-Reply-To: <9710131.CDJkKcVGEf@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 04:46:10PM +0100, Rafael J. Wysocki wrote:
> 
> Pass a struct acpi_fan pointer as an argument to several functions in
> the ACPI fan driver either instead of or in addition to a struct
> acpi_device or a struct device pointer.
> 
> This allows acpi_driver_data() usage to be reduced and some other
> simplifications to be made.
> 
> No intentional functional impact.

Does it make sense to consistently put a acpi_fan to be always the first
parameter?

-- 
With Best Regards,
Andy Shevchenko


