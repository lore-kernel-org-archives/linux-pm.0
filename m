From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Wed, 26 Jul 2017 11:46:37 +0530
Message-ID: <20170726061637.GZ352@vireshk-i7>
References: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35377 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdGZGQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 02:16:40 -0400
Received: by mail-pg0-f53.google.com with SMTP id v190so79965114pgv.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jul 2017 23:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

+Rafael,

On 24-07-17, 18:03, Waldemar Rymarkiewicz wrote:
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
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/of.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

@Waldemar: I don't see this series on patchwork [1]. Are you
subscribed for that list ?

-- 
viresh

[1] https://patchwork.kernel.org/project/linux-pm/list/
