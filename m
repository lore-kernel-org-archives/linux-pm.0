From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 9/10] cpufreq: governor: Rearrange governor data structures
Date: Fri, 05 Feb 2016 23:47:55 +0100
Message-ID: <2480267.pVUasc5mK9@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <13133705.tMsel709A1@vostro.rjw.lan> <20160205091357.GL21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47047 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751035AbcBEWqu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 17:46:50 -0500
In-Reply-To: <20160205091357.GL21792@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Friday, February 05, 2016 02:43:57 PM Viresh Kumar wrote:
> On 05-02-16, 03:21, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The struct policy_dbs_info objects representing per-policy governor
> > data are not accessible directly from the corresponding policy
> > objects.  To access them, one has to get a pointer to the
> > struct cpu_dbs_info of policy->cpu and use the "shared" field of
> > that which isn't really straightforward.
> > 
> > To address that rearrange the governor data structures so the
> > governor_data pointer in struct cpufreq_policy will point to
> > struct policy_dbs_info and that will contain a pointer to
> > struct dbs_data.
> 
> IMHO, this patch has done way too much over what's mentioned here.
> 
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> > @@ -297,16 +298,22 @@ static int alloc_policy_dbs_info(struct
> >  	/* Allocate memory for the common information for policy->cpus */
> >  	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
> >  	if (!policy_dbs)
> > -		return -ENOMEM;
> > -
> > -	/* Set policy_dbs for all CPUs, online+offline */
> > -	for_each_cpu(j, policy->related_cpus)
> > -		gov->get_cpu_cdbs(j)->shared = policy_dbs;
> > +		return NULL;
> >  
> > +	policy_dbs->policy = policy;
> 
> Value of policy_dbs->policy was used to verify the state machine of
> the governor and so was updated only in start/stop.
> 
> You have moved it to INIT first (which shouldn't have been part of
> this patch at the least),

Why?

> and then there is no reasoning given on why
> that isn't required as part of the state machine now, which I believe
> is still required the way it was.

No, it isn't required.  The whole "state machine" isn't required IMO.

The only user of this is the cpufreq core, so why does the code here have to
double check what the core is doing?

Thanks,
Rafael

