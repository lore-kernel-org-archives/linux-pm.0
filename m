From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: [RFC PATCH 0/9] Add support for QCOM Core Power Reduction
Date: Thu,  4 Apr 2019 07:09:21 +0200
Message-ID: <20190404050931.9812-1-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jorge.ramirez-ortiz@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a first RFC for Core Power Reduction (CPR), a form of
Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.

Since this is simply an RFC, things like MAINTAINERS hasn't
been updated yet.

CPR is a technology that reduces core power on a CPU or on other device.
It reads voltage settings from efuses (that have been written in production),
it uses these voltage settings as initial values, for each OPP.

After moving to a certain OPP, CPR monitors dynamic factors such as
temperature, etc. and adjusts the voltage for that frequency accordingly
to save power and meet silicon characteristic requirements.

This driver is based on an RFC by Stephen Boyd[1], which in turn is
based on work by others on codeaurora.org[2].

[1] https://lkml.org/lkml/2015/9/18/833
[2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10


Jorge Ramirez-Ortiz (3):
  drivers: regulator: qcom_spmi: enable linear range info
  cpufreq: qcom: support qcs404 on nvmem driver
  cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Niklas Cassel (5):
  cpufreq: qcom: create a driver struct
  dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
  dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
  power: avs: Add support for CPR (Core Power Reduction)
  arm64: dts: qcom: qcs404: Add CPR and populate OPP tables

Sricharan R (1):
  cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem
    based qcom socs

 ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |   16 +-
 .../devicetree/bindings/opp/qcom-opp.txt      |   24 +
 .../bindings/power/avs/qcom,cpr.txt           |  119 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  152 +-
 drivers/cpufreq/Kconfig.arm                   |    4 +-
 drivers/cpufreq/Makefile                      |    2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
 ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} |  197 +-
 drivers/power/avs/Kconfig                     |   15 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/qcom-cpr.c                  | 1777 +++++++++++++++++
 drivers/regulator/qcom_spmi-regulator.c       |    7 +
 12 files changed, 2234 insertions(+), 81 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (97%)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (52%)
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.20.1
