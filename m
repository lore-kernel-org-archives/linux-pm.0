From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / runtime: Fix handling of suppliers with disabled runtime PM
Date: Fri, 01 Dec 2017 14:58:34 +0100
Message-ID: <1532136.s6buYvDjaS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Prevent rpm_get_suppliers() from returning an error code if runtime
PM is disabled for one or more of the supplier devices it wants to
runtime-resume, so as to make runtime PM work for devices with links
to suppliers that don't use runtime PM (such links may be created
during device enumeration even before it is known whether or not
runtime PM will be enabled for the devices in question, for example).

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 21d5c57b3726 (PM / runtime: Use device links)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -276,7 +276,8 @@ static int rpm_get_suppliers(struct devi
 			continue;
 
 		retval = pm_runtime_get_sync(link->supplier);
-		if (retval < 0) {
+		/* Ignore suppliers with disabled runtime PM. */
+		if (retval < 0 && retval != -EACCES) {
 			pm_runtime_put_noidle(link->supplier);
 			return retval;
 		}
