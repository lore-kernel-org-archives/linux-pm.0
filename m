Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495443F095
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315573; cv=none; b=begbzv/SpB4LvndVCkdgNe8rOAfj7v7IemLwelPUHJC/J8cfGMGux6hJnaQ0CPnVZRfGMsxW61AVSZrOQLRhoOiY0ZrXVeeRebX5+ptM/NV0a64tGAc92buF4SjcncbEutpP3k5jweNgTuZI3z0QReyiwEAMVI5LF255aY31sgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315573; c=relaxed/simple;
	bh=yKnjYx8lSNqt8Bfgn1Uw6mYSvKO+6twVH1bXjBZCpe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kOst73oD+ym6NCRmlPc1EvtclnFOieKPWTpMBYPbB/7ujMoKbIjwjGYsuChfz9Id9x9ZbFvb6b3BBsGJFYbv8mCx7InGOCg2u0OVzTz9hFjva58g/eVUrEHtwgZrKjAjEa4RBdRpeee3H8YVim4+jMl8lGgT1mTPHHvMhOL6Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1UoB7Ez; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1UoB7Ez"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso558190a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785315571; x=1785920371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MUBj8aoQIvZNl7lEmOibROP3TCidjP31UdlwOK8igZo=;
        b=X1UoB7EzHn2+0hQsb8SdvwvzDkSwg2TUmCNaBilabx4Nzq8fkxEbh++O65Eat5AVoQ
         s9/sy64DUr4v+OnPPhYUBn7bCsKjBEqrWDYNWrFPjH5w1a1o502MQ17jLxkzTcuE+63P
         Lthm3MYuOq9hWINS+3fgxd0de9n8F6vAU0brByHLKR8PeG76KUPvctRwJp+Iod0ESiu4
         36l7/5Z40IdoZSaBxHPB7KtHPPP/FLi7f/1CTJ9hLh+3UUiwz6G2DE+0qabckN0xATLS
         g1rPTqtvoHBsNZ+vnicGDLLA+F0v0X1W/BNayap7mjLjieICO0l6JZDv8N1nr6tWtQFu
         iaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785315571; x=1785920371;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MUBj8aoQIvZNl7lEmOibROP3TCidjP31UdlwOK8igZo=;
        b=BUIpwcYO30kPQdnp1J60VPNQtpp0NgRiOD3WEs7X+ma/F/9hMws8gQ4tPXRmgPzhRD
         cJFrbGD0ZjJ7skf7axXCEWzVvmPV2xNO/+fo1j8uAROLgcJtZf741BJjt1uvEPK5+Qhq
         0+YuQhRMPsfDOOpVFHXvpf6g1cIhjcE6pF6k3XxJD7Pmznu2Az3evx11GaUzXW7+9rUo
         BmxOT7zLsdmJrD/mVvXJq48u79pxUbjwVhH0P5MyfH63bli1OezgTN7UH30A4VC9gkKx
         Y9uzoZIlchNIKRmCDwz2KuF6QWYCJQJb53mUpGg8v+35dL+Fd/lHxUOZZS0OqHKGKRmU
         Sx7A==
X-Forwarded-Encrypted: i=1; AHgh+Rpv4Aid5tbygNFKpC9tfQ65qSOj1L7Uc+lPMttcaC/CPo1qzpWO5KrAahicYIqXW7ZD28uhsr6xdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lK4nJrn/a17/R8H8FjC7eIpf9nXx8OjzWawqiDXP7mErwr1R
	R2YXPNQKDBrqrtypVp76kZToivHaiV1HfP8HZHl4IxmakVC3YUsL1vwu
X-Gm-Gg: AR+sD11fXkIG5nn6alX91vLHnqUs6mVaGED83Lqqls3f4tVRpnum5lLLANcCAR41FnV
	KO7iiqWcUMLf3PzAb/f7i+qo1bz/BqP2jFWWO9S4WlaxVQ7ZFh8SkHBMljxcthP+d4EGbD89T3u
	DnADbjyBaKReUFi174QkYBrKDrl/Z8I7PpsMbLUvVjHsG7xy8BNxkg/NjZ2vBxhfLwIUXPW8jYl
	5itMUWZ9gVw3gKtnqLV7khirU0cpqnTyIzKktGGPDNxytdMQFpsG79kEnEb/I0no8VyS834HRMZ
	X5C8mfnxOgDxyVNIXG76vZNhu6UVB7DqbkU5zqNaMlLz85VBZo0Jp6eYI+Yg1+G7k6rGPIj1xy5
	g9Sh02yyaEfI3n4FZutkQn7DPI5luGN1kCX3sC6iF21CllIGSBRN247biDjEfikwZZsGjkbuh+x
	34mdzTpKD08bJUl5nYNv83dXnHm1CW0Os6+dwgCSB6/mTiBr1oNOfcOWl74Q==
X-Received: by 2002:a05:6a20:7290:b0:3c3:a804:8ee5 with SMTP id adf61e73a8af0-3c8ba635ee7mr7303455637.65.1785315570721;
        Wed, 29 Jul 2026 01:59:30 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b1246dsm7040104eec.2.2026.07.29.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 01:59:30 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Wed, 29 Jul 2026 16:59:24 +0800
Subject: [PATCH] cpufreq: intel_pstate: Sync policy->cur to the pinned
 pstate
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOvAaWoC/x3MSwqAIBAA0KvErBtIKftcJVqYTTUQJmpRRHdPW
 r7NeyCQZwrQZQ94OjnwbhNEnoFZtV0IeUoGWUhV1LLF8ViQbaQNXYg6Erp9Y3OjOTwKEmXb6Eq
 pUkAanKeZr3/vh/f9AF4Ac11tAAAA
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jing Wu <realwujing@gmail.com>
X-Mailer: b4 0.13.0

When cpu->policy is CPUFREQ_POLICY_PERFORMANCE, intel_pstate_set_policy()
pins the CPU to a fixed pstate (max(min_pstate, max_perf_ratio)) and
programs it directly, precisely because, per the existing comment,
"NOHZ_FULL CPUs need this as the governor callback may not be invoked
on them". Two lines later it still unconditionally clobbers policy->cur
down to policy->min, discarding the pinned value it just computed and
applied.

arch_freq_get_on_cpu() falls back to cpufreq_quick_get(), i.e.
policy->cur, whenever its APERF/MPERF sample goes stale. A CPU whose
tick keeps running refreshes that sample constantly and rarely hits
the fallback, but an isolated CPU covered by nohz_full with a single
runnable task never gets another tick, so it permanently reports the
floor through this fallback - even though it is genuinely pinned to,
and running at, the frequency computed just above.

Set policy->cur to the exact pinned frequency (pstate * scaling) in
the CPUFREQ_POLICY_PERFORMANCE branch instead, and only fall back to
policy->min for the general case, where the frequency genuinely isn't
known without a fresh sample.

Fixes: d51847acb018 ("cpufreq: intel_pstate: set stale CPU frequency to minimum")
Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5a0eeb84d3821..b2c60c4931dcd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2908,8 +2908,23 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_set_pstate(cpu, pstate);
+
+		/*
+		 * Report the exact pinned frequency instead of the floor:
+		 * the CPU is pinned to pstate here and nothing else changes
+		 * it, unlike the general case below.
+		 */
+		policy->cur = pstate * cpu->pstate.scaling;
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
+
+		/*
+		 * Keep policy->cur within limits here: outside of the pinned
+		 * CPUFREQ_POLICY_PERFORMANCE case above, it is never updated
+		 * by the intel_pstate driver, but it is used as a stale
+		 * frequency value.
+		 */
+		policy->cur = policy->min;
 	}
 
 	if (hwp_active) {
@@ -2922,11 +2937,6 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 			intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_hwp_set(policy->cpu);
 	}
-	/*
-	 * policy->cur is never updated with the intel_pstate driver, but it
-	 * is used as a stale frequency value. So, keep it within limits.
-	 */
-	policy->cur = policy->min;
 
 	mutex_unlock(&intel_pstate_limits_lock);
 

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260729-bug-intel-pstate-policy-cur-1e1498a56641

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

