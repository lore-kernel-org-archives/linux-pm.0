From: <michael.kao@mediatek.com>
Subject: [PATCH 0/7] Add Mediatek thermal dirver for mt8183
Date: Fri, 1 Feb 2019 15:38:06 +0800
Message-ID: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>, =Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Michael Kao <michael.kao@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

This patchset supports for mt8183 chip to mtk_thermal.c.
MT8183 has six temperature sensors and two thermal
controllers. It has different calibration coefficent with
past project, and doesn't need to select bank.
As a result, we add the common architecture for scalability.

Michael Kao (7):
  thermal: mediatek: fix register index error
  thermal: mediatek: add common index of vts settings.
  thermal: mediatek: add calibration item
  thermal: mediatek: add thermal controller offset
  thermal: mediatek: add flag for bank selection
  dt-bindings: thermal: add binding document for mt8183 thermal
    controller
  thermal: mediatek: add support for MT8183

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 315 +++++++++++++++++----
 2 files changed, 257 insertions(+), 59 deletions(-)

-- 
1.9.1
