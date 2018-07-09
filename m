From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 0/7] thermal: tsens: Refactoring for TSENSv2 IP
Date: Mon,  9 Jul 2018 16:57:33 +0530
Message-ID: <cover.1531133611.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series is a mixed bag:
- Some code moves to allow code sharing between different SoCs with v2 of
  the TSENS IP,
- a generic qcom,tsens-v2 property as a fallback compatible for all v2.x.y
  platforms,
- new platform support (sdm845)
- a cleanup patch and
- a DT change to have a common way to deal with the SROT and TM registers
  despite slightly different features across the IP family and different
  register offsets.

Changes since v4:
- Revert back to a single fallback bindind qcom,tsens-v2 as per Rob's
  suggestion.
- Rework how old (unsplit SROT and TM address space) DTs are handled by
  needing a 0x1000 offset but still sharing common code in tsens-v2.c
- Remove the patch to added TRDY checks while we investigate Matthias'
  reports
- Fix unit addressses for the two tsens blocks as per Stephen's comment.

Changes since v3:
- Introduce qcom,tsens-v2.4.0 property and make qcom,tsens-v2 a
  fallback, compatible property.
- Rename ops_v2 to ops_generic_v2

Changes since v2:

- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2
  property
- Added a DT patch to initialize tsens driver on sdm845, now that
  4.18-rc1 will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across
  sdm845 and 8996 due to different offsets

Amit Kucheria (7):
  thermal: tsens: Get rid of unused fields in structure
  thermal: tsens: Add support to split up register address space into
    two
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add generic support for TSENS v2 IP
  dt: thermal: tsens: Document the fallback DT property for v2 of TSENS
    IP
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 +++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-common.c                | 11 ++++++++
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 32 ++++++++++------------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  8 ++++--
 8 files changed, 81 insertions(+), 28 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (64%)

-- 
2.7.4
