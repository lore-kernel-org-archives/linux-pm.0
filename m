From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/76] ACPI: Introduce ACPI D3_COLD state support
Date: Fri, 30 Mar 2012 06:13:49 -0400
Message-ID: <3ebc81b8937d2bc1d0d0064bed29434dfce490aa.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

If a device has _PR3, it means the device supports D3_COLD.
Add the ability to validate and enter D3_COLD state in ACPI.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    4 ++--
 drivers/acpi/scan.c  |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 9ac2a9f..0d681fb 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -500,14 +500,14 @@ int acpi_power_transition(struct acpi_device *device, int state)
 {
 	int result;
 
-	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
+	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
 		return -EINVAL;
 
 	if (device->power.state == state)
 		return 0;
 
 	if ((device->power.state < ACPI_STATE_D0)
-	    || (device->power.state > ACPI_STATE_D3))
+	    || (device->power.state > ACPI_STATE_D3_COLD))
 		return -ENODEV;
 
 	/* TBD: Resources must be ordered. */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ab80ba..571396c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -885,6 +885,13 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 				acpi_bus_add_power_resource(ps->resources.handles[j]);
 		}
 
+		/* The exist of _PR3 indicates D3Cold support */
+		if (i == ACPI_STATE_D3) {
+			status = acpi_get_handle(device->handle, object_name, &handle);
+			if (ACPI_SUCCESS(status))
+				device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
+		}
+
 		/* Evaluate "_PSx" to see if we can do explicit sets */
 		object_name[2] = 'S';
 		status = acpi_get_handle(device->handle, object_name, &handle);
-- 
1.7.10.rc2.19.gfae9d
