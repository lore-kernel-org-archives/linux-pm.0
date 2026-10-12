Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE24D0CF5
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830115; cv=none; b=CxIicrND+FvHPwIH/DZsmuUG5o1kLvdox2IVGKjaknys4PY0jOYWm+/HhBlDYRO3v3dh5imWaE6tBOMU2BlSQsdRpMkrtEAh8U5yDO3GEtCU1/ZzJodynISY5ir1d+icJkmX/PfIQKdTViz1CZHMAu5jX0Kk2nXuQ0VaWn6nPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830115; c=relaxed/simple;
	bh=/u73akwTLMHu6ky4tjdnt+WIuDbZq0zQxdGwLLUeXXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKnrQxgHsTM4LFDvQwqUkG7B7BK6rL9cO4OW5NgsSmVPNRupVDG7pKF6b+N2IqsdNprt40w+Tx6t3tgJXlb4cmEGnktsv+7blfNhZNsVkeweYVCeOqVvY8z94Dj5ljjpTJf01EikmI3Q1+QNjmcguYkNsplnjpDlIqd78lusYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqbFRjxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqbFRjxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B41F0089B;
	Mon, 12 Oct 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830113;
	bh=tgwwV6Mlgg2q0Gs0Vr33zCZBDF4G4neZETbAZS7Q42g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=WqbFRjxtx1hDOhzDvIcOQEiGQSiaJqJ58rOvvTZb/Wzi+El3naailLK2Bv7ESzGpX
	 7Wj1by8GfFuuzAKrAAfkkaCU14x8NP5QQDBp/wYCDCcxEiN4EgLPfak5equfi9K+4y
	 diVNWEKLURDQ6mfSpxzuUSvn0taCag856dJ29HiNufYOWIfTPKYcxedMNdYwM3kt6N
	 exZB0ZAmsFft9Q4AUbScfjhnpJIg/fAuTNyU58telL9uDx1koNP+xkGln/FPKHYjEb
	 NXQU4uasIpRy9485bxVPfAmVaxYMCJlkYpNTKt9CoQ0yEEkjcfttF0WB82/FfxkGtc
	 B2hBsxDhT4G0A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/9] tools/power turbostat: Sanity check GFX%rc6 and SAM%mc6 percentages
Date: Mon, 12 Oct 2026 14:32:29 -0400
Message-ID: <485c59972808078570d21317de8275af47a18696.1791829903.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

When measuring over a suspend cycle, GRX%rc6 and SAM%mc6
are observed to print as numbers much greater than 100%.

Those numbers are not useful, and they mess up the columns.
Detect when they are out of range, and print them as NaN.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 808f079c874c..6a59cdcf8ba3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3636,7 +3636,7 @@ int format_counters(PER_THREAD_PARAMS)
 		if (p->gfx_rc6_ms == -1) {	/* detect GFX counter reset */
 			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
 		} else {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), p->gfx_rc6_ms / 10.0 / interval_float);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->gfx_rc6_ms / 10.0, interval_float));
 		}
 	}
 
@@ -3653,7 +3653,7 @@ int format_counters(PER_THREAD_PARAMS)
 		if (p->sam_mc6_ms == -1) {	/* detect GFX counter reset */
 			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
 		} else {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), p->sam_mc6_ms / 10.0 / interval_float);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->sam_mc6_ms / 10.0, interval_float));
 		}
 	}
 
-- 
2.45.2

