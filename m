Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202423806C8;
	Sat, 25 Apr 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142872; cv=none; b=NYC94jWUGj1QuuBgg5shRhqHQ2/iF/vdUKFDIUscio9rF+Tt7l9HlX8Ln83c8NNjjK9aFATSJ0AqIjoS4aiTOXNRA5voHk+ur3i6EpsVAWGSbTnGDnXENvtAVCKBUfQYhXPAL98uR5PODSt9tHNX1Yh3qI9BRlbX4UIwMxki13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142872; c=relaxed/simple;
	bh=z7QwbD9Bm2wuhEPhiKEYjjFzBbUXtxlxjHSj+5hl4zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPk6PNuttwtsyq0xKMkiyYDP7kIearRLLsvfhSITV0cGoqNcA7lTHF6iwAek5tKbXU33fAeFcJax7Odr3MPSSic4CSAGO89p++E0hhkZEbtc7OqX+pZrPdfAlK40RkEG3YHw8O9PmtF/RQktZFWWRbkJxJaVgKwtGa287+60Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFcnY91V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFcnY91V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30791C2BCB0;
	Sat, 25 Apr 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142871;
	bh=z7QwbD9Bm2wuhEPhiKEYjjFzBbUXtxlxjHSj+5hl4zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=PFcnY91Vhn22TlQVQw/5PTutCXWpY7bt04O0jHuGw7hZMc57d9/qY45Z3jZhrKZu7
	 VM39YcAwKN4iA1POW9hHAjt4eKnPe8pw8i2ivsw11GR+DfYWLLP0S94Ki8wdbDxsWt
	 +Ym/9rHCg0m7+b0+l11BdWetUXS0n3amjHoHt7p0chZ9kVzL1YPpVQdAt1J4rEyxq1
	 xyYNdLfw0MRAHPeW0uS2+DbU34d8Z4O0CpOhhylSbRdp5RnvW1qn2C493ihQGQoCx+
	 DGuzySJRk4nbn+zYTqZCzbJX3GCVXfynwxy5VsF1/hR7/Sz9tEOcnVQp67z+lcrfPH
	 XKDbaPq3Q/SNg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] tools/power turbostat: Fix AMD RAPL regression on big systems
Date: Sat, 25 Apr 2026 14:42:05 -0400
Message-ID: <3ae6bafa104d93ddc525b8de547bf66b43fcaf10.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

turbostat.c:8688: rapl_perf_init: Assertion `next_domain < num_domains' failed.

The initial fix for this regression was incomplete, as it did not
handle multi-package systems with sparse core ids.

Fixes: ef0e60083f76 ("tools/power turbostat: Fix AMD RAPL regression")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e9e8ef72395a..bea574d7aa68 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5155,7 +5155,7 @@ static inline int get_rapl_num_domains(void)
 	if (!platform->has_per_core_rapl)
 		return topo.num_packages;
 
-	return topo.num_cores;
+	return GLOBAL_CORE_ID(topo.max_core_id, topo.num_packages) + 1;
 }
 
 static inline int get_rapl_domain_id(int cpu)
-- 
2.45.2

