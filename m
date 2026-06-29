Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D33F54BB
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722162; cv=none; b=j6kebGi7NdyjHBwf28SZOXJhhxptNHBeqN4iyCZB/L4Zv92zDJD9ebC5Uh1DqevPuIrytNK1/0Wayt740kz40auuYUFXg9HOGQO9qIaeX6VR03ksa9fWsyVjGexBHfhPRCtVdVrnlbD6DqeknLqKWnnsWF25owsO07WPx+Ny1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722162; c=relaxed/simple;
	bh=D/jkgR4QXNxQDk+Ho/BN3hqOkJbsyn9lYgjtOPBi/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H05U0nvv2A7M/6lNB5QcKYnoph2pVdQ1aljcRXmuQeDFFcsvwuuiiwKSvsCU/nFag38qodgkVlI8PKQNglQzn3s5yKfaGkMbD2JuPWE8to/oyJqeMzraKUcOeRNyjnaTZAREZxl47B/NvwqUQK4BM/rULbhqBPTXFMVl+UOcVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnwZGyQP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnwZGyQP"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30e7eb50b83so1627641eec.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782722160; x=1783326960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWp1VWWw9zueZ4k+oQ3Wcp5KSo43CPvtGJhU4FTiZY=;
        b=qnwZGyQP+hZVwxBpQL0cqOPuWq/V9EJfzqMHUjLGmqZWmeUw/tLvaPxtnBzgl5RtyI
         Kd5lGV0NO1Rd1FQney6fFYHIhRVcFps2nMfMUlx+35UaMUmEqChj+igByiJTVoB37Uqt
         PrS9XFFkm3vfWcUTYaIZS60NcFg1R3aAHZ7R9RHKtBze/I199PpWDTtjY/WafUhs7tXv
         bQ+cC4YKlDsX7yiniFrM2y13AP+0jhmF9H/uSXS7dlrM5R+bcTeplv3NxbzFzP7AWVxG
         JrYsjikaAXJpZVpzgzNSSf73OU1tKOtgAJ2zgD3kCgUVYSchekPsdcw8zDxbQB96q3cn
         A+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782722160; x=1783326960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUWp1VWWw9zueZ4k+oQ3Wcp5KSo43CPvtGJhU4FTiZY=;
        b=RRI36XNFEUZjFyiVZjd21tBIzrY0T0MDMNhtytYJ9RGRJ2fwAyDteiDs53fYI7/ZMU
         uUstd/EwmuZuQ0FGk5/ztwwtP7Udq1GrZESj2CQcC7hWRuYFhFtSjHvoyEycy+IQnQN4
         EpeBK6qduHRrpYyoFF62owG6ggirWBgripIZ4Wb64AY4sX7c5CDeCIhfidrr8/kLBwK4
         5HbugwhVQL6TmpEzUW72UGkRR8rxudS4Ss4VDlxWTgsDIy2CnQPZvGuLotcGw0fzJBOj
         S0vszSaZxEJkL7PbybY6IUfyxb99izM2atIwODBV14S6kjXFqcvctE0//irmB17gocTD
         FlmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOqS6hYlIs1wPpMJOQ5VkfjNwQGei/ykF3FjstW7V9+YiG6jBUTqYbSNukSe7zuPlsab5G43Tl/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8Esx2Q4OyndNYFIWWY/xan2FrFUfmfhjNbiQAYvreS/2KwSu
	RX2QAfWR2J5/Rf1s9dxO99DeRCY0XGd1YkfI7vpmGJ/3uuTIcsHkwr3U
X-Gm-Gg: AfdE7cm+8Db8W0GzzXcPICir2OhgsJHNi73EbiRePM4FWXoZ/i+MWO1LTp4b/pqLFhk
	r+VyZ1c+qTUNj58KfF+KRzbAp3pTMYiXBjTsqMbhQvHxt/uh/9sqffrCpaFf8+qcPDgdVGKabHr
	kl7T1fujURdEUZawgK6mUGEldev3cWCoKfv3EJPaggmID3NhYW/EBTot8Oy3oGcH+hshF2B8uTb
	xc8FiwyJ2WksZWijJYAxbEMrIrS+/1ioC6/jTXyiE03QIwLbr9V8+DNqnQU1+uVJtNxdHOmXpTg
	nhP+Gd9gsTq8p+bambxP2qVToWpkXWa0DC0mAn080ZL7DYsb+mNMlZHoE1nyBNqoTI5w056/OpE
	QeXnvTPYbspFR5dj/UEVQPnq1lET6+hGxa3MzF9lWSQn/Zupv4Fx4P0Pbt19o4cOsuZ9lhvZA5K
	kpw0n3z8K4jhlmZs+9
X-Received: by 2002:a05:7301:6007:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-30c84d409dfmr14058054eec.26.1782722159974;
        Mon, 29 Jun 2026 01:35:59 -0700 (PDT)
Received: from lucas ([2804:29b8:5089:a52e:286c:f020:71b0:64f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e220bsm45902686eec.21.2026.06.29.01.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:35:59 -0700 (PDT)
From: =?UTF-8?q?Lucas=20de=20Lima=20N=C3=B3brega?= <lucaslnobrega38@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Lucas=20de=20Lima=20N=C3=B3brega?= <lucaslnobrega38@gmail.com>
Subject: [PATCH] sched/topology: Allow EAS without schedutil for artificial Energy Models
Date: Mon, 29 Jun 2026 05:35:42 -0300
Message-ID: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

EAS currently refuses to enable energy-aware scheduling on a root
domain unless schedutil is the active CPUFreq governor for all of its
CPUs (cpufreq_ready_for_eas()). This requirement exists to protect the
accuracy of the energy estimate: EAS predicts the OPP a CPU will run
at from its utilization, which is only meaningful if the active
governor actually requests OPPs that way, and schedutil is the only
one that does.

That requirement does not apply to artificial Energy Models
(EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
get_cost() callback instead of real power numbers, and only encodes a
cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
given utilization). It never claims to predict real energy use at any
specific OPP, so there is no per-OPP accuracy for the governor
requirement to protect, regardless of which governor is in control or
whether it tracks utilization at all.

intel_pstate registers exactly this kind of artificial EM for hybrid
(P/E-core) systems without SMT, regardless of whether it operates in
active or passive mode. In active mode it never uses schedutil, since
HWP picks frequency autonomously, so on these systems EAS never
engages even though SD_ASYM_CPUCAPACITY, frequency invariance and the
EM are all in place: find_energy_efficient_cpu() is never reached
because is_rd_overutilized() is hardcoded to true whenever
sched_energy_enabled() is false. cppc_cpufreq registers the same kind
of ranking-only artificial EM and is affected the same way with any
non-schedutil governor.

Allow EAS to be enabled when every CPU's EM in the root domain is
artificial, even when schedutil is not the active governor.

Tested on a Raptor Lake-P laptop with nosmt=force and intel_pstate in
active/HWP mode: find_energy_efficient_cpu() was never called before
this change (confirmed via the sched_overutilized_tp tracepoint and
ftrace) and is exercised as expected afterwards.

Signed-off-by: Lucas de Lima Nóbrega <lucaslnobrega38@gmail.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |  9 ++++--
 Documentation/scheduler/sched-energy.rst      |  7 ++++-
 kernel/sched/topology.c                       | 28 +++++++++++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 25fe5d88f..c8fef1e60 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -409,13 +409,16 @@ Energy-Aware Scheduling Support
 If ``CONFIG_ENERGY_MODEL`` has been set during kernel configuration and
 ``intel_pstate`` runs on a hybrid processor without SMT, in addition to enabling
 :ref:`CAS` it registers an Energy Model for the processor.  This allows the
-Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler if
-``schedutil`` is used as the  ``CPUFreq`` governor which requires ``intel_pstate``
-to operate in the :ref:`passive mode <passive_mode>`.
+Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler.
 
 The Energy Model registered by ``intel_pstate`` is artificial (that is, it is
 based on abstract cost values and it does not include any real power numbers)
 and it is relatively simple to avoid unnecessary computations in the scheduler.
+Because of that, EAS does not require ``schedutil`` to be used as the
+``CPUFreq`` governor in this case: the cost ranking it relies on does not
+depend on the governor tracking utilization when requesting frequencies, so
+EAS works the same way regardless of whether ``intel_pstate`` operates in the
+active or in the :ref:`passive mode <passive_mode>`.
 There is a performance domain in it for every CPU in the system and the cost
 values for these performance domains have been chosen so that running a task on
 a less performant (small) CPU appears to be always cheaper than running that
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 4e47aaf10..c23ca226d 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -379,7 +379,12 @@ Consequently, the only sane governor to use together with EAS is schedutil,
 because it is the only one providing some degree of consistency between
 frequency requests and energy predictions.
 
-Using EAS with any other governor than schedutil is not supported.
+Using EAS with any other governor than schedutil is not supported, unless the
+EM in use is artificial (see EM_PERF_DOMAIN_ARTIFICIAL).  An artificial EM only
+encodes a cost ranking between CPUs/OPPs instead of a real power table, so it
+does not make any claim about energy use at a specific OPP and its conclusions
+do not depend on the governor actually tracking utilization when requesting
+frequencies.
 
 
 6.5 Scale-invariant utilization signals
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5847b83d9..124a4bb4d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,6 +212,27 @@ static unsigned int sysctl_sched_energy_aware = 1;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;
 
+/*
+ * An artificial EM (see EM_PERF_DOMAIN_ARTIFICIAL) only encodes a cost
+ * ranking between CPUs and does not claim to predict energy use at any
+ * particular OPP.  Unlike a real power-based EM, its conclusions do not
+ * rely on the active governor tracking utilization when selecting
+ * frequencies, so the schedutil requirement below does not apply to it.
+ */
+static bool perf_domains_are_artificial(const struct cpumask *cpu_mask)
+{
+	int i;
+
+	for_each_cpu(i, cpu_mask) {
+		struct em_perf_domain *pd = em_cpu_get(i);
+
+		if (!pd || !em_is_artificial(pd))
+			return false;
+	}
+
+	return true;
+}
+
 static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 {
 	bool any_asym_capacity = false;
@@ -249,7 +270,8 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 		return false;
 	}
 
-	if (!cpufreq_ready_for_eas(cpu_mask)) {
+	if (!cpufreq_ready_for_eas(cpu_mask) &&
+	    !perf_domains_are_artificial(cpu_mask)) {
 		if (sched_debug()) {
 			pr_info("rd %*pbl: Checking EAS: cpufreq is not ready\n",
 				cpumask_pr_args(cpu_mask));
@@ -403,7 +425,9 @@ static void sched_energy_set(bool has_eas)
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. no SMT is detected.
- *    4. schedutil is driving the frequency of all CPUs of the rd;
+ *    4. schedutil is driving the frequency of all CPUs of the rd, or the EM
+ *       of all of them is artificial (i.e. a cost ranking rather than a
+ *       real power table, see EM_PERF_DOMAIN_ARTIFICIAL);
  *    5. frequency invariance support is present;
  */
 static bool build_perf_domains(const struct cpumask *cpu_map)
-- 
2.54.0

