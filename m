From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/15] ACPI battery: only refresh the sysfs files
	when pertinent information changes
Date: Mon,  4 Jun 2012 01:39:52 -0400
Message-ID: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
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
Cc: Andy Whitcroft <apw@canonical.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Andy Whitcroft <apw@canonical.com>

We only need to regenerate the sysfs files when the capacity units
change, avoid the update otherwise.

The origin of this issue is dates way back to 2.6.38:
da8aeb92d4853f37e281f11fddf61f9c7d84c3cd
(ACPI / Battery: Update information on info notification and resume)

cc: <stable@vger.kernel.org>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
Tested-by: Ralf Jung <post@ralfj.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 86933ca..7dd3f9f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -643,11 +643,19 @@ static int acpi_battery_update(struct acpi_battery *battery)
 
 static void acpi_battery_refresh(struct acpi_battery *battery)
 {
+	int power_unit;
+
 	if (!battery->bat.dev)
 		return;
 
+	power_unit = battery->power_unit;
+
 	acpi_battery_get_info(battery);
-	/* The battery may have changed its reporting units. */
+
+	if (power_unit == battery->power_unit)
+		return;
+
+	/* The battery has changed its reporting units. */
 	sysfs_remove_battery(battery);
 	sysfs_add_battery(battery);
 }
-- 
1.7.11.rc0.100.g5498c5f
