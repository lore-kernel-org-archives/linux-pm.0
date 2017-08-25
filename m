From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC] ACPI / PM: Reuse the acpi_sleep_syscore_ops for future requirement
Date: Sat, 26 Aug 2017 00:43:30 +0800
Message-ID: <eac9a77583a7ee95321acffb495f8c8e292f4a09.1503678995.git.yu.c.chen@intel.com>
References: <cover.1503678995.git.yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1503678995.git.yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There might be other actions to be taken during the
acpi syscore suspend/resume phase, thus reuse the
acpi_sleep_syscore_ops in case other operations are
added into the acpi_sleep_syscore_ops.

No functional change.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/sleep.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index fa8243c..cad1a0f 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -865,9 +865,19 @@ static void  acpi_restore_bm_rld(void)
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
 }
 
+static int  acpi_syscore_suspend(void)
+{
+	return acpi_save_bm_rld();
+}
+
+static void  acpi_syscore_restore(void)
+{
+	acpi_restore_bm_rld();
+}
+
 static struct syscore_ops acpi_sleep_syscore_ops = {
-	.suspend = acpi_save_bm_rld,
-	.resume = acpi_restore_bm_rld,
+	.suspend = acpi_syscore_suspend,
+	.resume = acpi_syscore_restore,
 };
 
 void acpi_sleep_syscore_init(void)
-- 
2.7.4

