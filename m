From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v1 0/2] 96boards: add thermal senor support to hikey board
Date: Wed, 25 Mar 2015 15:50:23 +0800
Message-ID: <1427269825-11324-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:43733 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbCYHtp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 03:49:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com, kong.kongxinwei@hisilicon.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, devicetree@vger.kernel.org, liguozhu@hisilicon.com, xuwei5@hisilicon.com

From: kongxinwei <kong.kongxinwei@hisilicon.com>

Thank you all for giving this RFC patches stages some comments. Here is v1
patches and address all the issues raised as part of RFC review.

The Linaro connect introduce 96boards series in Hong Kong,The HiKey board
is the first board to be certified 96Boards Consumer Edition compatible.
This board is based on the HiSilicon SoC. you can get more information
from https://www.96boards.org.

The hisilicon SoC contains thermal module, this thermal module has 4 sensors,

	- sensor 0: local sensor;
	- sensor 1: remote sensor for ACPU cluster 1;
	- sensor 2: remote sensor for ACPU cluster 2;
	- sensor 3: remote sensor for GPU;

It can obtain this device temperature by operating this hardware. The new
sensor driver satisfies thermal framework and to realize the ACPU ,GPU and
so on to cool function.

Changes v0->v1;
* Delete this hi6220 dtsi.
* Fix documentation and error checks.
* Modify this driver which makes use of kernel to decide dynamically bind
  the interrupt to hottest sensor.
* Delete "sensor-thres-temp" property in DTS and write thermal_zone trips
  points value to register.
* Delete "sensor-reset-temp" property and define the fixed value.

kongxinwei (2):
  thermal: hisilicon: add new hisilicon thermal sensor driver
  dt-bindings: Document the hi6220 thermal sensor bindings

 .../bindings/thermal/hisilicon-thermal.txt         |  45 ++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 526 +++++++++++++++++++++
 4 files changed, 580 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1


