Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A33324B20
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895868; cv=none; b=FRWSEIXTzF+peYcAdkcn+Bpzrf85v7GZJ1uYL5tHaB/QMOxU8wu09C0tPZwdJLKvqBW5TZWj1u0b4NxU3ao2F1kyN/RQxQDUvx64kO9MmXo1i4qCNXQJWJYBe73X/eqLuiC8JNaTy9haDvMIRciudNgQWTy2zaLTluSM+l/Ws+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895868; c=relaxed/simple;
	bh=vqTiocBonkBWL8ASCbljvA0u231zQ3DHaPsyfQbino0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjQVVXF0gfARTYI3Dam37phUPHnzoJzqQeQqeVd9TQyYXlOlCx6jp4TtRu9915mJzrmbH7WF3BO6vCm4sA4E4wH4DhWyKGalaeJxQV7d5SVgSab4ppNsdxM0RV67gbddSr2mbeMh0Q82kL4AzAT4BF27TiE1p97c09HlDtEs0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vYMiHMwM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gt0EqDBj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vYMiHMwM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gt0EqDBj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D32C6B5C9;
	Mon,  8 Jun 2026 05:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Uy+6faj0/F/X5rjzint+FLhrxLd8I//FthGmjDkjoew=;
	b=vYMiHMwMTBXFb/sW49zCsJTPzSZk9fTDS+skHO2/1HtWnWRAVhQC8Kd4ZHMSuZzBxQpZvH
	csKtqhPOMsKQaA6neMYLphcJt8PJk3vL4TRSX7r8cEpcVebZd3tsFokGbIf5B7+iCNJRRs
	4Cv0b4bB+tgXr1v+tOz0a3xxYNUah3Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gt0EqDBj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Uy+6faj0/F/X5rjzint+FLhrxLd8I//FthGmjDkjoew=;
	b=Gt0EqDBj6Sj/cT65f0e0sayMAb9RZXZIe0K+1Q9KM0FcR31gCd+YySNLtFKWPONryzvlia
	xrQb8qETMP8oMDEUbsWHZwG7JsC/MQeze6zcfgTUJtslV7DQJZLtzamSSUB1M2o5Niypys
	XyMQXLv3bN9z8nhYxoqi4ZjenPLkYV0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7597D779A7;
	Mon,  8 Jun 2026 05:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ljMeG3dQJmo6dQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 05:17:43 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v3 00/11] x86/msr: Drop 32-bit variants of *_on_cpu() MSR functions
Date: Mon,  8 Jun 2026 07:17:30 +0200
Message-ID: <20260608051741.3207435-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2D32C6B5C9
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Drop the variants using 2 32-bit values instead of a single 64-bit one
of the *_on_cpu() MSR access functions.

Changes in V2:
- patches 1+2 split out from other patch
- keep the *q() variants instead of those without suffix

Changes in V3:
- V3 patch 7 split out from V2 patch 7

Juergen Gross (11):
  x86/msr: Switch rdmsrl_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Remove rdmsrl_on_cpu()
  x86/msr: Switch rdmsr_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Remove rdmsr_on_cpu()
  x86/msr: Switch wrmsr_on_cpu() users to wrmsrq_on_cpu()
  x86/msr: Remove wrmsr_on_cpu()
  x86/msr: Don't use rdmsr_safe_on_cpu() in rdmsrq_safe_on_cpu()
  x86/msr: Switch rdmsr_safe_on_cpu() users to rdmsrq_safe_on_cpu()
  x86/msr: Remove rdmsr_safe_on_cpu()
  x86/msr: Switch wrmsr_safe_on_cpu() users to wrmsrq_safe_on_cpu()
  x86/msr: Remove wrmsr_safe_on_cpu()

 arch/x86/events/intel/ds.c                   | 11 +--
 arch/x86/include/asm/msr.h                   | 28 +-----
 arch/x86/kernel/cpu/mce/amd.c                |  6 +-
 arch/x86/kernel/cpu/mce/inject.c             |  8 +-
 arch/x86/kernel/msr.c                        |  8 +-
 arch/x86/lib/msr-smp.c                       | 89 +++-----------------
 drivers/cpufreq/amd-pstate.c                 |  2 +-
 drivers/cpufreq/amd_freq_sensitivity.c       |  6 +-
 drivers/cpufreq/p4-clockmod.c                | 32 +++----
 drivers/cpufreq/speedstep-centrino.c         | 27 +++---
 drivers/hwmon/coretemp.c                     | 44 +++++-----
 drivers/hwmon/via-cputemp.c                  | 16 ++--
 drivers/thermal/intel/intel_tcc.c            | 43 +++++-----
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 25 +++---
 14 files changed, 128 insertions(+), 217 deletions(-)

-- 
2.54.0

