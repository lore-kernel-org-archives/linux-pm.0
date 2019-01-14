From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
Date: Mon, 14 Jan 2019 22:04:52 +0530
Message-ID: <cover.1547481320.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "moderated list:ARM/Mediatek SoC
        support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add a flag to be used by cpufreq drivers to tell cpufreq core to
auto-register themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others. 

Things needing fixing:
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.
 - The other pending issue is to fix allmodconfig that leaves us with
   CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
   references for functions defined in cpu_cooling.c

Amit Kucheria (10):
  cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
  cpufreq: Add a flag to auto-register a cooling device
  cpufreq: Replace open-coded << with BIT()
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/cpufreq-dt.c       | 14 ++----------
 drivers/cpufreq/cpufreq.c          | 17 ++++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 18 ++-------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++----------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-----------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++----------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++----------
 include/linux/cpufreq.h            | 36 ++++++++++++++++++++----------
 9 files changed, 55 insertions(+), 90 deletions(-)

-- 
2.17.1
