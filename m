From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH v1] tools/power: turbostat: fix buffer overrun
Date: Wed,  3 Apr 2019 16:02:14 +0900
Message-ID: <1554274934-12649-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

turbostat could be terminated by general protection fault on some latest
hardwares which (for example) support 9 levels of C-states and show 18
"tADDED" lines. That bloats the total output and finally causes buffer
overrun.  So let's extend the buffer to avoid this.

This patch also removes duplicated "pc10:" line to reduce buffer usage.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
index c7727be..17b1f544 100644
--- v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c
+++ v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
@@ -861,7 +861,6 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
 		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
-		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
 		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
@@ -5135,7 +5134,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.7.0
