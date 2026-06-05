Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F03CC9E2
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670616; cv=none; b=W8z1bEj4qKUpLsg6ZoLHL4u/rhw8+KGjpfJmU05zWkP2pRnyAVsjww8AOz9Qnb+5Q7k25Tkuj3SFuifEmeDf5bqLDBwNxjJxHPm0GsPUlE4bveRF5s/7zdB+ftNh6dQoPeLS8SauWT/fSjvzk/i7pcp1XTI/qpcC8PQr3Rdlxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670616; c=relaxed/simple;
	bh=dJanACVNtJGpR2aTB+msFj3gLjqXQHmBUjBngJ5GrY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J16Fj6i7bJu5WTNYkmVpTz0cCmYrYBk9sopoz1MmIPTZVaVldNxY+94WpM40BjZ9N3raZLaqdBFykbd18kCZUDLanK4p3hM52US6NfVIc7JMxH3rdRr/332aWrStAFYBw24IW0qlyuyryzhjZFiYK2aVHezwyh4IacAUbSg/psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=epQUrVEF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=epQUrVEF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="epQUrVEF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="epQUrVEF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C93F175992;
	Fri,  5 Jun 2026 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780670603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+5cq3+j4X/akDtIcMoCvLSbbIDblYGhZGXw0uvKbw0=;
	b=epQUrVEFXnUTKjaQYhvNXgYmnQD9xCM37U4AOrs5ekOdNGyMEpaqmbj2wUm+BiYxsHFfep
	UqFoM7wwjUcwrmP7Jr+mAkQl5iWKTdqRMje39pFLqC8RyVjBVS6ffF35GMTZD2NCJ30S5S
	aHtYN4VbbsLxdgC2jyabBdh1qbncELU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780670603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+5cq3+j4X/akDtIcMoCvLSbbIDblYGhZGXw0uvKbw0=;
	b=epQUrVEFXnUTKjaQYhvNXgYmnQD9xCM37U4AOrs5ekOdNGyMEpaqmbj2wUm+BiYxsHFfep
	UqFoM7wwjUcwrmP7Jr+mAkQl5iWKTdqRMje39pFLqC8RyVjBVS6ffF35GMTZD2NCJ30S5S
	aHtYN4VbbsLxdgC2jyabBdh1qbncELU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86EBF779A8;
	Fri,  5 Jun 2026 14:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pau/H4vgImrmWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 14:43:23 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 01/10] x86/msr: Switch rdmsrl_on_cpu() users to rdmsrq_on_cpu()
Date: Fri,  5 Jun 2026 16:43:05 +0200
Message-ID: <20260605144314.3031049-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605144314.3031049-1-jgross@suse.com>
References: <20260605144314.3031049-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -6.80

rdmsrl_on_cpu() is a deprecated synonym for rdmsrq_on_cpu().
Switch its only user to rdmsrq_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- carved out from other patch (Ingo Molnar)
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 62b5d995281d..7847cf363ce8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,7 +476,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
+	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
 	if (ret)
 		return ret;
 
-- 
2.54.0

