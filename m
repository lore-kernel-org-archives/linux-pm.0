From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] SKL intel_pstate update MSR values when changing
 governors
Date: Mon, 23 Nov 2015 17:17:36 -0800
Message-ID: <1448327856.24744.6.camel@spandruv-desk3.jf.intel.com>
References: <1447887520-10399-1-git-send-email-alexandra.yates@linux.intel.com>
	 <564FB7EE.6030507@linux.intel.com>
	 <CAJZ5v0ic4PvuvXdNvr=2O4qGLP7kHvaAFjyLPT3goZTEo=LpHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4987 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbbKXBSd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 20:18:33 -0500
In-Reply-To: <CAJZ5v0ic4PvuvXdNvr=2O4qGLP7kHvaAFjyLPT3goZTEo=LpHQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 2015-11-24 at 02:09 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Sat, Nov 21, 2015 at 1:16 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> >
> > On 11/18/2015 02:58 PM, Alexandra Yates wrote:
> >>
> >> When changing from powersave to performance governors
> >> Intel_pstate fails to update the MSR values that reflect the
> >> max_perf_pct to 100%. For instance in SKL reading rdmsr 0x774:
> >>
> >> Governor        MSR                     max_perf_pct
> >> =========       ========                ============
> >> Powersave       80002808                100%
> >> Powersave       80002008                80%
> >> Performance     80002028 [error]        100%
> >> Performance     80002828 [expected]     100%
> >>
> >> The line label [error] shows the culprit. At this point the MSR
> >> should reflect the max_perf_pct that is 100%, that corresponds
> >> to MSR 80002828 as shown on the next line of the example. Which
> >> is the maximum performance for the Performance governor.
> >> Instead it holds back the MSR value previously set by the
> >> Powersave, in this case 80002028.
> >>
> >> This patch allows the system to print the correct MSR value
> >> 80002828 that corresponds to the 100% max_perf_pct when changing
> >> from powersave to performance governors.
> 
> Is this only about what is printed or does it mean that the driver
> actually uses an incorrect MSR value?
Driver was not configuring correct value in HWP MSR, which sets min and
max limits, so the HWP is not using correct limits. In HWP case driver
doesn't do anything other than setting this MSR.
When she means print correct MSR, is that when changing the mode from
powersave to peformance, when she prints MSRs (rdmsr 0x774), this
doesn't have correct max limit.
> 
> >> For more information on the MSR values for SKL please visit
> >> ISDM under Managing HWP.
> >>
> >> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> >
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >>
> >> ---
> >>   drivers/cpufreq/intel_pstate.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c
> >> b/drivers/cpufreq/intel_pstate.c
> >> index 2e31d09..0eeb7da 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -1242,6 +1242,8 @@ static int intel_pstate_set_policy(struct
> >> cpufreq_policy *policy)
> >>             policy->max >= policy->cpuinfo.max_freq) {
> >>                 pr_debug("intel_pstate: set performance\n");
> >>                 limits = &performance_limits;
> >> +               if (hwp_active)
> >> +                       intel_pstate_hwp_set();
> 
> Honestly, I'm not really sure how this is matching the changelog.
> 
> What it does is to ensure that the correct limits are used when in the
> HWP mode too as far as I can say.  Is my understanding correct here?
Yes.
> 
> >>                 return 0;
> >>         }
> >>
> >>
> > --
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


