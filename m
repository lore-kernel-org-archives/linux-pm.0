Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E04A4839;
	Fri, 11 Sep 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144049; cv=none; b=WojwxPXRGysCuyr3Q+KLpv1zIevRoUqvDeybkCPOJFjHTn7enl2TAUelvB6fEQPBiXpbdQFyIZH2q5K0ZemVDJba1BgrBvsDyRyHTUanbR3bWS9c5UsbOmg88R0uKz/8S1nIi3jReyDbhLgAzfYmE/HQXxIMccBFJ/QIg8RsUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144049; c=relaxed/simple;
	bh=b+IWU51OnllHs5XfURcNBNiy5eIlJ0+bTwXhcH9qCs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZkafvL9d22EwFJT+xqPMc7EuZ5eT422282/X8mXEopTDuAytSaBXxa/2AOs6dwAav7OZLtasi+96cb938NTTdRnaxs/kruv3qf4FV21NVQv5B1R3zgmZPxkfzUFRFxfrgRaJS4C6UrJAEbGq0rlPnAzUxoY1ih0kB81gKXhLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3sgZyHe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3sgZyHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789144046; x=1820680046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+IWU51OnllHs5XfURcNBNiy5eIlJ0+bTwXhcH9qCs0=;
  b=d3sgZyHeTg2BhNOGnmscydaxZ67aBGTPxGHTOKly2S/UByAoJn8i0tzq
   aLAcS7qLtTBZJmv4xy9PNzl015xXANGokGsjHzSNIDnLkHsYJidxS/wna
   wVkfnkSUXwazN1AQ8Vh7e1C3i2hqdgfRxMQcMpyHJRNov615UqlCDALG/
   n+5GrUoIYKMbew30P++HalmBo/P1SjI388YlbeSHA6M6ZwCxPWj/nMlLn
   jgJDB7jbxBvpFQKJBGi5JTkufj9t3vk38WXsgPmwOUmxMQVA2YiWUegls
   4Hc62VmVDit/mHVZrL0a3SxBHao4emx4tQSBpONGafPBQkx3yZBdQBWYN
   g==;
X-CSE-ConnectionGUID: rSf0qbmWQ1Ops2ZCTuDJ8Q==
X-CSE-MsgGUID: UQKqShVMTNyTwIKeW/eOhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89482545"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89482545"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:27:25 -0700
X-CSE-ConnectionGUID: HrctSv75SzKE8KclnyCgXw==
X-CSE-MsgGUID: 5JePjAnBSv2GkR1x1eSgTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270587050"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:27:24 -0700
Date: Fri, 11 Sep 2026 19:27:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 02/10] ACPI: video: Fix backlight unregistration
 ordering
Message-ID: <aqQr6bZjZziZVPyy@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <3429468.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3429468.aeNJFYEL58@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 03:01:30PM +0200, Rafael J. Wysocki wrote:

> In acpi_video_dev_unregister_backlight(), the sysfs interface of the
> cooling class device may access the brightness object under the
> backlight device's ACPI companion, so that object cannot be freed
> before unregistering the cooling class device.
> 
> Adjust the code to take that into account.
> 
> Fixes:

Fixes?

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
With Best Regards,
Andy Shevchenko


