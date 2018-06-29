From: David Dai <daidavid1@codeaurora.org>
Subject: [RFC PATCH v1 0/2] Add QCOM SDM845 interconnect provider driver
Date: Fri, 29 Jun 2018 14:08:16 -0700
Message-ID: <1530306498-5181-1-git-send-email-daidavid1@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, daidavid1@codeaurora.org, amit.kucheria@linaro.org, ilina@codeaurora.org, seansw@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds a driver and DT binding using the interconnect (ICC)
framework [1] to describe the Qualcomm SDM845 platform's topology of its
interconnected buses and internal aggregation nodes known as
Bus Clock Managers(BCM). The SDM845 ICC provider driver would aggregate and
satisfy consumer requests accross the SoC by generating commands that
communicate with the BCM through the Resource Power Manager (RPMh) driver [2]
interface. The SDM845 ICC driver also configures QoS settings specific to each
node to ensure clients have proper priority.

The SDM845 interconnect provider has dependencies on the RPMh driver
and Command DB driver [3] which are under review.

Changes since v0 [4]:
 - Addressed review feedback from Georgi D. and Evan G.
 - Removed proposal to modify ICC aggregate callback interface
 - Moved BCM aggregation into provider set function
 - Added devicetree binding documentation
 - Fixed logic in generating TCS command list
 - Added keepalive flags for resources that are critical to platform operation
 - Added various comments to clarify intent
 - Removed unused types and struct definitions

[1]: https://lkml.org/lkml/2018/6/20/453
[2]: https://lkml.org/lkml/2018/5/9/729
[3]: https://lkml.org/lkml/2018/3/14/787
[4]: https://patchwork.kernel.org/patch/10428167/

Summary of the patches:
Patch 1 creates the Qualcomm SDM845 Specific provider driver.
Patch 2 Adds dt binding for SDM845 provider

TODO:
  * Expand aggregation/provider to handle clients with active only requirements.
  * Add Network-on-Chip (NoC) objects to encapsulate logical nodes for QoS.
  * Add QoS configuration specific to each NoC.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom-sdm845.txt          |  22 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/interconnect/qcom/Kconfig                  |   8 +
 drivers/interconnect/qcom/Makefile                 |   1 +
 drivers/interconnect/qcom/qcom-icc-ids.h           | 142 ++++
 drivers/interconnect/qcom/sdm845.c                 | 826 +++++++++++++++++++++
 6 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
 create mode 100644 drivers/interconnect/qcom/qcom-icc-ids.h
 create mode 100644 drivers/interconnect/qcom/sdm845.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
