From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 23:48:19 +0200
Message-ID: <1780433.ynzyL9V08i@vostro.rjw.lan>
References: <20161012182550.2102-1-piotr.luc@intel.com> <1991911.AIWBrncZ9n@vostro.rjw.lan> <1476369859.27971.11.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45495 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755022AbcJMVnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 17:43:07 -0400
In-Reply-To: <1476369859.27971.11.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Luc, Piotr" <Piotr.Luc@intel.com>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thursday, October 13, 2016 02:48:28 PM Luc, Piotr wrote:
> On Wed, 2016-10-12 at 21:39 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 12, 2016 08:25:50 PM Piotr Luc wrote:
> > > 
> > > ---
> > > Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
> > > https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel
> > > ! com
> > 
> > First, putting broken URLs into patch tags doesn't really help.
> 
> OK, with a series the link is not needed. I will refer to a patch
> inside the series.
> 
> > 
> > Second, please send all of these patches as a series where the first
> > patch makes the change the rest depends on.  That would make them
> > easier to
> > handle.
> > 
> I see. I just wonder if I should send the entire series to all
> maintainers that maintain individual modules/files or somehow limit
> 'TO' recipients only to their modules. 
> Is any good method to it correctly?

The To: list should be possibly short.  I would just send it To: x86@kernel.org
and put the other addresses into the CC list.

Generally speaking, CCs of the entire series should go to all of the relevant
maintainers (so they have a chance to respond to your patches in the context of
the series) though.

Thanks,
Rafael

