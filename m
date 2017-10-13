From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / core: Fix kerneldoc comments of three functions
Date: Fri, 13 Oct 2017 02:33:33 +0200
Message-ID: <1805031.1a2Ur49QVy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix kerneldoc comments of __device_suspend_noirq(),
__device_suspend_late() and __device_suspend() where the function
names in kerneldoc don't match the actual names of the functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1077,7 +1077,7 @@ static pm_message_t resume_event(pm_mess
 }
 
 /**
- * device_suspend_noirq - Execute a "late suspend" callback for given device.
+ * __device_suspend_noirq - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
@@ -1237,7 +1237,7 @@ int dpm_suspend_noirq(pm_message_t state
 }
 
 /**
- * device_suspend_late - Execute a "late suspend" callback for given device.
+ * __device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
@@ -1439,7 +1439,7 @@ static void dpm_clear_suppliers_direct_c
 }
 
 /**
- * device_suspend - Execute "suspend" callbacks for given device.
+ * __device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
