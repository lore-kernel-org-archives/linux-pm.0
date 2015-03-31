From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v2 0/2] 96boards: add thermal senor support to hikey board
Date: Tue, 31 Mar 2015 14:59:20 +0800
Message-ID: <1427785162-15172-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:35239 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbCaG6y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 02:58:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, devicetree@vger.kernel.org, liguozhu@hisilicon.com, xuwei5@hisilicon.com, jorge.ramirez-ortiz@linaro.org, xweikong@hotmail.com, mark.rutland@arm.com

From: kongxinwei <kong.kongxinwei@hisilicon.com>

Thank you all for giving this v1 patches stages some comments. Here is v2
patches and address all the issues raised as part of v1 review.

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
* Modify this driver which makes use of kernel to decide how to dynamically
  bind the interrupt to hottest sensor.
* Delete "sensor-thres-temp" property and read thermal_zone trips points
  replace of it.
* Delete "sensor-reset-temp" property and define the fixed value replace
  of it.

Changes v1->v2;
* change patch's situation between binding document and driver file
* clean up some regiser for enabling thermal sensor
* use mutex lock to replace the spin lock

kongxinwei (2):
  dt-bindings: Document the hi6220 thermal sensor bindings
  thermal: hisilicon: add new hisilicon thermal sensor driver

 .../bindings/thermal/hisilicon-thermal.txt         |  45 ++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 475 +++++++++++++++++++++
 4 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1


