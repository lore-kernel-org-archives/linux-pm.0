From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Sat, 05 Sep 2015 03:41:54 +0200
Message-ID: <1515919.qL4a0PTUEF@vostro.rjw.lan>
References: <001401d0e691$302127b0$90637710$@net> <000e01d0e766$2f07dfb0$8d179f10$@net> <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932489AbbIEBOL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 21:14:11 -0400
In-Reply-To: <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Saturday, September 05, 2015 02:22:39 AM Rafael J. Wysocki wrote:
> On Sat, Sep 5, 2015 at 1:05 AM, Doug Smythies <dsmythies@telus.net> wrote:
> > On 2015.09.04 15:26 Rafael J. Wysocki wrote:
> >> On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
> >>> On 2015.09.04 07:43 Viresh Kumar wrote:
> >>>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
> >>>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
> >>>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
> >>>>>> CPU offline (7 in my case), the system will not suspend.
> >>
> >>>> @Doug: Can you please enable DEBUG for cpufreq with this:
> >>>>
> >>>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> >>>> index 9fde14544ead..c09945aa7f17 100644
> >>>> --- a/drivers/cpufreq/Makefile
> >>>> +++ b/drivers/cpufreq/Makefile
> >>>> @@ -1,3 +1,4 @@
> >>>> +subdir-ccflags-y  := -DDEBUG
> >>>> # CPUfreq core
> >>>> obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
> >>>>
> >>>>
> >>>> And give us the outputs of both successful and unsuccessful logs?
> >>>
> >>> Edited /var/log/kern.log attached (might get stripped for
> >>> on-list e-mail deliveries)
> >
> >> Hmm.
> >> I suspect that your user space does something that fails during the pm-suspend.
> >
> > Are you saying that the patch might be O.K., but reveals
> > and issue with pm-suspend that was always there?
> 
> Or it breaks something that pm-suspend does before suspending.
> 
> It would be good to know what it is. :-)
> 
> The "setting new policy for" messages in your log are from
> cpufreq_set_policy() and the last thing printed before pm-suspend
> exits in the failing case is before calling
> cpufreq_driver->setpolicy().
> 
> I guess we need to focus on that one, will send you a debug patch shortly.

Please apply this one and see if there are any message from intel_pstate_set_policy()
in the failing case.

---
 drivers/cpufreq/intel_pstate.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -972,8 +972,10 @@ static unsigned int intel_pstate_get(uns
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
-	if (!policy->cpuinfo.max_freq)
+	if (!policy->cpuinfo.max_freq) {
+		pr_err("%s: failed for CPU%d\n", __func__, policy->cpu);
 		return -ENODEV;
+	}
 
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
 	    policy->max >= policy->cpuinfo.max_freq) {

