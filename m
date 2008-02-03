From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM: Make suspend_device() static
Date: Sun, 3 Feb 2008 22:55:18 +0100
Message-ID: <200802032255.19835.rjw__47681.2966204763$1202076291$gmane$org@sisk.pl>
References: <200802032252.04852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032252.04852.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Adrian Bunk <bunk@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>

suspend_device() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
344fcfcea0df8cbaa83e10d7e66b826ead67290b 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 200ed5f..cfcc54f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  */
-int suspend_device(struct device *dev, pm_message_t state)
+static int suspend_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
