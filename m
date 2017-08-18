From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 7/8 v2] turbostat: add node information into turbostat calculations
Date: Fri, 18 Aug 2017 09:08:28 -0400
Message-ID: <1503061709-4319-8-git-send-email-prarit@redhat.com>
References: <1503061709-4319-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdHRNIm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Aug 2017 09:08:42 -0400
In-Reply-To: <1503061709-4319-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

The previous patches have added node information to turbostat, but the
counters code does not take it into account.

Add node information from cpu_topology calculations to turbostat
counters.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 143 ++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 58 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 076c28b2726b..219fc8a5c335 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -205,12 +205,21 @@ struct pkg_data {
 #define ODD_COUNTERS thread_odd, core_odd, package_odd
 #define EVEN_COUNTERS thread_even, core_even, package_even
 
-#define GET_THREAD(thread_base, thread_no, core_no, pkg_no) \
-	(thread_base + (pkg_no) * topo.cores_per_node * \
-		topo.threads_per_core + \
-		(core_no) * topo.threads_per_core + (thread_no))
-#define GET_CORE(core_base, core_no, pkg_no) \
-	(core_base + (pkg_no) * topo.cores_per_node + (core_no))
+#define GET_THREAD(thread_base, thread_no, core_no, node_no, pkg_no)	      \
+	((thread_base) +						      \
+	 ((pkg_no) *							      \
+	  topo.nodes_per_pkg * topo.cores_per_node * topo.threads_per_core) + \
+	 ((node_no) * topo.cores_per_node * topo.threads_per_core) +	      \
+	 ((core_no) * topo.threads_per_core) +				      \
+	 (thread_no))
+
+#define GET_CORE(core_base, core_no, node_no, pkg_no)			\
+	((core_base) +							\
+	 ((pkg_no) *  topo.nodes_per_pkg * topo.cores_per_node) +	\
+	 ((node_no) * topo.cores_per_node) +				\
+	 (core_no))
+
+
 #define GET_PKG(pkg_base, pkg_no) (pkg_base + pkg_no)
 
 enum counter_scope {SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE};
@@ -286,27 +295,33 @@ int cpu_is_not_present(int cpu)
 int for_all_cpus(int (func)(struct thread_data *, struct core_data *, struct pkg_data *),
 	struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base)
 {
-	int retval, pkg_no, core_no, thread_no;
+	int retval, pkg_no, core_no, thread_no, node_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
 		for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
-			for (thread_no = 0; thread_no <
-				topo.threads_per_core; ++thread_no) {
-				struct thread_data *t;
-				struct core_data *c;
-				struct pkg_data *p;
-
-				t = GET_THREAD(thread_base, thread_no, core_no, pkg_no);
-
-				if (cpu_is_not_present(t->cpu_id))
-					continue;
-
-				c = GET_CORE(core_base, core_no, pkg_no);
-				p = GET_PKG(pkg_base, pkg_no);
-
-				retval = func(t, c, p);
-				if (retval)
-					return retval;
+			for (node_no = 0; node_no < topo.nodes_per_pkg;
+			     node_no++) {
+				for (thread_no = 0; thread_no <
+					topo.threads_per_core; ++thread_no) {
+					struct thread_data *t;
+					struct core_data *c;
+					struct pkg_data *p;
+
+					t = GET_THREAD(thread_base, thread_no,
+						       core_no, node_no,
+						       pkg_no);
+
+					if (cpu_is_not_present(t->cpu_id))
+						continue;
+
+					c = GET_CORE(core_base, core_no,
+						     node_no, pkg_no);
+					p = GET_PKG(pkg_base, pkg_no);
+
+					retval = func(t, c, p);
+					if (retval)
+						return retval;
+				}
 			}
 		}
 	}
@@ -2403,32 +2418,42 @@ int for_all_cpus_2(int (func)(struct thread_data *, struct core_data *,
 	struct thread_data *thread_base2, struct core_data *core_base2,
 	struct pkg_data *pkg_base2)
 {
-	int retval, pkg_no, core_no, thread_no;
+	int retval, pkg_no, node_no, core_no, thread_no;
 
 	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
-			for (thread_no = 0; thread_no <
-				topo.threads_per_core; ++thread_no) {
-				struct thread_data *t, *t2;
-				struct core_data *c, *c2;
-				struct pkg_data *p, *p2;
-
-				t = GET_THREAD(thread_base, thread_no, core_no, pkg_no);
-
-				if (cpu_is_not_present(t->cpu_id))
-					continue;
-
-				t2 = GET_THREAD(thread_base2, thread_no, core_no, pkg_no);
-
-				c = GET_CORE(core_base, core_no, pkg_no);
-				c2 = GET_CORE(core_base2, core_no, pkg_no);
-
-				p = GET_PKG(pkg_base, pkg_no);
-				p2 = GET_PKG(pkg_base2, pkg_no);
-
-				retval = func(t, c, p, t2, c2, p2);
-				if (retval)
-					return retval;
+		for (node_no = 0; node_no < topo.nodes_per_pkg; ++node_no) {
+			for (core_no = 0; core_no < topo.cores_per_node;
+			     ++core_no) {
+				for (thread_no = 0; thread_no <
+					topo.threads_per_core; ++thread_no) {
+					struct thread_data *t, *t2;
+					struct core_data *c, *c2;
+					struct pkg_data *p, *p2;
+
+					t = GET_THREAD(thread_base, thread_no,
+						       core_no, node_no,
+						       pkg_no);
+
+					if (cpu_is_not_present(t->cpu_id))
+						continue;
+
+					t2 = GET_THREAD(thread_base2, thread_no,
+							core_no, node_no,
+							pkg_no);
+
+					c = GET_CORE(core_base, core_no,
+						     node_no, pkg_no);
+					c2 = GET_CORE(core_base2, core_no,
+						      node_no,
+						      pkg_no);
+
+					p = GET_PKG(pkg_base, pkg_no);
+					p2 = GET_PKG(pkg_base2, pkg_no);
+
+					retval = func(t, c, p, t2, c2, p2);
+					if (retval)
+						return retval;
+				}
 			}
 		}
 	}
@@ -4506,25 +4531,26 @@ void topology_probe()
 }
 
 void
-allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_data **p)
+allocate_counters(struct thread_data **t, struct core_data **c,
+		  struct pkg_data **p)
 {
 	int i;
+	int num_cores = topo.cores_per_node * topo.nodes_per_pkg *
+			topo.num_packages;
+	int num_threads = topo.threads_per_core * num_cores;
 
-	*t = calloc(topo.threads_per_core * topo.cores_per_node *
-		topo.num_packages, sizeof(struct thread_data));
+	*t = calloc(num_threads, sizeof(struct thread_data));
 	if (*t == NULL)
 		goto error;
 
-	for (i = 0; i < topo.threads_per_core *
-		topo.cores_per_node * topo.num_packages; i++)
+	for (i = 0; i < num_threads; i++)
 		(*t)[i].cpu_id = -1;
 
-	*c = calloc(topo.cores_per_node * topo.num_packages,
-		sizeof(struct core_data));
+	*c = calloc(num_cores, sizeof(struct core_data));
 	if (*c == NULL)
 		goto error;
 
-	for (i = 0; i < topo.cores_per_node * topo.num_packages; i++)
+	for (i = 0; i < num_cores; i++)
 		(*c)[i].core_id = -1;
 
 	*p = calloc(topo.num_packages, sizeof(struct pkg_data));
@@ -4547,14 +4573,15 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 	struct pkg_data *pkg_base, int cpu_id)
 {
 	int pkg_id = cpus[cpu_id].physical_package_id;
+	int node_id = cpus[cpu_id].logical_node_id;
 	int core_id = cpus[cpu_id].physical_core_id;
 	int thread_id = cpus[cpu_id].thread_id;
 	struct thread_data *t;
 	struct core_data *c;
 	struct pkg_data *p;
 
-	t = GET_THREAD(thread_base, thread_id, core_id, pkg_id);
-	c = GET_CORE(core_base, core_id, pkg_id);
+	t = GET_THREAD(thread_base, thread_id, core_id, node_id, pkg_id);
+	c = GET_CORE(core_base, core_id, node_id, pkg_id);
 	p = GET_PKG(pkg_base, pkg_id);
 
 	t->cpu_id = cpu_id;
-- 
1.8.5.5
