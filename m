From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 09/18] staging: typec: fusb302: Use tcpm_set_current_limit_psy
Date: Sun,  6 Aug 2017 14:35:46 +0200
Message-ID: <20170806123555.5124-10-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbdHFMg0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Aug 2017 08:36:26 -0400
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

Register a power_supply and use tcpm_set_current_limit_psy as
set_current_limit so that another driver (e.g. the charger driver) can
pick the limit up and configure the system accordingly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index 1d8c9b66df2f..e1e08f57af99 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -854,17 +854,6 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 	return ret;
 }
 
-static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
-{
-	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
-						 tcpc_dev);
-
-	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
-		    max_ma, mv);
-
-	return 0;
-}
-
 static int fusb302_pd_tx_flush(struct fusb302_chip *chip)
 {
 	return fusb302_i2c_set_bits(chip, FUSB_REG_CONTROL0,
@@ -1208,7 +1197,7 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 	fusb302_tcpc_dev->set_polarity = tcpm_set_polarity;
 	fusb302_tcpc_dev->set_vconn = tcpm_set_vconn;
 	fusb302_tcpc_dev->set_vbus = tcpm_set_vbus;
-	fusb302_tcpc_dev->set_current_limit = tcpm_set_current_limit;
+	fusb302_tcpc_dev->set_current_limit = tcpm_set_current_limit_psy;
 	fusb302_tcpc_dev->set_pd_rx = tcpm_set_pd_rx;
 	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
 	fusb302_tcpc_dev->start_drp_toggling = tcpm_start_drp_toggling;
@@ -1733,6 +1722,11 @@ static int fusb302_probe(struct i2c_client *client,
 			return -EPROBE_DEFER;
 	}
 
+	ret = tcpm_register_psy(chip->dev, &chip->tcpc_dev,
+				"fusb302-typec-source");
+	if (ret < 0)
+		return ret;
+
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
-- 
2.13.3
