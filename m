Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F939656D;
	Sun, 13 Sep 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789287345; cv=none; b=Xu0Y7QzPw8MUVx4bgium5aLk0+Bh/8BqqmkJ7wuWu9+XOw/Akwu/AhELoQPT002M7GBPNsYj5hSxBn7tBgcQALGwHJ4jwagqbcTTS33Yz3HBFKmMxfrAW77171m6MXE+u2IRWGVl6wAUSWlj2BVZMptBUTuN53IadfHy+tCjvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789287345; c=relaxed/simple;
	bh=8whL5rfu7ItpVPYbWw8d50VN3Lnehka9GqryvGSY4ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErsKiJk6v7hsZzLW7yK4B90oFSwsHa1fD0mT6U5drGhbximByGC+IVyRRuGT8EavThr381hJluQ54rKKd1wxRJlEt6Ilqih41tZkJmiMStSnjVgKAaB6LSch5oeuDkAql0iU3bCvT32s4W6R3fK6x84yMA5hRZRbYOo87Z63d9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kA5xc+cj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kA5xc+cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789287344; x=1820823344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8whL5rfu7ItpVPYbWw8d50VN3Lnehka9GqryvGSY4ek=;
  b=kA5xc+cjP9fO14rL5tVU+aK0lxGwRVU9nHJJonx8RF77vWu9gKtopw2c
   wQc0LSltPLeX6xsoLFbag/1nuOC5hWzn24zJgCnsqvWAcDX31ggr+EPjw
   DP5/qzMlLGb6p8lUXA0X5JcFv1SFNORSVCuILFZkDB4ubgInZNXUUhFTM
   /8hnaV1vaWPy70B3A0ZUnBZB7gtfXHLfqjvJN/KfGGZ/ly3hTOCXFCkLe
   AYbIVFlv857N1s+M5PtyFD6+l/imQY4hzUBF9tGfjVRnaXShZXYP1Z0RR
   +rd9PrmtgOADCfhAzvawcKggHPyZFITHgOefvCzWDUJtQrjbiSiOyKXgp
   Q==;
X-CSE-ConnectionGUID: jIuG6uXNQj6TCFShrsOMmQ==
X-CSE-MsgGUID: AOqMNMHRRaOuayB6QvtCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="100012139"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="100012139"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 01:15:43 -0700
X-CSE-ConnectionGUID: boYKGEARTvWRjz0uMCRndg==
X-CSE-MsgGUID: uFkRTUl6REuTCmAbN0qRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="268666557"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.0])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 01:15:40 -0700
Date: Sun, 13 Sep 2026 11:15:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
Message-ID: <aqZbqbSsRlsjjRPB@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local>
 <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local>
 <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
 <aqRDC2LZ7m3caTSn@ashevche-desk.local>
 <5b54b08a-4dfd-4efe-b646-821adcd235b2@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b54b08a-4dfd-4efe-b646-821adcd235b2@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 11:14:09PM +0200, Armin Wolf wrote:
> Am 11.09.26 um 20:06 schrieb Andy Shevchenko:
> > On Fri, Sep 11, 2026 at 07:01:23PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Fri, Sep 11, 2026 at 6:47 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > > On Fri, Sep 11, 2026 at 6:32 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:

...

> > > > > > Is any user space ABI breakage expected as an outcome of this change?
> > > > > Not really.
> > > > Maybe makes sense to state this clearly in the cover letter?
> > > I guess you specifically mean the manually created symbolic links in
> > > sysfs that get removed.
> > > 
> > > If so, I'm not aware of anyone using them for anything, but the lack
> > > of observation is not proof of nonexistence.
> > Yes, I refer to the changes in the sysfs layout / presence / absence.
> 
> AFAIK those custom sysfs attributes are not even documented under Documentation/ABI, and
> thermald also does not seem to use them. I thus think we can safely remove them.

There is Debian source code browser (that covers hundreds of OSS projects) [1],
have you tried to seek any matches there? Otherwise the assumption that nobody
uses them might be wrong even if they were never documented.

[1]: https://codesearch.debian.net/

-- 
With Best Regards,
Andy Shevchenko


