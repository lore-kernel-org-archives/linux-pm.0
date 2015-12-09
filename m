From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/4] cpufreq governors and Intel P state driver compatibility
Date: Wed, 09 Dec 2015 16:02:47 +0100
Message-ID: <2157917.dlSdjkkIZW@skinner>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com> <3480094.iq1rZTMoWu@skinner> <1449596583.3240.158.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41366 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbbLIPCu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 10:02:50 -0500
In-Reply-To: <1449596583.3240.158.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Tuesday, December 08, 2015 09:43:03 AM Srinivas Pandruvada wrote:
> On Tue, 2015-12-08 at 15:35 +0100, Thomas Renninger wrote:
> > On Friday, December 04, 2015 04:08:34 PM Srinivas Pandruvada wrote:
> > > Intel P State driver implements two policies, performance and powersave.
> > > The powersave policy is similar to ondemand cpufreq governor when using
> > > acpi-cpufreq. This causes lots of confusion among users. This results
> > > in invalid comparison of performance when acpi-cpufreq and Intel P state
> > > performance is compared.
> > 
> > After several years you want to change this again?
> 
> This is based on feedback. But again, if this breaks some users, then we
> need to think.
> 
> > We released documentation for this for SLE 12 recently.
> > It was not that easy to phrase, but it would be wrong again with newer
> > kernels..., sigh.
> 
> Will this patchset break SLE 12?
> Are you defaulting to "powersave" policy of Intel P state?

We use powersave as default with intel_pstate because this is default.

You won't "break" SLE 12 and I mostly thought about documentation.
This is the intel_pstate part:

-------------------------------------
Not all drivers use the in-kernel governors to dynamically scale power 
frequency at runtime. For example, the intel_pstate driver adjusts power 
frequency itself. Use the cpupower frequency-info command to find out which 
driver your system uses.
-------------------------------------

Fortunately we cut out the part to explain why "powersave" governor shows
up and what it does. So we are more or less safe.

Still.., instead of providing the next quick shot, we may want to think
further...
Having an ondemand governor and a faked may lead to more confusion in the
future.

In general, worst that can happen for SLE (probably same for RHEL) are any 
kind of performance regressions that are introduced by trying to save more 
power (on the same HW).
Customers/users will find them and complain and need at least a param to
get back to old (power wasting) behaviour.

   Thomas

