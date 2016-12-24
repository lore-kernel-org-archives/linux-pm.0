From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/17] tools/power turbostat: Allocate correct amount of fd and irq entries
Date: Sat, 24 Dec 2016 15:53:32 -0500
Message-ID: <01a67adfc5d73d24e999d9cf65b5b8a6687187b8.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32828 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbcLXU4G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:06 -0500
Received: by mail-qk0-f196.google.com with SMTP id n21so21671355qka.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:06 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

The tool uses topo.max_cpu_num to determine number of entries needed for
fd_percpu[] and irqs_per_cpu[]. For example on a system with 4 CPUs
topo.max_cpu_num is 3 so we get too small array for holding per-CPU items.

Fix this to use right number of entries, which is topo.max_cpu_num + 1.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index be50892f27aa..741fefa2f07e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1618,7 +1618,7 @@ void free_fd_percpu(void)
 {
 	int i;
 
-	for (i = 0; i < topo.max_cpu_num; ++i) {
+	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
 		if (fd_percpu[i] != 0)
 			close(fd_percpu[i]);
 	}
@@ -3584,7 +3584,7 @@ void allocate_output_buffer()
 }
 void allocate_fd_percpu(void)
 {
-	fd_percpu = calloc(topo.max_cpu_num, sizeof(int));
+	fd_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 	if (fd_percpu == NULL)
 		err(-1, "calloc fd_percpu");
 }
@@ -3594,9 +3594,9 @@ void allocate_irq_buffers(void)
 	if (irq_column_2_cpu == NULL)
 		err(-1, "calloc %d", topo.num_cpus);
 
-	irqs_per_cpu = calloc(topo.max_cpu_num, sizeof(int));
+	irqs_per_cpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 	if (irqs_per_cpu == NULL)
-		err(-1, "calloc %d", topo.max_cpu_num);
+		err(-1, "calloc %d", topo.max_cpu_num + 1);
 }
 void setup_all_buffers(void)
 {
-- 
2.11.0.161.g6610af872

