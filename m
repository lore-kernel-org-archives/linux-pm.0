From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 5/9] i2c: core: Convert to dev_pm_domain_attach|detach()
Date: Thu,  4 Sep 2014 15:52:32 +0200
Message-ID: <1409838756-31963-6-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Previously only the ACPI PM domain was supported by the i2c bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Cc: linux-i2c@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 632057a..3cd8f11 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -279,10 +279,13 @@ static int i2c_device_probe(struct device *dev)
 	if (status < 0)
 		return status;
 
-	acpi_dev_pm_attach(&client->dev, true);
-	status = driver->probe(client, i2c_match_id(driver->id_table, client));
-	if (status)
-		acpi_dev_pm_detach(&client->dev, true);
+	status = dev_pm_domain_attach(&client->dev, true);
+	if (status != -EPROBE_DEFER) {
+		status = driver->probe(client, i2c_match_id(driver->id_table,
+					client));
+		if (status)
+			dev_pm_domain_detach(&client->dev, true);
+	}
 
 	return status;
 }
@@ -302,7 +305,7 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
-	acpi_dev_pm_detach(&client->dev, true);
+	dev_pm_domain_detach(&client->dev, true);
 	return status;
 }
 
-- 
1.9.1

