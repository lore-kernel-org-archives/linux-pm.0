From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 0/3] Add QCS404 interconnect provider driver
Date: Fri,  5 Apr 2019 10:54:43 +0700
Message-ID: <20190405035446.31886-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (2):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  arm64: dts: qcs404: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,qcs404.txt     |  45 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  25 +
 drivers/interconnect/qcom/Kconfig             |   8 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcs404.c            | 488 ++++++++++++++++++
 drivers/interconnect/qcom/qcs404_ids.h        |  86 +++
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 ++++
 7 files changed, 742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/qcs404_ids.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h
