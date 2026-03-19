Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD62D0C97
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929050; cv=none; b=IGzYUjRfiFUUv5Jg7WPWSn/50FXFPItZXoSgCkktYjLanC+O3G/EliR2hIB4mA1+KOzHZ6kp0yS7rWRS1YFAgHyTJrfzWWRJhlb9u7y3wKtP3RjV2MI2SIpGgje1Ta0pGgMA47qQrEqBxtKAwhnslCCO8QTb6N1btv8/SMZO8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929050; c=relaxed/simple;
	bh=BJDioJ7VTPZdZcrChnvmZGPUKqEzl5xZmpnKkUYNiMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lL7Azt0ihLbR/GOdPG06YE3M6YcJs7lNe/yY58pdpm3ZbxqLKTucoPLDOXq5t7Ikqouin8oa+j24k3koLU/VtMDVs77Z+MH6dE5HCEHihUu1wPv2KVOEYBfYyiIfZkkJtRFurPjHI6Ynkr5HMo1u0W7wnO2kF9ea8mBmYYGoaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mhp9ZqH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mhp9ZqH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773929048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q6NyLZcL6/89S3l5gs2Exgc21wjIy72JJSu1rERb5B8=;
	b=Mhp9ZqH0g+iH7oyOOPY6Oqlj+5FAVnbXIJ56940EY21QYVHnJTPRG1RnFrZpCDNn+df+g7
	750RujGJXLkWkhswl3L1LEK4smiPxBikssbCB0OfA/e6z7N9B2vG9msS4Uk24fTNKVT/QG
	t9darnQtlPXPfx+JTLhnRb/z9pOA6pI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-MxFyPVTiMNWYtBYto8AHzQ-1; Thu,
 19 Mar 2026 10:04:04 -0400
X-MC-Unique: MxFyPVTiMNWYtBYto8AHzQ-1
X-Mimecast-MFC-AGG-ID: MxFyPVTiMNWYtBYto8AHzQ_1773929043
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A3FB1955F6A;
	Thu, 19 Mar 2026 14:04:03 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D94BF1955F21;
	Thu, 19 Mar 2026 14:04:02 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: Len Brown <lenb@kernel.org>
Cc: David Arcari <darcari@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Allow execution to continue after perf_l2_init() failure
Date: Thu, 19 Mar 2026 10:03:07 -0400
Message-ID: <20260319140307.441950-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, if perf_l2_init() fails turbostat exits after issuing the
following error (which was encountered on AlderLake):

turbostat: perf_l2_init(cpu0, 0x0, 0xff24) REFS: Invalid argument

This occurs because perf_l2_init() calls err(). However, the code has been
written in such a manner that it is able to perform cleanup and continue.
Therefore, this issue can be addressed by changing the appropriate calls
to err() to warnx().

Additionally, correct the PMU type arguments passed to the warning strings
in the ecore and lcore blocks so the logs accurately reflect the failing
counter type.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a2671c28209..f1b8059a4eec 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9403,13 +9403,13 @@ void perf_l2_init(void)
 		if (!is_hybrid) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.uniform, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.uniform, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
 				free_fd_l2_percpu();
 				return;
 			}
@@ -9418,39 +9418,39 @@ void perf_l2_init(void)
 		if (perf_pcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_pcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.pcore, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.pcore, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
 				free_fd_l2_percpu();
 				return;
 			}
 		} else if (perf_ecore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_ecore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.ecore, perf_model_support->second.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->second.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.ecore, perf_model_support->second.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.ecore, perf_model_support->second.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->second.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.ecore, perf_model_support->second.hits);
 				free_fd_l2_percpu();
 				return;
 			}
 		} else if (perf_lcore_set && CPU_ISSET_S(cpu, cpu_possible_setsize, perf_lcore_set)) {
 			fd_l2_percpu[cpu] = open_perf_counter(cpu, perf_pmu_types.lcore, perf_model_support->third.refs, -1, PERF_FORMAT_GROUP);
 			if (fd_l2_percpu[cpu] == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->third.refs);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __func__, cpu, perf_pmu_types.lcore, perf_model_support->third.refs);
 				free_fd_l2_percpu();
 				return;
 			}
 			retval = open_perf_counter(cpu, perf_pmu_types.lcore, perf_model_support->third.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP);
 			if (retval == -1) {
-				err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.pcore, perf_model_support->third.hits);
+				warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __func__, cpu, perf_pmu_types.lcore, perf_model_support->third.hits);
 				free_fd_l2_percpu();
 				return;
 			}
-- 
2.53.0

