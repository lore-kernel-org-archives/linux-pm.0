Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B003CA4A5
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327955; cv=none; b=t7u4fZ6kWgs79qvfTFDo1Wl92nYG3V1jEK0OtKK430K+spBEleSngYRFwY0vYCn0YZS2qKRSsOkx0EJOKk6JfACODcJkT5NtJYjzecg1JpkJggMSaTOGUfJitr1M4udCwvwSed97GnlXU6L10ab85Ci2B6fCvIqKutrIxfZVqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327955; c=relaxed/simple;
	bh=+XkdBL/iBbPTLn6OXMzJHR0G0dsvQ7QtqeAjp/Z9o4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV4R5KzZ3PaUCegl+q+DVTyAEJKqyJT3llk7ID46cWCPdtw0AsghU36K0BFuE69z4h0ADB9FzU0shVrGYNfEAOSHUDvdwugyfkN01d7WN6Qrv/CaDuA6YNsLDT13brZVrIaWn3ustE8dEZAv9TmHiccHikGwjjto1h0of3elx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=lvoe69mV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="lvoe69mV"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d738fe814cso940950a34.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327953; x=1773932753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMO8ByhAJjZDznl2VKgDz1seDvubSt586JSGerTT4Zo=;
        b=lvoe69mVa/cGPAP2NfsR+SxJC7i99xneDBViKFJK7Yx5cmmCqKq97NVFMPiRU6p8Oe
         EOVvZewRWsru6MrsrzLHTwr/Jsk32D7RThRNhZatXQa+YPz3JUtakROSf0bIbE41A243
         8jIHB5B6m0exSjiPUMyyCGHfDjkrBn0+Hj/jq1ZhLNjwi96N089n4R+9vRbqkGn4Gk2c
         6HEcddOhgP0kF2Ib8cxgliAk26+Xq9Z0MnyvzsgwXjw0zZWtjTcclTQzhvptld+gGyZ/
         r9uEkaik6z08ojseVxKak6tS4zPcMHGPNZI+3A5VqhcPgJupt7W7xwKUWk6qaLOlYyNr
         tCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327953; x=1773932753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lMO8ByhAJjZDznl2VKgDz1seDvubSt586JSGerTT4Zo=;
        b=fuCD+CX9EeAMigZbXknUvH+9u7/XC4qpDK5f2kMG+dSysM6voDJzn0Oto24dqemjsa
         59Z1A1yGnbjj9cXk/qhjdUCu88jBY0Yci0aeTvdE3vf4habx0J0kI6mWQIeUSKA2nmW2
         Lehw4S56GXgeK2XPpyOgQZYZPc/deU7EcaSyVSJMWPbjPWPfYfHMB7DCjh8TfOvUsvJE
         H+ki5ZIVsXknA9a0YZsyWBBo0wgHonhUP4820SB89oTxCDroPObWfbNn3ZThnZN9TmLx
         Bjtw0YOuWwvY7LkBuYIsuxxWtOaOtfd3qjERTWo4fSFYNlROq0sK7kYf5bXhlAZ/CmR2
         CFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7lk9TjtIowUjeiZ6UU0zrF+KZksfwymESgxPchKvSD8LJmqOBKynrP3hqfzU24xcqOkMzCs3GWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9AjqrWGX4eBDa6HmqCibgAwkdhv444wTFQrGfiKMNjKgsfD5
	qouGC2DphPxZO66CBb1kHPy2jdZ4EArXCvFxoK06aCGPCQpw20AiXJWQvMK7VJf/Y2c=
X-Gm-Gg: ATEYQzya9lPes+uCb/OPR3JgksNdpwFOks25Nw+hiQ+WRbet40D0bGmBgBJ3tMTRAlJ
	YTMLhUyvbjwKzmUQ6Ph1UvnTgFFKzTlc+Rno0W6FALVu1RRBqpRuqmxl4VBubi6VQmb6p+GWxQv
	pzH4gQTh0D1/ihxnno6+MzAaao6XioA/YfY0rc0z6c0FeXI6hoCQ34ILy0B+EntX1Y5Pev/t5FA
	Tm9bWtfhdDZiSorst/sn3b7p7PufcOCkDAvW3AwywoG4Rd5fAQqKsgm8ejfgCn5eo8Aj6Hiu+dZ
	0UbzYz6IzP1a/LCJ0yRsPk21mTk21V/zK8Z9IogKbKwI+QuE7oRsbSB/bt2DijAjzkOx0gZxIzh
	xugkTY4qDhyhZkFolUTOb+/35Gr8ORL69zV3c5f4pu/CWFnZkCV1TrFN2c9pKRC9XpxmsSPGiBa
	8zFy5H/rrWq5n++a+m4RIAF03gHKFkpHepzPM6WVJKEUYUH3FYiI8XwIkkQu2bUkEK+yxURSoSs
	nVf
X-Received: by 2002:a05:6830:63ca:b0:7d7:5bb2:568d with SMTP id 46e09a7af769-7d76a7dbfd1mr4441780a34.28.1773327953165;
        Thu, 12 Mar 2026 08:05:53 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:52 -0700 (PDT)
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
Subject: [PATCH 06/15] cpufreq: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:01 -0400
Message-ID: <20260312150523.2054552-7-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
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
index 5aa9fcd80cf51..3fa40a32ef6b5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_invoke_amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -298,7 +298,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_invoke_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -343,7 +343,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_invoke_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -507,7 +507,7 @@ static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_invoke_amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -588,7 +588,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	}
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
-		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
+		trace_invoke_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
 				cpudata->cpu, fast_switch);
 	}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913c..cf57aeb503790 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	if (trace_cpu_frequency_enabled()) {
 		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(freq, cpu);
+			trace_invoke_cpu_frequency(freq, cpu);
 	}
 
 	return freq;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 11c58af419006..a0da9b31c4ffe 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, in
 		return;
 
 	sample = &cpu->sample;
-	trace_pstate_sample(trace_type,
+	trace_invoke_pstate_sample(trace_type,
 		0,
 		old_pstate,
 		cpu->pstate.current_pstate,
-- 
2.53.0

