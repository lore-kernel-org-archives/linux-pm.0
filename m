Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135F2D1907;
	Wed,  2 Sep 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332388; cv=none; b=LEU8EuIm3ZOdkM+YtyOYef2TWbyK8+QKb8NkGT4x32ESrtifgRZ6Ms0KwAV1nPjjx9mgZxFNlJYe3P/yBqClb5FZDFLbfv5Ao3c53MTZ8/4rnCY8hJe9B2DIv/0+y9cbTRSAsVr/t5UwRgdnNCoayUFK0+OiMSlrTBux40+WgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332388; c=relaxed/simple;
	bh=bqWADgekKXXR70Fmdpbf4vfMd+A9yQCXyeXWcNH/dOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bek4vhlOmI4W2jXKCvdO88FKHd51ReAAutVVUy4wExC0CAB/db5GTuUGjYUKUzyHj5zt6T7IxyLWow4JoU97FtZ1Ap7geCNQR9TmdoRAnYps70sxA95y7+JkaU8hO9mjzdwF5XB0yO+gT1oLq8/KgB5bAxrUykwn42hLYdVvd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dcccb066a69b11f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7c78418b-b980-4756-896a-9a08998a0e2a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a27810cb80e1289447633c93d48b3059,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dcccb066a69b11f19a56ed5b684f684d-20260902
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 791158317; Wed, 02 Sep 2026 14:59:37 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] tools/power/x86/turbostat: add NULL check after calloc()
Date: Wed,  2 Sep 2026 14:59:22 +0800
Message-ID: <20260902065922.1408-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 tools/power/x86/turbostat/turbostat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4ad7cb1df5c5..926dd1422fbe 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8578,6 +8578,8 @@ void rapl_perf_init(void)
 {
 	const unsigned int num_domains = get_rapl_num_domains();
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
+	if (!domain_visited)
+		err(-1, "calloc domain_visited");
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
 	if (rapl_counter_info_perdomain == NULL)
@@ -9942,6 +9944,8 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 	const size_t max_num_domains = MAX(topo.max_cpu_num + 1, MAX(topo.max_core_id + 1, topo.max_package_id + 1));
 
 	domain_visited = calloc(max_num_domains, sizeof(*domain_visited));
+	if (!domain_visited)
+		errx(1, "%s: alloc %s", __func__, "domain_visited");
 
 	while (pinfo) {
 		switch (pinfo->scope) {
@@ -10333,6 +10337,8 @@ int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum
 	pcounter = pmt_find_counter(*pmt_root, name);
 	if (!pcounter) {
 		pcounter = calloc(1, sizeof(*pcounter));
+		if (!pcounter)
+			return 1;
 		new_counter = true;
 	}
 
-- 
2.43.0

