From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/15] ACPI: Ignore invalid _PSS entries,
	but use valid ones
Date: Mon,  4 Jun 2012 01:39:53 -0400
Message-ID: <d8e725f356fd5f225ad97f21213fc007e409c9f5.1338786831.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Marco Aurelio da Costa <costa@gamic.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Marco Aurelio da Costa <costa@gamic.com>

The EliteBook 8560W has non-initialized entries in its _PSS ACPI
table. Instead of bailing out when the first non-initialized entry is
found, ignore it and use only  the valid entries. Only bail out if there
is no valid entry at all.

[v3: Fixes suggested by Konrad]

Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 0af48a8..a093dc1 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -333,6 +333,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	struct acpi_buffer state = { 0, NULL };
 	union acpi_object *pss = NULL;
 	int i;
+	int last_invalid = -1;
 
 
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
@@ -394,14 +395,33 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 		    ((u32)(px->core_frequency * 1000) !=
 		     (px->core_frequency * 1000))) {
 			printk(KERN_ERR FW_BUG PREFIX
-			       "Invalid BIOS _PSS frequency: 0x%llx MHz\n",
-			       px->core_frequency);
-			result = -EFAULT;
-			kfree(pr->performance->states);
-			goto end;
+			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
+			       pr->id, px->core_frequency);
+			if (last_invalid == -1)
+				last_invalid = i;
+		} else {
+			if (last_invalid != -1) {
+				/*
+				 * Copy this valid entry over last_invalid entry
+				 */
+				memcpy(&(pr->performance->states[last_invalid]),
+				       px, sizeof(struct acpi_processor_px));
+				++last_invalid;
+			}
 		}
 	}
 
+	if (last_invalid == 0) {
+		printk(KERN_ERR FW_BUG PREFIX
+		       "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
+		result = -EFAULT;
+		kfree(pr->performance->states);
+		pr->performance->states = NULL;
+	}
+
+	if (last_invalid > 0)
+		pr->performance->state_count = last_invalid;
+
       end:
 	kfree(buffer.pointer);
 
-- 
1.7.11.rc0.100.g5498c5f
