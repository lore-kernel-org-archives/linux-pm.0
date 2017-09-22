From: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 0/9] add support for Hi3660 tsensor
Date: Fri, 22 Sep 2017 17:42:03 +0800
Message-ID: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lonela.Voinescu-5wv7dgnIgG8@public.gmane.org, Valentin.Schneider-5wv7dgnIgG8@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, gengyanping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Wangtao <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patchset reorganize hisi thermal driver and make it both
support Hi6220 and Hi3660.
This patchset is based on Daniel thermal patch V2.
https://lkml.org/lkml/2017/9/4/432

Kevin Wangtao (9):
  thermal/drivers/hisi: move clk operation to related function
  thermal/drivers/hisi: use round up step value
  thermal/drivers/hisi: put platform code together
  thermal/drivers/hisi: add platform prefix to function name
  thermal/drivers/hisi: perpare to add support for other hisi platform
  thermal/drivers/hisi: add support for multi temp threshold
  dt-bindings: Document the hi3660 thermal sensor binding
  thermal/drivers/hisi: add support for hi3660 SoC
  arm64: dts: register Hi3660's thermal sensor

 .../bindings/thermal/hisilicon-thermal.txt         |   9 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +
 drivers/thermal/hisi_thermal.c                     | 494 ++++++++++++++-------
 3 files changed, 351 insertions(+), 160 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
