Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128564;
	b=dKKAFS0JxVlFmu6LpQGFPoYDC8ORzvmBjINECtDYs49mLhB63xvzVHN9XBgtHPOQhf8b
	 jl+Kl0+lnOcW1g0XRFlltVVfkVJGVNlc1/THCUOZeJgNZF69qNI9vecdaM/0uOpUQszHw
	 89ctXLXKncK9pg8z2BMofmbkqFgiG8XPI+Xb9cqwXqYTrVJCgCZc6ytbDc/AuUKfFb1ON
	 UeSlHFgo8i8MnB3UZ/sd1xQLLpnXKAr9OYQOX4twJvTqI5nxJrXZNlDEmz6JBik24N/Zd
	 YsuLHus6sub96MrY6jzpnE2zmIL5n54vlmVd7Jcz0sTkfuHsRhK1EE1TvYIFZoM6/Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=bqe7hLZh4E7oP+6KQ2w7oqlLvlkTMwdT2LfTEGtE3CU=;
	b=l0V5rxOBKaSRJeTtaSd58Di/SVcD41gCFssNlEj2/cpAEGLZoN93U2kCupJ9o1/NYfZx
	 OR/rSCJcPvgP+/p4X4gwC07JWhs/B/qosG0IYIBSDeiRuH2AqxC0XCULmP9AGk7MBURCH
	 RGiQDEKFAFJ+nSNIH+3FPGTmBabCZayZc1lL/dqfIHdQVAXzqkSe+7VtK4UC/vO/b+Tbf
	 DPsyZ2fBBb95moJ08Ys3258mgAbSaZTV7x6j5WjmOW79KXV7cPlEP1TWLLJ1uZz+Cq8zE
	 rsmYQQcf6a8RKnCFu5fuo5qdDc5sqnOwNIOv9pGRA7z2mUehh9Ybl0EsCRGXPOtfeew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6VM5ako;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF56606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6VM5ako
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F9E1F031E1;
	Tue, 27 Oct 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128564;
	bh=bqe7hLZh4E7oP+6KQ2w7oqlLvlkTMwdT2LfTEGtE3CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=k6VM5akoqCAIdD9Yd9+sgg0IpVVkI51UBw3Fc0g/dEWen0FMgnNc94wXY4Y/6VCkw
	 hOOSK2n593qH6Pw2Woh1CQLbwPuiZw3QugH9z52Ncqu6gGFkL2FoaS/EMXyPTKALIj
	 T3NfDty9h9EDeTarnbGYVIhOcNTJR5iUT/bLKQ90XNgIY4YK8eYFYvOtc6O2v9a46L
	 kDJSvAhVW3yIIbsdUiiGcmx9S2w7V0ZkL1YdqENRnpbeiWMy1aSSWwqT/QoVoZKgVy
	 PVFEz/MwmCo+CtUEB5+BxKF4Iw9wK9zxBFFZZTQ6LoIgQq7pFyGBxfIv1WYXnImNJl
	 Im2xg198XfvQg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 09/16] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
Date: Tue, 27 Oct 2026 15:01:59 -0400
Message-ID: <1b2cc9a8fcf2af42f0f8048fda4683bbd4563c86.1793124601.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
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

Replace the hardcoded value 100 with a named symbolic constant BCLK_MHZ in
ratio_2_sysfs_khz() to document the assumed bus clock frequency.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fb6b0883e55..0a67b6f5381c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -37,6 +37,10 @@
 /* Maximum HWP activity window duration in microseconds */
 #define HWP_WINDOW_MAX_USEC 1270000000U
 
+/* Nominal bus clock frequency in MHz - assumed for all HWP systems */
+#define BCLK_MHZ 100
+#define KHZ_PER_MHZ 1000
+
 struct msr_hwp_cap {
 	unsigned char highest;
 	unsigned char guaranteed;
@@ -1163,7 +1167,7 @@ int print_pkg_msrs(int pkg)
  */
 int ratio_2_sysfs_khz(int ratio)
 {
-	int bclk_khz = 100 * 1000;	/* 100,000 KHz = 100 MHz */
+	int bclk_khz = BCLK_MHZ * KHZ_PER_MHZ; /* Convert MHz to KHz */
 
 	return ratio * bclk_khz;
 }
-- 
2.45.2

