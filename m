Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A8381AE3;
	Sat, 25 Apr 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142876; cv=none; b=K31lAhs5gp/azCvWvs8/gJEXHwMwSzzCkZGCND9Vgi5R2bGgnhiE/OWdwByncWszDkoHvnX8Zron4OlatRdJE1Ngcgp1h28VWDfU7XiAEpb7YfSMp7DI8rrxy9w8K/dDYvMQ17DsgNq4i9Un50ciPSPoGwZUwJW4mNijnKiFwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142876; c=relaxed/simple;
	bh=G62KuKWBGn7Qwh+LQ3h0CA9TMOR6GCyvygsHWLmMHAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhKqzoI1xVhz9dfePLk9RPj5aj0pXinTXXNEYLwGQXF+Xu7EdTYpI6XEAtPPZjF46enVx86dcq36SAQsKDs3/Leh3XCTFk8S2XyCbmIsk0cujS06Qfw4Q0smJEePFLF7tN9R8QleLH6yHqMTsof9ZCn2cOHDV6AAHQWgPy1MHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuzsebhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuzsebhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B42BC2BCB0;
	Sat, 25 Apr 2026 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142876;
	bh=G62KuKWBGn7Qwh+LQ3h0CA9TMOR6GCyvygsHWLmMHAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=cuzsebhdn6oYzwfI5yot0gY2CgGbXZqC3GnIP5+Pjy/mgY5gYYI9fyazCVLR3YzBf
	 uBGkm/QNfAwAfUbHqF9F5Zcgg3diyz2q3ezx/7exwkqv7/Y5VpCBg9UiC3VR3Yj8yX
	 siGvC83sjxWyvu2edjxUtdEddF+T7ryJljP9GfuFCwvvhmFkwPzB73nvonlbtsq/CK
	 gPK61K9Nw/dkvYmevmSBC9VmUtuQrJmLvOQr5U0ZuH3jw+pzVULYZthc1FaIP9bVMq
	 ayTQohQVAchSJ5zEhNEc1mkSemOFSAUtGMGvMM4NKEtppY9S4YfIIsUxGWeJKWEfDj
	 GfOaLuip17gug==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] tools/power turbostat: Show module_id column
Date: Sat, 25 Apr 2026 14:42:11 -0400
Message-ID: <aea40f1e2d77a5581539d1ec6366c7dc7566321d.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Get the "module_id" from the Linux topology "cluster_id".
If the there is more than one id, show it by default.

Module joins Die etc. in the "topology" group.

Display in hex, as it is usually based mask of the APIC-id

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 38 +++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b27227414dc7..f8e9aa8c9e54 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -191,6 +191,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Any%C0", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "GFX%C0", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPUGFX%", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Module", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "Core", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "APIC", NULL, 0, 0, 0, NULL, 0 },
@@ -264,6 +265,7 @@ enum bic_names {
 	BIC_Any_c0,
 	BIC_GFX_c0,
 	BIC_CPUGFX,
+	BIC_Module,
 	BIC_Core,
 	BIC_CPU,
 	BIC_APIC,
@@ -364,6 +366,7 @@ static void bic_groups_init(void)
 	SET_BIC(BIC_Node, &bic_group_topology);
 	SET_BIC(BIC_CoreCnt, &bic_group_topology);
 	SET_BIC(BIC_PkgCnt, &bic_group_topology);
+	SET_BIC(BIC_Module, &bic_group_topology);
 	SET_BIC(BIC_Core, &bic_group_topology);
 	SET_BIC(BIC_CPU, &bic_group_topology);
 	SET_BIC(BIC_Die, &bic_group_topology);
@@ -2383,6 +2386,7 @@ struct platform_counters {
 struct cpu_topology {
 	int cpu_id;
 	int core_id;		/* unique within a package */
+	int module_id;
 	int package_id;
 	int die_id;
 	int l3_id;
@@ -2404,6 +2408,8 @@ struct topo_params {
 	int allowed_cores;
 	int max_cpu_num;
 	int max_core_id;	/* within a package */
+	int min_module_id;	/* system wide */
+	int max_module_id;	/* system wide */
 	int max_package_id;
 	int max_die_id;
 	int max_l3_id;
@@ -2919,6 +2925,8 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sL3", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Node))
 		outp += sprintf(outp, "%sNode", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_Module))
+		outp += sprintf(outp, "%sModule", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Core))
 		outp += sprintf(outp, "%sCore", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU))
@@ -3388,6 +3396,8 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Node))
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+		if (DO_BIC(BIC_Module))
+			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Core))
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CPU))
@@ -3421,6 +3431,12 @@ int format_counters(PER_THREAD_PARAMS)
 			else
 				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
+		if (DO_BIC(BIC_Module)) {
+			if (c)
+				outp += sprintf(outp, "%s0x%x", (printed++ ? delim : ""), cpus[t->cpu_id].module_id);
+			else
+				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
 				outp += sprintf(outp, "%s0x%x", (printed++ ? delim : ""), cpus[t->cpu_id].core_id);
@@ -6079,6 +6095,11 @@ int get_l3_id(int cpu)
 	return parse_int_file("/sys/devices/system/cpu/cpu%d/cache/index3/id", cpu);
 }
 
+int get_module_id(int cpu)
+{
+	return parse_int_file("/sys/devices/system/cpu/cpu%d/topology/cluster_id", cpu);
+}
+
 int get_core_id(int cpu)
 {
 	return parse_int_file("/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
@@ -9641,6 +9662,7 @@ void topology_probe(bool startup)
 	 * For online cpus
 	 * find max_core_id, max_package_id, num_cores (per system)
 	 */
+	topo.min_module_id = 0x7FFFFFFF;
 	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		int siblings;
 
@@ -9672,6 +9694,13 @@ void topology_probe(bool startup)
 		if (cpus[i].physical_node_id > topo.max_node_num)
 			topo.max_node_num = cpus[i].physical_node_id;
 
+		/* get module information */
+		cpus[i].module_id = get_module_id(i);
+		if (cpus[i].module_id > topo.max_module_id)
+			topo.max_module_id = cpus[i].module_id;
+		if (cpus[i].module_id < topo.min_module_id)
+			topo.min_module_id = cpus[i].module_id;
+
 		/* get core information */
 		cpus[i].core_id = get_core_id(i);
 		if (cpus[i].core_id > max_core_id)
@@ -9693,6 +9722,11 @@ void topology_probe(bool startup)
 	if (!summary_only)
 		BIC_PRESENT(BIC_Core);
 
+	if (debug > 1)
+		fprintf(outf, "min_module_id %d max_module_id %d\n", topo.min_module_id, topo.max_module_id);
+	if (!summary_only && (topo.min_module_id != topo.max_module_id))
+		BIC_PRESENT(BIC_Module);
+
 	topo.num_die = topo.max_die_id + 1;
 	if (debug > 1)
 		fprintf(outf, "max_die_id %d, sizing for %d die\n", topo.max_die_id, topo.num_die);
@@ -9727,9 +9761,9 @@ void topology_probe(bool startup)
 		if (cpu_is_not_present(i))
 			continue;
 		fprintf(outf,
-			"cpu %d pkg %d die %d l3 %d node %d lnode %d core %d ht_id %d",
+			"cpu %d pkg %d die %d l3 %d node %d lnode %d module 0x%x core %d ht_id %d",
 			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id,
-			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].core_id, cpus[i].ht_id);
+			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].module_id, cpus[i].core_id, cpus[i].ht_id);
 		fprintf(outf, " siblings");
 		for (ht_id = 0; ht_id <= MAX_HT_ID; ++ht_id)
 			fprintf(outf, " %d", cpus[i].ht_sibling_cpu_id[ht_id]);
-- 
2.45.2

