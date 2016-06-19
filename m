From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH 4/4] arm64: defconfig: Enable R-Car Gen3 thermal support
Date: Sun, 19 Jun 2016 10:36:43 +0700
Message-ID: <5766134B.9040904@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <576612DE.3070204@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <576612DE.3070204@rvc.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4f3e1f6..b5551d9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -200,8 +200,10 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL=y
+CONFIG_THERMAL_OF=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
 CONFIG_MFD_SPMI_PMIC=y
-- 
1.9.1
