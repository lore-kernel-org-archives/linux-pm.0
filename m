From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: disable HWP notifications
Date: Thu, 25 Feb 2016 15:20:42 -0800
Message-ID: <1456442442.17628.12.camel@linux.intel.com>
References: <1456441771-4961-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <4390416.B5Ve4E8iPL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40226 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbcBYXWh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 18:22:37 -0500
In-Reply-To: <4390416.B5Ve4E8iPL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Fri, 2016-02-26 at 00:18 +0100, Rafael J. Wysocki wrote:
> On Thursday, February 25, 2016 03:09:31 PM Srinivas Pandruvada wrote:
> > Disable HWP Interrupt notification before enabling HWP. Since we
> > don't
> > have HWP interrupt handling for possible performance interrupts,
> > there
> > is not much use of enabling HWP interrupts.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> 
> The patch is fine, but are there any known systems where it fixes any
> functional issues just for the record?

We don't know whether it fixes any functional issue. But it was set on
some system on boot. I worry that this may cause flooding of interrupt
during boot if there are some thermal issues.

Thanks,
Srinivas

> 
> Rafael
> 
