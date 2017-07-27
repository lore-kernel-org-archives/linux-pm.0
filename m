From: <louis.yu@mediatek.com>
Subject: [PATCH v1 0/4] Add Mediatek thermal driver for mt2712
Date: Thu, 27 Jul 2017 13:46:53 +0800
Message-ID: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:24322 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750965AbdG0Frq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 01:47:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com

This series support for mt2712 chip to mtk_thermal.c, and integrate
mt8173, mt2701, and mt2712 on the same mediatek thermal driver.
mt2712 has only one bank and four sensors, and extends calibration
data for mt2712.
Unpaired clock error handle flow is also fixed in this series.

Louis Yu (4):
  dt-bindings: thermal: Add binding document for Mediatek thermal
    controller
  thermal: mediatek: add Mediatek thermal driver for mt2712
  thermal: mediatek: extend calibration data for mt2712 chip
  thermal: mediatek: minor mtk_thermal.c cleanups

 .../bindings/thermal/mediatek-thermal.txt          |  1 +
 drivers/thermal/mtk_thermal.c                      | 90 +++++++++++++++++++---
 2 files changed, 80 insertions(+), 11 deletions(-)

--
1.9.1
