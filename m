From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: prevent lockup on reading
 scaling_available_frequencies
Date: Wed, 07 Oct 2015 11:05:58 -0700
Message-ID: <1444241158.2444.4.camel@spandruv-desk3.jf.intel.com>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007124508.GG902@linux>
	 <1444234737.3514.17.camel@spandruv-desk3.jf.intel.com>
	 <20151007170304.GD4557@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59231 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbbJGSYZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 14:24:25 -0400
In-Reply-To: <20151007170304.GD4557@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wed, 2015-10-07 at 22:33 +0530, Viresh Kumar wrote:
> On 07-10-15, 09:18, Srinivas Pandruvada wrote:
> > freq_table is allocated in init() callbacks and freed on exit()
> > callback. But I don't see any driver changing policy->freq_table to NULL
> > or setting value to policy->freq_table to their allocated freq_table .
>  
> That's what I am asking for.
> 
> > I see policy->freq_table is only assigned value in function
> > cpufreq_table_validate_and_show, as part of the core API.
> 
> Its just an helper written to reduce code redundancy..
> 
> > So I think we
> > should set to NULL after clients freed the freq_table as part of core
> > function.
> 
> Not really. If we want to do the opposite, then we should initiate
> policy->freq_table = NULL, right from exit(), as its done as part of
> init() first.
> 
> > Otherwise we need to modify every client cpufreq driver and assign
> > policy->freq_table=NULL on .exit().  Since they don't assign value to
> > this policy->freq_table in first place, they shouldn't change this.
> 
> They did set it in the first place, with help of a helper routine
> though.
> 
> But I do understand the code redundancy we are about to create. So,
> maybe we can do this in the core as a special case.
> 
> But then you missed another location where exit() was called.
In cpufreq_online() function? In this case whole policy is freed. Do we
need to assign here also?

> 
> > Also I don't know why we need to keep the sysfs entry cpufreq after
> > offline. There are other values, which we can read without crash, but
> > may not be valid. We may delete this sysfs entry. But may be some
> > cpufreq driver cares about this even after offline. If we can delete
> > this entry, it can be part of cleanup of cpufreq subsystem.
> 
> Go thought the mail threads where that support is added, it was indeed
> useful.
> 


