Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490856;
	b=uaHt8BlmX3GqkUI9XcUknZfV/hepdOZwu/t/ZBH4piLI+S+DhdE7kcSGM3U7SOwn+dt+
	 sO43BL7Ag2FlumMb9mUYStb4h1MeFXEg3naZIlrK5zUeuJ6/V4qm71lOcsiT0WITEzFw3
	 bP3Vp6GueLJftuLjVBRE5WwGdA9GEhJkO1s8iS+Br9WyhPCqPcswTt7BwMHuDomHRIlno
	 +BSYYyoHcHmhWCNMhYR3Iev2YuvR0yNt38Ay12YestA2lDF7/2A3h1Jy7UB3UgK+Ft+ay
	 4m1dxT4yNEvZaGdYN5JtCkJAlXSGUnge5+ZHSUCr5S1po6AqmBCaxN/xfF/X/n8dqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490856;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iFLm/wDa5GDbjds9OPd0AHYQbbjtGgQzE7KYTlbVV7E=;
	b=Mo3cp7DsW11Uerj5QUw3eic6os3oeji8AVz8G/ErAB0lLjzniwSlbR+bfpDvFrC+e0zA
	 uaQHz01quguxKtSNe4Lw8OPTKzuZxz3sB6t2lZDNXu1PndWSMs+fU4CDAhHynRI4S+Jek
	 /YwzHIwJ9Mwq9q7E9vmEgxUWaLTiZ5B6ptlFQNfVAZUtfCOuMTISl7I8cDvcQuO9nXBbD
	 5AKQdyiFj2fb2k5eV4HGs4RXZi1bhIuihKezc91mrvH12CMb5hC45pFOjdFGiTLGbAx+d
	 1+8PSEeEoy245iNCPx+4mN4WXUjDvkEoqJulddRhekG+y5WomAPLJvmAkh3pUbeWkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MoOKUZRC;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A9606A332;
	Tue, 24 Nov 2026 03:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80A9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MoOKUZRC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795490847; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iFLm/wDa5GDbjds9OPd0AHYQbbjtGgQzE7KYTlbVV7E=;
	b=MoOKUZRC8UUK34GAYvBWk0wUxEBbHuUIK4jXmrS7MqPb5qQvMIAEpaJgy3sF3A/RNvc8/vOO2D1YFafKWQVDyqla5ARmP/RuO9hyO4bSCwxBNgBTawvVuL/Ut1nxHPAunqQ3rSK6xGa3ZfJp6+7musWZ1XUGOPe+2a/q+5dsjj0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFN2idP_1795490846;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XFN2idP_1795490846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 11:27:26 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: lenb@kernel.org
Cc: michael.hebenstreit@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 1/3] tools/power turbostat: Fix average format for CPU/core perf counters
Date: Tue, 24 Nov 2026 11:27:21 +0800
Message-ID: <20261124032723.157254-2-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf counters added with the average format report interval deltas at
CPU and core scope instead of the latest counter values. Their summary
rows consequently average the deltas rather than the counter values.

delta_thread() and delta_core() only preserve FORMAT_RAW perf counters.
FORMAT_AVERAGE falls through to subtraction before the summary is
calculated.

Preserve FORMAT_AVERAGE values in both perf counter loops, matching the
existing handling in delta_package() and the MSR counter loops.

Fixes: dcd1c379b0f1 ("tools/power turbostat: add format "average" for external attributes")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 123078926131..4e7eba8d8752 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3956,7 +3956,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	}
 
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
-		if (pp->format == FORMAT_RAW)
+		if (pp->format == FORMAT_RAW || pp->format == FORMAT_AVERAGE)
 			old->perf_counter[i] = new->perf_counter[i];
 		else
 			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
@@ -4079,7 +4079,7 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 	}
 
 	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
-		if (pp->format == FORMAT_RAW)
+		if (pp->format == FORMAT_RAW || pp->format == FORMAT_AVERAGE)
 			old->perf_counter[i] = new->perf_counter[i];
 		else
 			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
-- 
2.55.0

