Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44B31714B;
	Fri, 11 Sep 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145223; cv=none; b=q57F7W/RyIXyk7u7WfRs+ZMFPFqZhwS1zdYk9AB46f/RR4yzM3aWKTrQoAMhZD1SmJhisI6+QjisDDxyXjGQAjR2FYfShjtSLsF+qeErnFhAu2scqlGELvdAB+QIchiwZc7DiAviOhsh/CZ90/EqsRqlLcVCxLQtIYA3CiTpNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145223; c=relaxed/simple;
	bh=iH20cSjE1fWTpvYdC8EyISA7flwjJKpSj+QQr7/M1bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4vl449ArF7yT+3T3rdRp0CG1bUALsYtVQBhPn5JNdiXJ020rS6WpjZh2H3DqZ/jHZDe4mFtkFObwQHq1D3hNOHNN+Cna+lXsMpRM/YiKVHhHu/T5P2/GODfrAxQRlGvyp5jB9WV43q4BUlaVgzKunY3r27VDmD2MHuqMJ94szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G21JjmaR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G21JjmaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789145222; x=1820681222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iH20cSjE1fWTpvYdC8EyISA7flwjJKpSj+QQr7/M1bE=;
  b=G21JjmaRzVU2uThpfo1XB8sJZK2VpyW+a3EyuDACBDIKCYCia9GftQLX
   TEZJQyDzYOGJQrhwa3AdpDS5Q83qjV2c0MDkWO4VARrfw/SnAYcGj5Jxo
   5tEkF0CTn3JHxfcXin6hFCwsB7LZxXeacSxRLPEBRP7dzqbTKF5h8G7hS
   kMDCXfWSQf3JvON3+lw9RZbWrn054KWvt34UhggPzQBVraLN8P7SMtnj3
   VsM+5aGdhHq5KEUFvvj/8xMyptXLkxapLq9le8Z2yeUTHN1EbJvcaTekn
   VOyYm9xLiw/WI9WB9YcZ3cRwtVGsjHNYjUxaUW0pYD6f245AVx5RHsJ3m
   w==;
X-CSE-ConnectionGUID: hb84ba8wQk6UbADLlUFEAg==
X-CSE-MsgGUID: 9FlDjO1ySQGkFxDfuR7iMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100772499"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100772499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:47:01 -0700
X-CSE-ConnectionGUID: vWfIzKSqTKSl6oQA/Gdz4Q==
X-CSE-MsgGUID: bhCNUBfoThOhVTvLRGNwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="275722256"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:46:59 -0700
Date: Fri, 11 Sep 2026 19:46:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
Message-ID: <aqQwf3y66lPhTTyf@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local>
 <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 11, 2026 at 6:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:

...

> > Is any user space ABI breakage expected as an outcome of this change?
> 
> Not really.

Maybe makes sense to state this clearly in the cover letter?

-- 
With Best Regards,
Andy Shevchenko


