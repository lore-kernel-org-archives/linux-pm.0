Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C03B8920
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281678; cv=none; b=Mnv9Zu8+TcxcAntGNXoULMHy/dpRPgx4ZEPv45MyeAemwR4DcN7tH1+W/JuSPriaEm25gENS9I9p6znqwT5xzrpM9dK6TQiYQ3CPG4VeyV4s27SGInZCaCd+JRQYmS8VT+9yBF5JhQpSIMyHxj3INx8aTwDeO/LsjZ5NTOKi6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281678; c=relaxed/simple;
	bh=UYWQZ2GP0U++mha636tNmQDeDr1xCrJ4Hne/HQIGbQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OG/uOLiS1KcHPzuivpjd5F9kCGZ5ZOo52GMoFGMHwT4jflR14eGdiA0n2E+LLe2ck2MbgzFuzar8UoSc4HQXHvR314SWRUYZROY8RC793F+sbKJsE10HFlBpuqasmZ2Zej5PZa57865jAx14c+PeDFmmY1QzviZjmQXtzSZjjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MRJeYg/5; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MRJeYg/5"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67c2db63127so174867eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281675; x=1774886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alZhVdYENKaCgEyuFWCx1ONcWxmGf0Z0mu4iI7gLWPk=;
        b=MRJeYg/53vCtQQdVZ5EGQ7rzA+mX1UXmCi8u38vZSN1PYY7KKlq25mnhrJGEoqSJTt
         6/jmy57s5FIbDh0shGos4MkijwsPQJU7CflSO56jAS5naxUG+NAp7Tdu2WjGEtWQqCN0
         HeXUCFFNUbeM6LRFjkI3Y1edH9JTHvjI5pqdEJboiuAScB/JI7zgrSAG8eHPcJ5qiGTi
         JJTlYDxlUSjDs7Dm4VapwPFU0XgLi78A8Ty5M+Wzhm2NV8BmO4CYcJPGZvwEaDILXUsB
         RyMeUxDP1j5wQ5RlyZlM/zEsWLhW6PcPpVuA/m4p9Vr5reHLRhKIX54Cz6mKnJjpMi8J
         m8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281675; x=1774886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alZhVdYENKaCgEyuFWCx1ONcWxmGf0Z0mu4iI7gLWPk=;
        b=i0NyzOSwCXCVG25yqmWd0aovRBWXYaKwMwB5RlgeKiPSePW46BoO+OrFPx2fRK8LkH
         N0yHb30Okz/CRqHjprdKYPlI6TZH/lQO7oT9z0V/nRK8htyB/4din0Mw9KMgoLPfNq3H
         n07I9VidFgnoVgcYSVQd4XjNxlrJ9ycCCXaVXIjzg+8Zsm0ebn45okmqvzzJ407Fh2ox
         68jOXdhzYAHbXHUKq6otxwOEH0Yj7OoFnVBfihSnf6YZSyNdiF4IvKP7vEi8VJYgnBQQ
         m0GZpkKbd6A5WG+FPqqfhzwKrY1bRFroMtCuaCpu6k14Wo7Z3wB4O0zCBUaKbOATcX23
         eLdA==
X-Forwarded-Encrypted: i=1; AJvYcCUI4I3ZBq/eTJpTb9xl5npoOuuuh0W7rQVzfDprFYVvnuaMA7Zqty/4S01wWJSCqRCykX9z6UrRYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/f0IJnl3KIzcyRzsL/nzPS0ySDHM89O7z48O6yw2Cuxo0gpC
	55E85eg5t02JV8IctPlh9jaPidgh3IhmdvLTUA8Fs7CPH4UZvcsgWnRmbXi0hCqYSpg=
X-Gm-Gg: ATEYQzxB9MGMUP5cDV3Cfh7QEtKXPsi+t6aTYWI4PPe2U2bIU0owum2zd7eknWYQ19O
	BBQHfETe6SFTbOdmAKAhArSsVwBLqMx9HKhwngKPnwrExbeOCqfebh6IM3II+e15wd5eBwhNqgj
	6Fycz4pMNu6KXs0GuPnLuhFaST1yMmO4bo0Q9yidIs1yfdWa79hgx7gRr7gyrWP/HoRl4Iq5paV
	7cg1mNYAT5/enIm4p5VWLiOqRx1eglK/kkxW8Y2ufRC+MlXqrqlZLKDc3mmA9WerSJsImVH6zB8
	P6R3PKcUi/ONxJIe2ySleql6IT72J++vyj4CTW0S+Iwg0UfgTSQdEDRNx+4kNonmL4hzJ9RN4jS
	y232ZaDUKIcpnw+Dp+icJrcvIIWHuSTFbqyJcpUI5ucLOMQ1RWh8wyVDw0y++9YkXlfRi/Ukscu
	r220A9Sr8dI0HptMmgJiQsHTEB0kLLEplJfw+6doRacyUJRELABYy20aN2tLuluQNXeA==
X-Received: by 2002:a05:6820:1a03:b0:67b:f147:4cdc with SMTP id 006d021491bc7-67c22fe7998mr10114283eaf.64.1774281675182;
        Mon, 23 Mar 2026 09:01:15 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:14 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 06/19] cpufreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:25 -0400
Message-ID: <20260323160052.17528-7-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/cpufreq/amd-pstate.c   | 10 +++++-----
 drivers/cpufreq/cpufreq.c      |  2 +-
 drivers/cpufreq/intel_pstate.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..4c47324aa2f73 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -298,7 +298,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -343,7 +343,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -507,7 +507,7 @@ static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -588,7 +588,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	}
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
-		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
+		trace_call__amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
 				cpudata->cpu, fast_switch);
 	}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913c..58901047eae5a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	if (trace_cpu_frequency_enabled()) {
 		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(freq, cpu);
+			trace_call__cpu_frequency(freq, cpu);
 	}
 
 	return freq;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 11c58af419006..70be952209144 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, in
 		return;
 
 	sample = &cpu->sample;
-	trace_pstate_sample(trace_type,
+	trace_call__pstate_sample(trace_type,
 		0,
 		old_pstate,
 		cpu->pstate.current_pstate,
-- 
2.53.0

