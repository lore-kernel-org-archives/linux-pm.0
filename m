From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH] cpufreq: governor: Change the calculation of load
 for deferred updates
Date: Fri, 18 Nov 2016 08:45:05 +0530
Message-ID: <20161118031504.GC3110@vireshk-i7>
References: <4f7f7d9e-4b6b-a9f8-bf54-a6d99bd952c6@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33058 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbcKRDVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 22:21:41 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so98191208pgd.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2016 19:21:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4f7f7d9e-4b6b-a9f8-bf54-a6d99bd952c6@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 17-11-16, 21:54, Stratos Karafotis wrote:
> Commit 18b46abd0009 ("cpufreq: governor: Be friendly towards latency-
> sensitive bursty workloads"), introduced a method to copy the calculated
> load from the previous sampling period in case of a deferred timer
> (update).
> 
> This helps on bursty workloads but generally coping the load for the
> previous measurement could be arbitrary, because of the possibly different
> nature of the new workload.
> 
> Instead of coping the load from the previous period we can calculate the
> load considering that between the two samples, the busy time is comparable
> to one sampling period. Thus:
> 
>  busy = time_elapsed - idle_time
> 
> and
> 
>  load = 100 * busy / sampling_rate;
> 
> Also, remove the 'unlikely' hint because it seems that a deferred update
> is a very common case on most modern systems.

You have any numbers to prove that this improves something ?

-- 
viresh
