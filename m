Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180882;
	b=Q8oPlqURAmMWXBVpoz4LBZe/oUIo/AcyT00W4NCFTcQkqxM7Ck5fpIFfVaYuPA+KIZv3
	 9Y6ajv22jN+tQRedutUKH8IV+N7aSj/iQSyP+couCpMNqNn0qloLFBi77SWofE1GmIG0T
	 BPqIqYJ/YZelBZuCngYcGEySYP1jr+8ANF5pKoaC9UjsvaNiocC+s1NArWZvvekzWkeBJ
	 7wGwFYviQzoG6Zz1QkSZbm/AXG+EQnviaC1w1ECzjTIbv8yKhXTelyd02n7czQUgRn2pt
	 DsHkjvogKURRURy6hQeAyWUA8NrEZNIoMhPg/zxjLhMZ1O3a4qO6iB0YL8sUo8y+b/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
	b=McMhqFv09Pg8pTw/oAwF0aNlkPkCCXQX2PSBTbwK+aMij6IdL3QfDhqJ2ZhdUNR0hDQ5
	 6CbwZ/Y1A5XJ2kD/eKPQXJ/NwAXV0fn/G6w6NreMm0xbGHtysgodUhx8e3XJYinchiHRH
	 BQcIxM+hToypzFr5fpJRIEnXiCIgqJNdbASxnbCIGruivviCg3k2SxHxqbG1IbWoZyuI5
	 q2qPEm5OncDLci87akHK3o5p7P2gN1qMGip3c2w/IxmQ3Eob9SGLuFhzhS+97YlMB0lj5
	 H95XykSlBoK8s5L955UQplBCFuYFnBRaiv2gWzQDbZlPExHmYjwTBrrALiMoiVpdS2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SS536KN/";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49819606A31C
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49819606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SS536KN/
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so5843195e9.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
        b=SS536KN/FNb5ZcLsLsAYO46h/5MEOlP+vGqlqfGkkILFUt+I4S7V9CFmqXZF8Jf/4v
         JvOgGdgHX8kN0hPDIvDCbYR2Gv+V22vOuKrhezQQqWxTveWH1fOY3XdGaEH/PZlebHP8
         yb8TMuHEN+DBGkOWtVvqCc4SclYN6wEjUh0WE8WyavAPdJMvgwlmcmoK7ZNKUDnV6Q2y
         4hWdCi3ItZN5RJBEXjP/BgkmHI/a/J5nclWfU8V76GCE1KtEh3ns116DvOnStV3t9Yvc
         L7rWbxYybvUByz/fEzvWlKjprfc6u5ulkeTKtXKIUUQPf1xiTh3R04s1mhzjq2tQ6GK6
         6Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180881; x=1793785681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
        b=QRofrvW4DBSP07zz29jL4VTmLeN6/MCU/DOxqmO9bD4qGuPnDCB5WAjqIPgq9sGVhh
         42nqmMOrWde/qXQu9Rvlp9YflSJyamjCWJJtVk8lAscpzxVbi1xbwn9R1h5G/PAhidkA
         BsL92EX5NjvOgxpGH7qxgIQMY0hfwTZq5z8K6/Fym9apqYt7kHyPnDQE2i9CnDkKHKGI
         JavN9L8l06oUB8WMmZHySHtcPs2zSlAPh9dHs2D05UBbjxmNqLRFoWB4+qx8qfY8m29S
         U+c6zsS1riHt98z9QZTp3bOYgY3yOxSNAmhMfDdKsNMdtzCun1d0nw/pEKppCb/szYhJ
         ONiQ==
X-Gm-Message-State: AFq9FYLRMEGFcCLlkqh+OhzbE7784tErdkSDm9nZvTZ0mJ+Ct+FTUY/v
	XpSPQPsoRuKUgJsFr8pASsZkAaCzmjQIaeSSsggcH0C0GcBCDsiITCvlQjXG2VK/+44=
X-Gm-Gg: AYBFou3SFJlP/2rF3A+ZmKk0qNtUllVqBhayjQCoi/0xo78JcZBFnxYIji7hT4HHPAc
	Z8xKWgN8DnFGmEcU1ZX4NNeeUaZVK02dslpw6CPPc1QMxeJm52FHl6Ac68DZ0FJjrueORti0qET
	PCAiwOgc5oHsxb18oL/H4Pti38sQsGMGSFEp7oYDQ2l2mFBpcN074X5ZmfFwW1kPr6yF1cEeBQZ
	b8eiOtY9rBR0ZZox5/A/vaSiUkc37ZIUQe9miv8JfzytmM+PrU4yY03jY4Vc+/xJfocHurdmshw
	yvW4lKLolj2j+xD5YRnLXqhZEpnOQmbv+5tVMjX/yBiSM5ynAOQwtMByybcc2rHAv2r/I35+iO+
	hTU95eSeUf5/k/HaO7W2XVBYAp5gT34qcr0n6M7o1vlbmZMh0c6B6cT9i1jfjgYDRUFg5dnW0U/
	DmfdSZcH1MK4lffJ1nW7vKcrQUNYR+PJwMyyTrEx9qGRLsfl/eaC824k8/dgYGaB3CpTiXYxTIz
	9jtNnyZp8fO0HcQDhwOFI0DOgxnFBKoqeWCv0l+bEBJPcWx4jAI7BMSYNbaKis1t2AYNUI/WHKt
	E9mlgp+DVbRSnss+TNHspdx96UaP2LVFLylFIfOZN0sIzTYevLXjFEnSDvKeNc6hdfK9pnuX0Q7
	ItgLBfg==
X-Received: by 2002:a05:600c:8b63:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4a961892781mr34341255e9.0.1793180880339;
        Wed, 28 Oct 2026 02:48:00 -0700 (PDT)
Received: from gandalf.magpie-herring.ts.net ([90.251.75.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd35c2sm26957431f8f.39.2026.10.28.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:47:59 -0700 (PDT)
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	linux-kernel@vger.kernel.org,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Wed, 28 Oct 2026 09:46:59 +0000
Message-ID: <20261028094659.2321491-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
References: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
the CPUs stop using turbo after every suspend to RAM when intel_pstate
is in passive mode with the performance governor: they stay at the
2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
policy limits change or the system is rebooted.

During resume, the platform firmware sets each CPU's P-state request
register, MSR_IA32_PERF_CTL, to the base ratio (28).  Without
hardware-managed P-states (HWP), nothing in the passive mode writes it
again afterwards:

 - When the nonboot CPUs go offline during suspend,
   intel_cpufreq_cpu_offline() bails out because cpu->suspended is
   set, so the cached P-state (cpu->pstate.current_pstate) and
   policy->cur keep the values from before suspend.

 - When they come back online, cpufreq_set_policy() does not start the
   governor, because cpufreq_suspended is still set at that point.

 - cpufreq_resume() then calls intel_pstate_resume(), which does not
   touch the register without HWP, and starts the governor.  The
   performance governor asks for policy->max, which is equal to
   policy->cur, so __cpufreq_driver_target() returns without calling
   the driver.  Even if it did, intel_cpufreq_update_pstate() would
   skip the write, because the requested P-state matches the cached
   one.

Governors that change the request often, like schedutil, write the
register again shortly after resume, so they mostly hide the problem.
In the active mode, intel_pstate_set_policy() writes the register for
the nonboot CPUs when they come back online.

Fix this by adding a ->resume() callback to intel_cpufreq that writes
the cached P-state back to the register when HWP is not used, before
calling intel_pstate_resume().  The governor of the policy is not
running at that point, and the write is done under the policy rwsem,
so it cannot race with updates of the policy limits either.

The problem was found and root-caused, and this patch was drafted, with
the help of an AI coding assistant (Claude, by Anthropic) during a
performance review of the machine described above.

Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Changes in v2:
- Only restore the request in the passive mode, from a new ->resume()
  callback of intel_cpufreq, and do it there unconditionally, as
  suggested by Rafael.  v1 did it in intel_pstate_resume() for both
  modes, where it could race with the active-mode util update hook, as
  reported by Sashiko.
- Hold the policy rwsem around the write.  The governor of the policy
  is stopped at that point, but cpufreq_resume() has already cleared
  cpufreq_suspended, so a policy->update work item (handle_update() ->
  refresh_frequency_limits() -> cpufreq_set_policy() ->
  cpufreq_governor_limits() -> ->limits()) can still get to
  intel_cpufreq_target() for the same CPU, for example after a limit
  change during resume, and its write could then be overwritten with
  the stale request.  This is the second case in Sashiko's report;
  please drop the lock if that cannot happen there.
- Describe the suspend/resume flow in the changelog, based on Rafael's
  explanation.  When the nonboot CPUs come back online during resume,
  cpufreq_init_governor() and cpufreq_start_governor() return early
  because cpufreq_suspended is still set, so the request is only
  dropped later, by the target_freq == policy->cur check in
  __cpufreq_driver_target() (see the debug messages below).
- Fixes: 4adcf2e5829f, after which the nonboot CPUs no longer go
  through ->init on online.  Before it, intel_cpufreq_cpu_init() reset
  PERF_CTL and policy->cur to the minimum when they came back, so the
  request after resume was written.

v1: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/

Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
with v7.3 plus this patch and a temporary module parameter, not part
of this patch, to turn the new write off, built with PROVE_LOCKING.
intel_pstate.c and the cpufreq core functions involved are the same
in v7.3 and in the base commit below.  Passive mode, performance
governor, one suspend to RAM and resume per row (rtcwake -m mem
-s 25), PERF_CTL read on all eight CPUs:

  fix  before resume   5 and 17 s after resume   single-thread clock
  off  38 on all       28 on all                 2.8 GHz
  on   28 on all       38 on all                 3.8 GHz
  on   38 on all       38 on all                 3.8 GHz

The second row started from the state the first one left: the restore
writes the cached request, which was still 38.  No lockdep reports,
and debug_locks was still 1 after the three cycles.

With dynamic debug enabled for cpufreq.c, cpufreq_performance.c and
intel_pstate.c, the online part of resume logged "governor switch" and
"governor change" for CPUs 1-7, but no cpufreq_init_governor() or
cpufreq_start_governor() messages and no frequency requests.  After
"Resuming Governors", every CPU logged cpufreq_start_governor(),
"setting to 3800000 kHz" and "CPU n: cur 3800000 kHz -> target
3800000 kHz", and there were no transition notifications at all, so
intel_cpufreq_target() was not called during resume.

In v1's testing, the active mode was back at 38 on all CPUs after
resume on this machine even without a restore.  Doug Smythies saw the
same on an i5-10600K with HWP disabled (passive mode affected, active
mode fine) and tested v1 there; v2 has not been tested on that
machine yet.  sparse was not run.
The tests were scripted and run by the same AI assistant.

 drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb..67a3015 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3408,6 +3408,27 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int intel_cpufreq_resume(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	/*
+	 * Without HWP, PERF_CTL is only written when the requested P-state
+	 * changes, but the platform firmware may have changed it during
+	 * resume, so write the last request back.  The governor is not
+	 * running yet, and holding the policy rwsem serializes this with
+	 * updates of the policy limits.
+	 */
+	if (!hwp_active && cpu->suspended) {
+		guard(cpufreq_policy_write)(policy);
+
+		intel_cpufreq_perf_ctl_update(cpu, cpu->pstate.current_pstate,
+					      false);
+	}
+
+	return intel_pstate_resume(policy);
+}
+
 static struct cpufreq_driver intel_cpufreq = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_cpufreq_verify_policy,
@@ -3418,7 +3439,7 @@ static struct cpufreq_driver intel_cpufreq = {
 	.offline	= intel_cpufreq_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.suspend	= intel_cpufreq_suspend,
-	.resume		= intel_pstate_resume,
+	.resume		= intel_cpufreq_resume,
 	.update_limits	= intel_pstate_update_limits,
 	.scale_freq_ref = intel_pstate_scale_freq_ref,
 	.name		= "intel_cpufreq",

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.56.0

