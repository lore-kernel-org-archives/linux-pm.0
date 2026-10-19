Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422174;
	b=be+JXjGAk1BdJOXXdi3W/F/iRA8Boz28utGop5wFkmOPTbJBQMe2BaDCcdcXR0YT64T1
	 AI98K2WITcViY/J/CcY0iAcrhdVGE9JrDYcAZiu6ah4y0OS7mIuGZVLSXgAGXKwOQyvNQ
	 lE1VVCrngu6CCkxblkUNnn9meE4m0+ap9x7QZ4vxb9qarqRENIJtXAIth9+Bj4EPZmKw8
	 G04Smx/q2fwUIFo+/4cKgKoQM7xb5rkxh6RNV40dmld5Yz7apcqa9dPIJHYOiuCoCHwjg
	 gtdZAE6qJHsEfhB6cdhQViTWETxIp1ioGYKGQTnu96mc0JXORar57cakyj0KToEz9mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422174;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=iwuIKTmAD3pioSB5lc+bOGRK4tOhe0UizSU4feWiRDg=;
	b=PMdYD37AHPstSKMpz14W/cAO0BpOu5WLfgZVaEk+fmKf+PPyV7TNn1Py8vsbA3W5DgQp
	 4TT0eSoxF8WLxS1nS2QC5pAuZUTv9GB6LKz98zR2/3eEpRf5j7/w87bnDnTMxdHeb84Hq
	 ptWmQvC0X7fC5qStoUUpm0V8WbARwB0TH86hOkiSAO0B6TUtwabb7atxPo5P3YdUyF6xB
	 ObHZURFNZx/3o94Um4TWo1xuEnJCA0zrj/hzE7UndSd5tAg3lCDRsTNJKc84w72s3iVPj
	 jPdRLH8JZyVDo2xhnCAzdW45PfH9rEfwi1DLFRAiU2qEZERPYXXZLLr2/eA4EQFwMsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOFzXz6S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1B607BF30
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOFzXz6S
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA756513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422174; cv=none; b=f4XGtVIr7/Lw/JmtJHCq8d3iSJ3XYOHonuxIl6pCk6aKAnY4hpSlGgOEL+rFljxsFT8o6qsE6Ab/h4cND3zqNhoU4FvUdxTOlxukDHxlzRaLdrp1oytI7glz/Hs46DVqu4x7t2kYrBx8n2O/p79hm21pGxYTw2FKAMrnbjXS2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422174; c=relaxed/simple;
	bh=3JLnGcwhDfdI0mog4dxz/yGCZWPsA5TrDdRwl8wU9Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CecGCVBxUjhrQSemNGIbpJIfr5zd2XJqZT39A7nAN/htvXPM4hpSMWD12rtdu4D0IzXgAARZf3UmTDJUcilML0ilNrwV0n8eaGM1Fd8yreEuspRRPMz2t6A+FZHxfWSi3gPX6rzf0M4xc+ufDG+rheHxl7ZdTlX3IMnujfNJ+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOFzXz6S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF67F1F000C4;
	Mon, 19 Oct 2026 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422172;
	bh=iwuIKTmAD3pioSB5lc+bOGRK4tOhe0UizSU4feWiRDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=WOFzXz6Syq2D41SFVmUtLyqQ23aSNM58A0jPiH3s6QjY+H+wayyqXfdNQZzQxf6iU
	 2Jdw4cABpKI9mma6/E1K3AEQ6O1YkzJOO1p8t4eUKja/PJ73knDLHQVSjeI/6Q1wGE
	 Uf1P9Lcyd81UbllIRCzPExtgFp280BXEpprOK9vE5NQ1uXVzVe1uKNcf3bLunceIYL
	 LfqVg96QYiI82bB7lo5jzrpMruqpSY6iNZLkxEitGSzi+E6wW7R3LzlBdKxV6wFy34
	 +rmiomSO7Pl8Tz8qoy9IRu4Mnw4KeKI3RNukSH8x30qzo80VUWP4LisaUu2vyHXV+K
	 mhrE35FuuB0uQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/23] tools/power turbostat: Cleanup: Remove hard-coded 8192 CPU limit
Date: Mon, 19 Oct 2026 10:38:37 -0400
Message-ID: <c1165c0db999a201110a2affb05115bc0169ca2b.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

The --cpu cmdline option was parsed before topology_probe()
set max_cpu_num, and so it used a hard-coded CPU limit of 8192.

Probe max_cpu_num earlier and allocate the set for --cpu
using the same size as all other CPU sets, large
enough to hold max possible (but not bigger).

No functional change, unless you count fixing some error paths.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 75 ++++++++++++++++-----------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b4403b4ed2c8..70e272447511 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1407,7 +1407,6 @@ void init_perf_model_support(unsigned int family, unsigned int model)
 int backwards_count;
 char *progname;
 
-#define CPU_SUBSET_MAXCPUS	8192	/* need to use before probe... */
 cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
 cpu_set_t *perf_pcore_set, *perf_ecore_set, *perf_lcore_set;
 size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
@@ -6170,7 +6169,7 @@ int get_physical_node_id(struct cpu_topology *thiscpu)
 
 static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 {
-	unsigned int start, end;
+	int start, end;
 	char *next = cpu_str;
 
 	while (next && *next) {
@@ -6183,7 +6182,7 @@ static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 
 		start = strtoul(next, &next, 10);
 
-		if (start >= CPU_SUBSET_MAXCPUS)
+		if (start > topo.max_cpu_num)
 			return 1;
 		CPU_SET_S(start, cpu_set_size, cpu_set);
 
@@ -6210,7 +6209,7 @@ static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 			return 1;
 
 		while (++start <= end) {
-			if (start >= CPU_SUBSET_MAXCPUS)
+			if (start > topo.max_cpu_num)
 				return 1;
 			CPU_SET_S(start, cpu_set_size, cpu_set);
 		}
@@ -6380,26 +6379,6 @@ void re_initialize(void)
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus, topo.allowed_cpus);
 }
 
-void set_max_cpu_num(void)
-{
-	FILE *filep;
-	int current_cpu;
-	unsigned long dummy;
-	char pathname[64];
-
-	current_cpu = sched_getcpu();
-	if (current_cpu < 0)
-		err(1, "cannot find calling cpu ID");
-	sprintf(pathname, "/sys/devices/system/cpu/cpu%d/topology/thread_siblings", current_cpu);
-
-	filep = fopen_or_die(pathname, "r");
-	topo.max_cpu_num = 0;
-	while (fscanf(filep, "%lx,", &dummy) == 1)
-		topo.max_cpu_num += BITMASK_SIZE;
-	fclose(filep);
-	topo.max_cpu_num--;	/* 0 based */
-}
-
 /*
  * count_cpus()
  * remember the last one seen, it will be the max
@@ -9578,6 +9557,35 @@ int set_thread_siblings(struct cpu_topology *thiscpu)
 	return (ht_id - 1);
 }
 
+/*
+ * get_max_cpu_num(path)
+ * return the last number of the cpu list in this file
+ */
+static int get_max_cpu_num(char *path)
+{
+	FILE *filep;
+	int retval, num;
+	char c;
+
+	filep = fopen(path, "r");
+	if (filep == NULL) {
+		warn("%s", path);
+		return 255;
+	}
+
+	while ((retval = fscanf(filep, "%d%c", &num, &c)) == 2) {
+		if (c == '\n')
+			break;
+		if (c != ',' && c != '-')
+			errx(1, "Bad Format '%s'", path);
+	}
+	if (retval != 2)
+		errx(1, "Bad format '%s'", path);
+
+	fclose(filep);
+	return num;
+}
+
 void topology_probe(bool startup)
 {
 	int i;
@@ -9585,8 +9593,7 @@ void topology_probe(bool startup)
 	int max_package_id = 0;
 	int max_siblings = 0;
 
-	/* Initialize num_cpus, max_cpu_num */
-	set_max_cpu_num();
+	/* Initialize num_cpus */
 	topo.num_cpus = 0;
 	for_all_proc_cpus(count_cpus);
 	if (!summary_only)
@@ -9653,7 +9660,7 @@ void topology_probe(bool startup)
 	 *
 	 * cpu_allowed_set is the intersection of cpu_present_set/cpu_effective_set/cpu_subset.
 	 */
-	for (i = 0; i < CPU_SUBSET_MAXCPUS; ++i) {
+	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		if (cpu_subset && !CPU_ISSET_S(i, cpu_subset_size, cpu_subset))
 			continue;
 
@@ -9661,7 +9668,7 @@ void topology_probe(bool startup)
 			if (cpu_subset) {
 				/* cpus in cpu_subset must be in cpu_present_set during startup */
 				if (startup)
-					err(1, "cpu%d not present", i);
+					errx(1, "cpu%d not present", i);
 				else
 					fprintf(stderr, "cpu%d not present\n", i);
 			}
@@ -9681,7 +9688,7 @@ void topology_probe(bool startup)
 		print_cpu_set("allowed set", cpu_allowed_set);
 
 	if (!CPU_COUNT_S(cpu_allowed_setsize, cpu_allowed_set))
-		err(-ENODEV, "No valid cpus found");
+		errx(-ENODEV, "No valid cpus found");
 	sched_setaffinity(0, cpu_allowed_setsize, cpu_allowed_set);
 
 	/*
@@ -11520,15 +11527,17 @@ void parse_cpu_command(char *optarg)
 	if (show_core_only || show_pkg_only)
 		goto error;
 
-	cpu_subset = CPU_ALLOC(CPU_SUBSET_MAXCPUS);
+	cpu_subset = CPU_ALLOC(topo.max_cpu_num + 1);
 	if (cpu_subset == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_subset_size = CPU_ALLOC_SIZE(CPU_SUBSET_MAXCPUS);
+	cpu_subset_size = CPU_ALLOC_SIZE(topo.max_cpu_num + 1);
 
 	CPU_ZERO_S(cpu_subset_size, cpu_subset);
 
 	if (parse_cpu_str(optarg, cpu_subset, cpu_subset_size))
 		goto error;
+	if (debug)
+		print_cpu_set("cpu subsetset", cpu_subset);
 
 	return;
 
@@ -11740,6 +11749,10 @@ int main(int argc, char **argv)
 	close(fd);
 
 skip_cgroup_setting:
+
+	/* probe max_cpu_num early for use by cmdline() */
+	topo.max_cpu_num = get_max_cpu_num("/sys/devices/system/cpu/possible");
+
 	outf = stderr;
 	cmdline(argc, argv);
 
-- 
2.45.2

