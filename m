Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25E3D567F;
	Fri,  9 Oct 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534594; cv=none; b=eAo+kfTNqz79Um2iSJX7+LhYelJfH8Bp6dLumAwXqVMOYnypvc1tD0BZ/SSkTRAYf9pTtlwRBewByXo3xlGQIIDmOVbmR/F7SAkWiIIwDTQLhYgxUoHE+3xI5ICutjeUWyD2q9YN2WmoqJ5CLoV8O3fZWzc6aIEXeBq6UODf9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534594; c=relaxed/simple;
	bh=J91+lpe3p8vIaZNTRS0qt7fvQOznS3JG+eN2p7pKkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2HhW5uGZVY8XttShX6V62aJepsYE7qPlwHDcoENFB9a/JeMi+Lr9yBhp3R5gqnDA05OOdO6+Je/7mKLIhWyostrfldHQtCxYnfOURVr3PEhn9cPiiwm8ysBSc2tCs0R2Br4b0wsOG+SrJtKJd7Q9GYfCFwhKDpjbOC2S+kipf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BB981F790;
	Fri,  9 Oct 2026 08:29:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8B701326D;
	Fri,  9 Oct 2026 08:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1nvmIP6lyGoJGwAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Fri, 09 Oct 2026 08:29:50 +0000
From: Giovanni Gherdovich <ggherdovich@suse.cz>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] cpufreq: Don't track pressure if policy->max equals top of freq_table
Date: Fri,  9 Oct 2026 10:29:28 +0200
Message-ID: <20261009082928.21847-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]

The acpi-cpufreq driver stores non-boost frequencies in
policy->freq_table, but policy->cpuinfo.max_freq contains the max
boost frequency.

policy->max is constrained to be, at most, the largest value in
freq_table. This means that under nominal conditions, policy->max is
substantially lower than policy->cpuinfo.max_freq, resulting in large
values of cpufreq_pressure, on all CPUs, for no reason.
The result is large performance regressions on compute/memory intensive
benchmarks that use a limited number of CPUs; tasks migrate more and
lose locality. My tests are with the "NAS Parallel Benchmarks" suite,
limiting to 1/4 of available CPUs.

This change sets cpufreq_pressure to zero if policy->max is equal
(or above) the maximum frequency in freq_table.

Here a concrete example from a 1st generation AMD EPYC (Naples) using
acpi-cpufreq. Under nominal conditions (no capping, no throttling):

freq_table               : 1200 MHz, 1700 MHz, 2200 MHz
policy->max              : 2200 MHz (maximum from freq_table)
policy->cpuinfo.max_freq : 3200 MHz (max boost)

Before this change, in the example above we'd get a cpufreq_pressure
value of 320 (32% pressure); with the change, the pressure is zero as
it's expected to be.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
Clarifying the recipients list, beyond the cpufreq maintainers:

Mario Limonciello, Huang Rui: the patch isn't for amd-pstate, but
   AMD EPYC up to Genoa (Zen4) defaults to acpi-cpufreq, so they may come
   across this if they haven't already.
Vincent Guittot: for the cpufreq_pressure and scheduler load balancer
   implications.
Ricardo Neri: he's been looking at cpufreq_pressure on x86, albeit
   this patch isn't for intel_pstate.
Pierre Gondois: he looked at policy->max in freq_table.c earlier this year.

 drivers/cpufreq/cpufreq.c    | 3 +++
 drivers/cpufreq/freq_table.c | 1 +
 include/linux/cpufreq.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..aa652750f711 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2601,6 +2601,9 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 	 */
 	if (max_freq <= capped_freq) {
 		pressure = 0;
+	} else if (policy->freq_table && policy->max_table_freq &&
+		   policy->max_table_freq <= capped_freq) {
+		pressure = 0;
 	} else {
 		max_capacity = arch_scale_cpu_capacity(cpu);
 		pressure = max_capacity -
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ea994647abc8..55c3293685c2 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -50,6 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.min_freq = min_freq;
+	policy->max_table_freq = max_freq;
 	/*
 	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
 	 * it as is.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..4a3316e47f4e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -67,6 +67,7 @@ struct cpufreq_policy {
 	unsigned int		max;    /* in kHz */
 	unsigned int		cur;    /* in kHz, only needed if cpufreq
 					 * governors are used */
+	unsigned int		max_table_freq; /* max freq in the table */
 	unsigned int		suspend_freq; /* freq to set during suspend */
 
 	unsigned int		policy; /* see above */
-- 
2.43.0

