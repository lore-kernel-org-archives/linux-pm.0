From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/10] cpufreq: ondemand: only queue canceled works from
 update_sampling_rate()
Date: Fri, 26 Jun 2015 12:58:13 +0530
Message-ID: <20150626072813.GE16275@linux>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
 <4a478b21805d9454ce48e115ab1b7bc61f06cabb.1434959517.git.viresh.kumar@linaro.org>
 <558CF647.4020308@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36791 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbbFZH2T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 03:28:19 -0400
Received: by paceq1 with SMTP id eq1so64050433pac.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 00:28:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558CF647.4020308@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 26-06-15, 12:20, Preeti U Murthy wrote:
> On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> > The sampling rate is updated with a call to update_sampling_rate(), and
> > we process CPUs one by one here. While the work is canceled on per-cpu
> > basis, it is getting enqueued (by mistake) for all policy->cpus.
> > 
> > That would result in wasting cpu cycles for queuing works which are
> > already queued and never canceled.
> > 
> > This patch is about queuing work only on the cpu for which it was
> > canceled earlier.
> > 
> > gov_queue_work() was missing the CPU parameter and it's better to club
> > 'modify_all' and the new 'cpu' parameter to a 'cpus' mask. And so this
> > patch also changes the prototype of gov_queue_work() and fixes its
> > caller sites.
> 
> This looks good, except I did not understand the motivation to change
> the 'modify_all' to 'load_eval'. Neither is saying the purpose better
> than the other.

modify_all was used to check if we need to queue work on all CPUs or a
single cpu. But now we pass the cpumask and that name isn't valid
anymore. The only other thing we do with help of modify_all is
evaluating the load again and so is named load_eval.

I think the purpose is very much clear with load_eval now.

-- 
viresh
