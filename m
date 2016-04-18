From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/9] thermal: rockchip: Support rk3366/rk3399 SoCS and fixes
 the driver
Date: Mon, 18 Apr 2016 11:35:52 +0800
Message-ID: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <mbrugger-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Eduardo, Heiko
This series pacthes to support the rk3366/rk3399 SoCs thermal, and fixes the driver.

65ae684 thermal: rockchip: disable thermal->clk in err case
31e6d69 thermal: rockchip: fixes the code_to_temp for tsadc driver
6e2d6fb thermal: rockchip: update the tsadc table for rk3399
49f6ccf thermal: rockchip: handle the power sequence for tsadc controller
9f8bd52 thermal: rockchip: Support RK3366 SoCs in the thermal driver
a959e42 thermal: rockchip: add the notes for better reading
e5cbc6a thermal: of: Add support for hardware-tracked trip points
7f613e4 thermal: rockchip: add the set_trips function
94cc571 arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Verified on url =
https://github.com/Caesar-github/rockchip/commits/wip/fixes-rockchip-thermal-20160418
Based on linux-next kernel for 20160415

Verified on rk3288/rk3366/rk3399 SoCs with rockchip inside kernel(develop4.4).

The rk3399 dtsi has benn sent on https://patchwork.kernel.org/patch/8462441/.
The dts thermal will be updated in later.

---



Caesar Wang (6):
  thermal: rockchip: fixes the code_to_temp for tsadc driver
  thermal: rockchip: update the tsadc table for rk3399
  thermal: rockchip: handle the power sequence for tsadc controller
  thermal: rockchip: add the notes for better reading
  thermal: rockchip: add the set_trips function
  arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Elaine Zhang (1):
  thermal: rockchip: Support RK3366 SoCs in the thermal driver

Mikko Perttunen (1):
  thermal: of: Add support for hardware-tracked trip points

Shawn Lin (1):
  thermal: rockchip: disable thermal->clk in err case

 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi | 112 ---------
 arch/arm64/boot/dts/rockchip/rk3368.dtsi         |  66 ++++-
 drivers/thermal/of-thermal.c                     |  82 +++++-
 drivers/thermal/rockchip_thermal.c               | 302 ++++++++++++++++++-----
 include/linux/thermal.h                          |   2 +
 5 files changed, 388 insertions(+), 176 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1
