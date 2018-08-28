From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 00/11] Another round of tsens cleanups
Date: Tue, 28 Aug 2018 19:08:29 +0530
Message-ID: <cover.1535462942.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc1.

In this series, we have the following:
- splitup 8916 and 8974 register address spaces for SROT and TM
- cleanups: move to spdx, dead code removal, removal of id field
- Add support to map the SROT address space for DTs that list it separately
- Check if TSENS IP is enabled in firmware by querying the SROT space
- Add reg-names property to get more readable outputs in /proc/iomem
- Add myself as maintainer of tsens

Changes since v1:
- Split up changes that split the address space and added qcom,sensors
  property into two separate patches
- Remove brackets in typo correction patch

Amit Kucheria (11):
  arm/arm64: dts: msm8974/msm8916: thermal: Split address space into two
  arm/arm64: dts: msm8974/msm8916: thermal: Add "qcom,sensors" property
  dt-bindings: thermal: Fix a typo in documentation
  thermal: tsens: Add SPDX license identifiers
  thermal: tsens: Get rid of dead code
  thermal: tsens: Rename map field in order to add a second address map
  thermal: tsens: Add the SROT address map
  thermal: tsens: Check if the IP is correctly enabled by firmware
  thermal: tsens: Get rid of 'id' field
  arm64: dts: qcom: Add reg-names for all tsens nodes
  MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers

 .../devicetree/bindings/thermal/thermal.txt   |  2 +-
 MAINTAINERS                                   |  7 +++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  7 ++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  7 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +
 drivers/thermal/qcom/tsens-8916.c             | 11 +---
 drivers/thermal/qcom/tsens-8960.c             | 41 +++++-------
 drivers/thermal/qcom/tsens-8974.c             | 11 +---
 drivers/thermal/qcom/tsens-common.c           | 62 ++++++++++++-------
 drivers/thermal/qcom/tsens-v2.c               |  6 +-
 drivers/thermal/qcom/tsens.c                  | 21 +------
 drivers/thermal/qcom/tsens.h                  | 24 +++----
 13 files changed, 99 insertions(+), 104 deletions(-)

-- 
2.17.1
