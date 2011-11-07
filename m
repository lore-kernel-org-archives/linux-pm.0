From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/14] ACPI: Fix possible recursive locking in
	hwregs.c
Date: Sun, 06 Nov 2011 23:11:54 -0500
Message-ID: <f7f71cfbf0c276ee3d8d856d0f35a41aed997fa4.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
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
Cc: Rakib Mullick <rakib.mullick@gmail.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rakib Mullick <rakib.mullick@gmail.com>

Calling pm-suspend might trigger a recursive lock in it's code path.
In function acpi_hw_clear_acpi_status, acpi_os_acquire_lock holds
the lock acpi_gbl_hardware_lock before calling acpi_hw_register_write(),
then without releasing acpi_gbl_hardware_lock, this function calls
acpi_ev_walk_gpe_list, which tries to hold acpi_gbl_gpe_lock.
Both acpi_gbl_hardware_lock and acpi_gbl_gpe_lock are at same
lock-class and which might cause lock recursion deadlock.

Following patch fixes this scenario by just releasing
acpi_gbl_hardware_lock before calling acpi_ev_walk_gpe_list.

 Changes since v0(https://lkml.org/lkml/2011/9/21/355):
	- Fix changelog, thanks to Lin Ming.

 Changes since v1 (https://lkml.org/lkml/2011/11/3/89):
	- Update changelog and rename goto label, courtesy Srivatsa S. Bhat.

Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 55accb7..cc70f3f 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -269,16 +269,17 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 					ACPI_BITMASK_ALL_FIXED_STATUS);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
+
+	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+
+	if (ACPI_FAILURE(status))
+		goto exit;
 
 	/* Clear the GPE Bits in all GPE registers in all GPE blocks */
 
 	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
 
-      unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+exit:
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.7.rc0.72.g4b5ea
