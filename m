From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 6/7] turbostat: remove num_ from cpu_topology struct
Date: Fri, 28 Jul 2017 08:06:20 -0400
Message-ID: <1501243581-31491-8-git-send-email-prarit@redhat.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdG1MGj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 08:06:39 -0400
In-Reply-To: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

Cleanup, remove num_ from num_nodes_per_pkg, num_cores_per_node, and
num_threads_per_node.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index db690ef4bfb0..537f879ea90a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -206,11 +206,11 @@ struct pkg_data {
 #define EVEN_COUNTERS thread_even, core_even, package_even
 
 #define GET_THREAD(thread_base, thread_no, core_no, pkg_no) \
-	(thread_base + (pkg_no) * topo.num_cores_per_node * \
-		topo.num_threads_per_core + \
-		(core_no) * topo.num_threads_per_core + (thread_no))
+	(thread_base + (pkg_no) * topo.cores_per_node * \
+		topo.threads_per_core + \
+		(core_no) * topo.threads_per_core + (thread_no))
 #define GET_CORE(core_base, core_no, pkg_no) \
-	(core_base + (pkg_no) * topo.num_cores_per_node + (core_no))
+	(core_base + (pkg_no) * topo.cores_per_node + (core_no))
 #define GET_PKG(pkg_base, pkg_no) (pkg_base + pkg_no)
 
 enum counter_scope {SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE};
@@ -262,9 +262,9 @@ struct topo_params {
 	int num_cores;
 	int max_cpu_num;
 	int max_node_num;
-	int num_nodes_per_pkg;
-	int num_cores_per_node;
-	int num_threads_per_core;
+	int nodes_per_pkg;
+	int cores_per_node;
+	int threads_per_core;
 } topo;
 
 struct timeval tv_even, tv_odd, tv_delta;
@@ -289,9 +289,9 @@ int for_all_cpus(int (func)(struct thread_data *, struct core_data *, struct pkg
 	int retval, pkg_no, core_no, thread_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (core_no = 0; core_no < topo.num_cores_per_node; ++core_no) {
+		for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
 			for (thread_no = 0; thread_no <
-				topo.num_threads_per_core; ++thread_no) {
+				topo.threads_per_core; ++thread_no) {
 				struct thread_data *t;
 				struct core_data *c;
 				struct pkg_data *p;
@@ -2317,8 +2317,8 @@ void set_node_data(void)
 	}
 
 	for (pkg = 0; pkg < topo.num_packages; pkg++)
-		if (pni[pkg].count > topo.num_nodes_per_pkg)
-			topo.num_nodes_per_pkg = pni[0].count;
+		if (pni[pkg].count > topo.nodes_per_pkg)
+			topo.nodes_per_pkg = pni[0].count;
 
 	for (cpu = 0; cpu < topo.num_cpus; cpu++) {
 		pkg = cpus[cpu].physical_package_id;
@@ -2400,9 +2400,9 @@ int for_all_cpus_2(int (func)(struct thread_data *, struct core_data *,
 	int retval, pkg_no, core_no, thread_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (core_no = 0; core_no < topo.num_cores_per_node; ++core_no) {
+		for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
 			for (thread_no = 0; thread_no <
-				topo.num_threads_per_core; ++thread_no) {
+				topo.threads_per_core; ++thread_no) {
 				struct thread_data *t, *t2;
 				struct core_data *c, *c2;
 				struct pkg_data *p, *p2;
@@ -4468,11 +4468,11 @@ void topology_probe()
 				cpus[i].physical_core_id);
 	}
 
-	topo.num_cores_per_node = max_core_id + 1;
+	topo.cores_per_node = max_core_id + 1;
 	if (debug > 1)
 		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n",
-			max_core_id, topo.num_cores_per_node);
-	if (!summary_only && topo.num_cores_per_node > 1)
+			max_core_id, topo.cores_per_node);
+	if (!summary_only && topo.cores_per_node > 1)
 		BIC_PRESENT(BIC_Core);
 
 	topo.num_packages = max_package_id + 1;
@@ -4484,9 +4484,9 @@ void topology_probe()
 
 	set_node_data();
 	if (debug > 1)
-		fprintf(outf, "num_nodes_per_pkg %d\n", topo.num_nodes_per_pkg);
+		fprintf(outf, "nodes_per_pkg %d\n", topo.nodes_per_pkg);
 
-	topo.num_threads_per_core = max_siblings;
+	topo.threads_per_core = max_siblings;
 	if (debug > 1)
 		fprintf(outf, "max_siblings %d\n", max_siblings);
 }
@@ -4496,21 +4496,21 @@ void topology_probe()
 {
 	int i;
 
-	*t = calloc(topo.num_threads_per_core * topo.num_cores_per_node *
+	*t = calloc(topo.threads_per_core * topo.cores_per_node *
 		topo.num_packages, sizeof(struct thread_data));
 	if (*t == NULL)
 		goto error;
 
-	for (i = 0; i < topo.num_threads_per_core *
-		topo.num_cores_per_node * topo.num_packages; i++)
+	for (i = 0; i < topo.threads_per_core *
+		topo.cores_per_node * topo.num_packages; i++)
 		(*t)[i].cpu_id = -1;
 
-	*c = calloc(topo.num_cores_per_node * topo.num_packages,
+	*c = calloc(topo.cores_per_node * topo.num_packages,
 		sizeof(struct core_data));
 	if (*c == NULL)
 		goto error;
 
-	for (i = 0; i < topo.num_cores_per_node * topo.num_packages; i++)
+	for (i = 0; i < topo.cores_per_node * topo.num_packages; i++)
 		(*c)[i].core_id = -1;
 
 	*p = calloc(topo.num_packages, sizeof(struct pkg_data));
-- 
1.8.5.5
