From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH] power_supply: rt9455_charger: Check if CONFIG_USB_PHY is enabled
Date: Wed,  3 Jun 2015 11:47:03 +0300
Message-ID: <1433321223-19442-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61530 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbbFCInu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Jun 2015 04:43:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

If CONFIG_USB_PHY is not enabled, struct notifier_block is not defined and
compilation fails. Therefore, the functions that process USB event
notifications are defined only if CONFIG_USB_PHY is enabled.
There is no need to define these functions if CONFIG_USB_PHY is not
enabled, since no USB notifications are received in this case.
Also, since rt9455_set_boost_voltage_before_boost_mode() function is
called only if USB_EVENT_ID notification is received, this function should
also be defined only if CONFIG_USB_PHY is enabled.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/rt9455_charger.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
index 7c0c1ff..de86913 100644
--- a/drivers/power/rt9455_charger.c
+++ b/drivers/power/rt9455_charger.c
@@ -804,6 +804,7 @@ static int rt9455_hw_init(struct rt9455_info *info, u32 ichrg,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_USB_PHY)
 /*
  * Before setting the charger into boost mode, boost output voltage is
  * set. This is needed because boost output voltage may differ from battery
@@ -828,6 +829,7 @@ static int rt9455_set_boost_voltage_before_boost_mode(struct rt9455_info *info)
 
 	return 0;
 }
+#endif
 
 /*
  * Before setting the charger into charge mode, battery regulation voltage is
@@ -1241,6 +1243,7 @@ static int rt9455_discover_charger(struct rt9455_info *info, u32 *ichrg,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_USB_PHY)
 static int rt9455_usb_event_none(struct rt9455_info *info,
 				 u8 opa_mode, u8 iaicr)
 {
@@ -1445,6 +1448,7 @@ static int rt9455_usb_event(struct notifier_block *nb,
 	}
 	return NOTIFY_DONE;
 }
+#endif
 
 static void rt9455_pwr_rdy_work_callback(struct work_struct *work)
 {
-- 
1.7.9.5

