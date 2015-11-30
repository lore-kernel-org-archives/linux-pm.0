From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of
 information common to policy->cpus
Date: Mon, 30 Nov 2015 10:49:15 +0530
Message-ID: <20151130051915.GH3373@ubuntu>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
 <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org>
 <1448625400.3689.103.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33323 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbK3FT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 00:19:26 -0500
Received: by pabfh17 with SMTP id fh17so177806528pab.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 21:19:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448625400.3689.103.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 27-11-15, 12:56, Lucas Stach wrote:
> Sorry for being late to the party, as this has long been applied, but I
> stumbled upon this while looking at other stuff and wanted to express my
> finding.

No issues, we can still fix things if they have gone wrong.

> From a short look this change is totally bogus.

That's a bit shocking, after two people reviewed and tested it :)

> The *_dbs_timer functions are called from a workqueue on each CPU.

Right.

> Moving the time_stamp and the timer_mutex to a shared structure now
> causes a thundering herd issue on multicore systems.

You faced an issue or you just think that something is wrong ?

> All workqueues wake
> up at the same time with all but one of the worker bouncing on the
> contended mutex.

This is exactly what used to be done earlier, but it was designed
badly. For example, for ondemand governor, each CPU had a
struct od_cpu_dbs_info_s and we only used the od_cpu_dbs_info_s for
the 'policy->cpu'. So, even if all CPUs had this structure (i.e. the
time_stamp and the lock), we only used structure for policy->cpu.

> Also sharing the time_stamp causes all but the first worker to acquire
> the mutex to not properly update their sampling information, I guess.

Yeah, that's what we want per-policy.

> I didn't look to deeply into this.

Perhaps, yes.

-- 
viresh
