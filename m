From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v2 2/6] mfd: axp20x: Add register bits for axp20x-ac-power
Date: Sun,  1 May 2016 10:57:23 +0200
Message-ID: <1462093047-7885-3-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55345 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcEAI54 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 May 2016 04:57:56 -0400
In-Reply-To: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: degoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

This change adds some register bit definitions used by the
axp20x-ac-power driver.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 include/linux/mfd/axp20x.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index d82e7d5..c4c6dfa 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -90,6 +90,17 @@ enum {
 #define AXP22X_ALDO3_V_OUT		0x2a
 #define AXP22X_CHRG_CTRL3		0x35
 
+
+/* Fields of AXP20X_PWR_INPUT_STATUS */
+#define AXP20X_PWR_STATUS_AC_PRESENT     BIT(7)
+#define AXP20X_PWR_STATUS_AC_AVAILABLE   BIT(6)
+#define AXP20X_PWR_STATUS_AC_VBUS_SHORT  BIT(1)
+#define AXP20X_PWR_STATUS_AC_VBUS_SEL    BIT(0)
+
+/* Fields of AXP20X_ADC_EN1 */
+#define AXP20X_ADC_EN1_ACIN_VOLT BIT(5)
+#define AXP20X_ADC_EN1_ACIN_CURR BIT(4)
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
-- 
2.8.0

