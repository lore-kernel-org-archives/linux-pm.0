From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 0/7] PM / OPP: per OPP node clock support and imx7ulp
 cpufreq driver
Date: Mon, 11 Sep 2017 15:28:06 +0800
Message-ID: <20170911072806.GB19297@b29396-OptiPlex-7040>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35522 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdIKH2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2017 03:28:15 -0400
Content-Disposition: inline
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com

Hi Viresh and Rafael,

On Thu, Aug 24, 2017 at 12:10:03AM +0800, Dong Aisheng wrote:
> This patch series does three things:
> 1) Add platform specific set_clk function
> 2) Add per OPP node clock support
> 3) Add imx7ulp cpufreq driver support
> 
> 3 is depends on 1 & 2.
> 
> MX7ULP supports HSRUN mode (528 Mhz), RUN mode (413 Mhz) and VLPR mode
> (restricted to FIRC clock, usually 48 Mhz). This patch adds the cpufreq
> driver support for HSRUN and RUN mode.
> When in different modes, the A7 core is using different clocks:
> RUN:	clk run_divcore
> HSRUN:	clk hsrun_divcore
> 
> Thus, this driver replies on the newly added features in OPP core framework
> patch 1~6: e.g.
> "PM / OPP: use OPP node clock to set CPU frequency"
> 
> And since IMX7ULP CPU clock setting is different from the generic
> set OPP clock, we also implemented a private set_clk function.
> 
> Dong Aisheng (7):
>   PM / OPP: Add platform specific set_clk function
>   dt-bindings: PM / OPP: add clocks per OPP node support
>   PM / OPP: rename opp_table->clk to opp_table->cur_clk
>   PM / OPP: use OPP node clock to set CPU frequency
>   PM / OPP: Add dev_pm_opp_get_cur_clk()
>   cpufreq: make cpufreq_generic_init transition_latency default to
>     CPUFREQ_ETERNAL
>   cpufreq: add imx7ulp cpufreq driver
> 

Do you have any comments about this series?

Regards
Dong Aisheng

>  Documentation/devicetree/bindings/opp/opp.txt |  52 ++++++
>  drivers/base/power/opp/core.c                 | 155 ++++++++++++++---
>  drivers/base/power/opp/of.c                   |   8 +
>  drivers/base/power/opp/opp.h                  |  11 +-
>  drivers/cpufreq/Kconfig.arm                   |   8 +
>  drivers/cpufreq/Makefile                      |   1 +
>  drivers/cpufreq/cpufreq.c                     |   2 +
>  drivers/cpufreq/imx7ulp-cpufreq.c             | 234 ++++++++++++++++++++++++++
>  include/linux/pm_opp.h                        |  16 ++
>  9 files changed, 466 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/cpufreq/imx7ulp-cpufreq.c
> 
> -- 
> 2.7.4
> 
