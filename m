Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735378;
	b=fqlXuINKvwvC8nNWaZEnLhDwYpqGyvktmv7FgK69ZRBg/9zCHivfptHU2UJkMV8TmraN
	 aPmoLS+bmjt3FCuuZBjwLgv4VEvN08CPOeGoSmLdFiNZMTtkDXCpqwNJTVYiUIQb2T8PC
	 gPvh/FMeLy67cxETh6vUFsiVYlnUVEAmTaWsX+VV/VK8J6gDB/TeaOoi9sgD9hSeRNR5Z
	 5bSvENhNpYZCWCysPbXKYikJgt+z14LoQ6+uR0I62Wt2YzcccNPClotQYtZruV1LgzR56
	 lD9LidjDu2XFlUrZmv3a1iPZl2swSoB2RuABHv/g8POMv3d36mWmWZXhgTMoafvyO3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=RgqDVbeyeNuM2Z4SYh9s/DEqR+ea6FLqa6X1Q3RCgy4=;
	b=ljUEOcv7FRUicNx8yejtJuNtx1Kie17p0invAVRTYLuv+XURze87QY4+rDyTyzY8bCEV
	 iPC9zfpe0gYuehUZbbTHItvu/PWrCPoK26BzpLihcmSipYvxjJW2CBmoaSMo/XBXpmyGB
	 Lr51HnfnlcW+EhXpZFcOzljq4TIGRy4eCng3hcd7Pevr18Up5yHmGsROVDTvUy0ctq+5i
	 y/jqWBSsj3wus1y7AOMQUb1LfveHsnkAb/FxfL9SPn3cgsVpJXWqlu4yDagwRsVkAeoJz
	 UtgjoTMmYM2Paaf18/s54/vIy3ecwvmnj+k9NU3S/vg/y6FuE4XpZSPn6RxNRQxSmDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgUxFOG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F4606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgUxFOG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147E51F000C1;
	Tue,  3 Nov 2026 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735377;
	bh=RgqDVbeyeNuM2Z4SYh9s/DEqR+ea6FLqa6X1Q3RCgy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgUxFOG7QuywY29K+XcJLbE52Zc8wl4qS67FDOebG4mHWW1/IjmptmARaJD8jvvxu
	 Hy6/m8yoSTKA9uRpQ0CEm1Mi/LSMv496hLidbxbppzt7yL1tLc1ne6ym5LEMoMQrYy
	 blbJqMlK6QZcta/lEazNKuPKT9XVeXUV/jIRQFyNNjZaAxdk3dgmwPl6OK5ladIw1s
	 HNlu1pdLhqUgNGpMLbuh70/PQB3zrPJP+VGvWSz5eYNoPcUlYgL72zSZTETHsHtyVe
	 8LI+EHKUWLkqsjVhn1O3HSACD5EDWDLjjgFuijYqo0Y5U1yXKQVjInN5lYx169Z9kj
	 yHRb7+FBZknbA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 3/3] cpufreq: intel_pstate: Clear last written P-state value on
 suspend
Date: Tue, 03 Nov 2026 20:49:06 +0100
Message-ID: <14150222.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
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

v1 -> v2: No changes

---
 drivers/cpufreq/intel_pstate.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3389,10 +3389,11 @@ static void intel_cpufreq_cpu_exit(struc
 
 static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
 	intel_pstate_suspend(policy);
 
 	if (hwp_active) {
-		struct cpudata *cpu = all_cpu_data[policy->cpu];
 		u64 value = READ_ONCE(cpu->hwp_req_cached);
 
 		/*
@@ -3403,6 +3404,17 @@ static int intel_cpufreq_suspend(struct
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



