From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/3] PM: Asynchronous suspend and resume for
	ACPI battery
Date: Wed, 12 Aug 2009 22:22:02 +0200
Message-ID: <200908122222.02315.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122218.13975.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Allow the ACPI battery device to be resumed and suspended
asynchronously.

This only means that the driver's suspend and resume callbacks may
be executed in parallel with the callbacks of devices that don't
directly depend on the battery device (i.e. that are not its parent
or children).

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -837,6 +837,7 @@ static int acpi_battery_add(struct acpi_
 		printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 			ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 			device->status.battery_present ? "present" : "absent");
+		device_enable_async_suspend(&device->dev, true);
 	} else {
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_battery_remove_fs(device);
