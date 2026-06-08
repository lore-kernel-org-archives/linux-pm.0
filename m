Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FE324B20
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895874; cv=none; b=RCsbmdid1MlDXT89E2cM6TLT5j/QMrlXwIYzLUGN07Fva1k5JfktLshI7wjYb7kIfGo0aoAX60r3CU0YRzSdzHBo2xcn9aUiqislobf+r9OobMz/MqX+OzYMC81fVhvvwZs3idyfAIb7q38krP/FLfSwhXnVt+noZ+oehk58UPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895874; c=relaxed/simple;
	bh=cAviuNB4luImlZPMVRUNy6lsiWmLabQf23Sh7eVWb0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSeLIyKDAKUiGIh8qDWUmjmwO+ft2/YlmZ6JYavEnlsWSY+yNIHfMk6rMvlLSdkzHInbrM7QQrMleFEVUVXT8ZUXSj579ZQj+R2z/ywgX11ip4079ZHbW9m9pKILPmjeXu0/5qcxXO6rwRHCzY1B5T+5H5QZK3Niu/FNGkrV0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwAWQmQj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwAWQmQj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwAWQmQj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwAWQmQj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B17926B5D4;
	Mon,  8 Jun 2026 05:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzXdnIGiPs+Cv7y2Aw/DmzGMbykW3qZwwNs0u/oFS6Q=;
	b=AwAWQmQj/bYnNPG4eicPMOeBFHw1leoBIN9UnHJkHsf6yAgsI2pjwGS8LvFKDhXsJY4rpN
	9/gpQP3HV9IGljxemc/1ZcFyFBxVyWY63dK4r0hyBmK9RJdYxOC70dm/z95oeuyKiY77U8
	RQcYuuA+z5xLT2yoWlIJiCTNmmAysM0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AwAWQmQj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzXdnIGiPs+Cv7y2Aw/DmzGMbykW3qZwwNs0u/oFS6Q=;
	b=AwAWQmQj/bYnNPG4eicPMOeBFHw1leoBIN9UnHJkHsf6yAgsI2pjwGS8LvFKDhXsJY4rpN
	9/gpQP3HV9IGljxemc/1ZcFyFBxVyWY63dK4r0hyBmK9RJdYxOC70dm/z95oeuyKiY77U8
	RQcYuuA+z5xLT2yoWlIJiCTNmmAysM0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72278779A7;
	Mon,  8 Jun 2026 05:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 51/NGn1QJmpFdQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 05:17:49 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 01/11] x86/msr: Switch rdmsrl_on_cpu() users to rdmsrq_on_cpu()
Date: Mon,  8 Jun 2026 07:17:31 +0200
Message-ID: <20260608051741.3207435-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608051741.3207435-1-jgross@suse.com>
References: <20260608051741.3207435-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B17926B5D4
X-Spam-Score: -3.01

rdmsrl_on_cpu() is a deprecated synonym for rdmsrq_on_cpu().
Switch its only user to rdmsrq_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
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

