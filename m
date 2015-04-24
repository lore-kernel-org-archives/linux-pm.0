From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v4 0/2] 96boards: add thermal senor support to hikey board
Date: Fri, 24 Apr 2015 11:51:21 +0800
Message-ID: <1429847483-10552-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, jorge.ramirez-ortiz@linaro.org, mporter@konsulko.com, robh+dt@kernel.org, bintian.wang@huawei.com, khilman@linaro.org, mturquette@linaro.org, rob.herring@linaro.org, zhangfei.gao@linaro.org, haojian.zhuang@linaro.org, xuwei5@hisilicon.com, yanhaifeng@gmail.com, linux@arm.linux.org.uk, guodong.xu@linaro.org, xuyiping@hisilicon.com, wangbinghui@hisilicon.com, zhenwei.wang@hisilicon.com, victor.lixin@hisilicon.com, puck.chen@hisilicon.com, dan.zhao@hisilicon.com, z.liuxinliang@huawei.com, heyunlei@huawei.com, w.f@huawei.com, liguozhu@hisilicon.com, gongyu@hisilicon.com, wanghuan4@hisilicon.com, yudongbin@hisilicon.com
List-Id: linux-pm@vger.kernel.org

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
