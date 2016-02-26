From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: disable HWP notifications
Date: Fri, 26 Feb 2016 02:28 +0100
Message-ID: <2448880.VP0sabqmaJ@vostro.rjw.lan>
References: <1456441771-4961-1-git-send-email-srinivas.pandruvada@linux.intel.com> <4390416.B5Ve4E8iPL@vostro.rjw.lan> <1456442442.17628.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43813 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752171AbcBZB00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 20:26:26 -0500
In-Reply-To: <1456442442.17628.12.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Thursday, February 25, 2016 03:20:42 PM Srinivas Pandruvada wrote:
> On Fri, 2016-02-26 at 00:18 +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 25, 2016 03:09:31 PM Srinivas Pandruvada wrote:
> > > Disable HWP Interrupt notification before enabling HWP. Since we
> > > don't
> > > have HWP interrupt handling for possible performance interrupts,
> > > there
> > > is not much use of enabling HWP interrupts.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > > .com>
> > 
> > The patch is fine, but are there any known systems where it fixes any
> > functional issues just for the record?
> 
> We don't know whether it fixes any functional issue.

OK

> But it was set on some system on boot. I worry that this may cause flooding
> of interrupt during boot if there are some thermal issues.

It obviously may lead to problems, which is why the patch is needed.

Thanks,
Rafael

