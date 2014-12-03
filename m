From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] hsi / OMAP / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 03:02:24 +0100
Message-ID: <6319344.XVfdONE5DJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57273 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750730AbaLCBlA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 20:41:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Do that for the omap_ssi driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/hsi/controllers/omap_ssi.c      |    2 +-
 drivers/hsi/controllers/omap_ssi_port.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/hsi/controllers/omap_ssi.c
===================================================================
--- linux-pm.orig/drivers/hsi/controllers/omap_ssi.c
+++ linux-pm/drivers/hsi/controllers/omap_ssi.c
@@ -555,7 +555,7 @@ static int __exit ssi_remove(struct plat
 	return 0;
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int omap_ssi_runtime_suspend(struct device *dev)
 {
 	struct hsi_controller *ssi = dev_get_drvdata(dev);
Index: linux-pm/drivers/hsi/controllers/omap_ssi_port.c
===================================================================
--- linux-pm.orig/drivers/hsi/controllers/omap_ssi_port.c
+++ linux-pm/drivers/hsi/controllers/omap_ssi_port.c
@@ -1260,7 +1260,7 @@ static int __exit ssi_port_remove(struct
 	return 0;
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int ssi_save_port_ctx(struct omap_ssi_port *omap_port)
 {
 	struct hsi_port *port = to_hsi_port(omap_port->dev);

