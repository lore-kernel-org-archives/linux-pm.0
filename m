Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422179;
	b=l1mpNcYyY76yIGHxxxRRrbSDPI8llJD2F1xYyrfwBQarj5Y1wnmAE+x9wG7sCTkOiE1H
	 IGIrJkDZzxsMnqwPR6p7c2xezWUXUBxCLQrkfv1CJyRkVb3d7RuH5N1Z9xgzW5vUSAoMC
	 r3DDwh1elwW4UOe9Y9xEUKuqJwa4SOiQeedPl2SBliGlxVdwX6U9KW93KqWyu++Kf3kYS
	 i4j1oUPiVzXtEc9Bg8Wt8LHlJOD8d2YQxdW+ghahNHDKU6b7iEcUTt13W+NvGZFXcjMOg
	 iOCQF2VdWIVgyUa0Dgk/lF0nBXJ+cIX6oefHpXp2eaByMg0cWSX72m32PNQ0zAe0Klw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422179;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=qepqLpVGy9GvXiaMu/5RydQZUlQeGkbpR6u+DTc4YiY=;
	b=tQPEaVh9dxB3hATf0y6kAVwmh/6koIVWtanYBFkj2xyhtXzUv9hspOqfx0st8T+3mTKJ
	 1UHt+/Rae00x4NypVYp+CIa8BQBcG6OuuLuxZyyYvDQs6QDLqJkcnmDBI54K8fywnlep5
	 v5tN106Ug4H2x7NBMTD4Tg6NxgdB/Bjru/SV7VBjRX8I9rkt2DfJ5zxu5BYXykmVBZCwE
	 aGZPfQhMHr/LJC8CRh1AzLZvSDZsql75Rp/pTKwac45Huf8HDtpoJwAqGCkeSw8pfMC4c
	 A/GsZYNPQ7aJxpomwx9GF7vtvLZ2Yvy6qVxwKT/fcEFB2GJKy2mPZgp26dAXWmDfl2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3ibmiRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B420607BF39
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3ibmiRz
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2FB6513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422179; cv=none; b=fLgPjnSmQy1du0/jLNPFnevuEp9uQBlY0z+AnQh3zyUL1pL6AhwOJr6ovk+K1nJxNLaP2d8kbpqBj/RIX2BrzsxxBUN8JKiLg4LUsGbubj95g4QCTZf9sMrU/zT6cjISqRIYCTm3s2Ot/CLype4Emfnze9THS+AtHwV7oSbmU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422179; c=relaxed/simple;
	bh=LdkxKnFAfGfh1CLO8ywdO75m7o5jjrA9AcZXclTqPcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMq7EqoKsnDD7zPeITPVhhphzJAiRadJ6ux+Pl4fgqznOvK/cWRIukWX2czG/5VECUtZ2RbGYGrCEkOR5xR6MV+G+C8tGvrigAqiOPQkQbEY5azyA3q27cUUvXMsLpTT1Aso0XlzN0p+DMoU34Ckgzl9FjG0SbzpRoZuKG5OcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ibmiRz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964031F000C6;
	Mon, 19 Oct 2026 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422178;
	bh=qepqLpVGy9GvXiaMu/5RydQZUlQeGkbpR6u+DTc4YiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=M3ibmiRzB+aJAdmdrK5FQ4b3NcaUqH2XHiAZALoG37v8FqA2m3NIh+fBkeMGC6hOh
	 HuOuX0gW9ADYwn3bjM0QBP1pGrPfrvhEnxsK0PgWajKhqDQa5e55BducbkXUKgqx6s
	 2QfGBdUEb3jng0d0KzYrHgR6rpbVLfd+bPvUhaU663s6DCXNMnPvFYfl1Klhghxfb6
	 anS5U7asLsM5nblehhWtFOBN0vRXORLHhXsdVbaZBzQHDiP/PxF5w+A/2aAJneB9Jn
	 qHuIOeHhzVkWAVbsACT2GZWzrz6SfDDdSn4wezNufVU+5nJWC6tAsKCZM7hkGOlmLu
	 rVGBY+yY1dzeQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/23] tools/power turbostat: Cleanup counter sets debug code
Date: Mon, 19 Oct 2026 10:38:41 -0400
Message-ID: <6389a3ed1abdc00b00e3f79e3722d99ed119fab5.1792420722.git.len.brown@intel.com>
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

When the debug "--Dump" option is used to dump counter values,
also dump the counter sets.  Update that counter counter-set
debug code to pass code review.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 33 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ac28a9953bf1..c63aa2ec7426 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -98,6 +98,8 @@
 
 #define ROUND_UP_TO_PAGE_SIZE(n) (((n) + 0x1000UL-1UL) & ~(0x1000UL-1UL))
 
+FILE *outf;
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
@@ -292,20 +294,23 @@ enum bic_names {
 
 typedef cpu_set_t bic_set_t;	/* implement bic_set_t using cpu_set_t */
 
-void print_bic_set(char *s, bic_set_t *set)
+/*
+ * debug helper
+ */
+static void print_bic_set(const char *s, const bic_set_t *set)
 {
 	int i;
 
 	assert(MAX_BIC < CPU_SETSIZE);
 
-	printf("%s:", s);
+	fprintf(outf, "%s:", s);
 
 	for (i = 0; i < MAX_BIC; ++i) {
 
 		if (CPU_ISSET(i, set))
-			printf(" %s", bic[i].name);
+			fprintf(outf, " %s", bic[i].name);
 	}
-	putchar('\n');
+	fputc('\n', outf);
 }
 
 static bic_set_t bic_group_topology;
@@ -320,6 +325,21 @@ static bic_set_t bic_group_disabled_by_default;
 static bic_set_t bic_enabled;
 static bic_set_t bic_present;
 
+static void dump_bic_sets(void)
+{
+	print_bic_set("bic_enabled", &bic_enabled);
+	print_bic_set("bic_present", &bic_present);
+	print_bic_set("bic_group_topology", &bic_group_topology);
+	print_bic_set("bic_group_thermal_pwr", &bic_group_thermal_pwr);
+	print_bic_set("bic_group_frequency", &bic_group_frequency);
+	print_bic_set("bic_group_hw_idle", &bic_group_hw_idle);
+	print_bic_set("bic_group_sw_idle", &bic_group_sw_idle);
+	print_bic_set("bic_group_idle", &bic_group_idle);
+	print_bic_set("bic_group_cache", &bic_group_cache);
+	print_bic_set("bic_group_other", &bic_group_other);
+	print_bic_set("bic_group_disabled_by_default", &bic_group_disabled_by_default);
+}
+
 /* modify */
 #define BIC_INIT(set) CPU_ZERO(set)
 
@@ -485,7 +505,6 @@ static void bic_groups_init(void)
 #define PCLUNL 15		/* Unlimited */
 
 char *proc_stat = "/proc/stat";
-FILE *outf;
 int *fd_percpu;
 int *fd_instr_count_percpu;
 int *fd_llc_percpu;
@@ -11772,8 +11791,10 @@ int main(int argc, char **argv)
 		msr_sum_record();
 
 	/* dump counters and exit */
-	if (dump_only)
+	if (dump_only) {
+		dump_bic_sets();
 		return get_and_dump_counters();
+	}
 
 	/* list header and exit */
 	if (list_header_only) {
-- 
2.45.2

