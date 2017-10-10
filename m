From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/5] mfd: bd9571mwv: Add DDR Backup Power register bit definitions
Date: Tue, 10 Oct 2017 17:26:15 +0200
Message-ID: <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add definitions for the KEEPON_* bits in the "BKUP Mode Cnt" register,
which control the DDR rails to be kept powered when backup mode is
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/mfd/bd9571mwv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/bd9571mwv.h b/include/linux/mfd/bd9571mwv.h
index f0708ba4cbbae2dc..eb05569f752bb089 100644
--- a/include/linux/mfd/bd9571mwv.h
+++ b/include/linux/mfd/bd9571mwv.h
@@ -33,6 +33,11 @@
 #define BD9571MWV_I2C_MD2_E1_BIT_2		0x12
 
 #define BD9571MWV_BKUP_MODE_CNT			0x20
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK	GENMASK(3, 0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0	BIT(0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1	BIT(1)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0C	BIT(2)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1C	BIT(3)
 #define BD9571MWV_BKUP_MODE_STATUS		0x21
 #define BD9571MWV_BKUP_RECOVERY_CNT		0x22
 #define BD9571MWV_BKUP_CTRL_TIM_CNT		0x23
-- 
2.7.4
