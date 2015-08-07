From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3] base/platform: assert that dev_pm_domain callbacks are called unconditionally
Date: Fri,  7 Aug 2015 07:19:22 +0200
Message-ID: <1438924762-4548-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50179 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbbHGFTj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 01:19:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

When a platform driver doesn't provide a .remove callback the function
platform_drv_remove isn't called and so the call to dev_pm_domain_attac=
h
called at probe time isn't paired by dev_pm_domain_detach at remove
time.

To fix this (and similar issues if different callbacks are missing) hoo=
k
up the driver callbacks unconditionally and make them aware that the
platform callbacks might be missing.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

Changes since (implicit) v1, sent with
Message-Id: 1437491315-2370-1-git-send-email-uwe@kleine-koenig.org:

- initialize ret in platform_drv_remove
- change my email to the right one (only in the S-o-B) :-(
- adding some more people to Cc

Changes since v2, sent with
Message-Id: 1438849860-18504-1-git-send-email-u.kleine-koenig@pengutron=
ix.de

- change my email to the right one also in the author spec

Best regards
Uwe

 drivers/base/platform.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 063f0ab15259..58cea3ea00f8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -517,7 +517,7 @@ static int platform_drv_probe(struct device *_dev)
 		return ret;
=20
 	ret =3D dev_pm_domain_attach(_dev, true);
-	if (ret !=3D -EPROBE_DEFER) {
+	if (ret !=3D -EPROBE_DEFER && drv->probe) {
 		ret =3D drv->probe(dev);
 		if (ret)
 			dev_pm_domain_detach(_dev, true);
@@ -540,9 +540,10 @@ static int platform_drv_remove(struct device *_dev=
)
 {
 	struct platform_driver *drv =3D to_platform_driver(_dev->driver);
 	struct platform_device *dev =3D to_platform_device(_dev);
-	int ret;
+	int ret =3D 0;
=20
-	ret =3D drv->remove(dev);
+	if (drv->remove)
+		ret =3D drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
=20
 	return ret;
@@ -553,7 +554,8 @@ static void platform_drv_shutdown(struct device *_d=
ev)
 	struct platform_driver *drv =3D to_platform_driver(_dev->driver);
 	struct platform_device *dev =3D to_platform_device(_dev);
=20
-	drv->shutdown(dev);
+	if (drv->shutdown)
+		drv->shutdown(dev);
 	dev_pm_domain_detach(_dev, true);
 }
=20
@@ -567,12 +569,9 @@ int __platform_driver_register(struct platform_dri=
ver *drv,
 {
 	drv->driver.owner =3D owner;
 	drv->driver.bus =3D &platform_bus_type;
-	if (drv->probe)
-		drv->driver.probe =3D platform_drv_probe;
-	if (drv->remove)
-		drv->driver.remove =3D platform_drv_remove;
-	if (drv->shutdown)
-		drv->driver.shutdown =3D platform_drv_shutdown;
+	drv->driver.probe =3D platform_drv_probe;
+	drv->driver.remove =3D platform_drv_remove;
+	drv->driver.shutdown =3D platform_drv_shutdown;
=20
 	return driver_register(&drv->driver);
 }
--=20
2.4.6

