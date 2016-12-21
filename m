From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] power: supply: bq24735: allow polling even if there is no ac-detect gpio
Date: Wed, 21 Dec 2016 22:29:52 +0100
Message-ID: <1482355793-16190-2-git-send-email-peda@axentia.se>
References: <1482355793-16190-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:51776
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754345AbcLVAEP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 19:04:15 -0500
In-Reply-To: <1482355793-16190-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

It is possible to verify AC adapter presence via a register read, without
any physical connection to the ACOK pin on the charger. Allow this.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/power/supply/ti,bq24735.txt | 4 ++--
 drivers/power/supply/bq24735-charger.c                        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
index efc2c6a78661..de45e1a2a4d9 100644
--- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
+++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
@@ -27,8 +27,8 @@ Optional properties :
  - ti,external-control : Indicates that the charger is configured externally
    and that the host should not attempt to enable/disable charging or set the
    charge voltage/current.
- - poll-interval : In case 'interrupts' is not specified, poll AC presence
-   on the ti,ac-detect-gpios GPIO with this interval (milliseconds).
+ - poll-interval : In case 'interrupts' is not specified, poll AC adapter
+   presence with this interval (milliseconds).
 
 Example:
 
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 4f6275e5cf1c..d8be81203837 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -468,7 +468,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 				client->irq, ret);
 			return ret;
 		}
-	} else if (charger->status_gpio) {
+	} else {
 		ret = device_property_read_u32(&client->dev, "poll-interval",
 					       &charger->poll_interval);
 		if (ret)
-- 
2.1.4

