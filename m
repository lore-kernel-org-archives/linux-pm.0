From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/11] ACPI / PM: Do not enable multiple devices
	to wake up simultaneously
Date: Thu, 6 Jan 2011 23:33:30 +0100
Message-ID: <201101062333.30960.rjw__16213.4403166876$1294354237$gmane$org@sisk.pl>
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

If a device is enabled to wake up the system from sleep states via
/proc/acpi/wakeup and there are other devices associated with the
same wakeup GPE, all of these devices are automatically enabled to
wake up the system.  This isn't correct, because the fact the GPE is
shared need not imply that wakeup power has to be enabled for all the
devices at the same time (i.e. it is possible that one device will
have its wakeup power enabled and it will wake up the system from a
sleep state if the shared wakeup GPE is enabled, while another device
having its wakeup power disabled will not wake up the system even
though the GPE is enabled).  Rework acpi_system_write_wakeup_device()
so that it only enables wakeup for one device at a time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/proc.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

Index: linux-2.6/drivers/acpi/proc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/proc.c
+++ linux-2.6/drivers/acpi/proc.c
@@ -341,7 +341,6 @@ acpi_system_write_wakeup_device(struct f
 	char strbuf[5];
 	char str[5] = "";
 	unsigned int len = count;
-	struct acpi_device *found_dev = NULL;
 
 	if (len > 4)
 		len = 4;
@@ -363,33 +362,10 @@ acpi_system_write_wakeup_device(struct f
 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
 			dev->wakeup.state.enabled =
 			    dev->wakeup.state.enabled ? 0 : 1;
-			found_dev = dev;
+			physical_device_enable_wakeup(dev);
 			break;
 		}
 	}
-	if (found_dev) {
-		physical_device_enable_wakeup(found_dev);
-		list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-			struct acpi_device *dev = container_of(node,
-							       struct
-							       acpi_device,
-							       wakeup_list);
-
-			if ((dev != found_dev) &&
-			    (dev->wakeup.gpe_number ==
-			     found_dev->wakeup.gpe_number)
-			    && (dev->wakeup.gpe_device ==
-				found_dev->wakeup.gpe_device)) {
-				printk(KERN_WARNING
-				       "ACPI: '%s' and '%s' have the same GPE, "
-				       "can't disable/enable one separately\n",
-				       dev->pnp.bus_id, found_dev->pnp.bus_id);
-				dev->wakeup.state.enabled =
-				    found_dev->wakeup.state.enabled;
-				physical_device_enable_wakeup(dev);
-			}
-		}
-	}
 	mutex_unlock(&acpi_device_lock);
 	return count;
 }
