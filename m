From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH RESEND v4 0/2] 96boards: add thermal senor support to hikey board
Date: Mon, 4 May 2015 10:52:18 +0800
Message-ID: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:30114 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbEDCyt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2015 22:54:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org
Cc: linuxarm@huawei.com, devicetree@vger.kernel.org, dan.zhao@hisilicon.com, liguozhu@hisilicon.com, mporter@konsulko.com, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, leo.yan@linaro.org, zhenwei.wang@hisilicon.com, zhangfei.gao@linaro.org, z.liuxinliang@huawei.com, xuwei5@hisilicon.com, w.f@huawei.com, yuanzhichang@hisilicon.com, mark.rutland@arm.com

From: kongxinwei <kong.kongxinwei@hisilicon.com>

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
* change patch's position between binding document and driver file
* clean up some regiser for enabling thermal sensor
* use mutex lock to replace the spin lock

Changes v2->v3;
* delete sensor id property in binding document 
* fix sensor driver to satisfy sensor register after deleting sensor id
  property

Changes v3->v4;
* using "usleep_range" function instead of "msleep" function
* delete code detail error

kongxinwei (2):
  dt-bindings: Document the hi6220 thermal sensor bindings
  thermal: hisilicon: add new hisilicon thermal sensor driver

 .../bindings/thermal/hisilicon-thermal.txt         |  23 ++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 437 +++++++++++++++++++++
 4 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1


