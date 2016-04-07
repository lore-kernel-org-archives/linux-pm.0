From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Thu, 7 Apr 2016 09:58:20 +0530
Message-ID: <20160407042820.GA14903@vireshk-i7>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33888 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcDGE2X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 00:28:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id fe3so46801693pab.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 21:28:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2044559.GVlD7a2JcO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 03:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since governor operations are generally skipped if cpufreq_suspended
> is set, do nothing at all in cpufreq_start_governor() and
> cpufreq_exit_governor() in that case.
> 
> In particular, this prevents fast frequency switching from being
> disabled after a suspend-to-RAM cycle on all CPUs except for the
> boot one.

static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
{
	int ret;

	/* Don't start any governor operations if we are entering suspend */
	if (cpufreq_suspended)
		return 0;

        ...

}

Above already guarantees that we would start/stop governors. Why do we
need this change then ?


-- 
viresh
