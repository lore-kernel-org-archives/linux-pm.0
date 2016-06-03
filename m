From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/6] cpufreq: Remove cpufreq_frequency_get_table()
Date: Fri, 3 Jun 2016 10:41:45 +0530
Message-ID: <20160603051145.GK16176@vireshk-i7>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
 <13d43ddfe208a9b387fe0fd247de069ba0332308.1464876229.git.viresh.kumar@linaro.org>
 <20160602145903.GA2966@e104805>
 <CAKohponBAEZMhiVPNKqbY3nHAT9uB=7rK=SvVaf4jfgMPPft9w@mail.gmail.com>
 <20160602180250.GC2966@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34902 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcFCFLt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 01:11:49 -0400
Received: by mail-pa0-f49.google.com with SMTP id xk1so11232232pac.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 22:11:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160602180250.GC2966@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02-06-16, 19:02, Javi Merino wrote:
> On Thu, Jun 02, 2016 at 09:06:26PM +0530, Viresh Kumar wrote:
> > On 2 June 2016 at 20:29, Javi Merino <javi.merino@arm.com> wrote:
> > > In 5a31d594a973 ("cpufreq: Allow freq_table to be obtained for offline
> > > CPUs") you did the opposite: don't use cpufreq_cpu_get_raw() because
> > > it won't give you the policy of a cpu that is offline.  Now you are
> > > arguing that we should go back to cpufreq_cpu_get() which implicitly
> > > calls cpufreq_cpu_get_raw().  Won't we hit the same issue that
> > > 5a31d594a973 was trying to prevent: that we can't get a freq_table for
> > > a cpu that is offline?
> > 
> > Yes, that should be fixed. Thanks for letting me know about it :)
> 
> Ok, that was my only nit.  Other than that, it looks good to me.  For cpu_cooling.c 
> 
> Acked-by: Javi Merino <javi.merino@arm.com>

Thanks, I will be adding this to the original patch.

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 63f760869651..4d678cfc81b1 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -792,10 +792,12 @@ __cpufreq_cooling_register(struct device_node *np,
        struct cpufreq_cooling_device *cpufreq_dev;
        char dev_name[THERMAL_NAME_LENGTH];
        struct cpufreq_frequency_table *pos, *table;
+       struct cpumask temp_mask;
        unsigned int freq, i, num_cpus;
        int ret;
 
-       policy = cpufreq_cpu_get(cpumask_first(clip_cpus));
+       cpumask_and(&temp_mask, clip_cpus, cpu_online_mask);
+       policy = cpufreq_cpu_get(cpumask_first(&temp_mask));
        if (!policy) {
                pr_debug("%s: CPUFreq policy not found\n", __func__);
                return ERR_PTR(-EPROBE_DEFER);


This will also make this problem clear, otherwise it was just hidden in the
function call which was really easy to miss, as I missed it as well :(

-- 
viresh
