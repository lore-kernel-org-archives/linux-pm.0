Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128563;
	b=e+naKv9GcjbVOhkWTAzqjy8QDy2wedK+QQBneD+dkuMWvc5mumMUfV9wgKaOEWCnoOiN
	 ZujjJBFggeXLxOnYppk2LdiwPTSSteFqjnVLuWEppZ4qWzfEW3b5EQvisi3WQC8qf+dFA
	 1eZ91+f6RlcFWzFy/nPegpFP176mnUTykvUpHe7T8YcR7y0Cx67TKW4eQjld2Q3pzG7G9
	 5r3b9Dc+xP7jFQL1loy/tF+p9mLmeDEXna01wpE9O31PjgCkiqOOe/SH341L9Au3tAJp3
	 EceyqsXeT9FqM8XRFGe6hMGnHYw8S2VmbJ6iqcq8hyXng/J7C0BB3h7BRG2sH/CaiMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=ISMEEkMU/BE5053mJI94/RlGYSw/dGJ9F+vRj1PUKjk=;
	b=g2oarBLyI60pSLwhNAlsszItza2hZOWQ7CorFUqQn1HuqrD6wnN8wc8ZhBB9iL3X1a77
	 k3lAz9nMqw6sKiC2oLFJjXFfCJ0xid9fx/zP0iPMadE8Mm1hSRFQKEHdR2DuJkh28Zg+t
	 +VjCxb7Iptnc1JU35e1uAZ+IUxULr72GmYPF3hcvf4MgCe3xP9uvQ7mqLrwN8Dz4DJwwe
	 qWZSXEYwyA9JgqgSd45Ab6IV55bWfmJBXyqPqsND7g7CmYFq48X40fqI1fUCF5uLBfjmd
	 vhDZrbBEu0HntVmvivNapao53tlr0n//uAresvSpddp4ElNlQCTaDtMXZAeuCehR7nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJEadQEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1004606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJEadQEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873141F031E5;
	Tue, 27 Oct 2026 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128562;
	bh=ISMEEkMU/BE5053mJI94/RlGYSw/dGJ9F+vRj1PUKjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=NJEadQEtJPchtrKZnRRbm1X2O9jNFaTqo0H314/VvzcC8AnKXcQpviDLeXcfPEw77
	 FYeB+KcBkO+Ri8ryn+UVRsk13yJPYzC+GtPsTTKIIYncmM4UFHu+damizDgtP/FEjm
	 ID8fwgJ+qL+QPUsIU3zJxcktaiuS2LERiTmChiqM1cLb8h8jkM5s8k9x6YvTEf54rl
	 H0g8Me74Efv6DzhtUd52lz1dliSaI0iY06LHOfrI/6DwvEVGyLaWLNcW0IpxPikvw5
	 EIfZvoHwBLVFkEdgQjCRy926hDdtyP9oc5EtSu+b2bsghkXp21OnF6guNj4doDdcXZ
	 7p1xvY0ZCv4mg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/16] x86_energy_perf_policy: Cleanup: Define HWP_WINDOW_MAX_USEC
Date: Tue, 27 Oct 2026 15:01:58 -0400
Message-ID: <f7950006f0fd09c7291b1cba5f60cda0003236b1.1793124601.git.len.brown@intel.com>
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

Define HWP_WINDOW_MAX_USEC
Doing so pointed out that it should be unsigned,
so change associated code that touches it to use unsigned.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 2d77f465f1ee..5fb6b0883e55 100644
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
@@ -259,7 +262,7 @@ int parse_cmdline_hwp_desired(int i)
 	return i;
 }
 
-int parse_cmdline_hwp_window(int i)
+unsigned int parse_cmdline_hwp_window(unsigned int i)
 {
 	unsigned int exponent;
 
@@ -273,13 +276,13 @@ int parse_cmdline_hwp_window(int i)
 	case OPTARG_PERFORMANCE:
 		return 0;
 	}
-	if (i < 0 || i > 1270000000) {
-		fprintf(stderr, "--hwp-window: 0 for auto; 1 - 1270000000 usec for window duration\n");
+	if (i > HWP_WINDOW_MAX_USEC) {
+		fprintf(stderr, "--hwp-window: 0 for auto; 1 - %u usec for window duration\n", HWP_WINDOW_MAX_USEC);
 		usage();
 	}
 	for (exponent = 0;; ++exponent) {
 		if (debug)
-			printf("%d 10^%d\n", i, exponent);
+			printf("%u 10^%d\n", i, exponent);
 
 		if (i <= 127)
 			break;
@@ -287,7 +290,7 @@ int parse_cmdline_hwp_window(int i)
 		i = i / 10;
 	}
 	if (debug)
-		fprintf(stderr, "%d*10^%d: 0x%x\n", i, exponent, (exponent << 7) | i);
+		fprintf(stderr, "%u*10^%d: 0x%x\n", i, exponent, (exponent << 7) | i);
 
 	return (exponent << 7) | i;
 }
-- 
2.45.2

