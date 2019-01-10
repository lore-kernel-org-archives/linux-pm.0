From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 0/7] Thermal throttling for SDM845
Date: Thu, 10 Jan 2019 05:30:49 +0530
Message-ID: <cover.1547078153.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Javi Merino <javi.merino@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add support for thermal throttling on SDM845. 

We introduce a generic .ready callback to be used by cpufreq drivers to
register as a thermal cooling device. If this approach is acceptable I can
send a series converting other cpufreq drivers to use this callback.

Amit Kucheria (7):
  drivers: thermal: of-thermal: Print name of device node with error
  drivers: cpufreq: Add thermal_cooling_device pointer to struct
    cpufreq_policy
  cpu_cooling: Add generic driver ready callback
  cpufreq: qcom-hw: Move to device_initcall
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  arm64: dts: sdm845: Increase alert trip point to 95 degrees
  arm64: dts: sdm845: wireup the thermal trip points to cpufreq

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 161 +++++++++++++++++++++++++--
 drivers/cpufreq/qcom-cpufreq-hw.c    |   7 +-
 drivers/thermal/cpu_cooling.c        |  18 +++
 drivers/thermal/of-thermal.c         |   4 +-
 include/linux/cpu_cooling.h          |   9 ++
 include/linux/cpufreq.h              |   2 +
 6 files changed, 190 insertions(+), 11 deletions(-)

-- 
2.17.1
