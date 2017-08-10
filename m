From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH v3 0/3] thermal: add thermal sensor driver for Hi3660
Date: Thu, 10 Aug 2017 16:32:12 +0800
Message-ID: <1502353935-92924-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3489 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdHJIh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 04:37:56 -0400
In-Reply-To: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, kevin.wangtao@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com

From: Tao Wang <kevin.wangtao@linaro.org>

This series adds thermal support for Hi3660 Soc, which support
all the hardware temperture sensors and two virtual sensors(one
for maximum value of all and one for average value of all).

Patch 1 add dt-binding document to describe how to config dt
for the driver.
Patch 2 introduces the thermal sensor driver.
Patch 3 add dts for the thermal senor driver on Hi3660.

hardware document can be found on
https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey960/HardwareDocs/HiKey960_SoC_Reference_Manual.pdf

Changes in v2:
- correct alphabet order
- correct compatible name
- remove redundant property
- rebase changes on linux next

Changes in v3:
- remove unnecessary log print
- described all platform related parameters in DT
- make the driver forward compatible

Tao Wang (3):
  dt-bindings: Document the hi3660 thermal sensor bindings
  thermal: hisilicon: add thermal sensor driver for Hi3660
  arm64: dts: register Hi3660's thermal sensor

 .../devicetree/bindings/thermal/hisi-tsensor.txt   |  23 +++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  10 +
 drivers/thermal/Kconfig                            |  13 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_tsensor.c                     | 223 +++++++++++++++++++++
 include/dt-bindings/thermal/hi3660-thermal.h       |  30 +++
 6 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisi-tsensor.txt
 create mode 100644 drivers/thermal/hisi_tsensor.c
 create mode 100644 include/dt-bindings/thermal/hi3660-thermal.h

-- 
2.8.1
