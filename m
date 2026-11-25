Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632298;
	b=TVqLDhlTlx8VZhJYflHBezF+yy6ktQUPgpZwpCID+JVq6VhrUsFHwYcwEViDdcYuWCyF
	 x7WmKXMCnZAqir2zOQ+WMPpE+vfdhS5NT/9pnDZ6vUaYUElV7xbWoEOG5FccKKkoS7bKP
	 kw8Swts9Z82a8HqpY3Uthw+rHwibaWAAaSztpWPolSc/lXdNOL5THkHccZumpgllxgj2t
	 RXwP5svg1pOOoExT7MaLhheWgFWJZlSV/8QhdmNdGxQuNphcOb62hl0fcimqY6KZ5xA/D
	 Bc2QhsMOtF6aeq0od985K3VUhm3FRhzgIw5q17Mk1GoGT/51B6eNnorsCuul7hs3pCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632298;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RznO+xGbhGHVbBfVIylztmMidSyy4IbiAZE6wY9q/cc=;
	b=qA0ra6MwAVOwHX8LKmx/RNwkHqyIYkHHevpZeb88Tjvx3Nkf2XP7MPfqRlE/rR5e56Z0
	 uILMXepfxREUIlupzRAsdAknzu9w5UEeJUrDAXmEQnveStzyrg01gww07Fj8x892t0uEP
	 qQUemj/6IY4xMyHDBztCXk+yj8bYlN6Q7IZ04EIv4CuJ0Fx5v4m7OYtO9nmJmlDoyp2B7
	 bnoaLs2PfwN0MzLTsBFi7olLl3KFY6eKVjYqMaET9kOP5aDfsFFiaMxZGMIcM1aKsH94Z
	 76m65SGC76OSzQnzb0cxsdQZPVoYPIWa/QJk77s4UxDc5MyIEWxj/yjlD67r30L4POg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzp7CTGG;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66E606A68F;
	Wed, 25 Nov 2026 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D66E606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzp7CTGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795632297; x=1827168297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTSlISAoScwHyQtpVTvYz6/o13sEfr2B/0399pvL3OU=;
  b=hzp7CTGGx7jnFUdIKyD67+iLTFj45ydDL8pI88DXgnN/bGkgRJ7IPcyP
   Npxw6eFSlsc+l8VOD63AW9MNFB1iXcfhR7JzJCTq1ayN4P4iw5dnz76N4
   tGlsTgwvS3RMzYh9ccktkmystpIkEPRJnAsFWosFr1SN2ndf2vFjla90G
   j3zRcFxuX5NhUh5UelgFI8lB7EtCkEL9uVs4Loz4xp5brMRRh6/y2bBaG
   FDa+HOg8aMR3VgodmRGHdHGg4gQgVyMBJg7MwbkaxgJhOCMdkYNH0cV/0
   mt0PHo/AdVh4qb936+JEiSSERBRi/qSa4cUrspYWVcYFXSoOeLFcrvqW+
   w==;
X-CSE-ConnectionGUID: XnCMgxXCReSizLEKYwPmVA==
X-CSE-MsgGUID: Yma4C00RQAusy21AqJ+P1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4580268"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4580268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:32:13 -0800
X-CSE-ConnectionGUID: m6tiOOLrR3W/nERm0t1wsw==
X-CSE-MsgGUID: zxH9QAMDSAqXHWMMbfd0xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12252120"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:32:11 -0800
Date: Wed, 25 Nov 2026 19:32:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v2 5/5] ACPI: fan: Use acpi_handle_debug/err() for
 diagnostic messages
Message-ID: <awcbme-3ek34er9H@ashevche-desk.local>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <2374022.iZASKD2KPV@rafael.j.wysocki>
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
In-Reply-To: <2374022.iZASKD2KPV@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:10:29PM +0100, Rafael J. Wysocki wrote:
> 
> Use acpi_handle_debug() or acpi_handle_err() for printing all of the
> remaining diagnostic messages in the ACPI fan driver core code that
> are still printed relative to the fan ACPI device object.
> 
> It is better to print them relative the device object's path in the
> ACPI namespace because that's where the problems actually happen.
> 
> Also, add FW_BUG to error messages printed on errors that cause probe
> to fail.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But I think we may gain by doing the same in acpi_fan_dsm_init() and dropping
no more used 'dev' parameter.

-- 
With Best Regards,
Andy Shevchenko


