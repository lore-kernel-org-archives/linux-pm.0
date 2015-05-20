From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v6 0/3] 96boards: add thermal senor support to hikey board
Date: Wed, 20 May 2015 19:16:35 +0800
Message-ID: <1432120598-18268-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:39600 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbbETLSx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 07:18:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, mark.rutland@arm.com, linux-pm@vger.kernel.org
Cc: dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, leo.yan@linaro.org, mporter@konsulko.com, liguozhu@hisilicon.com

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

Changes v5->v6;
* Add "include" header file
* Fix mutex lock to protect binding irq variable

Changes v4->v5;
* Rebase to kernel 4.1-rc1
* Add the DTS file according to the maintainer advice
* Clean up "include" header file and fix detail format
* Deal with negative temperature and add mutex lock to
  protect binding irq variable
* Remove this "const struct themal_trip" from "struct
  hisi_thermal_sensor", making it as local variable
* Make sensor_temp part of "struct hisi_thremal_sensors"

Changes v3->v4;
* using "usleep_range" function instead of "msleep" function
* delete code detail error

Changes v2->v3;
* delete sensor id property in binding document 
* fix sensor driver to satisfy sensor register after deleting sensor id
  property

Changes v1->v2;
* change patch's position between binding document and driver file
* clean up some regiser for enabling thermal sensor
* use mutex lock to replace the spin lock

Changes v0->v1;
* Delete this hi6220 dtsi.
* Fix documentation and error checks.
* Modify this driver which makes use of kernel to decide how to dynamically
  bind the interrupt to hottest sensor.
* Delete "sensor-thres-temp" property and read thermal_zone trips points
  replace of it.
* Delete "sensor-reset-temp" property and define the fixed value replace
  of it.

kongxinwei (3):
  dt-bindings: Document the hi6220 thermal sensor bindings
  thermal: hisilicon: add new hisilicon thermal sensor driver
  dts: hi6220: enable thermal sensor for hisilicon SoC

 .../bindings/thermal/hisilicon-thermal.txt         |  23 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 124 ++++++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 419 +++++++++++++++++++++
 5 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1


