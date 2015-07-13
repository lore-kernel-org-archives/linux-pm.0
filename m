From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] acpi-cpufreq: Fix an acpi perf unregister issue
Date: Mon, 13 Jul 2015 07:58:59 +0530
Message-ID: <20150713022859.GA10415@linux>
References: <559F67E4.7010509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35668 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbGMC3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jul 2015 22:29:04 -0400
Received: by pactm7 with SMTP id tm7so198667869pac.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2015 19:29:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559F67E4.7010509@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On 10-07-15, 14:36, Pan Xinhui wrote:
> 
> As policy->cpu may not be same in acpi_cpufreq_cpu_init and
> acpi_cpufreq_cpu_exit. There is a risk that we use different *cpu* to
> un/register acpi performance. So acpi_processor_unregister_performance
> may not be able to do the cleanup work. That causes a memory leak. And
> if there will be another acpi_processor_register_performance call, it
> may also fail thanks to the internal check of pr->performace.
> 
> So we add a field *acpi_perf_cpu* to fix this issue.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
> Change from V1:
> 	comments update
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
