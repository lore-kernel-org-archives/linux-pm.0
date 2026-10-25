Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963861;
	b=hXNE/P1LoTpszAyF8EJx2J90UuOK6rk91g4u146weSOL25zAk0IycnZGtE6KpNxokMuO
	 g9tDk8+bng0G5pmxzkG7AUPVdiImymUM6Ati9y6XhVIgNgv4mMumWWpQtVf0Tor2aa8rx
	 C9FMf8PZKt+cLsFaDjttx2PnvGnVOnN/s7cvlf+n74etWhcoPCSftLB+E2pdSJQkAAhYD
	 60emvPh6Nlz1b3UdxehHzZdkpMZrz5FfoZNP9d94r+rkAmqRuNokvkctBDmUUVuey+Qmi
	 ae6PQ6SzQnPWdFoX7bds0WH0PHgCbOnnv/6B+wr6/F/r84Ad65knNDynbehpAYFKwZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=d25WSqaQK+h6OimmvaMbLqYE63lPDx4Do2bAQF5I+jw=;
	b=we6Xk649/8XP69PD3lAKh2yv8LB/ew06DQfERGMDIsAf54Ueabc7h8iXg0JltjD7jYxM
	 E9sZeXGrrtrQKtLVm/VUT/qpB2ZaqQDs/LyKtIGrz0ewLAmDGrS9gf/NpDEaXE5q7Idwh
	 /en8T5wsUY7Gl28hmmIX3Mu2Y1MQpTWpf+spjdGaS3Tck7eOfAOImDdHcu5MFRdeyFAga
	 I/jvFX/RgYsS4poi8o32jmVUcZ+SztSsU5QL4Iu0yATmqDzTtv4tx7McnGUKNP1L/SgcU
	 sxFUHT+OJZMFjx4TJski6JD8UJ0spmVyAsHmA03p/pQyozIlt5VHswJmbTXfINedIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HcwLD0Sf;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD0606A31E
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 21:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FFD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HcwLD0Sf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792963859; x=1824499859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q7hn82Wd4CE7SAem8UOdTPVRjl7SoyydFIKFp5FI6Ws=;
  b=HcwLD0SfrC5/kY227cfzeU+Lm0h7rRbmTtoVULWqf6hmFccVvj3bxhRi
   YjTzVKgCgrqnoh8A7AbHuT6mm/0+PqdiC3hPKypOvF23MfzHdboVoM3ux
   D0DTvbELVa2hlC08UvOhnt1g51ABcRv/RU3Y/bwZb4HbgO+LsYuv8dU7B
   zenjmDdxiUemjQBzG4j2W8ch7kkowuM2ieiviERL/InmE3/1Ety6bTG6O
   38BUJ/Yqhw/iuhhPUhqeujh+CLZ5JEGVFF1XvfKf5XOJsjis2M4Zq7T+t
   PD9NpBEuMPmJhP4sHz9rEpiaP/qGxpvaIrmfwr/BydqvX/NWG1//uHIHq
   A==;
X-CSE-ConnectionGUID: ue5i6l+BQN6GN+OvjzBy8Q==
X-CSE-MsgGUID: MZ+u1i8IRbajHHEVCIlJaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1639815"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1639815"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:30:59 -0700
X-CSE-ConnectionGUID: FxPcOtK6R4Kq7oeEfTCeuQ==
X-CSE-MsgGUID: m9kko5KvQ5CALJBujzqXLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4146816"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:30:58 -0700
Date: Sun, 25 Oct 2026 23:30:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 10/18] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
Message-ID: <at51D1EFpX7tOsxJ@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <a6aebf7e2c69130fd8be86c8dd763abad28d5d7b.1792428130.git.len.brown@intel.com>
 <atjlQe1C-xU9fYuG@ashevche-desk.local>
 <CAJvTdKkQQq5=TMGYypV8wAb+TPwH9CSJxJ_rF49E8KUt48ogww@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvTdKkQQq5=TMGYypV8wAb+TPwH9CSJxJ_rF49E8KUt48ogww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 02:22:08PM -0400, Len Brown wrote:
> On Wed, Oct 21, 2026 at 12:16 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> 
> > #define KHZ_PER_MHZ     1000
> 
> sure.
> 
> > Also not sure why not define it directly in KHz?
> 
> The origin of this tool is that you can actually use it to manage HWP
> even if Linux has no cpufreq sub-system (cpufreq.off=1)
> And so its user interface took frequency in 100MHz ratio, to reflect
> the hardware units.
> 
> Then people wanted to use it with cpufreq enabled, and cpufreq has Khz in sysfs.
> Then we had to deal with not scribbling on MSRs behind sysfs/driver's
> back, else risk confusing a driver.
> Then hybrid was invented and HWP.REQ was defined to be performance
> that is not necessarily 100MHz units -- and for that we need
> sysfs/intel_pstate to translate...

Oh, I see, true good legacy and history :-)

-- 
With Best Regards,
Andy Shevchenko


