From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] SKL intel_pstate update MSR values when changing governors
Date: Tue, 24 Nov 2015 15:28:40 +0100
Message-ID: <8282537.nh6Mqkv7tq@vostro.rjw.lan>
References: <1447887520-10399-1-git-send-email-alexandra.yates@linux.intel.com> <CAJZ5v0ic4PvuvXdNvr=2O4qGLP7kHvaAFjyLPT3goZTEo=LpHQ@mail.gmail.com> <1448327856.24744.6.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47528 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751946AbbKXN7B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 08:59:01 -0500
In-Reply-To: <1448327856.24744.6.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alexandra Yates <alexandra.yates@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, November 23, 2015 05:17:36 PM Srinivas Pandruvada wrote:
> On Tue, 2015-11-24 at 02:09 +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Sat, Nov 21, 2015 at 1:16 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >

[cut]

> > 
> > >> For more information on the MSR values for SKL please visit
> > >> ISDM under Managing HWP.
> > >>
> > >> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> > >
> > > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > >>
> > >> ---
> > >>   drivers/cpufreq/intel_pstate.c | 2 ++
> > >>   1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/cpufreq/intel_pstate.c
> > >> b/drivers/cpufreq/intel_pstate.c
> > >> index 2e31d09..0eeb7da 100644
> > >> --- a/drivers/cpufreq/intel_pstate.c
> > >> +++ b/drivers/cpufreq/intel_pstate.c
> > >> @@ -1242,6 +1242,8 @@ static int intel_pstate_set_policy(struct
> > >> cpufreq_policy *policy)
> > >>             policy->max >= policy->cpuinfo.max_freq) {
> > >>                 pr_debug("intel_pstate: set performance\n");
> > >>                 limits = &performance_limits;
> > >> +               if (hwp_active)
> > >> +                       intel_pstate_hwp_set();
> > 
> > Honestly, I'm not really sure how this is matching the changelog.
> > 
> > What it does is to ensure that the correct limits are used when in the
> > HWP mode too as far as I can say.  Is my understanding correct here?
> Yes.

OK

But if we make the "performance" limits take effect here, it will effectively
make HWP use min = max = 100%, right?  Is that what we want to happen here?

Thanks,
Rafael

