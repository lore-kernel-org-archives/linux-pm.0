Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB03FF1D0
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499917; cv=none; b=M1I/YRJLNHuRxa0s/ax/1ZF1yTIfvNBsuSZZPiK00ZBKVptEqIu/kwgTHNvXmPaagehrbCMWMKKCOnm0PlcAjATlNFL8oBdwluxgoO8ZRTTCbgTUG65gs/aNuVpyMf/at89zAI5C2amhXE958/bvAgw3TeFizSS78aJlYVAWe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499917; c=relaxed/simple;
	bh=7LlIY7iWdjQU+yKa8zPiXnyERhnh6Yt/Ud1vl09fzXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do/RC4HuVmA/+4KmH09zkRO42SeTaORcVSfZyk7lZkyZvYino1NLzX04RicI8y6Frwv4wUZGj/wh3zAXquUj1qL8XguEUZ7DQf4gkjRg8uGmTxtB4VbkpSRlRS5ecb+a5vD7Uz0xoc5iU0Hg3vvzWWSAbLNCNH/ZM/gUa/xR4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1x+fu8u6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w5ekFfMN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YE2IutcX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GzlcVQ2F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1x+fu8u6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w5ekFfMN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YE2IutcX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GzlcVQ2F"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1427C75F36;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3ZfEmdPoWWVhjwaCn0cP/OxdqObypWpFwWRtej+hlcc=;
	b=1x+fu8u6VQr4gFLxwkblhjy8cXtMXrJobQMMd61HxPIbBN3FL2kUY6vVAPFyB5Zw3Y4M/l
	xtwPmt/MBITNGXVcj1zQYUMBgn2dJdPgEWQx+Sh4UGP86LpXXOxbj1GuO2MWcwNAz5/bnv
	mGLworkDITzUPGEqhimXNty+ISyEkvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3ZfEmdPoWWVhjwaCn0cP/OxdqObypWpFwWRtej+hlcc=;
	b=w5ekFfMNqo9JJ0tuCN+u9dOE/xg/5G+eZkgFIYbVqdPbQzHiMbPf0fxVfp0zCxqtThpXqA
	KDj6DfvBYTEr4PCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YE2IutcX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GzlcVQ2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3ZfEmdPoWWVhjwaCn0cP/OxdqObypWpFwWRtej+hlcc=;
	b=YE2IutcXM7B3gkb3icf7X4eYRT9GUsXfGVGy+JX2DPVKgy4CLOgI992j5EfwUAS7tLuFvL
	SceRovItHD31fRGkVxNG6GVS30uB7gQkBwXVC2G4jTk23HGAQxRhaYjga6IzcsVCu3K87v
	tJO7vvTYCi3iDWtXtJPoHkhfzGIMJ34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3ZfEmdPoWWVhjwaCn0cP/OxdqObypWpFwWRtej+hlcc=;
	b=GzlcVQ2F3OBG2iYBcGkN8WwAXBGnzQQ//aZTiBzAyicI99PHsmmiVdQySfZDmepE1dkqRN
	PAIHNnWr9lc0W/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB69B779AE;
	Wed,  8 Jul 2026 08:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dvJZNHwMTmpnIQAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 08 Jul 2026 08:38:20 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	rafael@kernel.org,
	msuchanek@suse.com
Subject: [PATCH 0/3] Fix sysfs duplicate filename if multiple BERT tables exist
Date: Wed,  8 Jul 2026 10:37:46 +0200
Message-ID: <20260708083803.80734-1-trenn@suse.de>
X-Mailer: git-send-email 2.54.0
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:mid,suse.de:dkim];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1427C75F36
X-Spam-Score: -3.01

Cmp with:
https://bugzilla.suse.com/show_bug.cgi?id=1270211

dmesg | grep BERT
ACPI: BERT 0x00000000DD695238 000030 (v01 AMD    AMD BERT 00000000      00000000)
ACPI: BERT 0x00000000DD6955C8 000030 (v01 AMI    AMI.BERT 00000000 AMI. 00000000)
ACPI: Reserving BERT table memory at [mem 0xdd695238-0xdd695267]
ACPI: Reserving BERT table memory at [mem 0xdd6955c8-0xdd6955f7]
sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'

Thomas Renninger (3):
  Use correct region size for BERT region size check
  ACPI: Pass table_attr instead of table_header to create acpi data
    tables
  ACPI: Properly map BERT and CCEL acpi tables to their data tables

 drivers/acpi/sysfs.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.54.0

