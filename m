Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559496;
	b=vY+xXh15RCZbP/gye8tE/PMZ28HudajH8SkDhn9t5qW+3y+jmdrDOh1EJ+mUuFKOb10a
	 M2SNCeBsM6Z1R/vMpnLZyJSmsjv1rNmJREmoN8dVkUuahwNYJhEpE5N4DZa1JRPeAUBmG
	 oIb+Byeb790dGQpH8ySMpF4Npm1q3tilPNgn2+CrppnnvS8SDpWhKBGZsb6MjAY7xzq15
	 Hzyjc4OFSlIGfeeMf8SSThfPgFXWCBFYlicCfRFp4zvrQ0oIUBFbgSlzSQWVwo25DmBQK
	 5dPwHIwixfSkvTovrIk4UjK5Itt6HXitS3e8KQLrG0tkZRoUELYcsB6SezQx/JVjPnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559496;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=ptw+MuKIB/nDKNuKuc8q9Chj/1S3rLY9q3tb7HiLDxM=;
	b=mwJtIyF0ppORVNaH1BhT5ZjiXnvJQ2g+OWvJwvTWM441bjlazQ/ubK6GckTKkzCI/M9j
	 a2B0exlkJna7w5QW3YLqDaf9QJshcs+rkYQADzSz+Aoc6fvKZ1olR/LBlgW1RGU2ev48d
	 K8xkx6juOuNE05Q1gC1hH4HDm2Pk1YIj/PVl4GNtE4fzJoAGCq5lsSU2alcVXeOi5QHfK
	 8KIy6uVGGcI1+mVpqK2UkWbv93HVnvhOiBM67INl/IgBnldgpu9k06OFA5q0lk4R2SN3R
	 z/suEVYUqsO1s2IfnhEtSR+qKIHe4e8509x0dqobw0fDXcTZFrbZgdk5s5x0wdHkvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=G1kYf7WO;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98D606A325;
	Sun,  1 Nov 2026 18:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E98D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=G1kYf7WO
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jHkch6h4SzKp9t;
	Sun, 01 Nov 2026 19:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793559492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptw+MuKIB/nDKNuKuc8q9Chj/1S3rLY9q3tb7HiLDxM=;
	b=G1kYf7WONy4WGNc1L+iXOuj4ZvU12x9SR3+jVRfniJKg6X5HwDpSt+NastzfDwdxrKZkLL
	ArM2WqcYg2RwhUOzraq1JfJWC6/HnIxEuxrNM35TAG3QQIPd8n7y+vQM2slbFiXrYdMhxF
	cIQ8O1AzAOozMZZlCkuJgpfXj1fB9wcnMp708Z7jEnf+IUIpq4vq9Ra0k9pEk2k752kg+y
	KLwK4GwFE2+YYpm3vXMcGGBPbYPZvWtV/293hmAH6+1uETHKNEE/+87sCEjbOfooYGIPtg
	7xa7BNyAmcj/Kpbedd21I13sbtY46B1U8WCGFcVNdqilXiRE0GYrU/AxtCikWA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] cpufreq: intel_pstate: Send CPUFREQ_UPDATE_CPUINFO on max_freq changes
Date: Sun,  1 Nov 2026 18:58:05 +0000
Message-ID: <20261101185807.112449-3-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101185807.112449-1-hugo@hsal.es>
References: <20261101185807.112449-1-hugo@hsal.es>
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
X-Rspamd-Queue-Id: 4jHkch6h4SzKp9t

intel_pstate has no ->set_boost() callback. It changes
policy->cpuinfo.max_freq in __intel_pstate_update_max_freq() when
no_turbo is written and when the HWP capabilities change, so
policy_set_boost() never sends CPUFREQ_UPDATE_CPUINFO for it

Send the event from there when the value changes, before the policy
limits are refreshed

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/cpufreq/intel_pstate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e6ae4cdda5de..f9e356409f199 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1429,13 +1429,19 @@ static void intel_pstate_update_policies(void)
 static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
 					   struct cpudata *cpudata)
 {
+	unsigned int max_freq;
+
 	guard(cpufreq_policy_write)(policy);
 
 	if (hwp_active)
 		intel_pstate_get_hwp_cap(cpudata);
 
-	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
-			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+	max_freq = READ_ONCE(global.no_turbo) ?
+		   cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+	if (policy->cpuinfo.max_freq != max_freq) {
+		policy->cpuinfo.max_freq = max_freq;
+		cpufreq_notify_cpuinfo_update(policy);
+	}
 
 	refresh_frequency_limits(policy);
 }
-- 
2.56.0

