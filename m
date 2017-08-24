From: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/5] thermal: rockchip: add tsadc support in thermal driver and IPA thermal control for RV1108 in dts
Date: Thu, 24 Aug 2017 18:27:50 +0800
Message-ID: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This series patches add the tsadc support in thermal driver and in devicetree for RV1108.
Also add thermal control with Intelligent Power Allocation (IPA) policy by default.  Please
refer to https://developer.arm.com/open-source/intelligent-power-allocation for more information
about IPA.

Rocky Hao (5):
  dt-bindings: rockchip-thermal: Support the RV1108 SoC compatible
  thermal: rockchip: Support the RV1108 SoC in thermal driver
  arm: dts: rockchip: add tsadc node for RV1108 SoC
  arm: dts: rockchip: add thermal nodes for RV1108 SoC
  arm: dts: rockchip: enable tsadc module on RV1108 evaluation board

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 arch/arm/boot/dts/rv1108-evb.dts                   |  4 ++
 arch/arm/boot/dts/rv1108.dtsi                      | 69 ++++++++++++++++++++++
 drivers/thermal/rockchip_thermal.c                 | 67 +++++++++++++++++++++
 4 files changed, 141 insertions(+)

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
