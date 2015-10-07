From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: prevent lockup on reading
 scaling_available_frequencies
Date: Wed, 07 Oct 2015 09:18:57 -0700
Message-ID: <1444234737.3514.17.camel@spandruv-desk3.jf.intel.com>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007124508.GG902@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46655 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbbJGQUo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 12:20:44 -0400
In-Reply-To: <20151007124508.GG902@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wed, 2015-10-07 at 18:15 +0530, Viresh Kumar wrote:
> On 01-10-15, 15:23, Srinivas Pandruvada wrote:
> > When scaling_available_frequencies is read on an offlined cpu, then
> > either lockup or junk values are displayed. This is caused by
> > freed freq_table, which policy is using.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index ef5ed94..25c4c15 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1436,8 +1436,10 @@ static void cpufreq_offline_finish(unsigned int cpu)
> >  	 * since this is a core component, and is essential for the
> >  	 * subsequent light-weight ->init() to succeed.
> >  	 */
> > -	if (cpufreq_driver->exit)
> > +	if (cpufreq_driver->exit) {
> >  		cpufreq_driver->exit(policy);
> > +		policy->freq_table = NULL;
> > +	}
> >  }
> 
> freq_table was set from the ->init() callbacks and only they should
> set it to NULL, isn't it?
freq_table is allocated in init() callbacks and freed on exit()
callback. But I don't see any driver changing policy->freq_table to NULL
or setting value to policy->freq_table to their allocated freq_table .

I see policy->freq_table is only assigned value in function
cpufreq_table_validate_and_show, as part of the core API. So I think we
should set to NULL after clients freed the freq_table as part of core
function.

Otherwise we need to modify every client cpufreq driver and assign
policy->freq_table=NULL on .exit().  Since they don't assign value to
this policy->freq_table in first place, they shouldn't change this.

Also I don't know why we need to keep the sysfs entry cpufreq after
offline. There are other values, which we can read without crash, but
may not be valid. We may delete this sysfs entry. But may be some
cpufreq driver cares about this even after offline. If we can delete
this entry, it can be part of cleanup of cpufreq subsystem.

Thanks,
Srinivas

> 


