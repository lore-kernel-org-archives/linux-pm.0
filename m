From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 10/10] cpufreq: governor: Drop cpu argument from
 dbs_check_cpu()
Date: Fri, 5 Feb 2016 14:45:10 +0530
Message-ID: <20160205091510.GM21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2367498.ClbHvSsNAg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34199 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbcBEJPO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 04:15:14 -0500
Received: by mail-pa0-f50.google.com with SMTP id uo6so31775093pac.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2016 01:15:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2367498.ClbHvSsNAg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 03:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since policy->cpu is always passed as the second argument to
> dbs_check_cpu(), it is not really necessary to pass it, because
> the function can obtain that value via its first argument just fine.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    2 +-
>  drivers/cpufreq/cpufreq_governor.c     |    5 +++--
>  drivers/cpufreq/cpufreq_governor.h     |    2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     |    6 ++----
>  4 files changed, 7 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
