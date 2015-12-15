From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Tue, 15 Dec 2015 15:24:53 +0100
Message-ID: <6686771.YYmmLREfhx@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <3489702.fdaYLucDTN@skinner> <1450117227.2912.17.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58843 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965025AbbLOOZC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 09:25:02 -0500
In-Reply-To: <1450117227.2912.17.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Monday, December 14, 2015 10:20:27 AM Srinivas Pandruvada wrote:
> On Mon, 2015-12-14 at 16:13 +0100, Thomas Renninger wrote:
> > On Thursday, December 10, 2015 09:28:40 AM Srinivas Pandruvada wrote:
> > > On Thu, 2015-12-10 at 14:04 +0100, Thomas Renninger wrote:
> > > > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:

...

> > And here:
> > https://en.wikipedia.org/wiki/Silvermont
> > 
> > I get:
> > List of Silvermont processors:
> > Desktop processors (Bay Trail-D)
> > Server processors (Avoton)
> > Communications processors (Rangeley)
> > Embedded/automotive processors (Bay Trail-I)
> > Mobile processors (Bay Trail-M)
> > Tablet processors (Bay Trail-T)
> > Smartphone processors (Merrifield and Moorefield)
> > 
> > List of Airmont processors
> > Mobile processors (Braswell)
> > Smartphone and Tablet processors (Cherry Trail)
> > 
> > Not sure what specific functions you mean...
> > Can you name them?
> 
> You have them above for two micro-architectures.
> But they have different cpu id when the use case calls for totally
> different use case. For example server processor (Avaton above in your
> list) has a cpuid of 0x4D, which we don't support for Intel Pstate.

Thanks.
Does this means Avaton will fall back to acpi-cpufreq?
Would it make sense to initalize with intel_pstate and then switch to 
performance governor per default?

This may need some fiddling with our certifcation tool which expects
cpupfreq to work at least a bit.

     Thomas

PS: Thanks for all the input. Summary (from my point of view):

Go for the airmont/silvermont specific algorithms. Especially as they seem to
be an important improvment. But at least write something to syslog.

The "ondemand" compatiblity patch(es) are not that important, right?
I would hold them off and evaluate whether it will make sense to get back
to governors. Even if not, I am not sure it is a good idea to introduce a
fake ondemand governor which is still doing things totally different than
the orignal one...

