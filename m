From: Prarit Bhargava <prarit@redhat.com>
Subject: [RESEND PATCH 8/8] turbostat: Add Node in output
Date: Fri,  3 Nov 2017 08:25:50 -0400
Message-ID: <20171103122550.13341-9-prarit@redhat.com>
References: <20171103122550.13341-1-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756195AbdKCM0J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Nov 2017 08:26:09 -0400
In-Reply-To: <20171103122550.13341-1-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, len.brown@intel.com, charles.rose@dell.com, rafael@kernel.org, suravee.suthikulpanit@amd.com, Prarit Bhargava <prarit@redhat.com>

Output a Node column if there is more than one node/socket.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 219fc8a5c335..01e3e71ac52e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -468,6 +468,7 @@ struct msr_counter bic[] = {
 #define	BIC_Any_c0	(1ULL << 40)
 #define	BIC_GFX_c0	(1ULL << 41)
 #define	BIC_CPUGFX	(1ULL << 42)
+#define	BIC_Node	(1ULL << 43)
 
 unsigned long long bic_enabled = 0xFFFFFFFFFFFFFFFFULL;
 unsigned long long bic_present = BIC_sysfs;
@@ -567,6 +568,8 @@ void print_header(char *delim)
 		outp += sprintf(outp, "usec %s", delim);
 	if (DO_BIC(BIC_Package))
 		outp += sprintf(outp, "%sPackage", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_Node))
+		outp += sprintf(outp, "%sNode", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Core))
 		outp += sprintf(outp, "%sCore", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU))
@@ -833,6 +836,8 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (t == &average.threads) {
 		if (DO_BIC(BIC_Package))
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+		if (DO_BIC(BIC_Node))
+			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Core))
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CPU))
@@ -844,6 +849,15 @@ int format_counters(struct thread_data *t, struct core_data *c,
 			else
 				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
+		if (DO_BIC(BIC_Node)) {
+			if (t)
+				outp += sprintf(outp, "%s%d",
+						(printed++ ? delim : ""),
+					      cpus[t->cpu_id].physical_node_id);
+			else
+				outp += sprintf(outp, "%s-",
+						(printed++ ? delim : ""));
+		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
 				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_id);
@@ -4524,6 +4538,8 @@ void topology_probe()
 	set_node_data();
 	if (debug > 1)
 		fprintf(outf, "nodes_per_pkg %d\n", topo.nodes_per_pkg);
+	if (!summary_only && topo.nodes_per_pkg > 1)
+		BIC_PRESENT(BIC_Node);
 
 	topo.threads_per_core = max_siblings;
 	if (debug > 1)
-- 
2.15.0.rc0.39.g2f0e14e64
