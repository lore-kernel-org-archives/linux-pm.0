From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: governor: Rearrange governor data structures
Date: Sun, 7 Feb 2016 21:25:55 +0530
Message-ID: <20160207155555.GJ3808@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2998470.K7oslgfuja@vostro.rjw.lan>
 <2710262.Af7Ngczbqf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32855 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbcBGPz6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 10:55:58 -0500
Received: by mail-pa0-f51.google.com with SMTP id cy9so60737740pac.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 07:55:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2710262.Af7Ngczbqf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 07-02-16, 16:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The struct policy_dbs_info objects representing per-policy governor
> data are not accessible directly from the corresponding policy
> objects.  To access them, one has to get a pointer to the
> struct cpu_dbs_info of policy->cpu and use the policy_dbs field of
> that which isn't really straightforward.
> 
> To address that rearrange the governor data structures so the
> governor_data pointer in struct cpufreq_policy will point to
> struct policy_dbs_info (instead of struct dbs_data) and that will
> contain a pointer to struct dbs_data.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c |    3 -
>  drivers/cpufreq/cpufreq_conservative.c |    6 +-
>  drivers/cpufreq/cpufreq_governor.c     |   74 ++++++++++++++++-----------------
>  drivers/cpufreq/cpufreq_governor.h     |   27 ++++++------
>  drivers/cpufreq/cpufreq_ondemand.c     |   18 ++++----
>  5 files changed, 68 insertions(+), 60 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
