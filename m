From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/3] add support of SCPSYS power domain for MediaTek MT7622
Date: Fri, 21 Jul 2017 11:57:11 +0800
Message-ID: <cover.1500608650.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

There are four power domains on MediaTek MT7622 SoC which are respectively
ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.

Those functions could be selectively powered gated when the corresponding
function is no longer to use in order to reach more minimal power
dissipation through the patch series introduced here.

Chen Zhong (2):
  soc: mediatek: add header files required for MT7622 SCPSYS dt-binding
  soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

Sean Wang (1):
  dt-bindings: soc: update the binding document for SCPSYS on MediaTek
    MT7622 SoC

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  3 +
 drivers/soc/mediatek/mtk-scpsys.c                  | 76 ++++++++++++++++++++++
 include/dt-bindings/power/mt7622-power.h           | 22 +++++++
 include/linux/soc/mediatek/infracfg.h              |  8 ++-
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
