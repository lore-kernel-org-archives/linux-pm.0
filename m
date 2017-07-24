From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Mon, 24 Jul 2017 14:17:13 +0530
Message-ID: <20170724084713.GR352@vireshk-i7>
References: <20170721121403.31202-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33944 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdGXIrQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 04:47:16 -0400
Received: by mail-pg0-f50.google.com with SMTP id 123so54442376pgj.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2017 01:47:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170721121403.31202-1-waldemarx.rymarkiewicz@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Cc: linux-pm@vger.kernel.org, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 21-07-17, 14:13, Waldemar Rymarkiewicz wrote:
> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
> exist. This can happen on platforms where not all possible CPUs are
> available at start up ie. hotplugged out. Cpu device is not registered in
> the system so we are not able to check struct device to set the sharing
> CPUs bitmask properly.
> 
> Example (real use case):
> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> due to the fact there is no struct device for cpu1 (remains offline at
> bootup).
> 
> To solve the bug, stop using device struct to check device_node. Instead
> get cpu device_node directly from device tree with of_get_cpu_node().
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> ---
>  drivers/base/power/opp/of.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
