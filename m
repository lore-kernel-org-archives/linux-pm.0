From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 2/7] tboot: Add return values for tboot_sleep
Date: Fri, 16 Dec 2011 17:38:14 -0500
Message-ID: <1324075099-11397-3-git-send-email-konrad.wilk@oracle.com>
References: <1324075099-11397-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1324075099-11397-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, rjw@sisk.pl, x86@kernel.org, len.brown@intel.com, joseph.cihula@intel.com, linux-pm@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, liang.tang@oracle.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, hpa@zytor.com
List-Id: linux-pm@vger.kernel.org

. as appropiately. As tboot_sleep now returns values.
remove tboot_sleep_wrapper.

Suggested-by: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Joseph Cihula <joseph.cihula@intel.com>
[v1: Return -1/0/+1 instead of ACPI_xx values]
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/tboot.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 1a4ab7d..6410744 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -272,7 +272,7 @@ static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
 		offsetof(struct acpi_table_facs, firmware_waking_vector);
 }
 
-void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
+static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 {
 	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = {
 		/* S0,1,2: */ -1, -1, -1,
@@ -281,7 +281,7 @@ void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 		/* S5: */ TB_SHUTDOWN_S5 };
 
 	if (!tboot_enabled())
-		return;
+		return 0;
 
 	tboot_copy_fadt(&acpi_gbl_FADT);
 	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
@@ -292,15 +292,10 @@ void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 	if (sleep_state >= ACPI_S_STATE_COUNT ||
 	    acpi_shutdown_map[sleep_state] == -1) {
 		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
-		return;
+		return -1;
 	}
 
 	tboot_shutdown(acpi_shutdown_map[sleep_state]);
-}
-static int tboot_sleep_wrapper(u8 sleep_state, u32 pm1a_control,
-			       u32 pm1b_control)
-{
-	tboot_sleep(sleep_state, pm1a_control, pm1b_control);
 	return 0;
 }
 
@@ -352,7 +347,7 @@ static __init int tboot_late_init(void)
 	atomic_set(&ap_wfs_count, 0);
 	register_hotcpu_notifier(&tboot_cpu_notifier);
 
-	acpi_os_set_prepare_sleep(&tboot_sleep_wrapper);
+	acpi_os_set_prepare_sleep(&tboot_sleep);
 	return 0;
 }
 
-- 
1.7.7.4
