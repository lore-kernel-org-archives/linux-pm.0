From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 00/13] qcom: Add support for GDSCs
Date: Thu,  6 Aug 2015 16:07:41 +0530
Message-ID: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

GDSCs (Global Distributed Switch Controllers) control switches
that supply power to an on-chip power domain and hence can be
programmed in SW to safely power collapse and restore power to the
respective PDs. They are part of a considerable number of recent QCOM
SoCs (This series adds support for msm8974, msm8916 and apq8084 devices)
and are part of the Clock control block.

The series implements support for GDSC using the genpd framework
modelling these as SW controllable power domains and uses PM clocks
to control clocks within the gdsc.

* Client drivers which plan to use GDSC can refer to
  Documentation/devicetree/bindings/power/power_domain.txt to know
  how to hook up the power domain for the device through DT
* Runtime PM specific documentation can be found in
  Documentation/power/runtime_pm.txt
* Patches are based of 4.2-rc5

Tested with and without CONFIG_PM on db8074, IFC6540 and
db410c (arm64)

Changes since v7:
* used of_clk_get_from_provider() instead of a con_id based clk_get()
This is based on an offlist discussion with Stephen.
* Moved the clock control patches to the end of the series, to enable
the rest of the gdsc support patches (1 to 10) to get merged if
clock control needs more discussions
* Added missing gdscs' from mmcc apq8084 (pointed to by Stan)

Changes since v6:
* removed hardcoded con_ids, now part of gdsc struct
* other minor review fixes

Changes since v5:
* Added support to manage clocks with !CONFIG_PM
* Added RET/OFF support
* Added support to assert/deassert reset while the GDSC is ON

Changes since v4:
* Added clock control support using PM clocks
* Included WA to enable an RCG (needed for Oxili gdsc in 8916)

Changes since v3:
* static inline'd gdsc_register/unregister stubs
* error check fixes in gdsc_register
* dropped oxili_gdsc for 8916 as its broken and needs additional
WA's not part of this series
* split dts and driver changes into seperate patches

Changes since v2:
* gdsc_unregister added
* gdsc_register/unregister introduced in patch 1/6

Changes since v1:
* added err checks for regmap apis
* added gdsc_register() in gdsc.c

Rajendra Nayak (9):
  clk: qcom: gdsc: Prepare common clk probe to register gdscs
  clk: qcom: gdsc: Add support for Memory RET/OFF
  clk: qcom: gdsc: Add support for ON only state
  clk: qcom: gdsc: Add GDSCs in msm8916 GCC
  clk: qcom: gdsc: Add GDSCs in apq8084 GCC
  arm: dts: qcom: Add #power-domain-cells property
  clk: qcom: gdsc: Use PM clocks to control gdsc clocks
  clk: qcom: gdsc: Enable an RCG before turing on the gdsc
  clk: qcom: gdsc: Manage clocks with !CONFIG_PM

Stephane Viau (1):
  clk: qcom: gdsc: Add GDSCs in apq8084 MMCC

Stephen Boyd (3):
  clk: qcom: Add support for GDSCs
  clk: qcom: gdsc: Add GDSCs in msm8974 GCC
  clk: qcom: gdsc: Add GDSCs in msm8974 MMCC

 arch/arm/boot/dts/qcom-apq8084.dtsi           |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |   1 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/common.c                     |  16 +-
 drivers/clk/qcom/common.h                     |   2 +
 drivers/clk/qcom/gcc-apq8084.c                |  42 +++
 drivers/clk/qcom/gcc-msm8916.c                |  52 ++++
 drivers/clk/qcom/gcc-msm8974.c                |  15 +
 drivers/clk/qcom/gdsc.c                       | 379 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h                       |  87 ++++++
 drivers/clk/qcom/mmcc-apq8084.c               |  86 +++++-
 drivers/clk/qcom/mmcc-msm8974.c               |  72 +++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h  |   6 +
 include/dt-bindings/clock/qcom,gcc-msm8916.h  |   8 +
 include/dt-bindings/clock/qcom,gcc-msm8974.h  |   3 +
 include/dt-bindings/clock/qcom,mmcc-apq8084.h |  10 +
 include/dt-bindings/clock/qcom,mmcc-msm8974.h |   8 +
 19 files changed, 798 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/gdsc.c
 create mode 100644 drivers/clk/qcom/gdsc.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
