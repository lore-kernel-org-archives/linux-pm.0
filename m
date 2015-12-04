From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V5 2/3] cpufreq: intel_pstate: account for non C0 time
Date: Fri, 04 Dec 2015 14:48:26 -0800
Message-ID: <1449269306.3240.127.camel@spandruv-desk3.jf.intel.com>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
	 <5661A41F.7050208@linux.intel.com>
	 <1449250743.3240.94.camel@spandruv-desk3.jf.intel.com>
	 <2560479.PPso1nSBcR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53378 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbbLDWt3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 17:49:29 -0500
In-Reply-To: <2560479.PPso1nSBcR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, Stephane Gasparini <stephane.gasparini@linux.intel.com>

On Sat, 2015-12-05 at 00:01 +0100, Rafael J. Wysocki wrote:
> On Friday, December 04, 2015 09:39:03 AM Srinivas Pandruvada wrote:
> > On Fri, 2015-12-04 at 15:33 +0100, Philippe Longepe wrote:
> > > Thank you Rafael,
> > > 
> > > I'll try to sent a new patch set taking your remarks into account for 
> > > these series before tonight.
> > > 
> > > Also, do you think we could have in some corner case a division by zero 
> > > when prev_tsc = tsc ?
> > > 
> > > Normally it should never happen but just in case, I think we should 
> > > complete the following test:
> > > 
> > > if ((cpu->prev_mperf == mperf) || (cpu->prev_tsc == tsc)) {
> > > ...
> > On Knight landing platform the first one is possible and second one
> > should never happen. But this function will never be called for such
> > platforms.
> 
> Still, in case there's a future platform where those counters don't advance
> for extended time intervals, would it really hurt to add a check for that
> and skip the sample when it triggers?
Doesn't hurt.

Thanks,
Srinivas

> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


