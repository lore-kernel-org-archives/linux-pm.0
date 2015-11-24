From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 1/2] intel_pstate: Use the cpu load to determine the
 PercentPerformance
Date: Mon, 23 Nov 2015 17:44:31 -0800
Message-ID: <1448329471.24744.13.camel@spandruv-desk3.jf.intel.com>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1546343.Y03T7q8XC6@vostro.rjw.lan>
	 <1446858868.5023.6.camel@linux.intel.com>
	 <001701d12478$a65886b0$f3099410$@net> <5653149B.5090100@linux.intel.com>
	 <001c01d12658$266277e0$732767a0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4655 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbbKXBp1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 20:45:27 -0500
In-Reply-To: <001c01d12658$266277e0$732767a0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'plongepe' <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>

On Mon, 2015-11-23 at 17:33 -0800, Doug Smythies wrote:
> On 2015.11.23 05:29 plongepe wrote:
> > On 21/11/2015 17:21, Doug Smythies wrote:
> >> On 2015.11.06 17:14 Srinivas Pandruvada wrote:
> >> On Sat, 2015-11-07 at 02:09 +0100, Rafael J. Wysocki wrote:
> >>> On Tuesday, November 03, 2015 10:27:19 AM Philippe Longepe wrote:
[CUT.]
> However, Intel should decide once and for all if mperf / tsc is allowed or not.
We can't apply this uniformly across all CPUs. So this patchset will not
be applied to all CPUs, only where this is allowed and verified. 
BTW, these patches need cleanup.

Thanks,
Srinivas
> It was used one time, then it was deleted, then I tried to bring it back,
> then I was told it wasn't allowed, now you are trying to bring it back.
> 
> ... Doug
> 
> 


