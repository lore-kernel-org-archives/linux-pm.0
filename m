From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 00/16] Another round of tsens cleanups
Date: Wed, 12 Sep 2018 15:22:45 +0530
Message-ID: <cover.1536744310.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.

Patches [1-6] can directly be applied by Eduardo.
Patches [9-16] can directly be applied by Andy.
Patches [7-8] introduce a new check and needs review and can then be
applied completely separately by Eduardo. 

There is a *dependency* however. Patch 1 should be applied to the tree
before the DT changes in patches 9 and 10.

In this series, I've collected all outstanding tsens patches by combining
the patches from the v2 posting with 3 DT patches for sdm845 thermal zones
and msm8916 camera and gpu thermal zones. Details are as follows:

- splitup 8916 and 8974 register address spaces for SROT and TM
- cleanups: move to spdx, dead code removal, removal of id field
- Add support to map the SROT address space for DTs that list it separately
- Check if TSENS IP is enabled in firmware by querying the SROT space
- Add myself as maintainer of tsens
- Add one-off patches adding sdm845 thermal zones and msm8916 gpu and
  camera thermal zones to this series.

Changes since v2:
- Split up changes to code and dt and within dt, split into arm and arm64
  patches
- Rearrange the sequence of patches so that the thermal maintainer can pick
  up the first part and the platform maintainer can pick up the latter part
  of the series
- Drop patch 09/11 because it causes some issues on systems with
  non-contiguous enabled sensors e.g. db410c
- Drop patch 10/11 because reg-name property isn't encouraged
- Fix a bug on msm8916 to check if IP is enabled in firmware. This was due
  to the register being at a different offset on msm8916. Fixed by coding
  this information as private data.

Changes since v1:
- Split up changes that split the address space and added qcom,sensors
  property into two separate patches
- Remove brackets in typo correction patch

Amit Kucheria (16):
  thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address
    space
  thermal: tsens: Add SPDX license identifiers
  thermal: tsens: Get rid of dead code
  thermal: tsens: Rename map field in order to add a second address map
  thermal: tsens: Add the SROT address map
  MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
  thermal: tsens: Pass register offsets as private data
  thermal: tsens: Check if the IP is correctly enabled by firmware
  arm: dts: msm8974: thermal: split address space into two
  arm64: dts: msm8916: thermal: split address space into two
  arm: dts: msm8974: thermal: Add "qcom,sensors" property
  arm64: dts: msm8916: thermal: Add "qcom,sensors" property
  dt-bindings: thermal: Fix a typo in documentation
  arm64: dts: msm8916: Add gpu thermal zone
  arm64: dts: msm8916: Add camera thermal zone
  arm64: dts: sdm845: enable tsens thermal zones

 .../devicetree/bindings/thermal/thermal.txt   |   2 +-
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   6 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  47 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 170 ++++++++++++++++++
 drivers/thermal/qcom/tsens-8916.c             |  12 +-
 drivers/thermal/qcom/tsens-8960.c             |  41 ++---
 drivers/thermal/qcom/tsens-8974.c             |  12 +-
 drivers/thermal/qcom/tsens-common.c           |  62 ++++---
 drivers/thermal/qcom/tsens-v2.c               |   8 +-
 drivers/thermal/qcom/tsens.c                  |  19 +-
 drivers/thermal/qcom/tsens.h                  |  23 +--
 12 files changed, 309 insertions(+), 100 deletions(-)

-- 
2.17.1
