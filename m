From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/18] staging: typec: fusb302: Set max supply voltage to 5V
Date: Sun,  6 Aug 2017 14:35:42 +0200
Message-ID: <20170806123555.5124-6-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Anything higher then 5V may damage hardware not capable of it, so
the only sane default here is 5V. If a board is able to handle a
higher voltage that should come from board specific data such as
device-tree and not be hard coded into the fusb302 code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index 03a3809d18f0..6baed06a3c0d 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -1187,9 +1187,9 @@ static const struct tcpc_config fusb302_tcpc_config = {
 	.nr_src_pdo = ARRAY_SIZE(src_pdo),
 	.snk_pdo = snk_pdo,
 	.nr_snk_pdo = ARRAY_SIZE(snk_pdo),
-	.max_snk_mv = 9000,
+	.max_snk_mv = 5000,
 	.max_snk_ma = 3000,
-	.max_snk_mw = 27000,
+	.max_snk_mw = 15000,
 	.operating_snk_mw = 2500,
 	.type = TYPEC_PORT_DRP,
 	.default_role = TYPEC_SINK,
-- 
2.13.3
