From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Mon, 14 Dec 2015 10:20:27 -0800
Message-ID: <1450117227.2912.17.camel@spandruv-desk3.jf.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	 <8633351.YrHIUtRzE5@skinner>
	 <1449768520.3240.250.camel@spandruv-desk3.jf.intel.com>
	 <3489702.fdaYLucDTN@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15015 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbbLNSVg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Dec 2015 13:21:36 -0500
In-Reply-To: <3489702.fdaYLucDTN@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Mon, 2015-12-14 at 16:13 +0100, Thomas Renninger wrote:
> On Thursday, December 10, 2015 09:28:40 AM Srinivas Pandruvada wrote:
> > On Thu, 2015-12-10 at 14:04 +0100, Thomas Renninger wrote:
> > > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > > > > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> 
> ...
>  
> > > > The function
> > > > to get next state can be common. There is no airmont/silvermont name
> > > > attached to this (get_target_pstate_use_cpu_load or
> > > > get_target_pstate_use_performance). So the default callback
> > > > ".get_target_pstate" can be changed based on preference.
> > > > 
> > > > This is the order I am thinking of in the order of priority high to
> > > > low :
> > > > - User policy (either command line or via cpu-freq scaling_governor)
> > > > - ACPI
> > > > - Pickup defaults based on CPU ID.
> 
> That would mean if ACPI pm profile is unknown and only then, assign
> algorithm (or other tunables) based on CPU ID?
Yes.
> 
> > > Why by CPU ID? This doesn't make sense to me and unnecessarily complicates
> > > things.
> > 
> > Some CPU are designed for a specific functions.
> 
> Ok, I nearly bought this...
> Then I started reading (only a very bit). Silvermont is simply a CPU model.
> It's not a bound to specific functions like different ARM processors with
> possibly very specific chipset. It's just a general X86 processor, right?
> 
These are micro architectures. The methods to get some parameters are
different. Currently our callbacks are also including pid_policy. 
If this core is used in ATOM servers, then it will have a different cpu
id. We have not added any ATOM server cpuids. We have to separate the
micro-architecture callbacks from pid_policy.
> And here:
> https://en.wikipedia.org/wiki/Silvermont
> 
> I get:
> List of Silvermont processors:
> Desktop processors (Bay Trail-D)
> Server processors (Avoton)
> Communications processors (Rangeley)
> Embedded/automotive processors (Bay Trail-I)
> Mobile processors (Bay Trail-M)
> Tablet processors (Bay Trail-T)
> Smartphone processors (Merrifield and Moorefield)
> 
> List of Airmont processors
> Mobile processors (Braswell)
> Smartphone and Tablet processors (Cherry Trail)
> 
> Not sure what specific functions you mean...
> Can you name them?
You have them above for two micro-architectures.
But they have different cpu id when the use case calls for totally
different use case. For example server processor (Avaton above in your
list) has a cpuid of 0x4D, which we don't support for Intel Pstate.

Thanks,
Srinivas
> 
> I cut the rest of the mail which was very helpful info and explained
> quite some open details.
> 
> Thanks!
> 
>       Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


