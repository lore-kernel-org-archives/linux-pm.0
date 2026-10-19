Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422191;
	b=1gU6qlcn6FqRbEMTwDoK7IdtChUIJ/y8q8RZLZRoSC0w67Q7Fb9W/PevJWe4DWiLI4hm
	 Moh7jTktWBxvPRTCop3Tg+D4zqkM14Odw3V9b/hFe4OPu+oX2Z+acoozbC4rPJv7ROEMV
	 XI5swiYGWNr17i7je6ED3lEpW4BkT6wdoBA95ZhgXXnBPkbidiUVKjPM0aeLJ0eyTcVua
	 LPQ7C9TuSK91bfWPVXUpPW9qB2MeZXePkwp8Zs7Xp3UICmbc2yrSUeyxoJL7HKv43OH40
	 rsrZ2J2enPSFZcsp2blHYBPBn+RaY98kpBG4hAfQN2eTQnIsbgj5+n+5jnNvOPsQLCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422191;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=hiO2a8o86HgfWK9hEz5v3Xf3wDk0gIseg3h7JO5mL+c=;
	b=UK8NrbekJfDzT68sKmfwsBYh9WoLClWGKIcTWkbE+lGFiSsfK6fbFL7z2wtO+Jsn22zB
	 ZiPBDZll2NiouBRRQVL4Di3ISplSPE8LW3uptll57tUqkeoZ+V6zgJp027vW+I+vrTeZN
	 j1ULEcG7AOSC/95zWJ1bG4OwKgexd2SQgmn6WhnF0h2Cj8VHkHLGj0MQZWKyJA4GrAdRp
	 /7sqBoU03ScOnqtuDa/5i/2a3GhxbYMFRuohmWQ9Zmy9UpxijeoXIYrimOCxQ2nr8KOgJ
	 lUYi+S6oiFOWylkYdvzu0ipNN1p+KbGuX3OrWXmgwqTFZtt8oFDPhUT7Q78N95Eep5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKoXbKGs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87DC607D36C
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKoXbKGs
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA56513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422191; cv=none; b=nOlePOQkdjcDTRyldR3ARbaVnxhe1QFzLaL6ALlryhEicsSTSTZEk3vGlDnI87Uhc3QqwZ3DaBgIN0t35x0Z/lM0FfbQsG8OgfM9L+aiJTQIo23QoqHdbpTzTtBU96tDjtt7o45Ylz9ZsNkpfx5mf8W5Vye5SgSZHi3/ugNfucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422191; c=relaxed/simple;
	bh=ehMQkQW+1mUmajjfpUlT2q4AfjyIU+1AEVJpWEIW6Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVpl1MQrz7ZqRUHmRhXVsUmWw00m5R7bjGoS21f3kL0Nld17T7p4Rl4VeedO28MhnYnvDT1k3212VRz8CZDfKaRJ3LOFyxb/FSz6+39Zd4RzLxlE7ypyZLrhBx/3TUkjuSmwBoR9SmDB/pqvnXp7C8oo/S6QABWgN5sCev1jWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKoXbKGs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4698E1F000C6;
	Mon, 19 Oct 2026 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422190;
	bh=hiO2a8o86HgfWK9hEz5v3Xf3wDk0gIseg3h7JO5mL+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=OKoXbKGsIMbN5i+HzrbYB8wRoHrpXeS0UXwdzCd3xsSakwPAxGkNJBWofuul83PwZ
	 eT+SAjKKemP9MK8qF25jbS+NM+KENIV8sgTWcwintB21iw76H0oB7iQpSD1JAv7IiR
	 jo2NJV2NyjSkSE5lDdPxbKLPjG8YjeXEyrKBXqskrH04lHtWnvPi3209oqan9yENiX
	 26jX7TZwT0fNsYruzMETZECjNzsyyDLdVa4O+TbyJbQMYA2xRqft54ZXySjmyb0q3z
	 59oWcPNLMGjchxT5OlHAl1+/FBHKJvvZ1O+UR+ZDKQ5TVRBRBgh9gluyVX4ziqKZXY
	 xi//dMC1X/2Lw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/23] tools/power turbostat: Cleanup: Use one cpu_setsize for all purposes
Date: Mon, 19 Oct 2026 10:38:50 -0400
Message-ID: <9a0d60f21e782a9d706e46a6c64ea3e4c80352fa.1792420722.git.len.brown@intel.com>
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

Use a single cpu_setsize to describe every cpu_set_t.
Size it based on the maximum possible cpu number.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 77 ++++++++++++---------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 591c3497efa3..3dd312931d1a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1426,7 +1426,7 @@ char *progname;
 
 cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
 cpu_set_t *perf_pcore_set, *perf_ecore_set, *perf_lcore_set;
-size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
+size_t cpu_setsize;
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define MAX_ADDED_CORE_COUNTERS 8
 #define MAX_ADDED_PACKAGE_COUNTERS 16
@@ -2459,7 +2459,7 @@ int cpu_is_not_present(int cpu)
 	if (cpu < 0)
 		return 1;
 
-	return !CPU_ISSET_S(cpu, cpu_present_setsize, cpu_present_set);
+	return !CPU_ISSET_S(cpu, cpu_setsize, cpu_present_set);
 }
 
 int cpu_is_not_allowed(int cpu)
@@ -2467,7 +2467,7 @@ int cpu_is_not_allowed(int cpu)
 	if (cpu < 0)
 		return 1;
 
-	return !CPU_ISSET_S(cpu, cpu_allowed_setsize, cpu_allowed_set);
+	return !CPU_ISSET_S(cpu, cpu_setsize, cpu_allowed_set);
 }
 
 #define GLOBAL_CORE_ID(core_id, pkg_id)	(core_id + pkg_id * (topo.max_core_id + 1))
@@ -2560,9 +2560,9 @@ int is_cpu_first_thread_in_package(struct thread_data *t, struct core_data *c, s
 
 int cpu_migrate(int cpu)
 {
-	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
-	CPU_SET_S(cpu, cpu_affinity_setsize, cpu_affinity_set);
-	if (sched_setaffinity(0, cpu_affinity_setsize, cpu_affinity_set) == -1)
+	CPU_ZERO_S(cpu_setsize, cpu_affinity_set);
+	CPU_SET_S(cpu, cpu_setsize, cpu_affinity_set);
+	if (sched_setaffinity(0, cpu_setsize, cpu_affinity_set) == -1)
 		return -1;
 	else
 		return 0;
@@ -3382,7 +3382,7 @@ int format_counters(PER_THREAD_PARAMS)
 		return 0;
 
 	/*if not summary line and --cpu is used */
-	if ((t != average.threads) && (cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_subset_size, cpu_subset)))
+	if ((t != average.threads) && (cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_setsize, cpu_subset)))
 		return 0;
 
 	if (DO_BIC(BIC_USEC)) {
@@ -5976,19 +5976,15 @@ void free_all_buffers(void)
 
 	CPU_FREE(cpu_present_set);
 	cpu_present_set = NULL;
-	cpu_present_setsize = 0;
 
 	CPU_FREE(cpu_effective_set);
 	cpu_effective_set = NULL;
-	cpu_effective_setsize = 0;
 
 	CPU_FREE(cpu_allowed_set);
 	cpu_allowed_set = NULL;
-	cpu_allowed_setsize = 0;
 
 	CPU_FREE(cpu_affinity_set);
 	cpu_affinity_set = NULL;
-	cpu_affinity_setsize = 0;
 
 	if (perf_pcore_set) {
 		CPU_FREE(perf_pcore_set);
@@ -6345,7 +6341,7 @@ static void update_effective_set(bool startup)
 {
 	update_effective_str(startup);
 
-	if (parse_cpu_str(cpu_effective_str, cpu_effective_set, cpu_effective_setsize))
+	if (parse_cpu_str(cpu_effective_str, cpu_effective_set, cpu_setsize))
 		err(1, "%s: cpu str malformat %s", PATH_EFFECTIVE_CPUS, cpu_effective_str);
 }
 
@@ -6387,7 +6383,7 @@ int count_cpus(int cpu)
 
 int mark_cpu_present(int cpu)
 {
-	CPU_SET_S(cpu, cpu_present_setsize, cpu_present_set);
+	CPU_SET_S(cpu, cpu_setsize, cpu_present_set);
 	return 0;
 }
 
@@ -8518,7 +8514,7 @@ int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, const char *sysfs_path,
 		warn("read %s", sysfs_path);
 		goto out;
 	}
-	if (parse_cpu_str(cpuset_buf, cpu_set, cpu_possible_setsize)) {
+	if (parse_cpu_str(cpuset_buf, cpu_set, cpu_setsize)) {
 		warnx("%s: cpu str malformat %s\n", sysfs_path, cpuset_buf);
 		goto out;
 	}
@@ -8555,7 +8551,7 @@ void linux_perf_init_hybrid_cpus(void)
 		perf_pcore_set = CPU_ALLOC((topo.max_cpu_num + 1));
 		if (perf_pcore_set == NULL)
 			err(3, "CPU_ALLOC");
-		CPU_ZERO_S(cpu_possible_setsize, perf_pcore_set);
+		CPU_ZERO_S(cpu_setsize, perf_pcore_set);
 		initialize_cpu_set_from_sysfs(perf_pcore_set, perf_cpu_pcore_path, "cpus");
 		if (debug)
 			print_cpu_set("perf pcores", perf_pcore_set);
@@ -8567,7 +8563,7 @@ void linux_perf_init_hybrid_cpus(void)
 		perf_ecore_set = CPU_ALLOC((topo.max_cpu_num + 1));
 		if (perf_ecore_set == NULL)
 			err(3, "CPU_ALLOC");
-		CPU_ZERO_S(cpu_possible_setsize, perf_ecore_set);
+		CPU_ZERO_S(cpu_setsize, perf_ecore_set);
 		initialize_cpu_set_from_sysfs(perf_ecore_set, perf_cpu_ecore_path, "cpus");
 		if (debug)
 			print_cpu_set("perf ecores", perf_ecore_set);
@@ -8579,7 +8575,7 @@ void linux_perf_init_hybrid_cpus(void)
 		perf_lcore_set = CPU_ALLOC((topo.max_cpu_num + 1));
 		if (perf_lcore_set == NULL)
 			err(3, "CPU_ALLOC");
-		CPU_ZERO_S(cpu_possible_setsize, perf_lcore_set);
+		CPU_ZERO_S(cpu_setsize, perf_lcore_set);
 		initialize_cpu_set_from_sysfs(perf_lcore_set, perf_cpu_lcore_path, "cpus");
 		if (debug)
 			print_cpu_set("perf lcores", perf_lcore_set);
@@ -9502,7 +9498,7 @@ void perf_l2_init(void)
 			}
 			continue;
 		}
-		if (perf_pcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_pcore_set)) {
+		if (perf_pcore_set && CPU_ISSET_S(cpu, cpu_setsize, perf_pcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.pcore, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
 				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
@@ -9515,7 +9511,7 @@ void perf_l2_init(void)
 				free_fd_l2_percpu();
 				return;
 			}
-		} else if (perf_ecore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_ecore_set)) {
+		} else if (perf_ecore_set && CPU_ISSET_S(cpu, cpu_setsize, perf_ecore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.ecore, perf_model_support->second.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
 				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.ecore, perf_model_support->second.refs);
@@ -9528,7 +9524,7 @@ void perf_l2_init(void)
 				free_fd_l2_percpu();
 				return;
 			}
-		} else if (perf_lcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_lcore_set)) {
+		} else if (perf_lcore_set && CPU_ISSET_S(cpu, cpu_setsize, perf_lcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.lcore, perf_model_support->third.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
 				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.lcore, perf_model_support->third.refs);
@@ -9648,8 +9644,7 @@ void topology_probe(bool startup)
 	cpu_present_set = CPU_ALLOC((topo.max_cpu_num + 1));
 	if (cpu_present_set == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_present_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(cpu_present_setsize, cpu_present_set);
+	CPU_ZERO_S(cpu_setsize, cpu_present_set);
 	for_all_proc_cpus(mark_cpu_present);
 	if (debug)
 		print_cpu_set("present set", cpu_present_set);
@@ -9660,8 +9655,7 @@ void topology_probe(bool startup)
 	cpu_possible_set = CPU_ALLOC((topo.max_cpu_num + 1));
 	if (cpu_possible_set == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_possible_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(cpu_possible_setsize, cpu_possible_set);
+	CPU_ZERO_S(cpu_setsize, cpu_possible_set);
 	initialize_cpu_set_from_sysfs(cpu_possible_set, "/sys/devices/system/cpu", "possible");
 	if (debug)
 		print_cpu_set("possible set", cpu_possible_set);
@@ -9672,8 +9666,7 @@ void topology_probe(bool startup)
 	cpu_effective_set = CPU_ALLOC((topo.max_cpu_num + 1));
 	if (cpu_effective_set == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_effective_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(cpu_effective_setsize, cpu_effective_set);
+	CPU_ZERO_S(cpu_setsize, cpu_effective_set);
 	update_effective_set(startup);
 	if (debug)
 		print_cpu_set("effective set", cpu_effective_set);
@@ -9684,8 +9677,7 @@ void topology_probe(bool startup)
 	cpu_allowed_set = CPU_ALLOC((topo.max_cpu_num + 1));
 	if (cpu_allowed_set == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_allowed_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(cpu_allowed_setsize, cpu_allowed_set);
+	CPU_ZERO_S(cpu_setsize, cpu_allowed_set);
 
 	/*
 	 * Validate and update cpu_allowed_set.
@@ -9697,10 +9689,10 @@ void topology_probe(bool startup)
 	 * cpu_allowed_set is the intersection of cpu_present_set/cpu_effective_set/cpu_subset.
 	 */
 	for (i = 0; i <= topo.max_cpu_num; ++i) {
-		if (cpu_subset && !CPU_ISSET_S(i, cpu_subset_size, cpu_subset))
+		if (cpu_subset && !CPU_ISSET_S(i, cpu_setsize, cpu_subset))
 			continue;
 
-		if (!CPU_ISSET_S(i, cpu_present_setsize, cpu_present_set)) {
+		if (!CPU_ISSET_S(i, cpu_setsize, cpu_present_set)) {
 			if (cpu_subset) {
 				/* cpus in cpu_subset must be in cpu_present_set during startup */
 				if (startup)
@@ -9711,21 +9703,21 @@ void topology_probe(bool startup)
 			continue;
 		}
 
-		if (CPU_COUNT_S(cpu_effective_setsize, cpu_effective_set)) {
-			if (!CPU_ISSET_S(i, cpu_effective_setsize, cpu_effective_set)) {
+		if (CPU_COUNT_S(cpu_setsize, cpu_effective_set)) {
+			if (!CPU_ISSET_S(i, cpu_setsize, cpu_effective_set)) {
 				fprintf(stderr, "cpu%d not effective\n", i);
 				continue;
 			}
 		}
 
-		CPU_SET_S(i, cpu_allowed_setsize, cpu_allowed_set);
+		CPU_SET_S(i, cpu_setsize, cpu_allowed_set);
 	}
 	if (debug)
 		print_cpu_set("allowed set", cpu_allowed_set);
 
-	if (!CPU_COUNT_S(cpu_allowed_setsize, cpu_allowed_set))
+	if (!CPU_COUNT_S(cpu_setsize, cpu_allowed_set))
 		errx(-ENODEV, "No valid cpus found");
-	sched_setaffinity(0, cpu_allowed_setsize, cpu_allowed_set);
+	sched_setaffinity(0, cpu_setsize, cpu_allowed_set);
 
 	/*
 	 * Allocate and initialize cpu_affinity_set
@@ -9733,8 +9725,7 @@ void topology_probe(bool startup)
 	cpu_affinity_set = CPU_ALLOC((topo.max_cpu_num + 1));
 	if (cpu_affinity_set == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_affinity_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
+	CPU_ZERO_S(cpu_setsize, cpu_affinity_set);
 
 	for_all_proc_cpus(clear_ht_id);
 
@@ -10629,11 +10620,11 @@ void turbostat_init()
 void affinitize_child(void)
 {
 	/* Prefer cpu_possible_set, if available */
-	if (sched_setaffinity(0, cpu_possible_setsize, cpu_possible_set)) {
+	if (sched_setaffinity(0, cpu_setsize, cpu_possible_set)) {
 		warn("sched_setaffinity cpu_possible_set");
 
 		/* Otherwise, allow child to run on same cpu set as turbostat */
-		if (sched_setaffinity(0, cpu_allowed_setsize, cpu_allowed_set))
+		if (sched_setaffinity(0, cpu_setsize, cpu_allowed_set))
 			warn("sched_setaffinity cpu_allowed_set");
 	}
 }
@@ -11564,11 +11555,10 @@ void parse_cpu_command(char *optarg)
 	cpu_subset = CPU_ALLOC(topo.max_cpu_num + 1);
 	if (cpu_subset == NULL)
 		err(3, "CPU_ALLOC");
-	cpu_subset_size = CPU_ALLOC_SIZE(topo.max_cpu_num + 1);
 
-	CPU_ZERO_S(cpu_subset_size, cpu_subset);
+	CPU_ZERO_S(cpu_setsize, cpu_subset);
 
-	if (parse_cpu_str(optarg, cpu_subset, cpu_subset_size))
+	if (parse_cpu_str(optarg, cpu_subset, cpu_setsize))
 		goto error;
 	if (debug)
 		print_cpu_set("cpu subsetset", cpu_subset);
@@ -11784,8 +11774,9 @@ int main(int argc, char **argv)
 
 skip_cgroup_setting:
 
-	/* probe max_cpu_num early for use by cmdline() */
+	/* probe max_cpu_num and set cpu_setsize early for use by cmdline() */
 	topo.max_cpu_num = get_max_cpu_num("/sys/devices/system/cpu/possible");
+	cpu_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
 
 	outf = stderr;
 	cmdline(argc, argv);
-- 
2.45.2

