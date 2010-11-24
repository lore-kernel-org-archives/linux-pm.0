From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/13] ACPI / PM: Introduce function for
	refcounting device power resources
Date: Thu, 25 Nov 2010 00:06:55 +0100
Message-ID: <201011250006.55559.rjw@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011250001.11297.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function acpi_power_on_resources() that reference counts
and possibly turns on ACPI power resources for a given device and
a given power state of it.

This function will be used for reference counting device power
resources during initialization.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/power.c    |    8 ++++++++
 2 files changed, 9 insertions(+)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -485,6 +485,14 @@ int acpi_power_get_inferred_state(struct
 	return 0;
 }
 
+int acpi_power_on_resources(struct acpi_device *device, int state)
+{
+	if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3)
+		return -EINVAL;
+
+	return acpi_power_on_list(&device->power.states[state].resources);
+}
+
 int acpi_power_transition(struct acpi_device *device, int state)
 {
 	int result;
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -42,6 +42,7 @@ int acpi_power_init(void);
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
+int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
 
