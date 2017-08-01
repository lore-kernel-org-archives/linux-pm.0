From: <sean.wang@mediatek.com>
Subject: [PATCH v2 0/3] add support of SCPSYS power domain for MediaTek MT7622
Date: Tue, 1 Aug 2017 18:06:10 +0800
Message-ID: <cover.1501581552.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:15622 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751012AbdHAKGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 06:06:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>

From: Sean Wang <sean.wang@mediatek.com>

Changes since v1:
- rebase to Linux v4.13-rc1

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
 drivers/soc/mediatek/mtk-scpsys.c                  | 81 ++++++++++++++++++++++
 include/dt-bindings/power/mt7622-power.h           | 22 ++++++
 include/linux/soc/mediatek/infracfg.h              |  8 ++-
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

-- 
2.7.4
