From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 8/10] cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info
Date: Fri, 05 Feb 2016 23:50:17 +0100
Message-ID: <8712905.AFUNqadUY1@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <2973464.jyrWv0qA55@vostro.rjw.lan> <20160205083406.GK21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53180 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751595AbcBEWtL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 17:49:11 -0500
In-Reply-To: <20160205083406.GK21792@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Friday, February 05, 2016 02:04:06 PM Viresh Kumar wrote:
> On 05-02-16, 03:20, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The struct cpu_common_dbs_info structure represents the per-policy
> > part of the governor data (for the ondemand and conservative
> > governors), but its name doesn't reflect its purpose.
> > 
> > Rename it to struct policy_dbs_info and rename variables related to
> > it accordingly.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c |  120 ++++++++++++++++++-------------------
> >  drivers/cpufreq/cpufreq_governor.h |    8 +-
> >  drivers/cpufreq/cpufreq_ondemand.c |   32 ++++-----
> >  3 files changed, 80 insertions(+), 80 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> > +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> > @@ -132,7 +132,7 @@ static void *get_cpu_dbs_info_s(int cpu)
> >   */
> >  
> >  /* Common to all CPUs of a policy */
> > -struct cpu_common_dbs_info {
> > +struct policy_dbs_info {
> >  	struct cpufreq_policy *policy;
> >  	/*
> >  	 * Per policy mutex that serializes load evaluation from limit-change
> > @@ -162,7 +162,7 @@ struct cpu_dbs_info {
> >  	 */
> >  	unsigned int prev_load;
> >  	struct update_util_data update_util;
> > -	struct cpu_common_dbs_info *shared;
> > +	struct policy_dbs_info *shared;
> 
> You should replaced shared with policy_dbs here as well ? Apart from
> that:

I wanted to keep the name as the object pointed to by it is technically
still "shared".  I guess I can change it too, though.

Thanks,
Rafael

