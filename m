Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422178;
	b=GAI3w5I5mGZEWYbJpWKuAu32TYxcwI+W4hEfXvXhEGavrOWPESF9fHOf3zokT+2isug6
	 T9OnddZAsrBaZMoavx0195+HAg/xoymXtq1UThf41FrDClRoaFdVRTRdSHJupAAGjE77f
	 GGMoMkkXir4Fb7BWXDiYE7obnczAXx3bxN10FFwa1BN+LbrWbZq/HoakF1fCdqhIxhM2D
	 DmfHucxBgldMgFZN0qoXlZVgoMda61qgwsQxc5cR2f++YPJjIqN9QzbXuZVm2Y4WtLlJu
	 bwcfBT1uD1aGTT0KAYOWEqY5etim4CFnRyrxCVX49TF0OUEUsEsFdAt8dMl4moJrLdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422178;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=kaAWzgqgRpJv4pLqerSbs7GYoDhkteUkcgVObNViUVE=;
	b=FRuDclSrEFJKOFEk17BqvG/pi+T+qqb0xEMiZik64201TU2jg/LFtxwAwdyprmh9B0Ox
	 APEGydVvqOsOPWf8LtA/QdPWPLKloQmgWZ5yRAP6REmcaqm9uSLuGDemY466xpS/Q686R
	 UfvjD7YGRIVy7yu2lw6nC2g8pD21g7x2ZkssucklQfai6iYNEFf2UpkHRgkDUrXOTegQ1
	 7RzXqLMFARKkjIVb/t8L1Hp9PjR184FgGT+6eJI/WTPrpWeiiyk5XgjlsZ4PnWTOWF1AU
	 3NDkACRscg5uzdg6wsjwJt0GxTDOzdJ40YLQyKxl/S7MkFNnFFnO+mbgZTvWOhlmswQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBtcoJ9d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D559607BF3B
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBtcoJ9d
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8866513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422178; cv=none; b=rKmB9bhG/8rQ4dk/Vpsfwsv5WqkOmvapP1bHRLiNcQ1S8gpUkTht61xyaPszaLq9syaj5rx94Zx5gEPKcwfdpGewnzu1gNfmDN+hzyHbO1oT7Tz1cqpbmwfzCcAZ5jB+043AdWKfMSB6LufVM2lqp/L+urfNwukSZzlvs7QaguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422178; c=relaxed/simple;
	bh=+jB8UTUxSwiTrThg22xLsEeP7DU7IuxwymkAyabnfEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSj5FEoMxaWiBxhIy83jxzWTE5YTBvRKipJ7atzESbfu4wgu6yFKvejjP/PYLeEZZeYyaPwE8JhLW/N5UT6i5VeF/gdFNsAIlc+s/rx72b1b+vWTxDJorn59eAZ5cISrXsW+DX2rSExolKqIvJfLz1I+bfn8UYc4XCBzGAkAumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBtcoJ9d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6211F000C4;
	Mon, 19 Oct 2026 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422177;
	bh=kaAWzgqgRpJv4pLqerSbs7GYoDhkteUkcgVObNViUVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=UBtcoJ9dTx5nl6Yhcp8UMS0GRgFsJ+cOFVUdveNbqrcnxyWTdOyFomRft1g64dxvd
	 b9LtnUIxvszbZ4tEAoouzuiwG21cJk/I6mUzko4+t181KSMUTd40ZT1KC1lZhKIuUB
	 CtvKatiL0qh69oj686cnsfIToLp+wc+EXziGZh+1ud+W8m8mk+EuvPia8CDoVxLUY1
	 fB2tZl4GKk3wrm/32gZqYYnAOK1LtrLYxpCwwmCf5Dq03nmt2IFyTTuSRm10ZJ5C+l
	 XxLi6tAiGkVWV6Vlx4Pp1DZGZ+RqPihZFoUkDQ0NB/+j4dsFIw9ctwABLs15cYQC7N
	 DgTfgTjvW2yxA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/23] tools/power turbostat: Cleanup: Unify comparisons to max_cpu_num
Date: Mon, 19 Oct 2026 10:38:40 -0400
Message-ID: <b1dc956189b1974e59ea08199657eb48e23f2806.1792420722.git.len.brown@intel.com>
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

Unify the syntax of loops over all CPUs for consistency,
since we just fixed two off-by-one bugs.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7b872bb82172..ac28a9953bf1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5834,7 +5834,7 @@ void free_fd_percpu(void)
 	if (!fd_percpu)
 		return;
 
-	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
+	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		if (fd_percpu[i] != 0)
 			close(fd_percpu[i]);
 	}
@@ -5848,7 +5848,7 @@ void free_fd_instr_count_percpu(void)
 	if (!fd_instr_count_percpu)
 		return;
 
-	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+	for (int i = 0; i <= topo.max_cpu_num; ++i) {
 		if (fd_instr_count_percpu[i] != 0)
 			close(fd_instr_count_percpu[i]);
 	}
@@ -5862,7 +5862,7 @@ void free_fd_llc_percpu(void)
 	if (!fd_llc_percpu)
 		return;
 
-	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+	for (int i = 0; i <= topo.max_cpu_num; ++i) {
 		if (fd_llc_percpu[i] != 0)
 			close(fd_llc_percpu[i]);
 	}
@@ -5879,7 +5879,7 @@ void free_fd_l2_percpu(void)
 	if (!fd_l2_percpu)
 		return;
 
-	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+	for (int i = 0; i <= topo.max_cpu_num; ++i) {
 		if (fd_l2_percpu[i] != 0)
 			close(fd_l2_percpu[i]);
 	}
@@ -8722,7 +8722,7 @@ void rapl_perf_init(void)
 
 		memset(domain_visited, 0, num_domains * sizeof(*domain_visited));
 
-		for (int cpu = 0; cpu < topo.max_cpu_num + 1; ++cpu) {
+		for (int cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
 
 			if (cpu_is_not_allowed(cpu))
 				continue;
@@ -9843,7 +9843,7 @@ void allocate_counters(struct counters *counters)
 	if (counters->threads == NULL)
 		goto error;
 
-	for (i = 0; i < topo.max_cpu_num + 1; i++)
+	for (i = 0; i <= topo.max_cpu_num; i++)
 		(counters->threads)[i].cpu_id = -1;
 
 	counters->cores = calloc(num_cores, sizeof(struct core_data));
@@ -9972,7 +9972,7 @@ void set_master_cpu(void)
 {
 	int i;
 
-	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
+	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		if (cpu_is_not_allowed(i))
 			continue;
 		master_cpu = i;
@@ -10091,7 +10091,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 
 		memset(domain_visited, 0, max_num_domains * sizeof(*domain_visited));
 
-		for (int cpu = 0; cpu < topo.max_cpu_num + 1; ++cpu) {
+		for (int cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
 
 			next_domain = cpu_to_domain(pinfo, cpu);
 
-- 
2.45.2

