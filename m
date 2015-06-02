From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/6] Support CPR on MSM8916
Date: Mon,  1 Jun 2015 18:47:53 -0700
Message-ID: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57797 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbbFBBsB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 21:48:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>

This patch series adds support for CPR on MSM8916. It depends on
a few different patch series to be fully functional. It needs SPMI
regulator support[1] and secondly it needs the NVMEM framework[2].
It also needs a patch that provides a "corner" voting mechanism to the
SMD RPM regulators (and it relies on the SMD RPM regulators to function
properly). If possible I would like to get rid of that patch entirely.
Finally it needs CPU clock support to support scaling CPU frequencies.
Once you have those 4 or 5 patch series in place you can apply these
patches and enable cpufreq-dt and add the cpufreq-dt device (maybe the
CPR driver should add the cpufreq-dt device?) and you'll see interrupts
for CPR and OPP voltage adjustments triggering CPUfreq to modify voltages.

Stephen Boyd (6):
  regulator: core: Don't spew backtraces on duplicate sysfs
  regulator: core: Print at debug level on debugfs creation failure
  PM / OPP: Support adjusting OPP voltages at runtime
  OPP: Allow notifiers to call dev_pm_opp_get_{voltage,freq} RCU-free
  cpufreq-dt: Handle OPP voltage adjust events
  power: avs: Add support for CPR (Core Power Reduction)

 drivers/base/power/opp.c     |   96 +-
 drivers/cpufreq/cpufreq-dt.c |   73 +-
 drivers/power/avs/Kconfig    |   14 +
 drivers/power/avs/Makefile   |    1 +
 drivers/power/avs/qcom-cpr.c | 1983 ++++++++++++++++++++++++++++++++++++++++++
 drivers/regulator/core.c     |    6 +-
 include/linux/pm_opp.h       |   10 +
 7 files changed, 2166 insertions(+), 17 deletions(-)
 create mode 100644 drivers/power/avs/qcom-cpr.c

[1]  http://lkml.kernel.org/r/1431466787-32247-1-git-send-email-sboyd@codeaurora.org
[2]  http://lkml.kernel.org/r/1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

