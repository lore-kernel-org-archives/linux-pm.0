From: <sean.wang@mediatek.com>
Subject: [PATCH v2 17/17] MAINTAINERS: add an entry for MediaTek board level shutdown driver
Date: Wed, 25 Apr 2018 17:32:43 +0800
Message-ID: <a356e91c593d600418c7a37cdae58bf2d80c0a94.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, matthias.bgg@gmail.com, eddie.huang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek board level shutdown driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7ef37f..816554b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8912,6 +8912,13 @@ S:	Maintained
 F:	drivers/net/dsa/mt7530.*
 F:	net/dsa/tag_mtk.c
 
+MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+F:	drivers/power/reset/mt6323-poweroff.c
+
 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
-- 
2.7.4
