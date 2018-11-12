From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] power: supply: sc2731_charger: Add charger status detection
Date: Mon, 12 Nov 2018 18:52:36 +0800
Message-ID: <7fa4e3191a6be72b5a90d0ee73b70457a699f9bd.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

The USB charger status can be notified before the charger driver registers
the USB phy notifier, so we should check the charger status in probe() in
case we missed the USB charger notification.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 393ba98..a012d6c 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -432,6 +432,24 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 	return ret;
 }
 
+static void sc2731_charger_detect_status(struct sc2731_charger_info *info)
+{
+	unsigned int min, max;
+
+	/*
+	 * If the USB charger status has been USB_CHARGER_PRESENT before
+	 * registering the notifier, we should start to charge with getting
+	 * the charge current.
+	 */
+	if (info->usb_phy->chg_state != USB_CHARGER_PRESENT)
+		return;
+
+	usb_phy_get_charger_current(info->usb_phy, &min, &max);
+	info->limit = min;
+
+	schedule_work(&info->work);
+}
+
 static int sc2731_charger_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -486,6 +504,8 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	sc2731_charger_detect_status(info);
+
 	return 0;
 }
 
-- 
1.7.9.5
