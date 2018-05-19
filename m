From: Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for QCOM cpufreq FW driver
Date: Sat, 19 May 2018 23:04:49 +0530
Message-ID: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, robh@kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

 [v2]
   * Address comments given in v0 series.

 [v1]
    * Fixed compilation reported by Amit K.

The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this firmware.

Taniya Das (2):
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
  cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver

 .../bindings/cpufreq/cpufreq-qcom-fw.txt           |  68 +++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c                  | 317 +++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
