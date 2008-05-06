From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] ACPI Hibernation: Use ACPI hardware signature
Date: Tue, 6 May 2008 23:33:16 +0200
Message-ID: <200805062333.17558.rjw__11590.3243808591$1210110421$gmane$org@sisk.pl>
References: <200805062331.39454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805062331.39454.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>

ACPI defines a hardware signature. BIOS calculates the signature
according to hardware configure, if hardware changes, the signature
will change, in this case, S4 resume should fail.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -255,6 +255,17 @@ static struct dmi_system_id __initdata a
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
+static unsigned long s4_hardware_signature;
+static struct acpi_table_facs *facs;
+static bool nosigcheck;
+
+static int __init acpi_s4_nosigcheck(char *str)
+{
+	nosigcheck = true;
+	return 1;
+}
+__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
@@ -301,6 +312,12 @@ static void acpi_hibernation_leave(void)
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	/* Check the hardware signature */
+	if (facs && s4_hardware_signature != facs->hardware_signature) {
+		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
+			"cannot resume!\n");
+		panic("ACPI S4 hardware signature mismatch");
+	}
 }
 
 static void acpi_hibernation_finish(void)
@@ -501,6 +518,13 @@ int __init acpi_sleep_init(void)
 		hibernation_set_ops(&acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
+		if (!nosigcheck) {
+			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+				(struct acpi_table_header **)&facs);
+			if (facs)
+				s4_hardware_signature =
+					facs->hardware_signature;
+		}
 	}
 #endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
