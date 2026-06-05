Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1235A39D
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643314; cv=none; b=N6PpxgTGjWasbZCubxlKtftvDIKyeukYWfP8p3fJsOLqI/EI7c00rQUqz63zKZGh9t5/IvOjRbrgF9rzLa1Oe3uN8aVKiDngC8nFNc1IpyiJpFF+ooaFByYXz/86pFhlqMRbQcIoN/1JGykJuzuqeRs+QxqGqb+uB2gWKAOBtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643314; c=relaxed/simple;
	bh=4hvsRn9Kp2CzHPwth+eNDSeQOsWa/Ckcpaciuv5v3HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nF2lyj7Go6pfoSRiPi6q1WmPDv0wLnuoHROkcP27ZswP1NM16n8nSDmTlVKrrh+7hidC0hDwTK/UR5NWrh4WURgODttODgrkpQU+otma1bEzLDd7R8TCw5r41S06X6ToAsm7R3zD5tzA9rRYz4HMkv9J12YZykl6XPtM8BLdLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKjYggke; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKjYggke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKjYggke";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKjYggke"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D92917593A;
	Fri,  5 Jun 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780643309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WN+1EqgKbEGm+Jlqz5BJMqJKAPMrZfGWpmYbaOaSum4=;
	b=iKjYggkeyd0GZUzAqkFLB4pGtPXBaZx1IpDKUVmqabC2LXYHwd8cAz/lMSJhTNLRDz9g8g
	WTjB7GUVsJ+bh6Z/izkQLAcxuwkp0XFoNejvkxa6k1y17q+fOyPepOPVR7+PK5t/W5JQy3
	ZOdYdIo1fEJ6ZuGbWmbYAdHMt3mUxH8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780643309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WN+1EqgKbEGm+Jlqz5BJMqJKAPMrZfGWpmYbaOaSum4=;
	b=iKjYggkeyd0GZUzAqkFLB4pGtPXBaZx1IpDKUVmqabC2LXYHwd8cAz/lMSJhTNLRDz9g8g
	WTjB7GUVsJ+bh6Z/izkQLAcxuwkp0XFoNejvkxa6k1y17q+fOyPepOPVR7+PK5t/W5JQy3
	ZOdYdIo1fEJ6ZuGbWmbYAdHMt3mUxH8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142B2779A8;
	Fri,  5 Jun 2026 07:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/G9A+11ImqDHQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:08:29 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
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
	James Clark <james.clark@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR functions
Date: Fri,  5 Jun 2026 09:08:18 +0200
Message-ID: <20260605070826.2995913-1-jgross@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

Drop the variants using 2 32-bit values instead of a single 64-bit one
of the *_on_cpu() MSR access functions.

Juergen Gross (8):
  x86/msr: Switch rdmsr_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_on_cpu() to use rdmsr_on_cpu()
  x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_on_cpu() to use wrmsr_on_cpu()
  x86/msr: Switch rdmsr_safe_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_safe_on_cpu() to use
    rdmsr_safe_on_cpu()
  x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_safe_on_cpu() to use
    wrmsr_safe_on_cpu()

 arch/x86/events/intel/ds.c                    | 11 +--
 arch/x86/events/intel/pt.c                    |  2 +-
 arch/x86/events/intel/uncore_discovery.c      |  2 +-
 arch/x86/events/intel/uncore_snbep.c          |  2 +-
 arch/x86/include/asm/msr.h                    | 44 +++--------
 arch/x86/kernel/acpi/cppc.c                   |  8 +-
 arch/x86/kernel/cpu/intel_epb.c               |  8 +-
 arch/x86/kernel/cpu/mce/amd.c                 |  6 +-
 arch/x86/kernel/cpu/mce/inject.c              | 12 +--
 arch/x86/kernel/cpu/microcode/intel.c         |  2 +-
 arch/x86/kernel/msr.c                         |  8 +-
 arch/x86/lib/msr-smp.c                        | 79 ++-----------------
 drivers/cpufreq/acpi-cpufreq.c                |  4 +-
 drivers/cpufreq/amd-pstate-ut.c               |  2 +-
 drivers/cpufreq/amd-pstate.c                  | 21 +++--
 drivers/cpufreq/amd_freq_sensitivity.c        |  4 +-
 drivers/cpufreq/intel_pstate.c                | 64 +++++++--------
 drivers/cpufreq/p4-clockmod.c                 | 32 ++++----
 drivers/cpufreq/speedstep-centrino.c          | 27 ++++---
 drivers/hwmon/coretemp.c                      | 44 +++++------
 drivers/hwmon/via-cputemp.c                   | 16 ++--
 drivers/platform/x86/amd/hfi/hfi.c            |  4 +-
 .../intel/speed_select_if/isst_if_common.c    | 13 ++-
 .../intel/uncore-frequency/uncore-frequency.c | 12 +--
 drivers/powercap/intel_rapl_msr.c             |  2 +-
 drivers/thermal/intel/intel_tcc.c             | 43 +++++-----
 drivers/thermal/intel/x86_pkg_temp_thermal.c  | 22 +++---
 27 files changed, 203 insertions(+), 291 deletions(-)

-- 
2.54.0

