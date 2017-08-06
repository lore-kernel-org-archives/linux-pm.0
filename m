From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/18] staging: typec: tcpm: Add get_usb2_current_limit tcpc_dev callback
Date: Sun,  6 Aug 2017 14:35:38 +0200
Message-ID: <20170806123555.5124-2-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

A Rp signalling the default current limit indicates that we're possibly
connected to an USB2 power-source. In some cases the type-c
port-controller may provide the capability to detect the current-limit
for USB2 power-sources (through e.g. BC1.2 detection).

This commit adds an optional get_usb2_current_limit tcpc_dev callback
which allows the port-controller to return the detected current-limit
if the CC pin is pulled up with Rp.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/tcpm.c | 5 ++++-
 drivers/staging/typec/tcpm.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
index 20eb4ebcf8c3..9f5adace4309 100644
--- a/drivers/staging/typec/tcpm.c
+++ b/drivers/staging/typec/tcpm.c
@@ -660,7 +660,10 @@ static u32 tcpm_get_current_limit(struct tcpm_port *port)
 		break;
 	case TYPEC_CC_RP_DEF:
 	default:
-		limit = 0;
+		if (port->tcpc->get_usb2_current_limit)
+			limit = port->tcpc->get_usb2_current_limit(port->tcpc);
+		else
+			limit = 0;
 		break;
 	}
 
diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
index 19c307d31a5a..01b7d89379a3 100644
--- a/drivers/staging/typec/tcpm.h
+++ b/drivers/staging/typec/tcpm.h
@@ -108,6 +108,7 @@ struct tcpc_dev {
 
 	int (*init)(struct tcpc_dev *dev);
 	int (*get_vbus)(struct tcpc_dev *dev);
+	int (*get_usb2_current_limit)(struct tcpc_dev *dev); /* Optional */
 	int (*set_cc)(struct tcpc_dev *dev, enum typec_cc_status cc);
 	int (*get_cc)(struct tcpc_dev *dev, enum typec_cc_status *cc1,
 		      enum typec_cc_status *cc2);
-- 
2.13.3
