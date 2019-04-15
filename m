From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 0/4] Add QCS404 interconnect provider driver
Date: Mon, 15 Apr 2019 13:43:53 +0300
Message-ID: <20190415104357.5305-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, bjorn.andersson@linaro.org, georgi.djakov@linaro.org
Cc: vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

v2:
- Use the clk_bulk API. (Bjorn)
- Move the port IDs into the provider file. (Bjorn)
- Use ARRAY_SIZE in the macro to automagically count the num_links. (Bjorn)
- Improve code readability. (Bjorn)
- Add patch [4/4] introducing a qcom,qos DT property to represent the link to
  the MMIO QoS registers HW block.

v1: https://lore.kernel.org/lkml/20190405035446.31886-1-georgi.djakov@linaro.org/

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (3):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  arm64: dts: qcs404: Add interconnect provider DT nodes
  dt-bindings: interconnect: qcs404: Introduce qcom,qos DT property

 .../bindings/interconnect/qcom,qcs404.txt     |  76 +++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  25 +
 drivers/interconnect/qcom/Kconfig             |   8 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcs404.c            | 559 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 6 files changed, 758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h
