Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422194;
	b=YGoikuZFWS7sc908m39N8ojsojRf3UndZmJJJFs/4kt7VxjYCk+KQDUxH1bTp9LivEeJ
	 wcT6pvotmh75qrIULEXaJHwJwbGxOL8ikZSvtevtjVDXzhpZxQc0AVdhIccHc0HGsKv2b
	 5qenNmCkZzpNoP89fjkadw4zHFnHnFYOmNP4QFtvgw+u6nMIFk122SB3v6PnN0sCXvdKV
	 e8CziNTHFAcVPxZ+8vsLVi8klEPYxkjOF3tbnuPd09T2/8k45cHupwKp+Y7KAddByZht5
	 FW4dh+u59Yvm72n0M5g5Eu7JTDy2YfE8+rhNt1Mjb0yi82uRchFj3sU2nE/ZWwEjbgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422194;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=sLRGknYPa42kdRe4qsC6Ur32o5buaryVLn46V4ZDDwo=;
	b=oJckoP1p+7Ss9oul4BL2yUCoNgzOeqgFZhik9Gi8lvkYVX8EEvP/NfyjMpohr9OEi/Y5
	 out0DWm+CJcJWt+65JqkcaALCMReOc7IDLwuJxI+mDed3eSksJMv3vbkLwqg0bnhAeXPU
	 kAu4/P8UlqchcrdmdOjdIUYVLPhwZJKOwX4Rq90tsf1RFnEjTItj9y2opTeCCJ+e5exEi
	 /IyxFE5P0MKwzY+kLsKe6AZ1kKREtvkpZpaqgEX6HYZYylPVaLjQmNYd7LtoIzcMdPQq2
	 oIg6b8VCGVJ02RJgquUnBcauAsOLUJ/YR3/ng8Zxk4e8n8RZw+31UuxjmqeBSYEmIkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyIC0IcI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C554607D373
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyIC0IcI
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED66513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422194; cv=none; b=ewWozOqkvEAX8ZcnloW59mOu53N35GISIw4aVMQKooPIZHJmjfA0Fj/FJJuhZj5dNQkKAV2IKdMs1ZSD8WJV4BMZbWn8aw3jB54AudJCuV7rmOrCn7iGUFP0sPKmZRacxwl20Y1AreiK7HFhVJY8wq22dqTiIMMbyyj7U7TqA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422194; c=relaxed/simple;
	bh=rXIwi84BqDHaQOhNkA5gx3ZXWj1FwrOISxizSxs0/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9WvsnaQUiO2r5xt4ANaseZxxVfFKrcLW3UTuemH7YaQIeD4vW6TQ2yhl9qPmFqdUl/IDFt7xRJxK2tqby7aRliTah7YW6+JxvL8uhM8f3p219j5ByWkCgXpIGcQtKIKl0b0ZtrqP7kJdtVy94ZLOkKZlt7m2mD8aevUIQuhfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyIC0IcI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD9E1F000C7;
	Mon, 19 Oct 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422192;
	bh=sLRGknYPa42kdRe4qsC6Ur32o5buaryVLn46V4ZDDwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=KyIC0IcI2GTPDvJdwP+5sqwzRbGSgztAv7gaa9Fh1dneB+6hytRmfZbIp77Bjx9CZ
	 C0nRI9PZXy/bqi5/aXudW1Pja1SrXPihiq6b/J3AWQBZ7TkLCMrj3Li9jWpN+N7RIZ
	 U0d6RPpPbbCTTLP+Kq8dqYPQwrN0So42lQUDcVzCeC1AV7wmHrrakFFgt5IygNPB/w
	 gLHJY5sXwiM2W9Vhtwrh+9ePoyyZm4jZi65c+U/+h+CgzH8OsVhBiK0jU41lSkKIYj
	 EMm/o8GjvtiQ67p8HNBfjfLxcj8epnpZQkXiEDp4puzJMwIBwh72HfC8AHZqx9ydFv
	 vcbWxrHz9+07w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/23] tools/power turbostat: Rename cpu_subset to cpuset_cmdline
Date: Mon, 19 Oct 2026 10:38:52 -0400
Message-ID: <258a27c56c602fe1e8351b1e3d727964d2cf9e1a.1792420722.git.len.brown@intel.com>
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

The cpu_set supporting "--cpu" on the cmdline is special.
Unlike all other cpu_sets, it is allocated, re-used,
and never freed.

Add a comment noting this and name it "cpuset_cmdline"
to clarify its use.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 39 +++++++++++++++------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index eb76e337267a..0fce1f3a937f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1424,7 +1424,7 @@ void init_perf_model_support(unsigned int family, unsigned int model)
 int backwards_count;
 char *progname;
 
-cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
+cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpuset_cmdline;
 cpu_set_t *perf_pcore_set, *perf_ecore_set, *perf_lcore_set;
 size_t cpu_setsize;
 #define MAX_ADDED_THREAD_COUNTERS 24
@@ -3382,7 +3382,7 @@ int format_counters(PER_THREAD_PARAMS)
 		return 0;
 
 	/*if not summary line and --cpu is used */
-	if ((t != average.threads) && (cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_setsize, cpu_subset)))
+	if ((t != average.threads) && (cpuset_cmdline && !CPU_ISSET_S(t->cpu_id, cpu_setsize, cpuset_cmdline)))
 		return 0;
 
 	if (DO_BIC(BIC_USEC)) {
@@ -9682,19 +9682,19 @@ void topology_probe(bool startup)
 	/*
 	 * Validate and update cpu_allowed_set.
 	 *
-	 * Make sure all cpus in cpu_subset are also in cpu_present_set during startup.
-	 * Give a warning when cpus in cpu_subset become unavailable at runtime.
+	 * Make sure all cpus in cpuset_cmdline are also in cpu_present_set during startup.
+	 * Give a warning when cpus in cpuset_cmdline become unavailable at runtime.
 	 * Give a warning when cpus are not effective because of cgroup setting.
 	 *
-	 * cpu_allowed_set is the intersection of cpu_present_set/cpu_effective_set/cpu_subset.
+	 * cpu_allowed_set is the intersection of cpu_present_set/cpu_effective_set/cpuset_cmdline.
 	 */
 	for (i = 0; i <= topo.max_cpu_num; ++i) {
-		if (cpu_subset && !CPU_ISSET_S(i, cpu_setsize, cpu_subset))
+		if (cpuset_cmdline && !CPU_ISSET_S(i, cpu_setsize, cpuset_cmdline))
 			continue;
 
 		if (!CPU_ISSET_S(i, cpu_setsize, cpu_present_set)) {
-			if (cpu_subset) {
-				/* cpus in cpu_subset must be in cpu_present_set during startup */
+			if (cpuset_cmdline) {
+				/* cpus in cpuset_cmdline must be in cpu_present_set during startup */
 				if (startup)
 					errx(1, "cpu%d not present", i);
 				else
@@ -11533,18 +11533,18 @@ void probe_cpuidle_counts(void)
 
 /*
  * parse cpuset with following syntax
- * 1,2,4..6,8-10 and set bits in cpu_subset
+ * 1,2,4..6,8-10 and set bits in cpuset_cmdline
  */
 void parse_cpu_command(char *optarg)
 {
 	if (!strcmp(optarg, "core")) {
-		if (cpu_subset)
+		if (cpuset_cmdline)
 			goto error;
 		show_core_only++;
 		return;
 	}
 	if (!strcmp(optarg, "package")) {
-		if (cpu_subset)
+		if (cpuset_cmdline)
 			goto error;
 		show_pkg_only++;
 		return;
@@ -11552,18 +11552,23 @@ void parse_cpu_command(char *optarg)
 	if (show_core_only || show_pkg_only)
 		goto error;
 
-	if (!cpu_subset) {
-		cpu_subset = CPU_ALLOC(topo.max_cpu_num + 1);
-		if (cpu_subset == NULL)
+	/*
+	 * cpuset_cmdline is allocated on the first invocation of --cpu
+	 * It is re-used for subsequent invocations.
+	 * It is never freed.
+	 */
+	if (!cpuset_cmdline) {
+		cpuset_cmdline = CPU_ALLOC(topo.max_cpu_num + 1);
+		if (cpuset_cmdline == NULL)
 			err(3, "CPU_ALLOC");
 
-		CPU_ZERO_S(cpu_setsize, cpu_subset);
+		CPU_ZERO_S(cpu_setsize, cpuset_cmdline);
 	}
 
-	if (parse_cpu_str(optarg, cpu_subset, cpu_setsize))
+	if (parse_cpu_str(optarg, cpuset_cmdline, cpu_setsize))
 		goto error;
 	if (debug)
-		print_cpu_set("--cpu", cpu_subset);
+		print_cpu_set("--cpu", cpuset_cmdline);
 
 	return;
 
-- 
2.45.2

