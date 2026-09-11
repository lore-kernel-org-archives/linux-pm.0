Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47444E053;
	Fri, 11 Sep 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149972; cv=none; b=SfNPOTyOriisL4EEI87TTtEDbJYz6Y9S0nCKcqo0T7eKHAfynixZNaOcXLurJbl8/q/0/qv+cQtu3qShfkUlM7D3ZN+KtOTiXtyN2PEcA+uZQ1fKMFTBmkbcmr0dUweHo3ocQxFnJWT/VTeCE5lMNcL2O/TkKvSUH4pJpAjqujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149972; c=relaxed/simple;
	bh=RIAJ1PV3nv5I8/lLBujjS2o1eS48nVJaYPxJr2KRFok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psH7k9fhSx2vXgZKTQYlr/vgTE44b3HLy86PzIjABWb0g68oqtIb0a7GcD1FHABuE2HB0xk/gPLiDqxhYq/+Q5TCwNhez17Oiz4DEMpTbXzMDQDc8OKQ1Z/bwd/pXF0r/e5Q3B1W0DWUhwWplhI+FfgX3rQKWqie7mvwQKFVtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeD4QeDy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeD4QeDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789149970; x=1820685970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RIAJ1PV3nv5I8/lLBujjS2o1eS48nVJaYPxJr2KRFok=;
  b=MeD4QeDyFc/6aiFkvZL9RFuZnLDn0vLj2zfWWknZantjO+D6sXMI3wdh
   YMgSPucaRtyy+uI/OAdWgMmO0xH9ApPmvE9sS2weumHDRS9IrvklXxGqf
   IZmlX3eUIenE78LDgxDvPZSL68ypinIQeV9yONv2OWV1oVI3uSH62FRpP
   6xkM0XikY95T8cWLvzUrkXClc4oetPj5BtVj8jMm9i7cr1N6rYI/q3CQz
   a/iFIfI+pe2zUOrx6SG5TbweSkPE3ZSOUOgEAM6AFP8ZKNeyZTae2EeaI
   F1eUh7Gcf1zL/Z13XFZc1yfOWLIR9XkpAgLUK8ULWwqZQnNaT5IT8CMx0
   w==;
X-CSE-ConnectionGUID: e9qcfASeTRmfkz/PLDYevg==
X-CSE-MsgGUID: agSkxulxR1eLlecG/Hct1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100778352"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100778352"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 11:06:08 -0700
X-CSE-ConnectionGUID: bpo89nF5RxKVCMTQGkNxUA==
X-CSE-MsgGUID: L975xS5oR9mIbYqMBJbjMA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 11:06:05 -0700
Date: Fri, 11 Sep 2026 21:06:03 +0300
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
Message-ID: <aqRDC2LZ7m3caTSn@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local>
 <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local>
 <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 07:01:23PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 11, 2026 at 6:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Fri, Sep 11, 2026 at 6:32 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:

...

> > > > Is any user space ABI breakage expected as an outcome of this change?
> > >
> > > Not really.
> >
> > Maybe makes sense to state this clearly in the cover letter?
> 
> I guess you specifically mean the manually created symbolic links in
> sysfs that get removed.
> 
> If so, I'm not aware of anyone using them for anything, but the lack
> of observation is not proof of nonexistence.

Yes, I refer to the changes in the sysfs layout / presence / absence.

-- 
With Best Regards,
Andy Shevchenko


