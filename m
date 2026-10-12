Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E94D2EE6
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830113; cv=none; b=cOF3DigQ+KUvmBqvh+lJJLYeojE4vGssbZDQvvLJ1lV5CusV5oF7/Efkvdrit1mrPX7/JOHs9pUbW+GzcDhzFYMnItoSvu1RwwquJZIF4weZWAdvgGJaqyD/HpHg5l2aPIOK0pfRGjLIqNTaPqXzLQE3ilpqCz3Es5QbLWw/w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830113; c=relaxed/simple;
	bh=BNQI2MZxNE5fBjXDeFNDZKEreAMnUJDV/4xe28Lizok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlUqOXzRkegipxiudkP9nrtGNaDhMLufX47fzAtqq2E1DmdfilEAXWVIyT5ulww6zssO1Xeu5FKxjyC+8I4g8P+E0ej9mOJw1nmSEjJasIfPloyqN0Sjeyjzq+A5nluWGfFPm+vYRTCi81vXuBBLZ/MdP5tSKT6GaBFzuegRRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiYTjQ1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiYTjQ1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5EA1F008A1;
	Mon, 12 Oct 2026 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830112;
	bh=Vj0h9YYfkkQoMrFeM0zCmRFGHVt8cZZ30AaH4xL3lns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=SiYTjQ1qBQ9I5TzMaVCJIe7KNtut2TYcxEV31cq7XD13Rbs9sVTlVY0tbNgPU94FZ
	 yBL3aMWneolMsal1QkQjI7fZ1ftst+ltFr3E+skuquA5EnDmo/z2nuni6OL1SJiPaW
	 umBLMkY3WkqSzlXxAPkW5wncKu11zR17LiZ8r5XelfDdpRwDAkOu4X7XV7wg5upGuO
	 FnVkfqL6rVYT7FY7mPe43NXOUaap7Gki8LKiIipWF951OZoO87JXefKp+WDk6e6g6+
	 5otWpA2tmdKPtKD2ilwstseP8S3rIKhnW3JjKCf3SHFAk8GN6Yh+0GLmDObOnqlpxc
	 TE7OqUz9LPjqg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 3/9] tools/power turbostat: add NULL check after calloc()
Date: Mon, 12 Oct 2026 14:32:28 -0400
Message-ID: <148aefa949b1da358c0ebd89e61b3efd48782b82.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
References: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: longlong yan <yanlonglong@kylinos.cn>

Three calloc() calls in turbostat lack NULL return checks, leading to
potential NULL pointer dereferences on allocation failure:

1. rapl_perf_init(): the allocated `domain_visited` is used later via
   memset(domain_visited, 0, ...) without checking for NULL.

2. added_perf_counters_init_(): the allocated `domain_visited` is used
   later via memset() and domain_visited[next_domain] without checking
   for NULL.

3. pmt_add_counter(): the allocated `pcounter` is dereferenced
   immediately via strncpy(pcounter->name, ...) without checking for
   NULL.

Add NULL checks after each calloc(), using the same error handling
style already present in each function: err(-1, ...) for rapl_perf_init(),
errx(1, ...) for added_perf_counters_init_(), and return 1 for
pmt_add_counter().

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0c55698d6843..808f079c874c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8661,6 +8661,8 @@ void rapl_perf_init(void)
 {
 	const unsigned int num_domains = get_rapl_num_domains();
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
+	if (!domain_visited)
+		err(-1, "calloc domain_visited");
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
 	if (rapl_counter_info_perdomain == NULL)
@@ -10007,6 +10009,8 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 	const size_t max_num_domains = MAX(topo.max_cpu_num + 1, MAX(topo.max_core_id + 1, topo.max_package_id + 1));
 
 	domain_visited = calloc(max_num_domains, sizeof(*domain_visited));
+	if (!domain_visited)
+		errx(1, "%s: alloc %s", __func__, "domain_visited");
 
 	while (pinfo) {
 		switch (pinfo->scope) {
@@ -10398,6 +10402,8 @@ int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum
 	pcounter = pmt_find_counter(*pmt_root, name);
 	if (!pcounter) {
 		pcounter = calloc(1, sizeof(*pcounter));
+		if (!pcounter)
+			return 1;
 		new_counter = true;
 	}
 
-- 
2.45.2

