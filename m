Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3E344DB1;
	Mon, 14 Sep 2026 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360564; cv=none; b=TyOA6yqdc4vgfIctm1ZUdagWiSgRHci6WUEetvPhsjTo+mwA0+FuJfsIOqj39xG/3KZcAPCtwSZfDAzmr7b0EuqfRLPvhA/wW0QSHECFbU5rptdtX11WoO1Vc+R3F4AMc/Nbsma8DFrFIewbmUBt+NfExuYES6DDh6d3qpD2V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360564; c=relaxed/simple;
	bh=/MkaBP2BXbpnwAuBhsPlzxp3Mgs/EG6ZZrIvMRBC9sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfd4Z+yENJixhlxKeB8FN1ZXkoJdqnxqFRFVAF2Yg5MeThVp/V7UMPEAy13Td+LkV+eOWWULM7GnYYunTrBlvtI0NdiicxXfs1qN4gSvsGolltaADHKHb4rMeqVCky8YUQS6Agdoox6WAUHEFfD5f9qkq9dZj9J9F87JAMObyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt/0t7R2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt/0t7R2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789360563; x=1820896563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/MkaBP2BXbpnwAuBhsPlzxp3Mgs/EG6ZZrIvMRBC9sY=;
  b=Bt/0t7R2PAv2r5OQyGnfMSY6IxAPRpVl3Xvock4jd8UFZsLZWyP8TMGR
   CJbMOkHFShpOSSdGMV/FT2B9af66s/h6NMvEaesuvpkc+5mEoXerEAzon
   cLko5nfgZhiKUVdwavj9NJys8Z2jpFgkTe7Il7KExaUVxJ3iCGb4+97BX
   sQk/SrDPhwHFLawteRkLlUD0HUchJqS7T4E6JHNy4ANxzuNd+U5agcEfB
   9z22kYQwLqVC2lhZFL6Pwb+h7iJMQZ+2cRQCV7U+wNGUBcqJZzfJ9GwWt
   1wTO/cw2y/4WhddnmKrAklxbCsrMLQsrCwhw9CPvxWSR4aQ41V1oKfywH
   A==;
X-CSE-ConnectionGUID: sgryxnn6TXW75zPuu+3Olg==
X-CSE-MsgGUID: ip0WduhPTRKiqNxCrdPRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100306394"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100306394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 21:36:03 -0700
X-CSE-ConnectionGUID: 5im3CHrXS8emo4yEcYNfHQ==
X-CSE-MsgGUID: ZDxBqddJRsOBoqU8uFwD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="269253911"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 21:36:00 -0700
Date: Mon, 14 Sep 2026 07:35:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
Message-ID: <aqd5rhdaE_AIxMNI@ashevche-desk.local>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local>
 <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local>
 <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
 <aqRDC2LZ7m3caTSn@ashevche-desk.local>
 <5b54b08a-4dfd-4efe-b646-821adcd235b2@gmx.de>
 <aqZbqbSsRlsjjRPB@ashevche-desk.local>
 <CAJZ5v0j9g9Vyam7PnrGikYyyrUwSFghPk6ecXVEm9PN8z8tOHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j9g9Vyam7PnrGikYyyrUwSFghPk6ecXVEm9PN8z8tOHg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 13, 2026 at 12:28:05PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Sun, Sep 13, 2026 at 10:15 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 11, 2026 at 11:14:09PM +0200, Armin Wolf wrote:
> > > Am 11.09.26 um 20:06 schrieb Andy Shevchenko:
> > > > On Fri, Sep 11, 2026 at 07:01:23PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > > On Fri, Sep 11, 2026 at 6:47 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > > > > On Fri, Sep 11, 2026 at 6:32 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:

...

> > > > > > > > Is any user space ABI breakage expected as an outcome of this change?
> > > > > > > Not really.
> > > > > > Maybe makes sense to state this clearly in the cover letter?
> > > > > I guess you specifically mean the manually created symbolic links in
> > > > > sysfs that get removed.
> > > > >
> > > > > If so, I'm not aware of anyone using them for anything, but the lack
> > > > > of observation is not proof of nonexistence.
> > > > Yes, I refer to the changes in the sysfs layout / presence / absence.
> > >
> > > AFAIK those custom sysfs attributes are not even documented under Documentation/ABI, and
> > > thermald also does not seem to use them. I thus think we can safely remove them.
> >
> > There is Debian source code browser (that covers hundreds of OSS projects) [1],
> > have you tried to seek any matches there? Otherwise the assumption that nobody
> > uses them might be wrong even if they were never documented.
> >
> > [1]: https://codesearch.debian.net/
> 
> It is mostly relevant whether or not they are used by someone today
> and not whether or not they have ever been used at all.

Yes, my point is if there is no use there, it will be a very good justification
to assume that no-one use that.

> We'll find out.

Sure. Sooner or later :-)

> If anyone complains and they are unable to cope with that, adding
> "thermal_cooling" back should not be a problem (although I'd rather
> not do it unless absolutely necessary).

Agreed.

-- 
With Best Regards,
Andy Shevchenko


