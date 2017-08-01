From: Louis Yu <louis.yu@mediatek.com>
Subject: [PATCH v2 0/4] Add Mediatek thermal driver for mt2712
Date: Tue, 1 Aug 2017 15:28:29 +0800
Message-ID: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:5610 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751563AbdHAH3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 03:29:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dawei Chien <dawei.chien@mediatek.com>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com

This series support for mt2712 chip to mtk_thermal.c, and integrate
mt8173, mt2701, and mt2712 on the same mediatek thermal driver.
mt2712 has only one bank and four sensors, and extends calibration
data for mt2712 and the existing chips.

Changes since v1:
- fix wrong clock error handle flow from Matthias' comment.
- make clear comment for the extended calibration data.

Louis Yu (4):
  dt-bindings: thermal: Add binding document for Mediatek thermal
    controller
  thermal: mediatek: add Mediatek thermal driver for mt2712
  thermal: mediatek: extend calibration data for mt2712 chip
  thermal: mediatek: minor mtk_thermal.c cleanups

 .../bindings/thermal/mediatek-thermal.txt          |  1 +
 drivers/thermal/mtk_thermal.c                      | 88 +++++++++++++++++++---
 2 files changed, 79 insertions(+), 10 deletions(-)

--
1.8.1.1.dirty
