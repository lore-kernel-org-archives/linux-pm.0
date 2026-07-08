Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFF4028D8
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499911; cv=none; b=S9Bf8JeUd+pHWlFkkAHL4++BrE4AimKdZe1/Itu0mjfW3fI6i1ox/w0oggCzaiSdYUpLzgfVOblFOOzlyX7aLcDDXkNz+9XsP5gVryPCIgppMgCLC89KwKszoA86bfZHexKVD7FQFWwTJ7Dh53V7vv5TczxQBSP0TuCE4TLqkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499911; c=relaxed/simple;
	bh=GsAJRpwyq8YMUa7C7jxdPLQZ3mb2VJhUR9IrueJj7qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skeRWk/ulUb3Fqx/k+6VwIX4eCJlzOGQnY44nxmH5phuj/8TEyNnAnX9A21Z68kkFz4T4PIMphzXEexkQy943Tojc3EPRQS6YpfuGxIfvjGUpox0t7y/t6BKh3VN2y8ePIhB/ursofBFpub7hnttapfTK78rHKrRGK1hHWcF17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w3uV7Keg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WAH2JdSh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w3uV7Keg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WAH2JdSh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w3uV7Keg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WAH2JdSh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w3uV7Keg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WAH2JdSh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A0E775A7B;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD6ZP0KHTAoVMIVZeDq5n0YSMLKTPcObI0BvTHVthoI=;
	b=w3uV7Kegll2J2XG13D8op7kZPU90boiGajdxzYra4zPBTSdBl5xjvdMdJEMLPzywelOETU
	8PhkrBNE99nF2OCcCAUVMMXM7Wl6vGkyCDmhzf5lgsj0Z+yxTR7wjde2ULpkiPlFUCvlrW
	rgJmJ1JW48VFZgwAE/+xrKbnK16Cd9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD6ZP0KHTAoVMIVZeDq5n0YSMLKTPcObI0BvTHVthoI=;
	b=WAH2JdShGFQMItJj3hEnKi3C3HM3WtwaEdH2VC/7K1Vd3x4YUwT3rHu8i/3+YIxtjOp7zS
	exQyK8v1y/JeCQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w3uV7Keg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WAH2JdSh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD6ZP0KHTAoVMIVZeDq5n0YSMLKTPcObI0BvTHVthoI=;
	b=w3uV7Kegll2J2XG13D8op7kZPU90boiGajdxzYra4zPBTSdBl5xjvdMdJEMLPzywelOETU
	8PhkrBNE99nF2OCcCAUVMMXM7Wl6vGkyCDmhzf5lgsj0Z+yxTR7wjde2ULpkiPlFUCvlrW
	rgJmJ1JW48VFZgwAE/+xrKbnK16Cd9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD6ZP0KHTAoVMIVZeDq5n0YSMLKTPcObI0BvTHVthoI=;
	b=WAH2JdShGFQMItJj3hEnKi3C3HM3WtwaEdH2VC/7K1Vd3x4YUwT3rHu8i/3+YIxtjOp7zS
	exQyK8v1y/JeCQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19D8B779AF;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILAlBX0MTmpnIQAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 08 Jul 2026 08:38:21 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	rafael@kernel.org,
	msuchanek@suse.com
Subject: [PATCH 1/3] Use correct region size for BERT region size check
Date: Wed,  8 Jul 2026 10:37:47 +0200
Message-ID: <20260708083803.80734-2-trenn@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708083803.80734-1-trenn@suse.de>
References: <20260708083803.80734-1-trenn@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4A0E775A7B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Looks like only acpi_hest_generic_status was defined when
the patch was created. Use the correct one now.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 908cc5c7e643..8395efbe248b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -447,7 +447,7 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	struct acpi_table_bert *bert = th;
 
 	if (bert->header.length < sizeof(struct acpi_table_bert) ||
-	    bert->region_length < sizeof(struct acpi_hest_generic_status)) {
+	    bert->region_length < sizeof(struct acpi_bert_region)) {
 		kfree(data_attr);
 		return -EINVAL;
 	}
-- 
2.54.0

