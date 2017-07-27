From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Thu, 27 Jul 2017 02:03:39 +0200
Message-ID: <2684007.FU6l9NfBCM@aspire.rjw.lan>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48932 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751175AbdG0ALk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 20:11:40 -0400
In-Reply-To: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Cc: linux-pm@vger.kernel.org, waldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On Wednesday, July 26, 2017 02:11:38 PM Waldemar Rymarkiewicz wrote:
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
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Please fix the build issue reported by 0-day introduced by this patch.

Thanks,
Rafael
