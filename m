From: David Dai <daidavid1@codeaurora.org>
Subject: [PATCH v3 0/2] Add sdm845 interconnect provider driver
Date: Thu, 23 Aug 2018 18:56:52 -0700
Message-ID: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, daidavid1@codeaurora.org, amit.kucheria@linaro.org, ilina@codeaurora.org, seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds a driver and DT binding using the interconnect (ICC)
framework [1] to describe the Qualcomm SDM845 platform's topology of its
interconnected buses and internal aggregation nodes known as
Bus Clock Managers(BCM). The SDM845 ICC provider driver would aggregate and
satisfy consumer requests across the SoC by generating commands that
communicate with the BCM through the Resource Power Manager (RPMh) driver [2]
interface. The SDM845 ICC driver also configures QoS settings specific to each
node to ensure clients have proper priority.

The SDM845 interconnect provider has dependencies on the RPMh driver
and Command DB driver [3].

Changes in v3 [6]:
 - Updated provider set prototype to be compatible with v8 of ICC framework
 - Added additional comments and fixed format (Evan G.)
 - Fixed endianess issues (Evan G.)
 - Added clean up of nodes in probe failure and qnoc_remove (Evan G.)
 - Merged sdm845 local node IDs with qcom dt-binding IDs
 - Removed IPA CORE nodes and BCMs.

Changes in v2 [5]:
 - Updated to use the latest RPMH and CommandDB patches
 - Fixed bug in bcm aggregation
 - Updated sdm845 provider dt entry

Changes in v1 [4]:
 - Addressed review feedback from Georgi D. and Evan G.
 - Removed proposal to modify ICC aggregate callback interface
 - Moved BCM aggregation into provider set function
 - Added devicetree binding documentation
 - Fixed logic in generating TCS command list
 - Added keepalive flags for resources that are critical to platform operation
 - Added various comments to clarify intent
 - Removed unused types and struct definitions

[1]: https://lkml.org/lkml/2018/8/10/387
[2]: https://lkml.org/lkml/2018/6/20/519
[3]: https://lkml.org/lkml/2018/4/10/714
[4]: https://patchwork.kernel.org/patch/10428167/
[5]: https://lkml.org/lkml/2018/6/29/743
[6]: https://lkml.org/lkml/2018/7/18/1109

Summary of the patches:
Patch 1 creates the Qualcomm SDM845 Specific provider driver.
Patch 2 Adds dt binding for SDM845 provider

TODO:
  * Add Network-on-Chip (NoC) objects to encapsulate logical nodes for QoS.
  * Add QoS configuration specific to each NoC.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom-sdm845.txt          |  22 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/interconnect/qcom/Kconfig                  |   8 +
 drivers/interconnect/qcom/Makefile                 |   1 +
 drivers/interconnect/qcom/sdm845.c                 | 844 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom.h            | 110 ++-
 6 files changed, 989 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
 create mode 100644 drivers/interconnect/qcom/sdm845.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
