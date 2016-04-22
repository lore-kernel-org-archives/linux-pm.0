From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] tools/power: turbostat: Allocate correct amount of fd and irq entries
Date: Fri, 22 Apr 2016 11:13:23 +0300
Message-ID: <1461312803-45678-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12395 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbcDVIN1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 04:13:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

The tool uses topo.max_cpu_num to determine number of entries needed for
fd_percpu[] and irqs_per_cpu[]. For example on a system with 4 CPUs
topo.max_cpu_num is 3 so we get too small array for holding per-CPU items.

Fix this to use right number of entries, which is topo.max_cpu_num + 1.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index acbf7ff2ee6e..fb70a6ce3e52 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1638,7 +1638,7 @@ void free_fd_percpu(void)
 {
 	int i;
 
-	for (i = 0; i < topo.max_cpu_num; ++i) {
+	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
 		if (fd_percpu[i] != 0)
 			close(fd_percpu[i]);
 	}
@@ -3598,7 +3598,7 @@ void allocate_output_buffer()
 }
 void allocate_fd_percpu(void)
 {
-	fd_percpu = calloc(topo.max_cpu_num, sizeof(int));
+	fd_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 	if (fd_percpu == NULL)
 		err(-1, "calloc fd_percpu");
 }
@@ -3608,9 +3608,9 @@ void allocate_irq_buffers(void)
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
2.8.0.rc3

