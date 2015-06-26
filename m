From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] cpufreq: governor: Drop __gov_queue_work()
Date: Fri, 26 Jun 2015 13:02:01 +0530
Message-ID: <20150626073201.GF16275@linux>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
 <c4dfd8121fd454a04a8d700a5a0f8b7858f7aed3.1434959517.git.viresh.kumar@linaro.org>
 <558CF932.4070409@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34859 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbFZHcI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 03:32:08 -0400
Received: by pdbci14 with SMTP id ci14so69956140pdb.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 00:32:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558CF932.4070409@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 26-06-15, 12:33, Preeti U Murthy wrote:
> On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> > __gov_queue_work() isn't required anymore and can be merged with
> > gov_queue_work(). Do it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index 416a8c5665dd..ac288f0efb06 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -158,25 +158,20 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(dbs_check_cpu);
> > 
> > -static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
> > -		unsigned int delay)
> > -{
> > -	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> > -
> > -	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
> > -}
> 
> Looking at this patch I feel now that, you can simply make the above
> function non static and call the same from update_sampling_rate() in
> patch[04/10] It already gives scope to pass in the cpu parameter, if not
> the mask. Anyway you want to pass in a single cpu from
> update_sampling_rate(). This will avoid having to change the other call
> sites of gov_queue_work().
> 
> I also see elsewhere in the kernel where a fn() and __fn() are sometimes
> both non-static, with __fn() giving you the additional benefit of
> passing a critical parameter. Eg:
> __hrtimer_start_range_ns() and hrtimer_start_range_ns().

Keeping two functions that way isn't a problem and is beneficial many
a times. But that doesn't fit here.

The above function doesn't have the necessary lock and so was never
used directly. And there is no need to keep two routines now that only
one is sufficient.

-- 
viresh
