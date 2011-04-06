From: Amerigo Wang <amwang@redhat.com>
Subject: [RESEND Patch] acpi: remove acpi_sleep=s4_nonvs
Date: Wed,  6 Apr 2011 13:28:44 +0800
Message-ID: <1302067724-14795-1-git-send-email-amwang__12072.8217335001$1302069344$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, WANG Cong <amwang@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

First post is here: https://lkml.org/lkml/2011/1/19/4

acpi_sleep=s4_nonvs is superseded by acpi_sleep=nonvs.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: WANG Cong <amwang@redhat.com>
Cc: Len Brown <len.brown@intel.com>

---
 Documentation/feature-removal-schedule.txt |    8 --------
 Documentation/kernel-parameters.txt        |    2 +-
 arch/x86/kernel/acpi/sleep.c               |    5 -----
 3 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 274b32d..f57775c 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -480,14 +480,6 @@ Who:	Thomas Gleixner <tglx@linutronix.de>
 
 ----------------------------
 
-What:	The acpi_sleep=s4_nonvs command line option
-When:	2.6.37
-Files:	arch/x86/kernel/acpi/sleep.c
-Why:	superseded by acpi_sleep=nonvs
-Who:	Rafael J. Wysocki <rjw@sisk.pl>
-
-----------------------------
-
 What: 	PCI DMA unmap state API
 When:	August 2012
 Why:	PCI DMA unmap state API (include/linux/pci-dma.h) was replaced
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d2b5150..26c69c1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -245,7 +245,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, s4_nonvs, sci_force_enable }
+				  old_ordering, nonvs, sci_force_enable }
 			See Documentation/power/video.txt for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index ff93bc1..18a857b 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -112,11 +112,6 @@ static int __init acpi_sleep_setup(char *str)
 #ifdef CONFIG_HIBERNATION
 		if (strncmp(str, "s4_nohwsig", 10) == 0)
 			acpi_no_s4_hw_signature();
-		if (strncmp(str, "s4_nonvs", 8) == 0) {
-			pr_warning("ACPI: acpi_sleep=s4_nonvs is deprecated, "
-					"please use acpi_sleep=nonvs instead");
-			acpi_nvs_nosave();
-		}
 #endif
 		if (strncmp(str, "nonvs", 5) == 0)
 			acpi_nvs_nosave();
