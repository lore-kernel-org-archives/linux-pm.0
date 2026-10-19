Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428734;
	b=dg4d2bh5js7sPu+xfW4OzL1U/1d6gOZFz4RLg967ueqI1N/YCkflEALQndSwodJOomLP
	 BeYbYPrbc4FHku9GnEgNgFkTDojEPTLkj7TO3aoSXkgbEr0x+rWqMMcoZS5vW+brYSqOZ
	 GMMqqrwENy8EWDjSWV+4sECAaBVlW1oxSuwAUDFBdbfYbVVIusk4alu12xTiZ1Fb3Tkr9
	 RM+gIxYNM6kMZdwsTUXf2Q6TeaP79jPphGrk2xdY/xRDchgkc6OV0PrDv33Nx8Kxz2Ybg
	 5GHnpgt/llKdCHysm8NqQPInbcDeUK62bQ6pNxy6f/bWcV58LxiycU75k6cQAxpNJtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=JbTLGyE62V9HCX0JYVzVunEDBU6+7VOy7lGAXyw3+Js=;
	b=3U7OknFPWp1JC5wy8AedXPVcsvUjzs1DxzwnzfhFAdC3FTVjfg2CzaamoNaafB5EWsDd
	 2KuU1m/vgKBz32rnoyUVYORknfimIntEdJBOkU23khsq5lbL23nUddVTs/tGTTfFMiMtr
	 mePfCIquF+MFiR8RsBainSg2NXfNqR7P7vQkRXCddMFfbPKJkN1ysez+yoxySLkvR8j9T
	 5BJYQZg8vH+BdaJyduVkAw4CFqbEU/4Dband6iuUW/zsgVJNwR/Iufp5cuTDYhvcqWG2h
	 KkUbd32XzRzwmLyBpfTI/TkWo6vxD4U6t1DUk6Zi8zeCFQFck7Ol/7iO7jWl7SgMVFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auAJwPjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D15606A335
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auAJwPjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866C1F000C7;
	Mon, 19 Oct 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428733;
	bh=JbTLGyE62V9HCX0JYVzVunEDBU6+7VOy7lGAXyw3+Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=auAJwPjPKAdAiXyM434053cE/HnF7izd//2feL48PhDmYuL3dflukPMaauEeVMYv1
	 RZvtH8xsQKSSylhlBuoOvk+hnwl1dqPx9c0nRyjysD29zUln1niEyg89hS0SVpbK7l
	 nAAJR4CQSPShL6sYf+cZvYZZDgYe+apTTsvX25xmnXTVwtP6ZJBAv4KAFlkG/Uh9Xp
	 Bj+mnDn73otK5mL00twknW33Q4sPxKiBYkS8Rcd/MYjr50KAgnXukMCm3DZ35h/xtB
	 H+NOJy3KfLKYXYS9x74iCsRvzIjOFQghFLcW2v8m67Ro/c54hl4kCTyVowFYBV27cv
	 byBdxOOUoJEVA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 09/18] x86_energy_perf_policy: Cleanup: Define HWP window max
Date: Mon, 19 Oct 2026 12:43:30 -0400
Message-ID: <3936dd5ee21ebaf399846da53eec7d870a58651d.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
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

Replace all occurrences of the hardcoded magic number 1270000000
with a named symbolic constant HWP_WINDOW_MAX_USEC to improve code
readability and maintainability.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5c54cf9e0fcf..1a0c23cd4cc4 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -34,6 +34,9 @@
 #define	OPTARG_BALANCE_PERFORMANCE	(INT_MAX - 4)
 #define	OPTARG_PERFORMANCE		(INT_MAX - 5)
 
+/* Maximum HWP activity window duration in microseconds */
+#define HWP_WINDOW_MAX_USEC 1270000000U
+
 struct msr_hwp_cap {
 	unsigned char highest;
 	unsigned char guaranteed;
@@ -273,8 +276,8 @@ int parse_cmdline_hwp_window(int i)
 	case OPTARG_PERFORMANCE:
 		return 0;
 	}
-	if (i < 0 || i > 1270000000) {
-		fprintf(stderr, "--hwp-window: 0 for auto; 1 - 1270000000 usec for window duration\n");
+	if (i < 0 || i > HWP_WINDOW_MAX_USEC) {
+		fprintf(stderr, "--hwp-window: 0 for auto; 1 - %u usec for window duration\n", HWP_WINDOW_MAX_USEC);
 		usage();
 	}
 	for (exponent = 0;; ++exponent) {
-- 
2.45.2

