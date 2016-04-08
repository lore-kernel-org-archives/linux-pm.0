From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Call cpufreq_disable_fast_switch() in
 sugov_exit()
Date: Fri, 8 Apr 2016 11:49:29 +0530
Message-ID: <20160408061929.GG9674@vireshk-i7>
References: <2791888.n2Juh7mFmz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35839 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbcDHGTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 02:19:37 -0400
Received: by mail-pa0-f50.google.com with SMTP id td3so69176123pab.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 23:19:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2791888.n2Juh7mFmz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 23:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Due to differences in the cpufreq core's handling of runtime CPU
> offline and nonboot CPUs disabling during system suspend-to-RAM,
> fast frequency switching gets disabled after a suspend-to-RAM and
> resume cycle on all of the nonboot CPUs.
> 
> To prevent that from happening, move the invocation of
> cpufreq_disable_fast_switch() from cpufreq_exit_governor() to
> sugov_exit(), as the schedutil governor is the only user of fast
> frequency switching today anyway.
> 
> That simply prevents cpufreq_disable_fast_switch() from being called
> without invoking the ->governor callback for the CPUFREQ_GOV_POLICY_EXIT
> event (which happens during system suspend now).
> 
> Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
