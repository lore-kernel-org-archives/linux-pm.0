From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Update cpu_frequency tracepoint every time
Date: Sat, 23 Jul 2016 14:41:43 +0200
Message-ID: <2133928.8B42yOlnv2@vostro.rjw.lan>
References: <3678564.0E838ntcHL@vostro.rjw.lan> <1468967958.2125.2.camel@linux.intel.com> <001a01d1e234$e33ce290$a9b6a7b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47447 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750786AbcGWMgq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jul 2016 08:36:46 -0400
In-Reply-To: <001a01d1e234$e33ce290$a9b6a7b0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On Tuesday, July 19, 2016 08:14:53 PM Doug Smythies wrote:
> On 2016.07.19 15:10 Srinivas Pandruvada wrote:
> > On Tue, 2016-07-19 at 15:10 +0200, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> 
> >> Currently, intel_pstate only updates the cpu_frequency tracepoint
> >> if the new P-state to set is different from the current one, but
> >> that causes powertop to report 100% idle on an 100% loaded system
> >> sometimes.
> >> 
> >> Prevent that from happening by updating the cpu_frequency tracepoint
> >> every time intel_pstate_update_pstate() is called.
> >> 
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>-
> 
> Shouldn't this patch refer to:
> 
> commit fdfdb2b1301670a69195ba1e5666df4a7f02eb46
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Fri Mar 18 23:20:02 2016 +0100
> 
>     intel_pstate: Do not call wrmsrl_on_cpu() with disabled interrupts
> 
> which is the patch that introduced the regression?

The logic changed by the $subject patch was there before the above commit,
so I don't think the issue at hand really is a regression introduced by it

Thanks,
Rafael

