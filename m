From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 0/5] Support CPR on MSM8916
Date: Fri, 18 Sep 2015 17:52:04 -0700
Message-ID: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

This patch series adds support for CPR on MSM8916. The first
patch exposes a corner voting API to the CPR driver so that we can
change the corner for the MX regulator. If possible I would
like to make this patch prettier, but I don't have any great
ideas right now. The next patch adds support to adjust voltages in the OPP
layer, and then hooks that up to cpufreq-dt so that we can adjust
the voltage in response to what CPR tells us to do. I've also thrown
in a patch to make RCU lockdep warnings go away, but I'm not sure if it's
right. There's still work to do.

The final patch adds the CPR driver. This still has some rough edges. With
the OPPv2 bindings I'm thinking of moving the frequency tables into DT
and adding a custom vendor property to describe which fuse corner to use for
each frequency.

Once you have these patches in place along with a CPU clock driver you
can eanble enable cpufreq-dt and add the cpufreq-dt device (maybe the
CPR driver should add the cpufreq-dt device?) and you'll see interrupts
for CPR and OPP voltage adjustments triggering CPUfreq to modify voltages.

Andy Gross (1):
  regulator: smd: Add floor and corner operations

Stephen Boyd (4):
  PM / OPP: Support adjusting OPP voltages at runtime
  OPP: Allow notifiers to call dev_pm_opp_get_{voltage,freq} RCU-free
  cpufreq-dt: Handle OPP voltage adjust events
  power: avs: Add support for CPR (Core Power Reduction)

 .../devicetree/bindings/power/avs/qcom,cpr.txt     |  125 ++
 drivers/base/power/opp.c                           |   96 +-
 drivers/cpufreq/cpufreq-dt.c                       |   63 +-
 drivers/power/avs/Kconfig                          |   15 +
 drivers/power/avs/Makefile                         |    1 +
 drivers/power/avs/qcom-cpr.c                       | 1999 ++++++++++++++++++++
 drivers/regulator/qcom_smd-regulator.c             |   52 +
 include/linux/pm_opp.h                             |   11 +
 include/linux/regulator/qcom_smd-regulator.h       |   30 +
 9 files changed, 2378 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 create mode 100644 drivers/power/avs/qcom-cpr.c
 create mode 100644 include/linux/regulator/qcom_smd-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
