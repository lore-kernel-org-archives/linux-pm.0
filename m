From: <sean.wang@mediatek.com>
Subject: [PATCH v3 0/4] add support of SCPSYS power domain for MediaTek MT7622
Date: Mon, 7 Aug 2017 15:24:33 +0800
Message-ID: <cover.1502090240.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:9503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751560AbdHGHYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 03:24:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>

From: Sean Wang <sean.wang@mediatek.com>

Changes since v2:
- reduce code duplication of scpsys_probe across all SoCs

Changes since v1:
- rebase to Linux v4.13-rc1

There are four power domains on MediaTek MT7622 SoC which are respectively
ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.

Those functions could be selectively powered gated when the corresponding
function is no longer to use in order to reach more minimal power
dissipation through the patch series introduced here.

Chen Zhong (1):
  soc: mediatek: add header files required for MT7622 SCPSYS dt-binding

Sean Wang (3):
  dt-bindings: soc: update the binding document for SCPSYS on MediaTek
    MT7622 SoC
  soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
  soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
 drivers/soc/mediatek/mtk-scpsys.c                  | 247 ++++++++++++---------
 include/dt-bindings/power/mt7622-power.h           |  22 ++
 include/linux/soc/mediatek/infracfg.h              |   7 +
 4 files changed, 179 insertions(+), 100 deletions(-)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

-- 
2.7.4
