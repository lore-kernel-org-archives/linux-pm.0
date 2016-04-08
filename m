From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set
Date: Fri, 08 Apr 2016 23:54:07 +0200
Message-ID: <1865551.sGARmvFdEr@vostro.rjw.lan>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan> <20160408054513.GF9674@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61612 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752203AbcDHVve (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 17:51:34 -0400
In-Reply-To: <20160408054513.GF9674@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Friday, April 08, 2016 11:15:13 AM Viresh Kumar wrote:
> On 07-04-16, 03:29, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Since governor operations are generally skipped if cpufreq_suspended
> > is set, do nothing at all in cpufreq_start_governor() and
> > cpufreq_exit_governor() in that case.
> > 
> > In particular, this prevents fast frequency switching from being
> > disabled after a suspend-to-RAM cycle on all CPUs except for the
> > boot one.
> > 
> > Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

However, since I'm going to apply https://patchwork.kernel.org/patch/8777561/
to pm-cpufreq-sched, I will only apply the first hunk of the $subject one,
ie. the patch below.  I assume that the ACK still applies. :-)

I'll take it for v4.6, because it fixes up a commit already in there.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set

Since governor operations are generally skipped if cpufreq_suspended
is set, do nothing at all in cpufreq_start_governor() in that case.

That function is called in the cpufreq_online() path, and may also
be called from cpufreq_offline() in some cases, which are invoked
by the nonboot CPUs disabing/enabling code during system suspend
to RAM and resume.  That happens when all devices have been
suspended, so if the cpufreq driver relies on things like I2C to
get the current frequency, it may not be ready to do that then.

The change here prevents problems from happening for this reason.

Fixes: 3bbf8fe3ae08 (cpufreq: Always update current frequency before startig governor)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2053,6 +2053,9 @@ static int cpufreq_start_governor(struct
 {
 	int ret;
 
+	if (cpufreq_suspended)
+		return 0;
+
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
 		cpufreq_update_current_freq(policy);
 

