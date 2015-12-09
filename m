From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Wed, 09 Dec 2015 12:21:53 -0800
Message-ID: <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	 <3600864.XZTfEJ2ljK@skinner>
	 <1449597743.3240.171.camel@spandruv-desk3.jf.intel.com>
	 <1536293.WV9n2YBamr@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48387 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbbLIUXZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 15:23:25 -0500
In-Reply-To: <1536293.WV9n2YBamr@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org

On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> > On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> > > Hi,
> 
> > > There may be atoms clustered in server platforms and there may be
> > > performance oriented CPU models built into laptops.
> > 
> > You mean BYT/CHT ATOM used as servers not Avaton, which has different
> > id.
> 
> I have no idea.
> And since Intel does not build mainboards anymore afaik or most
> are built by OEMs, you also have no idea which CPUs end up on which kind
> of system, right?
> 
> Default policy to go for performance, IO, workload based switching or
> whatever tunables are modified should be, as you said, platform oriented.
> 
> So instead of calling the params:
> silvermont, airmont, knl_params (knights landing, right?), whatever CPU...
> Better call them:
These param structure is much more than just policy specification. They
have callback to get limits. For example, silvermont and airmont has
different scaling methods. So they can't be common to all. The function
to get next state can be common. There is no airmont/silvermont name
attached to this (get_target_pstate_use_cpu_load or
get_target_pstate_use_performance). So the default callback
".get_target_pstate" can be changed based on preference.

This is the order I am thinking of in the order of priority high to
low :
- User policy (either command line or via cpu-freq scaling_governor)
- ACPI 
- Pickup defaults based on CPU ID.

The current patch-set only addresses the cpu id based selection.
BTW changing a pid set point can be done from user space without
changing code.
> laptop, io_optimized, performance params, whatever ...
> And later set them according to pm_profile, not CPU id and still
> provide something to override via userspace (I hope this is
> what you want to do anyway, right?).
> Even someone buys a tablet, there are Linux guys around who use them as
> their homeserver in 2 years and they want to override...
> 
> Hm, in fact what you are doing is you implement your own governors/policies 
> inside intel_pstate driver now, right?
> If not done already, you should name it in dmesg what kind of algorithm is 
> used (cmp with my patch). This makes it easier to find powersave
> or performance regressions that will come up with the new default settings
> and pin point them to intel_pstate.
Can be done.
> 
> Even better would be if intel_pstate could set it's own governor string.
> Then there wouldn't be any mixture with ondemand or whatever.
> But again.., those should not be named "airmont" policy/governor.
> 
The No airmont or silvermont policies. But more specific to use case
based string will be better.

> I had a quick look, but providing whole governors seem to be a lot overhead.
> But with some luck you do not have to fill up whole structures you have to
> pass to cpufreq_register_governor(..).
Adding a external governor is easy (Your RFC patch already does that).
But inside cpufreq core logic there is different processing based on
whether there are internal governor or cpufreq governor. So that needs
to be addressed first.

Thanks,
Srinivas
> 
>         Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


