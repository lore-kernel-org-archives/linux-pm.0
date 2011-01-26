From: Mandeep Singh Baines <msb@chromium.org>
Subject: [PATCH 2/6] arch/x86: use appropriate printk priority
	level
Date: Wed, 26 Jan 2011 15:29:26 -0800
Message-ID: <1296084570-31453-3-git-send-email-msb__3062.76975102282$1296144565$gmane$org@chromium.org>
References: <20110125235700.GR8008@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110125235700.GR8008@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: gregkh@suse.de, rjw@sisk.pl, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-pm@vger.kernel.org

printk()s without a priority level default to KERN_WARNING. To reduce
noise at KERN_WARNING, this patch set the priority level appriopriately
for unleveled printks()s. This should be useful to folks that look at
dmesg warnings closely.

Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
---
 arch/x86/kernel/tsc.c       |    9 +++++----
 arch/x86/platform/efi/efi.c |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ffe5755..dbf2cbc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -373,7 +373,7 @@ static unsigned long quick_pit_calibrate(void)
 			goto success;
 		}
 	}
-	printk("Fast TSC calibration failed\n");
+	printk(KERN_WARNING "Fast TSC calibration failed\n");
 	return 0;
 
 success:
@@ -395,7 +395,7 @@ success:
 	delta += (long)(d2 - d1)/2;
 	delta *= PIT_TICK_RATE;
 	do_div(delta, i*256*1000);
-	printk("Fast TSC calibration using PIT\n");
+	printk(KERN_INFO "Fast TSC calibration using PIT\n");
 	return delta;
 }
 
@@ -518,7 +518,8 @@ unsigned long native_calibrate_tsc(void)
 
 		/* We don't have an alternative source, disable TSC */
 		if (!hpet && !ref1 && !ref2) {
-			printk("TSC: No reference (HPET/PMTIMER) available\n");
+			printk(KERN_WARNING
+			       "TSC: No reference (HPET/PMTIMER) available\n");
 			return 0;
 		}
 
@@ -1002,7 +1003,7 @@ void __init tsc_init(void)
 		return;
 	}
 
-	printk("Detected %lu.%03lu MHz processor.\n",
+	printk(KERN_INFO "Detected %lu.%03lu MHz processor.\n",
 			(unsigned long)cpu_khz / 1000,
 			(unsigned long)cpu_khz % 1000);
 
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 0fe27d7..0da6907 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -376,7 +376,7 @@ void __init efi_init(void)
 	if (config_tables == NULL)
 		printk(KERN_ERR "Could not map EFI Configuration Table!\n");
 
-	printk(KERN_INFO);
+	printk(KERN_INFO " ");
 	for (i = 0; i < efi.systab->nr_tables; i++) {
 		if (!efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID)) {
 			efi.mps = config_tables[i].table;
-- 
1.7.3.1
