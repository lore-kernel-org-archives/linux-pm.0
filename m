From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of
 information common to policy->cpus
Date: Thu, 3 Dec 2015 10:24:25 +0530
Message-ID: <20151203045425.GA4302@ubuntu>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
 <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org>
 <1448625400.3689.103.camel@pengutronix.de>
 <20151130051915.GH3373@ubuntu>
 <1448879672.8275.15.camel@pengutronix.de>
 <20151130110327.GC4899@ubuntu>
 <565F661F.1020204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34225 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbbLCEy3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 23:54:29 -0500
Received: by padhx2 with SMTP id hx2so60388563pad.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2015 20:54:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <565F661F.1020204@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de

On 02-12-15, 13:43, Saravana Kannan wrote:
> There's a separate thread where we proposed a fix to deferrable
> timers that are stored globally if they are not CPU bound. That way,
> even if one CPU is up, they get handled. But TGLX had some valid
> concerns with cache thrashing and impact on some network code. So,
> last I heard, he was going to rewrite and fixed the deferrable timer
> problem by having the "orphaned" (because CPU has gone idle)
> deferrable timers being adopted by other CPUs while the original CPU
> is idle.
> 
> Once that's fixed, we just need one timer per policy. Long story
> short, CPU freq is working around a poor API semantic of deferrable
> timers.

There is another idea that I have.

Lets sacrifice idleness of CPU0 (which is already considered as
housekeeping CPU in scheduler) to save us from all the complexity we
have today.

Suppose we have 16 CPUs, with 4 CPUs per policy and hence 4 policies.
- Keep a single delayed-work (non-deferrable) per policy and queue them as:
  queue_work_on(CPU0).
- This will work because any CPU can calculate the load of other CPUs,
  and there is no dependency on the local CPU.
- CPU0 will hence get interrupted, check if the policy->cpus are idle
  or not, and if not, update their frequency (perhaps with an IPI).

Not sure if this will be better performance wise though.

-- 
viresh
