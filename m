From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid using inactive policies
Date: Mon, 21 Nov 2016 09:07:31 +0530
Message-ID: <20161121033731.GA4722@vireshk-i7>
References: <2709142.YWmMDScDNY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36380 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbcKUDhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2016 22:37:35 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so125272820pgc.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2016 19:37:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2709142.YWmMDScDNY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 18-11-16, 13:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two places in the cpufreq core in which low-level driver
> callbacks may be invoked for an inactive cpufreq policy, which isn't
> guaranteed to work in general.  Both are due to possible races with
> CPU offline.
> 
> First, in cpufreq_get(), the policy may become inactive after
> the check against policy->cpus in cpufreq_cpu_get() and before
> policy->rwsem is acquired, in which case using it going forward may
> not be correct.
> 
> Second, an analogous situation is possible in cpufreq_update_policy().
> 
> Avoid using inactive policies by adding policy_is_inactive() checks
> to the code in the above places.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>  Initialize ret in cpufreq_update_policy() if the inactive policy check
>  doesn't pass.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
