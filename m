From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 02/11] staging: typec: tcpm: Add get_current_limit tcpc_dev callback
Date: Wed, 30 Aug 2017 11:48:05 +0200
Message-ID: <20170830094814.17758-3-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

A Rp signalling the default current limit indicates that we're possibly
connected to an USB2 power-source. In some cases the type-c port-controller
may provide the capability to detect the current-limit in this case,
through e.g. BC1.2 detection.

This commit adds an optional get_current_limit tcpc_dev callback which
allows the port-controller to provide current-limit detection for when
the CC pin is pulled up with Rp.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v2:
-s/get_usb2_current_limit/get_current_limit/
---
 drivers/staging/typec/tcpm.c | 5 ++++-
 drivers/staging/typec/tcpm.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
index a911cad41a59..6ca73a3c7e88 100644
--- a/drivers/staging/typec/tcpm.c
+++ b/drivers/staging/typec/tcpm.c
@@ -667,7 +667,10 @@ static u32 tcpm_get_current_limit(struct tcpm_port *port)
 		break;
 	case TYPEC_CC_RP_DEF:
 	default:
-		limit = 0;
+		if (port->tcpc->get_current_limit)
+			limit = port->tcpc->get_current_limit(port->tcpc);
+		else
+			limit = 0;
 		break;
 	}
 
diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
index 374cea44a84a..7e9a6b7b5cd6 100644
--- a/drivers/staging/typec/tcpm.h
+++ b/drivers/staging/typec/tcpm.h
@@ -109,6 +109,13 @@ struct tcpc_dev {
 
 	int (*init)(struct tcpc_dev *dev);
 	int (*get_vbus)(struct tcpc_dev *dev);
+	/*
+	 * This optional callback gets called by the tcpm core when configured
+	 * as a snk and cc=Rp-def. This allows the tcpm to provide a fallback
+	 * current-limit detection method for the cc=Rp-def case. E.g. some
+	 * tcpcs may include BC1.2 charger detection and use that in this case.
+	 */
+	int (*get_current_limit)(struct tcpc_dev *dev);
 	int (*set_cc)(struct tcpc_dev *dev, enum typec_cc_status cc);
 	int (*get_cc)(struct tcpc_dev *dev, enum typec_cc_status *cc1,
 		      enum typec_cc_status *cc2);
-- 
2.13.4
