From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/9] qcom: Add support for TSENS driver
Date: Wed,  8 Jul 2015 15:17:09 +0530
Message-ID: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Changes since RFC:
* Added support for 8916 and 8084
* Based off the latest nvmem framework patches [1]
* Minor review fixes for comments mostly from Lina

** I have also added irq support using the hardware
trip point support series [2]. Will post that
out seperately.

This is an attempt to have a single TSENS driver for
the different versions of the TSENS IP that exist, on
different qcom msm/apq SoCs'
Support is added for msm8916, msm8960 and msm8974 families.
Based on top of the latest nvmem framework patches [2]

A lot of the work is based of original code from Stephen Boyd
and Siddartha Mohanadoss. I have also picked some of what
Narendran Rajan did in his attempt to upstream the support
for 8960 family. I could not keep the original authorship on
any of the patches because I ended up moving the code around
quite a bit in an effort to have a single driver for the
various devices. I would be glad to change the authorship
for any of the patches if needed.

[1] https://lkml.org/lkml/2015/6/22/609
[2] https://lkml.org/lkml/2015/5/20/472

Rajendra Nayak (8):
  thermal: qcom: tsens: Add a skeletal TSENS drivers
  thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
  thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
  thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
  arm: dts: msm8974: Add thermal zones, tsens and eeprom nodes
  arm: dts: apq8064: Add thermal zones, tsens and eeprom nodes
  arm: dts: apq8084: Add thermal zones, tsens and eeprom nodes
  arm64: dts: msm8916: Add thermal zones, tsens and eeprom nodes

Srinivas Kandagatla (1):
  clk: qcom: gcc-msm8960: add child devices support.

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  37 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 108 ++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 105 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 105 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  66 +++++
 drivers/clk/qcom/gcc-msm8960.c                     |   4 +-
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens-8916.c                  | 107 ++++++++
 drivers/thermal/qcom/tsens-8960.c                  | 291 +++++++++++++++++++++
 drivers/thermal/qcom/tsens-8974.c                  | 239 +++++++++++++++++
 drivers/thermal/qcom/tsens-common.c                | 128 +++++++++
 drivers/thermal/qcom/tsens.c                       | 209 +++++++++++++++
 drivers/thermal/qcom/tsens.h                       |  69 +++++
 16 files changed, 1485 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-8960.c
 create mode 100644 drivers/thermal/qcom/tsens-8974.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
