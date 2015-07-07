From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Tue, 7 Jul 2015 20:04:43 +0530
Message-ID: <20150707143443.GT14598@linux>
References: <559BC96E.8020804@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32885 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbbGGOet (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 10:34:49 -0400
Received: by pdbdz6 with SMTP id dz6so32159849pdb.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 07:34:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559BC96E.8020804@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On 07-07-15, 20:43, Pan Xinhui wrote:
> 
> Drivers can store their internal per-policy information in
> policy->driver_data, lets use it.
> 
> we have benefits after this replacing.
> 1) memory saving.
> 2) policy is shared by several cpus, per_cpu seems not correct. using
> *driver_data* is more reasonable.
> 3) fix a memory leak in acpi_cpufreq_cpu_exit. as policy->cpu might
> change during cpu hotplug. So sometimes we cant't free *data*, use
> *driver_data* to fix it.
> 4) fix a zero return value of get_cur_freq_on_cpu. Only per_cpu of
> policy->cpu is set to *data*, if we try to get cpufreq on other cpus, we
> get zero instead of correct values. Use *driver_data* to fix it.
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
> Changes from V1:
> 	codes style fix, comments update
> 	move cpufreq_cpu_put(policy) after we get *driver_data*
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
