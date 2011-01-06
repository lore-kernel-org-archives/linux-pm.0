From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/11] ACPI / PM: Rename acpi_power_off_device()
Date: Thu, 6 Jan 2011 23:38:04 +0100
Message-ID: <201101062338.04737.rjw__11412.0809980252$1294354429$gmane$org@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Rename acpi_power_off_device() to acpi_power_off() in analogy with
acpi_power_on().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -219,7 +219,7 @@ static int acpi_power_on(acpi_handle han
 	return result;
 }
 
-static int acpi_power_off_device(acpi_handle handle)
+static int acpi_power_off(acpi_handle handle)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -268,7 +268,7 @@ static void __acpi_power_off_list(struct
 	int i;
 
 	for (i = num_res - 1; i >= 0 ; i--)
-		acpi_power_off_device(list->handles[i]);
+		acpi_power_off(list->handles[i]);
 }
 
 static void acpi_power_off_list(struct acpi_handle_list *list)
@@ -430,8 +430,7 @@ int acpi_disable_wakeup_device_power(str
 
 	/* Close power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
-		int ret = acpi_power_off_device(
-				dev->wakeup.resources.handles[i]);
+		int ret = acpi_power_off(dev->wakeup.resources.handles[i]);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
