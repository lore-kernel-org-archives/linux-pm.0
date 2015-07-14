From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT/RFC] power_supply: bq2415x_charger: Initialize workqueue before
 scheduling it
Date: Tue, 14 Jul 2015 09:34:13 +0900
Message-ID: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56126 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbGNAe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 20:34:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The driver during probe registers a power supply notifier
(with bq2415x_notifier_call() callback) and calls it manually right
after. The notifier callback function schedules driver's workqueue
(bq->work).

However the workqueue was initialized after these two events (after
registering power supply notifier and calling manually the callback).

When power supply core notified the driver (executing its
bq2415x_notifier_call() callback) the scheduled workqueue could be
still uninitialized.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

---

I don't have the hardware, please test. Additionally I could not find
the commit which introduced the issue so I did not cc-stable.
---
 drivers/power/bq2415x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index e98dcb661cc9..527ed0f18796 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1601,6 +1601,7 @@ static int bq2415x_probe(struct i2c_client *clien=
t,
 	bq->reported_mode =3D BQ2415X_MODE_OFF;
 	bq->autotimer =3D 0;
 	bq->automode =3D 0;
+	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
=20
 	if (np || ACPI_HANDLE(bq->dev)) {
 		ret =3D device_property_read_u32(bq->dev,
@@ -1677,7 +1678,6 @@ static int bq2415x_probe(struct i2c_client *clien=
t,
 		dev_info(bq->dev, "automode not supported\n");
 	}
=20
-	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
 	bq2415x_set_autotimer(bq, 1);
=20
 	dev_info(bq->dev, "driver registered\n");
--=20
1.9.1

