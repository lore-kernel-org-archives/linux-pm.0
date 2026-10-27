Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111940;
	b=lYHu6YULtvlqbGArf0UEqsfgSgF+dhtLK0xY6KkVIJOs9ux0sJnAG+z1DS2BiUzthZdu
	 AHK8brBo/IqANqTGjlp/9ArVnkhfkABB6zgt1/jW61CY3zJ+YntLCNOXhX9mLYJj5rh3s
	 Q1pYnygo9l+keLWIPFQbN7H3/7/mXrDYbZaRbXLv08pmz7M+QFdoHgVrK04NtignT24WR
	 zzkrtQNv6X32DikIW2oBInlFUuy9iM5UKJ55lD780W+IS6aFAQiFvR8xFVwskXF10zwSN
	 GBNv8kZWcZh7uXH6vSdf7VyzLaDBwyxhxva8Vw4IfTR8TpQeKnQ0TwhAssxpbzqaijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
	b=VtSJ2fLk2tndxZRqYjyBB15+mj/amyfVo9iI72Dg+yWwJsl+GtqZ/S2POoCgX952Gwc4
	 ixK2ZyWvxaDFvMPTqbTwOIuXlhA7aKMJL6/3NUdHLV+7FssuEGBULI9lh3HIMTnjtCwHj
	 KXfxu1GUnpcXwwWdsxKh0rvM+ZMCHrQv7COi/gyZKNmxnEMB4zbx2i/x3wVaSN8CwVFvj
	 1wrOEfMaquoLkhUbJuT+dXpaH4znZfKTMUw9KW2rINtOcnF79DdwJuvDaBHZUe0HiqsMW
	 VgR4ORxMO4FMAV5dpy2pMW16Zjklj+DOYXrUMwdyfHk7wRTrd4CSDhmCKFA4Y57C58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jpnsjCn/";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFF606A321
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 14:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BFF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpnsjCn/
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so10723705e9.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111939; x=1793716739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
        b=jpnsjCn/z+orT58mKBtY8wQ/lzKmnn0U3m3etjjp5y+kmhxLw+s46PTbFKdHUXvYRO
         gtszKA9O+1Vauw8sqVHWQakwSaeroRp4he016MCqoheUO1c2v8yssAstYIB0DVsl+ESA
         FmpGYMPhHWm7DrhppfWdf6qQ/rLyYegQVtthweWFnS6vrJGClQD6hNE3tgZVLkKo0Y3x
         f4BjPj/r+e987cfazpgYNaMGg9KCGZCV7kL3pgnosZzJd1L/xF2I/Lk/3/7FIQ4PTg4S
         g7ANRX1pZgEthQ5T+Bo+lYUwJjL87YgkwnVGewp4sUK9lU1su0bwDRYRgMy+lxRxpSKi
         MpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111939; x=1793716739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Ltbz60b+IHvyoCek9XEc1bssVVFscuvuXVkPxdZ7Yw=;
        b=c5ym6CjErYvGwLGtGPNjio+KCsz1uFQ63pHf40uk0I9QnVyDdTpLmpUclsC4cpJMWh
         bb8OTcWqa56jOn0ZRKVWUiAeBEEmsyLu7jFmMVo1o1HTJbXJyg7CC6HNpkMzF1Kl5RLl
         1/2JEXaSo/Mh4/S0bLgDfG1tOVHK68R+lOgxpLYafOZvXA/zoaCf1S5tzU4f+CSygOYI
         0jydPimm/hIl55Gt8j+T0G6d9V38sgUHzRAhG9kRlAhbSBLCnR8QQ7ieN6FsXWHkHJcB
         mqj8XQLnqdhAdmbR+4gi57oq4bRZVwBMxpDCbNhMykcUT5inz8WOMF4aUNTGqs8bjCu7
         lowQ==
X-Gm-Message-State: AFq9FYJDv4+muYOlCq0WJB+JvWUyFp6DTXKC6cJvLsma9iQ8Zrj1pEnf
	wTnbKxkzWjOnktco8CzAYPtF6ugin1HanDhxpzj9lcuZaZT8COma6Yd+3gq1agREnng=
X-Gm-Gg: AYBFou0g3Tc3+ttJreawUO+2jJNVwCrQBj4HnmvafhjSzxZnGb9c5yiLkgm6Gkk/GfP
	BCi+LDsD4WNP4CdeI9sWXtAjUQ6D+tKxgMuVt4CigXb7U5GwXwIKZnrbbd6juZjGNMAJ+gMyzQ8
	t6NGILMloMVR9Hq6jExgUW39Zvb58QeCet5i7sVe0jBlvj+HtJfbW6kFySCyFTxKU6NPlAuOxcN
	fVcmDP2QPfGPFbsPlfJcwqe1NoV2NTp99XImeu64aXzAr/mtEwi7D3oGemPGd2iJdPrAh/kcq5y
	x1ib52QAZuLwmKfHQ2kJYm+0tQB+VjB1tt3OFDc5J7wpE5JCy4Mgjfh4IhgoqPD7SaV6lSFbsdr
	e6cMac/5gXtDucqgspWYlSjPKSBWfgeOr/G52NG/Fw6zM1dkd/dxOYyAibPesdg5EP3a+6A1sGl
	TtjbsQOl2fFW7HHg97tlMYd8byESIKFNnVSjQ669ZhmQsjVdn3Ow72vzZTz8sI6sOFsMlbA88Zi
	rCbs38juAOs9FvoMkVo/8oYEOL1w1dEg4Q6DXd3p5N6j9NSjwgtK91aIfwTZiBTI+7oK+t0MUr1
	MKIrIHbeb00=
X-Received: by 2002:a05:600c:3d08:b0:4a2:1960:6fa with SMTP id 5b1f17b1804b1-4a7bfec49damr64723785e9.4.1793111937376;
        Tue, 27 Oct 2026 07:38:57 -0700 (PDT)
Received: from gandalf.magpie-herring.ts.net ([90.251.75.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm279495975e9.2.2026.10.27.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:38:56 -0700 (PDT)
From: Zak <zakbrightonknight@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Tue, 27 Oct 2026 14:37:25 +0000
Message-ID: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Zak Brighton Knight <zakbrightonknight@gmail.com>

On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
the CPUs stop using turbo after every suspend to RAM when intel_pstate
is in passive mode with the performance governor: they stay at the
2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
policy limits change or the system is rebooted.

During resume, the firmware sets each CPU's P-state request register,
MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
the requested turbo ratio (38) again.  Without hardware-managed
P-states (HWP), intel_pstate caches the last P-state it wrote and
skips writes that would not change it.  In passive mode the cpufreq
core also skips requests for the frequency it believes is already set
(policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
only with HWP.  Neither cached value is updated across suspend and
resume, so as long as the governor keeps requesting the same P-state,
as the performance governor always does, the register is never
rewritten.  Governors that change the request often, such as
schedutil, mostly hide the problem.

Fix this by writing the cached P-state back to the register in
intel_pstate_resume() when HWP is not used, as is already done for
the HWP request when it is.

The problem was found and root-caused, and this patch was drafted, with
the help of an AI coding assistant (Claude, by Anthropic) during a
performance review of the machine described above.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Cc: stable@vger.kernel.org
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
with v7.3 plus this patch and a temporary module parameter, not part
of this patch, to turn the fix off.  intel_pstate.c is the same in
v7.3 and in the base commit below.

Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
"Request" is the P-state read back from PERF_CTL on all eight CPUs
5 and 17 seconds after resume; "clock" is the measured speed of a
single-threaded busy loop.  Before every suspend, all CPUs requested
38 and the clock was about 3.8 GHz.

  mode     governor     fix  request after resume  clock
  passive  performance  on   38 on all CPUs        3.8 GHz
  passive  performance  off  28 on all CPUs        2.8 GHz
  active   performance  off  38 on all CPUs        3.8 GHz
  active   performance  on   38 on all CPUs        3.8 GHz

The passive-mode failure was also reproduced twice on Fedora's 7.2.11
kernel.  In active mode the request was back at 38 after resume even
without the fix, so on this machine the fix only makes a difference in
passive mode, the default without HWP.

Not tested: systems with HWP (their code path is unchanged, only
restructured), other machines and firmware, and suspend-to-idle.  The
patch adds no warnings with W=1; sparse was not run.  The tests were
scripted and run by the same AI assistant.

 drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb..53db91a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
 }
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
 
 static void intel_pstate_hwp_reenable(struct cpudata *cpu)
 {
@@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
 	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
 		set_power_ctl_ee_state(false);
 
-	if (cpu->suspended && hwp_active) {
+	if (cpu->suspended) {
 		mutex_lock(&intel_pstate_limits_lock);
 
-		/* Re-enable HWP, because "online" has not done that. */
-		intel_pstate_hwp_reenable(cpu);
+		if (hwp_active) {
+			/* Re-enable HWP, because "online" has not done that. */
+			intel_pstate_hwp_reenable(cpu);
+		} else {
+			/*
+			 * PERF_CTL may have been changed by the platform
+			 * firmware, but it is only written when the requested
+			 * P-state changes, so restore it explicitly.
+			 */
+			intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate);
+		}
 
 		mutex_unlock(&intel_pstate_limits_lock);
 	}

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.56.0

