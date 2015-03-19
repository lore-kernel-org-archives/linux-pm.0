From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Date: Thu, 19 Mar 2015 15:57:26 +0800
Message-ID: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

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

kongxinwei (3):
  thermal: hisilicon: add new hisilicon thermal sensor driver
  dts: hi6220: enable thermal sensor for hisilicon SoC
  dt-bindings: Document the hi6220 thermal sensor bindings

 .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 531 +++++++++++++++++++++
 5 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
