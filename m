From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v8] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 18 Dec 2014 14:51:27 +0530
Message-ID: <CAKohpokjchaxTrWEBjLEAyx2i32cScA-VgKH9iFRMF9D5b_pQw@mail.gmail.com>
References: <20141218085900.GA31027@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49991 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaLRJV2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 04:21:28 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so2351528obc.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 01:21:27 -0800 (PST)
In-Reply-To: <20141218085900.GA31027@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 18 December 2014 at 14:29, Srinidhi Kasagar
<srinidhi.kasagar@intel.com> wrote:
> This adds the SFI based cpu freq driver for some of the Intel's
> Silvermont based Atom architectures like Z34xx and Z35xx.
>
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> v2:
> (v2-v3: comments from Viresh)
> * rephrase the Kconfig text
> * merge the header file as its not being shared with anyone
> * remove the unnecessary checks in sfi_cpufreq_target
> * style changes in kzalloc
> * fix the potential memory leak sfi_cpufreq_cpu_init
> * move the cpufreq driver flag to the structure definition
> * remove the redundant init of policy->cpu and policy->cur
> * remove the unnecessary check while init the freq table
> * merge the for loops in cpu_init
> * use cpufreq_generic_attr rather than the custom one
>
> v3:
> * Add this change log
> * remove the left over not used cached_freq var
> * merge yet another for loop in cpu_init
>
> v4:
> * remove unnecessary pr_debug
> * rephrase Kconfig text
> * remove unused macro SFI_CPU_MAX
> * Add Viresh's Acked-by
>
> v5:
> (comments from Len Brown)
> * rename few private functions with sfi_cpufreq_ prefix
> * move the PERF_CTL_MASK to msr-index.h
> * make the driver.get current freq to refer PERF_CTRL
> * remove sfi_processor_px, rather reuse sfi_freq_table_entry
> * remove unnecessary memcpy, rather just point to the freq table
> * consolidate get_performance_states with parse_freq
> * remove extract_freq and make get_cur_freq to read from MSR directly
> * move the state_count check while registering the perf states
>
> v6:
> * release the mutex in case of error in register_performance
> (comments from Viresh)
> * drop local perf pointer in ->target and ->init
> * fix the order of freeing memories in the error path of ->init
> * remove alloc_percpu, rather allocate it at runtime in ->init
>
> v7:
> (comments from Len Brown)
> * drop the unnecessary mutex
> * move sfi_table_parse to __init as it is global to the system
> * drop ->get callback
> * consolidate few global data structures
>
> v8:
> (Viresh)
> * drop per-cpu usage
> (Len Brown)
> * drop the usage of SFI_FREQ_MAX
> * remove the logic of detecting transition_latency
> * remove the last redundant pr_debug in ->init

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
