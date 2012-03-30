From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/76] ACPICA: Move ACPI timer prototypes to
	public acpixf file
Date: Fri, 30 Mar 2012 06:13:28 -0400
Message-ID: <d08310fe0d6bd8c82da94e8d8ef48bdbe14d2bd1.1333101989.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

These prototypes were incorrectly declared in achware.h.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/achware.h |   12 ------------
 include/acpi/acpixf.h         |   12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 087f710..eed204a 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -145,16 +145,4 @@ acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
 
-#ifdef	ACPI_FUTURE_USAGE
-/*
- * hwtimer - ACPI Timer prototypes
- */
-acpi_status acpi_get_timer_resolution(u32 * resolution);
-
-acpi_status acpi_get_timer(u32 * ticks);
-
-acpi_status
-acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed);
-#endif				/* ACPI_FUTURE_USAGE */
-
 #endif				/* __ACHWARE_H__ */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index a28da35..67cd51c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -419,6 +419,18 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
 /*
+ * ACPI Timer interfaces
+ */
+#ifdef ACPI_FUTURE_USAGE
+acpi_status acpi_get_timer_resolution(u32 *resolution);
+
+acpi_status acpi_get_timer(u32 *ticks);
+
+acpi_status
+acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 *time_elapsed);
+#endif				/* ACPI_FUTURE_USAGE */
+
+/*
  * Error/Warning output
  */
 void ACPI_INTERNAL_VAR_XFACE
-- 
1.7.10.rc2.19.gfae9d
