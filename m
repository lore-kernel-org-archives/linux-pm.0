From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date: Thu, 14 Jun 2018 13:43:10 +0300
Message-ID: <cover.1528972165.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM64 PORT
        AARCH64 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This series is a mixed bag: Some code moves to deal with v2 of the
TSENS IP into common functions, a new qcom,tsens-v2 DT property to cover
all v2 platforms, new platform support (sdm845), a cleanup
patch and a DT change to have a common way to deal with the SROT and TM
registers despite slightly different features across the IP family and
different register offsets.

Rob, I haven't added your Ack to patch 4 because it changed a bit.

Regards,
Amit

Changes since v2:
- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2 property
- Added a DT patch to initialize tsens driver on sdm845, now that 4.18-rc1
  will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across sdm845 and
  8996 due to different offsets


Amit Kucheria (6):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 42 +++++++++++++---------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  7 ++--
 7 files changed, 61 insertions(+), 22 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (65%)

-- 
2.7.4
