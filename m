From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 8/8] ACPI PM: Add DMI quirk list for ACPI 1.0
	suspend ordering
Date: Thu, 10 Jul 2008 02:07:02 +0200
Message-ID: <200807100207.03636.rjw__29179.0046067492$1215650262$gmane$org@sisk.pl>
References: <200807100152.17755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807100152.17755.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: ACPI PM: Add DMI quirk list for ACPI 1.0 suspend ordering

There are a few BIOS' that we know of already that need to use the
ACPI 1.0 suspend order. This appears to be only be a small minority of
mostly nVidia based systems.

Based on observation of Windows behaviour, it's clear that Windows is
also doing maintaining its own list of broken hardware that needs this
workaround.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 drivers/acpi/sleep/main.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


Index: linux-next/drivers/acpi/sleep/main.c
===================================================================
--- linux-next.orig/drivers/acpi/sleep/main.c
+++ linux-next/drivers/acpi/sleep/main.c
@@ -280,6 +280,24 @@ static struct platform_suspend_ops acpi_
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
+
+static int __init init_old_suspend_ordering(const struct dmi_system_id *d)
+{
+	old_suspend_ordering = true;
+	return 0;
+}
+
+static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Abit KN9 (nForce4 variant)",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "http://www.abit.com.tw/"),
+		DMI_MATCH(DMI_BOARD_NAME, "KN9 Series(NF-CK804)"),
+		},
+	},
+	{},
+};
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
@@ -531,6 +549,8 @@ int __init acpi_sleep_init(void)
 	u8 type_a, type_b;
 #ifdef CONFIG_SUSPEND
 	int i = 0;
+
+	dmi_check_system(acpisleep_dmi_table);
 #endif
 
 	if (acpi_disabled)
