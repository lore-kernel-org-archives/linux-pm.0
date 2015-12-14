From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Mon, 14 Dec 2015 16:13:46 +0100
Message-ID: <3489702.fdaYLucDTN@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <8633351.YrHIUtRzE5@skinner> <1449768520.3240.250.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52002 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbbLNPNs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Dec 2015 10:13:48 -0500
In-Reply-To: <1449768520.3240.250.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Thursday, December 10, 2015 09:28:40 AM Srinivas Pandruvada wrote:
> On Thu, 2015-12-10 at 14:04 +0100, Thomas Renninger wrote:
> > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > > > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:

...
 
> > > The function
> > > to get next state can be common. There is no airmont/silvermont name
> > > attached to this (get_target_pstate_use_cpu_load or
> > > get_target_pstate_use_performance). So the default callback
> > > ".get_target_pstate" can be changed based on preference.
> > > 
> > > This is the order I am thinking of in the order of priority high to
> > > low :
> > > - User policy (either command line or via cpu-freq scaling_governor)
> > > - ACPI
> > > - Pickup defaults based on CPU ID.

That would mean if ACPI pm profile is unknown and only then, assign
algorithm (or other tunables) based on CPU ID?

> > Why by CPU ID? This doesn't make sense to me and unnecessarily complicates
> > things.
> 
> Some CPU are designed for a specific functions.

Ok, I nearly bought this...
Then I started reading (only a very bit). Silvermont is simply a CPU model.
It's not a bound to specific functions like different ARM processors with
possibly very specific chipset. It's just a general X86 processor, right?

And here:
https://en.wikipedia.org/wiki/Silvermont

I get:
List of Silvermont processors:
Desktop processors (Bay Trail-D)
Server processors (Avoton)
Communications processors (Rangeley)
Embedded/automotive processors (Bay Trail-I)
Mobile processors (Bay Trail-M)
Tablet processors (Bay Trail-T)
Smartphone processors (Merrifield and Moorefield)

List of Airmont processors
Mobile processors (Braswell)
Smartphone and Tablet processors (Cherry Trail)

Not sure what specific functions you mean...
Can you name them?

I cut the rest of the mail which was very helpful info and explained
quite some open details.

Thanks!

      Thomas
