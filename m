Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B13033D8;
	Thu, 17 Sep 2026 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627457; cv=none; b=aG53miIbqPRHW06kYGxOCVjAm1jJpzTTAwyHFwAJ/Tqy/9Ua/reRQDPSjq1PjVS43fRPOIszL0uiGxU66+Ub3QV53NOVXCz0WbirELw994/40oXn5J+BFC8IAzx/AFmchLhxwWq8DkRXQ8YrvF64+JCCETUlpSQbCCz7KLJSdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627457; c=relaxed/simple;
	bh=kKeXnN0zIIBMSYYU6iSXfCRynVVy2++cIQKazYFUdO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mevWJuxTV6qTkA/efiQi3V76i/Iv0MnimwR5EIkmzZvQLdpyZwxzZwiealTvtsIrB1rPCkwVrbbqxUZC475pMEGP5nFtbk87U5SZby7MjIQFwdWR/VvGHDf25iHGsxUXHEbuePjfr7kMiUn/dq38fbm9qb5/2DSQ3wTPJWbboGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1tHXk3F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1tHXk3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789627456; x=1821163456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kKeXnN0zIIBMSYYU6iSXfCRynVVy2++cIQKazYFUdO8=;
  b=m1tHXk3FHIjn8PDbxjXn7wMMR+FgDHBzgRB89IpM+NbrnDrrSXUiwT4A
   5rpu6MoqkP4x9zbP6mtGJA8b/uT/8oGoVYMAkXoYDo+SwmfPHLvlW6rEc
   kynGFELxUbKb/QnyLmRl7XMrwAK5EpakCOlJuaWyOOkbe3t1nFpsp6/jW
   YUfRn5BVu/EvTD3Z6LOeEIrr5/mR/bIU9sn1TYuEDcJdrWoLZed+TEV5p
   vdEUueWzQfnaYFKb67z34/DXYdlV1Roohz6sf3KBasdqd7Wz8BCpmgSJ5
   rkWVflSUfRb2t+v3L4BbxJw/Z2dRO8WmfMUCm5ehpbq+QnFID8OkVeGQ9
   Q==;
X-CSE-ConnectionGUID: KJmU9cf4R3iLlkIWFDuwsw==
X-CSE-MsgGUID: QCVRqtw4QjOHkCRcp01juw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77580794"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77580794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:44:15 -0700
X-CSE-ConnectionGUID: M3eLIZyxSO67kS4EbnJDkQ==
X-CSE-MsgGUID: /xNhXOuXQgmgSrEfv/zvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269905779"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:44:10 -0700
Date: Thu, 17 Sep 2026 09:44:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1][linux-next] ACPI: fan: Use __free() to simplify AML
 error handling
Message-ID: <aquMNwJmB0p15TTv@ashevche-desk.local>
References: <6029013.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6029013.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 09:42:54PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Introduce acpi_object_free for freeing union acpi_object objects
> allocated by AML and use it for simplifying AML error handling in
> the ACPI fan driver.
> 
> While at it, update the driver to use consistent error values across
> all function using the union acpi_object data type.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Applies on top of
> 
> https://lore.kernel.org/linux-acpi/1965933.tdWV9SEqCh@rafael.j.wysocki/
> 
> which is in linux-next now.
> 
> ---
>  drivers/acpi/fan_core.c |   80 ++++++++++++++++++------------------------------
>  include/linux/acpi.h    |    2 +
>  2 files changed, 32 insertions(+), 50 deletions(-)

Statistics says for itself, nice cleanup!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


