Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A797402B97
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499908; cv=none; b=bxILKG6TZgk7Nd+iptwGzGvTQ7P7qQCzUIwmLBQU+LlxZJ2eqVKQK7bnaLyE7en9V8lHic5AR+BjVxi5y4UY+Z/AIdAozHFHaCVl6qI9LvWxRfB2Flp/pGuAEhWi/B/KfWioPyWO0piOIUmGnvTumML9xzyOGP9rzhtFwU4B6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499908; c=relaxed/simple;
	bh=fKeaa2+OhLEQhEVvvn454OAt5M42M4ad17lBMVNnHjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw8CYxhe4njMvL+lR1P9lYYkyq+xkxLXGJEeHLAPuszQdhP3fpJxpbiX/4iZTTEnnGhG5qaJ9bWOGFf0VAFXK5uAP8BWkIqgY68Hi2exY0wB4WlARKDn3OpRWsSETJ7ehzyTpQ55SIllfxI03WpwmmCEvRR6Gy5qsrlbhej8q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mADAS3l3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xKF81gnk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AJaksyXX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jmoq9QgU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mADAS3l3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xKF81gnk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AJaksyXX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jmoq9QgU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F17075F3A;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0EJ00PtorWkwggm5FqNjLOtdjEkoVfXcxNZv+p0h0g=;
	b=mADAS3l3bAoFzXuamIw6HB/HdN/FR7URvYiJE5DI590K2H2KG2HgT6KwXTXSZPZ1hE53Sm
	QxUgkECkTTCy5RiFhwyjmG6sq4RoP1xyPVC4dCC25iA7dIIm+W4HPOOkjeVfqsijAkP4Ky
	FHA6nkFCLUD3+Vjyp07OftiSmXI+Qks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0EJ00PtorWkwggm5FqNjLOtdjEkoVfXcxNZv+p0h0g=;
	b=xKF81gnk89VxNRm8e8FbsmqFzUEk/4jBbIYNQRH2Yiah0iHGQfLpBUyvDYjAl+A+YHu1Lt
	q7+gNSDY0A7M4UAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0EJ00PtorWkwggm5FqNjLOtdjEkoVfXcxNZv+p0h0g=;
	b=AJaksyXXY3pIqds2mhPbglqxMW5HqYTrwhNj11QBAZ+O8rjmjR3jMZ5O+x+NgoyrvndLzi
	+k8cTOhFTXW4UybRUuQHTrbR5oauIk5YZvX2KoSsrYv85ckm8ysXPQVDZHnjvQxVUejD0/
	si8ZnOXKlVjM0b1D0sZWjsAcVsRLlso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0EJ00PtorWkwggm5FqNjLOtdjEkoVfXcxNZv+p0h0g=;
	b=jmoq9QgUoKkwDpzihtr5hRgIguraPSeyIN7PFtVh4FpnxWkFj9DDDoFrvVX1aEXmlhY2m+
	rNE6yJ3zD0fweICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B930779B0;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QGpJEX0MTmpnIQAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 08 Jul 2026 08:38:21 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	rafael@kernel.org,
	msuchanek@suse.com
Subject: [PATCH 2/3] ACPI: Pass table_attr instead of table_header to create acpi data tables
Date: Wed,  8 Jul 2026 10:37:48 +0200
Message-ID: <20260708083803.80734-3-trenn@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Data tables must match the exact table they describe.
This patch prepares things to make it possible in a follow up patch.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Reported-by: Michal Suchanek <msuchanek@suse.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1270211
---
 drivers/acpi/sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 8395efbe248b..16eaa0af7d0b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -484,11 +484,18 @@ static struct acpi_data_obj {
 
 #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
 
-static int acpi_table_data_init(struct acpi_table_header *th)
+static int acpi_table_data_init(struct acpi_table_attr *table_attr)
 {
 	struct acpi_data_attr *data_attr;
+	struct acpi_table_header *th;
+	acpi_status status;
 	int i;
 
+	status = acpi_get_table(table_attr->name, table_attr->instance,
+				&th);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
 	for (i = 0; i < NUM_ACPI_DATA_OBJS; i++) {
 		if (ACPI_COMPARE_NAMESEG(th->signature, acpi_data_objs[i].name)) {
 			data_attr = kzalloc_obj(*data_attr);
@@ -543,7 +550,7 @@ static int acpi_tables_sysfs_init(void)
 			return ret;
 		}
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
-		acpi_table_data_init(table_header);
+		acpi_table_data_init(table_attr);
 	}
 
 	kobject_uevent(tables_kobj, KOBJ_ADD);
-- 
2.54.0

