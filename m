From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/14] staging: typec: fusb302: Use client->irq as irq if
 set
Date: Tue, 15 Aug 2017 22:04:53 +0200
Message-ID: <20170815200502.17339-6-hdegoede@redhat.com>
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
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Yueyao (Nathan) Zhu" <yueyao@google.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The fusb302 is also used on x86 systems where the platform code sets
the irq in client->irq and there is no gpio named fcs,int_n.

Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index e1efc67..dea88fd 100644
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
2.9.4
