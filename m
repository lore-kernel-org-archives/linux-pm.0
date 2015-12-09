From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/4] cpufreq governors and Intel P state driver
 compatibility
Date: Wed, 09 Dec 2015 08:12:54 -0800
Message-ID: <1449677574.4180.11.camel@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <3480094.iq1rZTMoWu@skinner>
	 <1449596583.3240.158.camel@spandruv-desk3.jf.intel.com>
	 <2157917.dlSdjkkIZW@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25987 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbbLIQP3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 11:15:29 -0500
In-Reply-To: <2157917.dlSdjkkIZW@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Wed, 2015-12-09 at 16:02 +0100, Thomas Renninger wrote:
> On Tuesday, December 08, 2015 09:43:03 AM Srinivas Pandruvada wrote:
> > On Tue, 2015-12-08 at 15:35 +0100, Thomas Renninger wrote:
> > > On Friday, December 04, 2015 04:08:34 PM Srinivas Pandruvada
> > > wrote:
> > > > Intel P State driver implements two policies, performance and
> > > > powersave.
> > > > The powersave policy is similar to ondemand cpufreq governor
> > > > when using
> > > > acpi-cpufreq. This causes lots of confusion among users. This
> > > > results
> > > > in invalid comparison of performance when acpi-cpufreq and
> > > > Intel P state
> > > > performance is compared.
> > > 
> > > After several years you want to change this again?
> > 
> > This is based on feedback. But again, if this breaks some users,
> > then we
> > need to think.
> > 
> > > We released documentation for this for SLE 12 recently.
> > > It was not that easy to phrase, but it would be wrong again with
> > > newer
> > > kernels..., sigh.
> > 
> > Will this patchset break SLE 12?
> > Are you defaulting to "powersave" policy of Intel P state?
> 
> We use powersave as default with intel_pstate because this is
> default.
> 
> You won't "break" SLE 12 and I mostly thought about documentation.
> This is the intel_pstate part:
> 
> -------------------------------------
> Not all drivers use the in-kernel governors to dynamically scale
> power 
> frequency at runtime. For example, the intel_pstate driver adjusts
> power 
> frequency itself. Use the cpupower frequency-info command to find out
> which 
> driver your system uses.
> -------------------------------------
> 
> Fortunately we cut out the part to explain why "powersave" governor
> shows
> up and what it does. So we are more or less safe.
> 
> Still.., instead of providing the next quick shot, we may want to
> think
> further...
> Having an ondemand governor and a faked may lead to more confusion in
> the
> future.

May be calling "intel_pstate_ondemand" instead of powersave. But that
needs lots of changes in cpufreq core or we have to implement this
driver as a governor + cpufreq driver with target() I/F like acpi
-cpufreq.


> In general, worst that can happen for SLE (probably same for RHEL)
> are any 
> kind of performance regressions that are introduced by trying to save
> more 
> power (on the same HW).
> Customers/users will find them and complain and need at least a param
> to
> get back to old (power wasting) behaviour.
> 
I didn't get this point.

Thanks,
Srinivas

>    Thomas
> 
