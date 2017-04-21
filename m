From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Fri, 21 Apr 2017 03:17:39 +0200
Message-ID: <2640598.7kLQfP2zoQ@aspire.rjw.lan>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net> <003101d2b573$16b28370$44178a50$@net> <000a01d2b9e6$393afef0$abb0fcd0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58148 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S948405AbdDUBXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 21:23:46 -0400
In-Reply-To: <000a01d2b9e6$393afef0$abb0fcd0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Mel Gorman' <mgorman@techsingularity.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On Thursday, April 20, 2017 07:55:57 AM Doug Smythies wrote:
> On 2017.04.19 01:16 Mel Gorman wrote:
> > On Fri, Apr 14, 2017 at 04:01:40PM -0700, Doug Smythies wrote:
> >> Hi Mel,

[cut]

> > And the revert does help albeit not being an option for reasons Rafael
> > covered.
> 
> New data point: Kernel 4.11-rc7  intel_pstate, powersave forcing the
> load based algorithm: Elapsed 3178 seconds.
> 
> If I understand your data correctly, my load based results are the opposite of yours.
> 
> Mel: 4.11-rc5 vanilla: Elapsed mean: 3750.20 Seconds
> Mel: 4.11-rc5 load based: Elapsed mean: 2503.27 Seconds
> Or: 33.25%
> 
> Doug: 4.11-rc6 stock: Elapsed total (5 runs): 2364.45 Seconds
> Doug: 4.11-rc7 force load based: Elapsed total (5 runs): 3178 Seconds
> Or: -34.4%

I wonder if you can do the same thing I've just advised Mel to do.  That is,
take my linux-next branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

(which is new material for 4.12 on top of 4.11-rc7) and reduce
INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL (in intel_pstate.c) in it by 1/2
(force load-based if need be, I'm not sure what PM profile of your test system
is).

Thanks,
Rafael
