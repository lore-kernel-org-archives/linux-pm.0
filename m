From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Mon, 17 Jul 2017 12:42:34 +0530
Message-ID: <20170717071234.GK352@vireshk-i7>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35731 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdGQHMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 03:12:39 -0400
Received: by mail-pg0-f46.google.com with SMTP id v190so16937318pgv.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 00:12:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170713234226.GE22780@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Waldemar@codeaurora.org, Rymarkiewicz@codeaurora.org, waldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 13-07-17, 16:42, Stephen Boyd wrote:
> On 07/13, Waldemar Rymarkiewicz wrote:
> > On systems where not all possible CPUs are available for Linux call to
> > dev_pm_opp_of_get_sharing_cpus() will fail as cannot find a cpu device
> > for not present (not available) CPUs.
> > 
> > Example (real use case):
> > 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> > for linux. cpufreq-dt driver + opp v2 fail to register opp_table due to the
> > fact there is no struct device for cpu1 (cpu1 not available for Linux).
> > 
> > Solve the problem by iterating over cpu_present_mask instead of
> > cpu_possible_mask.
> > 
> > Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

> > ---
> >  drivers/base/power/opp/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> > index 57eec1c..389c924 100644
> > --- a/drivers/base/power/opp/of.c
> > +++ b/drivers/base/power/opp/of.c
> > @@ -589,7 +589,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
> >  	if (!of_property_read_bool(np, "opp-shared"))
> >  		goto put_cpu_node;
> >  
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		if (cpu == cpu_dev->id)
> >  			continue;
> >  
> 
> Is there some way to iterate through all cpu nodes in DT without
> using devices? I suppose some sort of loop on top of
> of_get_cpu_node().

I am looking for the same thing :)

> I worry that we may have some problem where we want to know about
> all the CPUs that are sharing a particular OPP table but they
> haven't been physically hotplugged yet.

We will have a problem if we are going to use OPP framework on
platforms where CPUs are hotpluggable. The cpumask returned by this
function is used by the cpufreq drivers to get the related_cpus mask
and that will be used when a cpu is inserted in later on.

Do we have such users of OPP framework right now ? ARM doesn't have
such platforms AFAIK. Does MIPS have it ?

> This also raises the
> question about what the DT looks like before and after a CPU is
> inserted into a system. If the non-present CPU nodes are in DT
> all the time, then it may make sense for cpufreq-dt to intersect
> the OPP sharing mask with the cpu_present_mask.

We need the related-cpus mask in cpufreq to include non-present CPUs
as well.

-- 
viresh
