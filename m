From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 02/14] staging: typec: tcpm: Add get_current_limit tcpc_dev
 callback
Date: Tue, 15 Aug 2017 22:04:50 +0200
Message-ID: <20170815200502.17339-3-hdegoede@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170815200502.17339-1-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A Rp signalling the default current limit indicates that we're possibly
connected to an USB2 power-source. In some cases the type-c port-controller
may provide the capability to detect the current-limit in this case,
through e.g. BC1.2 detection.

This commit adds an optional get_current_limit tcpc_dev callback which
allows the port-controller to provide current-limit detection for when
the CC pin is pulled up with Rp.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-s/get_usb2_current_limit/get_current_limit/
---
 drivers/staging/typec/tcpm.c | 5 ++++-
 drivers/staging/typec/tcpm.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
index 20eb4eb..8e823af 100644
--- a/drivers/staging/typec/tcpm.c
+++ b/drivers/staging/typec/tcpm.c
@@ -660,7 +660,10 @@ static u32 tcpm_get_current_limit(struct tcpm_port *port)
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
index 19c307d..1465668 100644
--- a/drivers/staging/typec/tcpm.h
+++ b/drivers/staging/typec/tcpm.h
@@ -108,6 +108,13 @@ struct tcpc_dev {
 
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
2.9.4
