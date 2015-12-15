From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Tue, 15 Dec 2015 10:10:55 -0800
Message-ID: <1450203055.2912.63.camel@spandruv-desk3.jf.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	 <3489702.fdaYLucDTN@skinner>
	 <1450117227.2912.17.camel@spandruv-desk3.jf.intel.com>
	 <6686771.YYmmLREfhx@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1180 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbbLOSME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 13:12:04 -0500
In-Reply-To: <6686771.YYmmLREfhx@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Tue, 2015-12-15 at 15:24 +0100, Thomas Renninger wrote:
> On Monday, December 14, 2015 10:20:27 AM Srinivas Pandruvada wrote:
> > On Mon, 2015-12-14 at 16:13 +0100, Thomas Renninger wrote:
> > > On Thursday, December 10, 2015 09:28:40 AM Srinivas Pandruvada wrote:
> > > > On Thu, 2015-12-10 at 14:04 +0100, Thomas Renninger wrote:
> > > > > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > > > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> 
> ...
> 
> > > And here:
> > > https://en.wikipedia.org/wiki/Silvermont
> > > 
> > > I get:
> > > List of Silvermont processors:
> > > Desktop processors (Bay Trail-D)
> > > Server processors (Avoton)
> > > Communications processors (Rangeley)
> > > Embedded/automotive processors (Bay Trail-I)
> > > Mobile processors (Bay Trail-M)
> > > Tablet processors (Bay Trail-T)
> > > Smartphone processors (Merrifield and Moorefield)
> > > 
> > > List of Airmont processors
> > > Mobile processors (Braswell)
> > > Smartphone and Tablet processors (Cherry Trail)
> > > 
> > > Not sure what specific functions you mean...
> > > Can you name them?
> > 
> > You have them above for two micro-architectures.
> > But they have different cpu id when the use case calls for totally
> > different use case. For example server processor (Avaton above in your
> > list) has a cpuid of 0x4D, which we don't support for Intel Pstate.
> 
> Thanks.
> Does this means Avaton will fall back to acpi-cpufreq?
> Would it make sense to initalize with intel_pstate and then switch to 
> performance governor per default?
> 
> This may need some fiddling with our certifcation tool which expects
> cpupfreq to work at least a bit.
> 
>      Thomas
> 
> PS: Thanks for all the input. Summary (from my point of view):
> 
> Go for the airmont/silvermont specific algorithms. Especially as they seem to
> be an important improvment. But at least write something to syslog.
> 
> The "ondemand" compatiblity patch(es) are not that important, right?
They are not going in current form even if I dropped powersave as you
suggested.
> I would hold them off and evaluate whether it will make sense to get back
> to governors. Even if not, I am not sure it is a good idea to introduce a
> fake ondemand governor which is still doing things totally different than
> the orignal one...
Idea is not to cause more confusion. Thinking of calling something
different "intel_pstate_..", but needs changes in cpufreq core. I will
propose some changes, and see if they are acceptable.

Thanks,
Srinivas
> 


