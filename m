From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/16] PM / OPP: multiple regulators & opp-transition support
Date: Fri, 11 Sep 2015 17:31:56 +0530
Message-ID: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36743 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbIKMCT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 08:02:19 -0400
Received: by padhk3 with SMTP id hk3so73532892pad.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 05:02:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This is rebased over following series that adds debugfs support to OPP
core: http://marc.info/?i=cover.1441354424.git.viresh.kumar%40linaro.org

This series extends V2 bindings support further to make it usable to
most of the platforms.

[1-2] update the bindings a bit to get them working for multiple
      regulators case.

[3-4] cleanups.
[5-7] Multiple regulator support
[8-16] OPP transition support, so that the user drivers can directly ask
       to switch device to a particular OPP, instead of them dealing
       with the complexity of handling clocks and voltages.

I have also got cpufreq-dt driver updated to work with the new bindings,
but holded-off those changes to keep this series smaller. Those were
another Nine patches.

For curious developers/reviewers, all required code (debugfs, this and
cpufreq-dt) is pushed to:

https://git.linaro.org/people/viresh.kumar/linux.git opp/multi-regulator-v1

Please help in getting this reviewed :)

Viresh Kumar (16):
  PM / OPP: Add 'supply-names' binding
  PM / OPP: Add 'opp-microvolt-triplets' binding
  PM / OPP: Improve debug print messages with pr_fmt
  PM / OPP: Rename routines specific to old bindings with _v1
  PM / OPP: Parse all power-supply related bindings together
  PM / OPP: Create separate structure for regulator/supplies
  PM / OPP: Add multiple regulators support
  PM / OPP: get/put regulators from OPP core
  PM / OPP: Disable OPPs that aren't supported by the regulators
  PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
  PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
  PM / OPP: Parse clock and voltage tolerance for v1 bindings
  PM / OPP: Manage device clk as well
  PM / OPP: Add dev_pm_opp_set_regulator() to specify regulator
  PM / OPP: Add dev_pm_opp_set_rate()
  PM / OPP: don't print error message for deferred probing

 Documentation/devicetree/bindings/opp/opp.txt |  40 +-
 drivers/base/power/opp/core.c                 | 637 +++++++++++++++++++++++---
 drivers/base/power/opp/cpu.c                  |   8 +-
 drivers/base/power/opp/debugfs.c              |  52 ++-
 drivers/base/power/opp/opp.h                  |  44 +-
 include/linux/pm_opp.h                        |  25 +
 6 files changed, 722 insertions(+), 84 deletions(-)

-- 
2.4.0

