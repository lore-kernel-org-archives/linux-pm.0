From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v6 2/8] i2c: i2c-smbus: Add null ptr guard in smb_alert_probe
Date: Tue,  2 May 2017 17:12:20 +0800
Message-ID: <1493716346-58517-3-git-send-email-preid@electromag.com.au>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-pm@vger.kernel.org

If platdata is not correct setup before registering the device
a null ptr derefence can occur.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-smbus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index b272493..df0e2fa 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -151,6 +151,11 @@ static int smbalert_probe(struct i2c_client *ara,
 	struct i2c_adapter *adapter = ara->adapter;
 	int res;
 
+	if (!setup) {
+		dev_err(&adapter->dev, "setup not defined\n");
+		return -ENODATA;
+	}
+
 	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
 			     GFP_KERNEL);
 	if (!alert)
-- 
1.8.3.1
