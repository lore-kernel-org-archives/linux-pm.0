From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 0/5] thermal: tsens: Prepare for version 2 of TSENS IP
Date: Tue, 12 Jun 2018 13:54:52 +0300
Message-ID: <cover.1528799892.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM64 PORT
        AARCH64 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This series is a mixed bag: Some code moves to deal with version 2 of the
TSENS IP in common functions, new platform support (sdm845), a cleanup
patch and a DT change to have a common way to deal with the SROT and TM
registers despite slightly different features across the IP family and
different register offsets.

I can merge the tsens-8996.c and tsens-sdm845.c files into a tsens-v2.c if
desired.

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across sdm845 and
  8996 due to different offsets

Amit Kucheria (5):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Move 8996 get_temp() to common code for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 +++-
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-8996.c                  | 74 +-------------------
 drivers/thermal/qcom/tsens-common.c                | 78 +++++++++++++++++++---
 drivers/thermal/qcom/tsens-sdm845.c                | 15 +++++
 drivers/thermal/qcom/tsens.c                       |  3 +
 drivers/thermal/qcom/tsens.h                       |  8 ++-
 8 files changed, 107 insertions(+), 86 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

-- 
2.7.4
