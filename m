From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 01/13] power: reset: ltc2952: prefer devm_kzalloc over kzalloc
Date: Wed, 22 Oct 2014 16:30:58 +0200
Message-ID: <1413988270-28092-2-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make use of the fact that the allocated resources can be automatically
deallocated. This reduces cleanup code and chance of leaks.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 116a1ce..951a90d 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -292,7 +292,8 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	ltc2952_data = kzalloc(sizeof(*ltc2952_data), GFP_KERNEL);
+	ltc2952_data = devm_kzalloc(&pdev->dev, sizeof(*ltc2952_data),
+				    GFP_KERNEL);
 	if (!ltc2952_data)
 		return -ENOMEM;
 
@@ -300,17 +301,13 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 
 	ret = ltc2952_poweroff_init(pdev);
 	if (ret)
-		goto err;
+		return ret;
 
 	pm_power_off = &ltc2952_poweroff_kill;
 
 	dev_info(&pdev->dev, "probe successful\n");
 
 	return 0;
-
-err:
-	kfree(ltc2952_data);
-	return ret;
 }
 
 static int ltc2952_poweroff_remove(struct platform_device *pdev)
@@ -324,8 +321,6 @@ static int ltc2952_poweroff_remove(struct platform_device *pdev)
 
 		for (i = 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
 			gpiod_put(ltc2952_data->gpio[i]);
-
-		kfree(ltc2952_data);
 	}
 
 	return 0;
-- 
2.1.0
