From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 0/9] Thermal throttling for SDM845
Date: Mon, 14 Jan 2019 15:51:02 +0530
Message-ID: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Javi Merino <javi.merino@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add support for thermal throttling on SDM845. 

We introduce a generic flag to be used by cpufreq drivers to tell the
cpufreq core to auto-register a thermal cooling device.

There are a few miscellaneous fixes to keep checkpatch happy.

If this approach is acceptable I can send a series converting other cpufreq
drivers to use this flag and get rid of driver code.

Amit Kucheria (9):
  [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
  drivers: thermal: of-thermal: Print name of device node with error
  drivers: cpufreq: Add thermal_cooling_device pointer to struct
    cpufreq_policy
  cpufreq: Add a flag to auto-register a cooling device
  cpufreq: Replace open-coded << with BIT()
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  arm64: dts: sdm845: Increase alert trip point to 95 degrees
  arm64: dts: sdm845: wireup the thermal trip points to cpufreq
  thermal: cpu_cooling: Clarify error message

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
 drivers/cpufreq/cpufreq.c            |  13 ++
 drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
 drivers/thermal/cpu_cooling.c        |   2 +-
 drivers/thermal/of-thermal.c         |   4 +-
 include/linux/cpufreq.h              |  34 +++--
 6 files changed, 210 insertions(+), 41 deletions(-)

-- 
2.17.1
