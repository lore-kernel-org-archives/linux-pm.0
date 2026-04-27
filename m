Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B638B7AA;
	Mon, 27 Apr 2026 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262135; cv=none; b=XglYRLL3VvjONgqyhpxaRzjplt/M53fA0P984HmM6KV0mq/y0F9h8HAKTbsrlxwwLQMp1jF+8wzsgeAb6UO4jE1rfp+fkQiu5T+U80tYbQfSLmwTHwKiBip++M4ikCml/Bxb3M3XZq4bjJT69yV5RBDWTqwLT1/f1E8k651fqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262135; c=relaxed/simple;
	bh=ehN+cCgaE0e49CTPW7ov4BElFyYzLVHX6VJe+/oACPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlNBfWSyF1dsOJNs/y4Plm31wnCgopFeuixbzZam4hiuQ/+ZSMrGy0EOf6noPBFYyTd8OggVlPA798OFsqXq67mbMa933ECuW9x1zjrWWKH+77czwK9vPS7MXInSL1hvvBGlJYU63r7ypflIpx8arrSXrJdA9ZlwR11RY+hunv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5RjW3Rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5RjW3Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D311C2BCC4;
	Mon, 27 Apr 2026 03:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262135;
	bh=ehN+cCgaE0e49CTPW7ov4BElFyYzLVHX6VJe+/oACPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5RjW3RwC3MS2t1sHAM0GHvg1mR42uK9fEoMsgJEpvi0ecphqk1FKYPsRqw8bZhB1
	 cxvReVhZ30037CbZiWCLpunbtX1iZIDv5I3DsRghQ6rwbHI30BJtdnUgAxc87CDtCZ
	 X0GbNKpddxSi+TkCnPOeSn85D/JBUE+WNYs3Jfb92cfCEVBQAT0/O3KGtBUYvQkojw
	 FNpc7cN9VT1PuqSrZRELyNEh5fOs9B+gBdU7u+I5O3bHL6XjAgIhFMdo43jtIzEGSq
	 x9/CZkB/G7K647SbAvkXawuyeycYVbqFgXarLzEFTBdgdJsd93lEZb746O0MbEKQXS
	 un+5zxK+upv0w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 6/6] cpufreq/amd-pstate: Get highest freq from CPPC if available
Date: Sun, 26 Apr 2026 22:55:20 -0500
Message-ID: <20260427035520.1427080-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035520.1427080-1-superm1@kernel.org>
References: <20260427035520.1427080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the _CPC object advertises the highest frequency for a CPU,
use this instead of trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f5c7cc05220c4..9703b54ee4820 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1026,8 +1026,12 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max freq came from _CPC */
+	if (cppc_perf.highest_freq)
+		max_freq = cppc_perf.highest_freq * 1000;
 	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	else
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.43.0

