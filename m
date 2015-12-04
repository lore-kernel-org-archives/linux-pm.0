From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 2/3] cpufreq: intel_pstate: account for non C0 time
Date: Sat, 05 Dec 2015 00:01:27 +0100
Message-ID: <2560479.PPso1nSBcR@vostro.rjw.lan>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com> <5661A41F.7050208@linux.intel.com> <1449250743.3240.94.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43652 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751813AbbLDWbf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 17:31:35 -0500
In-Reply-To: <1449250743.3240.94.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, Stephane Gasparini <stephane.gasparini@linux.intel.com>

On Friday, December 04, 2015 09:39:03 AM Srinivas Pandruvada wrote:
> On Fri, 2015-12-04 at 15:33 +0100, Philippe Longepe wrote:
> > Thank you Rafael,
> > 
> > I'll try to sent a new patch set taking your remarks into account for 
> > these series before tonight.
> > 
> > Also, do you think we could have in some corner case a division by zero 
> > when prev_tsc = tsc ?
> > 
> > Normally it should never happen but just in case, I think we should 
> > complete the following test:
> > 
> > if ((cpu->prev_mperf == mperf) || (cpu->prev_tsc == tsc)) {
> > ...
> On Knight landing platform the first one is possible and second one
> should never happen. But this function will never be called for such
> platforms.

Still, in case there's a future platform where those counters don't advance
for extended time intervals, would it really hurt to add a check for that
and skip the sample when it triggers?

Thanks,
Rafael

