Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649159;
	b=HbFaLLNB94V1DY3FUpG3PPca/2T5xt8MQsxKdIiZohKhdBiHFS2hJZWDc2ZZcLpejAE1
	 0h5FwG2+A7sJB2msTGMWyaSMHIXljuBLwtHJoH+BBu7O7b0uTji9332HLErHgjBurbz5F
	 d/u/fSubDRBE7pJ3jtNJ4QG2PhbqafDptPBFq7IRblkEU93iJiCvu/AFL3yIUx62lXoH9
	 ELzxiTLztyS/pTKfMkDx3KaEZiC1f/PiYDvM8C9H7k7zF8zW6cC5HIuQiXr6wBFvdWblB
	 GJXdQmqET6cVx7fnMPNTBTUkELDVM3cXeBEut+jI/0TJ14YZc0USpczGJpPtF2ujbdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=AaZ90ReWusq0LZzAbUoTnH7EemtyqlRkFEjjlpcV2nY=;
	b=em+/mmrsaA2NACG2xn4V+j932ezgBbQoasjoJRobfROuAOA294YDJ/DJ5gToKfTqNqhh
	 UQ6IIr3YwGNOACFR2tOTsGopfPGU4+AwXXOlsuGSiEgqTrQvthsNSvspLojGL4RDJw9+e
	 mew8WelDPiuwe8wFEcg9PoqP1tfAr1DGNjlg8k75XxTpfmf6QrCwoRHHqk70qVT+tZRom
	 3a8PuiuipRp5HFqEPQzd2PCTRjAZ40RukhkdrYXXPJXsYla6Yb/Jd/5peZ+oVihr9tlzL
	 +rKS66CdN0XXvmbBdpeSUHDi7mz1zZ2tJGAzh6uyVCJjPcR8idNTOejVVdku0OH6n+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/IxKy1Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B1606A326
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/IxKy1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E613C1F00A1A;
	Mon,  2 Nov 2026 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649159;
	bh=AaZ90ReWusq0LZzAbUoTnH7EemtyqlRkFEjjlpcV2nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/IxKy1QTKnuq2HBaSWmHICCU5e2nv3eKXuB7uMTu2t6j6ep5fNhwF477Pb95HOoc
	 n0Pr9Jk7PRw+s37LOIx/DzBShN7yrIbMeeb5HFvFSDb7XDDHM+/XUMQ+2s3IcthlqM
	 2XpjMm0BDu1Cnjq9lSZ0EiWfliOQ5mH4oHj6bKNz0BjyzE+yv5bsEfUKkr8uOpOcjH
	 04o3D7VNXkkZDn+ZZL17/+wQuF9Huh8dpjVHxQmQSGISQnAHE75mskk7RQexKMr2r2
	 LWxB/FIVYbEn/9bKY+Dh9x9wCm3mzgvlPSMs9LiEvGUgG9ekdBm3xKAoq16BpFjVeY
	 HLfqGbUhHv3AQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 3/4] cpufreq: intel_pstate: Clear last written P-state value on
 suspend
Date: Mon, 02 Nov 2026 20:50:49 +0100
Message-ID: <14146180.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5162355.31r3eYUQgx@rafael.j.wysocki>
References: <5162355.31r3eYUQgx@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Preserving cpu->pstate.current_pstate across system suspend-resume
cycles, when running in the passive mode with HWP disabled, is a mistake
because its value from before system suspend may become stale after the
subsequent system resume and in some cases it prevents MSR_IA32_PERF_CTL
from being updated properly after system resume [1].

Address this by clearing cpu->pstate.current_pstate after the governor
has been stopped during system suspend.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb25dd8..72798f25a931 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3389,10 +3389,11 @@ static void intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
 	intel_pstate_suspend(policy);
 
 	if (hwp_active) {
-		struct cpudata *cpu = all_cpu_data[policy->cpu];
 		u64 value = READ_ONCE(cpu->hwp_req_cached);
 
 		/*
@@ -3403,6 +3404,17 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 		value &= ~HWP_DESIRED_PERF(~0L);
 		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
+	} else {
+		/*
+		 * Invalidate the cached P-state value that may be stale when
+		 * the governor is started again during resume and may prevent
+		 * MSR_IA32_PERF_CTL from being updated.
+		 *
+		 * This does not require synchronization because the core
+		 * prevents frequency updates for suspended policies from
+		 * occurring.
+		 */
+		cpu->pstate.current_pstate = 0;
 	}
 
 	return 0;
-- 
2.51.0




