From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/16] PM / OPP: Introduce APIs to transition OPPs
Date: Thu, 28 Jan 2016 13:50:29 +0530
Message-ID: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36783 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965103AbcA1IUx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:20:53 -0500
Received: by mail-pf0-f180.google.com with SMTP id n128so19727671pfn.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 00:20:52 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This patchset add APIs in OPP layer to allow OPPs transitioning from
within OPP layer. Currently all OPP users need to replicate the same
code to switch between OPPs. While the same can be handled easily by
OPP-core.

The first 7 patches update the OPP core to introduce the new APIs and
the next Nine patches update cpufreq-dt for the same.

11 out of 17 are already Reviewed by Stephen, only few are left :)

@Rafael: I will send a pull request once that is done.

Testing:
- Tested on exynos 5250-arndale (dual-cortex-A15)
- Tested for both Old-V1 bindings and New V2 bindings
- Tested with regulator names as: 'cpu-supply' and 'cpu0-supply'
- Tested with Unsupported supply ranges as well, to check the
  opp-disable logic

V1->V2:
- Locking fixes as suggested by Stephen
- Made dev_pm_opp_put_regulator(), as we can't rely on dev_name() to get
  name of the supply (Stephen/Mark B.)
- Other minor modifications

Viresh Kumar (16):
  PM / OPP: get/put regulators from OPP core
  PM / OPP: Disable OPPs that aren't supported by the regulator
  PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
  PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
  PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
  PM / OPP: Manage device clk
  PM / OPP: Add dev_pm_opp_set_rate()
  cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
  cpufreq: dt: Rename 'need_update' to 'opp_v1'
  cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
  cpufreq: dt: Pass regulator name to the OPP core
  cpufreq: dt: Unsupported OPPs are already disabled
  cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
  cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
  cpufreq: dt: drop references to DT node
  cpufreq: dt: No need to allocate resources anymore

 drivers/base/power/opp/core.c | 420 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h  |  13 ++
 drivers/cpufreq/cpufreq-dt.c  | 290 ++++++++++-------------------
 include/linux/pm_opp.h        |  27 +++
 4 files changed, 555 insertions(+), 195 deletions(-)

-- 
2.7.0.79.gdc08a19

