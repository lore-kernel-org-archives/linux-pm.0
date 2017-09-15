From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 5/8 v2 RESEND] turbostat: rename num_cores_per_pkg to num_cores_per_node
Date: Fri, 15 Sep 2017 09:15:35 -0400
Message-ID: <1505481338-19770-6-git-send-email-prarit@redhat.com>
References: <1505481338-19770-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdIONPo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Sep 2017 09:15:44 -0400
In-Reply-To: <1505481338-19770-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

turbostat incorrectly assumes that there is one node per package.  As a
result num_cores_per_pkg is not correctly named and is actually
num_cores_per_node.

Rename num_cores_per_pkg to num_cores_per_node.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 03af557d46b4..52911b429526 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -206,11 +206,11 @@ struct pkg_data {
 #define EVEN_COUNTERS thread_even, core_even, package_even
 
 #define GET_THREAD(thread_base, thread_no, core_no, pkg_no) \
-	(thread_base + (pkg_no) * topo.num_cores_per_pkg * \
+	(thread_base + (pkg_no) * topo.num_cores_per_node * \
 		topo.num_threads_per_core + \
 		(core_no) * topo.num_threads_per_core + (thread_no))
 #define GET_CORE(core_base, core_no, pkg_no) \
-	(core_base + (pkg_no) * topo.num_cores_per_pkg + (core_no))
+	(core_base + (pkg_no) * topo.num_cores_per_node + (core_no))
 #define GET_PKG(pkg_base, pkg_no) (pkg_base + pkg_no)
 
 enum counter_scope {SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE};
@@ -263,7 +263,7 @@ struct topo_params {
 	int max_cpu_num;
 	int max_node_num;
 	int num_nodes_per_pkg;
-	int num_cores_per_pkg;
+	int num_cores_per_node;
 	int num_threads_per_core;
 } topo;
 
@@ -289,7 +289,8 @@ int for_all_cpus(int (func)(struct thread_data *, struct core_data *, struct pkg
 	int retval, pkg_no, core_no, thread_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (core_no = 0; core_no < topo.num_cores_per_pkg; ++core_no) {
+		for (core_no = 0; core_no < topo.num_cores_per_node;
+		     ++core_no) {
 			for (thread_no = 0; thread_no <
 				topo.num_threads_per_core; ++thread_no) {
 				struct thread_data *t;
@@ -2406,7 +2407,8 @@ int for_all_cpus_2(int (func)(struct thread_data *, struct core_data *,
 	int retval, pkg_no, core_no, thread_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (core_no = 0; core_no < topo.num_cores_per_pkg; ++core_no) {
+		for (core_no = 0; core_no < topo.num_cores_per_node;
+		     ++core_no) {
 			for (thread_no = 0; thread_no <
 				topo.num_threads_per_core; ++thread_no) {
 				struct thread_data *t, *t2;
@@ -4482,11 +4484,11 @@ void topology_probe()
 				cpus[i].thread_id);
 	}
 
-	topo.num_cores_per_pkg = max_core_id + 1;
+	topo.num_cores_per_node = max_core_id + 1;
 	if (debug > 1)
 		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n",
-			max_core_id, topo.num_cores_per_pkg);
-	if (!summary_only && topo.num_cores_per_pkg > 1)
+			max_core_id, topo.num_cores_per_node);
+	if (!summary_only && topo.num_cores_per_node > 1)
 		BIC_PRESENT(BIC_Core);
 
 	topo.num_packages = max_package_id + 1;
@@ -4510,21 +4512,21 @@ void topology_probe()
 {
 	int i;
 
-	*t = calloc(topo.num_threads_per_core * topo.num_cores_per_pkg *
+	*t = calloc(topo.num_threads_per_core * topo.num_cores_per_node *
 		topo.num_packages, sizeof(struct thread_data));
 	if (*t == NULL)
 		goto error;
 
 	for (i = 0; i < topo.num_threads_per_core *
-		topo.num_cores_per_pkg * topo.num_packages; i++)
+		topo.num_cores_per_node * topo.num_packages; i++)
 		(*t)[i].cpu_id = -1;
 
-	*c = calloc(topo.num_cores_per_pkg * topo.num_packages,
+	*c = calloc(topo.num_cores_per_node * topo.num_packages,
 		sizeof(struct core_data));
 	if (*c == NULL)
 		goto error;
 
-	for (i = 0; i < topo.num_cores_per_pkg * topo.num_packages; i++)
+	for (i = 0; i < topo.num_cores_per_node * topo.num_packages; i++)
 		(*c)[i].core_id = -1;
 
 	*p = calloc(topo.num_packages, sizeof(struct pkg_data));
-- 
1.8.5.5
