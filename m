Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7183CD8A7
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670607; cv=none; b=d+PiULsARQq00tn3JQ6DiV4ILB46NLYGKz0JT8ccqxNHmBqsXVeuZzMz91x/WnWMVAOGidMCmRZB/A5IemePjbs724hPpQ9u6UpzAKFoLAadVBTAOS22F1oNpE0ZcDFFwQNPblX+xDPZyI8UTBK1jocsVd9ZTFPxjWskPBIfC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670607; c=relaxed/simple;
	bh=JqbgTnbghYa1+fRv7NPNAXfW9K3kAyCUafNN0Cy4GTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szVJ6yW6SkvKut74D4TfpBldF//35vYJfCVmhPg7S8qEqnRG5yIqWUZoYiTER3L2U6cepeg+mf88iMnO5jbQv2A0p/fZvBm4uVZ659TOIniA4i/H4JY4yykX230qybSovKwD7Ta8lYd9KQXLZBbLilHfrnVQx9365TGXpDvxL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z6VtePlh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z6VtePlh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z6VtePlh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z6VtePlh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EEA075994;
	Fri,  5 Jun 2026 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780670598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HpEOzfpzcjzuP0x4lxSBQMRU2YmRM4anktQcV8bpWBY=;
	b=Z6VtePlhr3n+CGOw77JXL7ecovNWHrwVnpWnqln7iXDvVvsb2E5V7l69oXNBNOIcbgWfJR
	WKssSG1wBKeCWHnV/U7kFE/V2rp1lse9tdbd18o49yDH8ul/X8T5+7/mIcCA8K4SNn3Q5q
	sV+f0+smO5b9SbavaiChS5d35Wz8YWk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780670598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HpEOzfpzcjzuP0x4lxSBQMRU2YmRM4anktQcV8bpWBY=;
	b=Z6VtePlhr3n+CGOw77JXL7ecovNWHrwVnpWnqln7iXDvVvsb2E5V7l69oXNBNOIcbgWfJR
	WKssSG1wBKeCWHnV/U7kFE/V2rp1lse9tdbd18o49yDH8ul/X8T5+7/mIcCA8K4SNn3Q5q
	sV+f0+smO5b9SbavaiChS5d35Wz8YWk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86193779A8;
	Fri,  5 Jun 2026 14:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LLeIH4XgImrdWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 14:43:17 +0000
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
Subject: [PATCH v2 00/10] x86/msr: Drop 32-bit variants of *_on_cpu() MSR functions
Date: Fri,  5 Jun 2026 16:43:04 +0200
Message-ID: <20260605144314.3031049-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.80

Drop the variants using 2 32-bit values instead of a single 64-bit one
of the *_on_cpu() MSR access functions.

Changes in V2:
- patches 1+2 split out from other patch
- keep the *q() variants instead of those without suffix

Juergen Gross (10):
  x86/msr: Switch rdmsrl_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Remove rdmsrl_on_cpu()
  x86/msr: Switch rdmsr_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Remove rdmsr_on_cpu()
  x86/msr: Switch wrmsr_on_cpu() users to wrmsrq_on_cpu()
  x86/msr: Remove wrmsr_on_cpu()
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

