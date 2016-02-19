From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 8/12] cpufreq: governor: Make governor private data
 per-policy
Date: Fri, 19 Feb 2016 08:06:10 +0530
Message-ID: <20160219023610.GB16983@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1954429.fugFc6iA7T@vostro.rjw.lan>
 <20160218060324.GN2610@vireshk-i7>
 <3406818.qR0GBpdcFz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35799 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946891AbcBSCgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 21:36:24 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so43663630pfc.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 18:36:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3406818.qR0GBpdcFz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: governor: Make governor private data per-policy
> 
> Some fields in struct od_cpu_dbs_info_s and struct cs_cpu_dbs_info_s
> are only used for a limited set of CPUs.  Namely, if a policy is
> shared between multiple CPUs, those fields will only be used for one
> of them (policy->cpu).  This means that they really are per-policy
> rather than per-CPU and holding room for them in per-CPU data
> structures is generally wasteful.  Also moving those fields into
> per-policy data structures will allow some significant simplifications
> to be made going forward.
> 
> For this reason, introduce struct cs_policy_dbs_info and
> struct od_policy_dbs_info to hold those fields.  Define each of the
> new structures as an extension of struct policy_dbs_info (such that
> struct policy_dbs_info is embedded in each of them) and introduce
> new ->alloc and ->free governor callbacks to allocate and free
> those structures, respectively, such that ->alloc() will return
> a pointer to the struct policy_dbs_info embedded in the allocated
> data structure and ->free() will take that pointer as its argument.
> 
> With that, modify the code accessing the data fields in question
> in per-CPU data objects to look for them in the new structures
> via the struct policy_dbs_info pointer available to it and drop
> them from struct od_cpu_dbs_info_s and struct cs_cpu_dbs_info_s.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This adds a header file for the definitions of data structures shared
> between ondemand and amd_freq_sensitivity.
> 
> The latter is updated to look for the governor tunables in struct od_policy_dbs_info
> instead of struct od_cpu_dbs_info_s.
> 
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c |    5 +---
>  drivers/cpufreq/cpufreq_conservative.c |   34 +++++++++++++++++++++++++++++----
>  drivers/cpufreq/cpufreq_governor.c     |    7 ++----
>  drivers/cpufreq/cpufreq_governor.h     |    9 +-------
>  drivers/cpufreq/cpufreq_ondemand.c     |   34 +++++++++++++++++++++++----------
>  drivers/cpufreq/cpufreq_ondemand.h     |   26 +++++++++++++++++++++++++
>  6 files changed, 87 insertions(+), 28 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
