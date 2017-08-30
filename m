From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 05/11] staging: typec: fusb302: Use client->irq as irq if set
Date: Wed, 30 Aug 2017 11:48:08 +0200
Message-ID: <20170830094814.17758-6-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org, "Yueyao (Nathan) Zhu" <yueyao@google.com>
List-Id: linux-pm@vger.kernel.org

The fusb302 is also used on x86 systems where the platform code sets
the irq in client->irq and there is no gpio named fcs,int_n.

Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index 1c1751c994db..675161cf4f3a 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -1735,9 +1735,13 @@ static int fusb302_probe(struct i2c_client *client,
 		goto destroy_workqueue;
 	}
 
-	ret = init_gpio(chip);
-	if (ret < 0)
-		goto destroy_workqueue;
+	if (client->irq) {
+		chip->gpio_int_n_irq = client->irq;
+	} else {
+		ret = init_gpio(chip);
+		if (ret < 0)
+			goto destroy_workqueue;
+	}
 
 	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
 	if (IS_ERR(chip->tcpm_port)) {
-- 
2.13.4
