Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB70403E80
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499920; cv=none; b=hp6QiCbbKF5HMtFt0EiNxLcLCzSgYXAUKeSCOUIGDlLDKWFWZt4oY3P3o8AzS9ueJX18+AC4zKR5G/f8+h5Jumdawj8phtXa47BEiUVJyOC9clkOSo0588Qm9pGsetRwpUWepP3k0qNkcPGndAvyYvHrEZYRC1vAwgdAQwDk/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499920; c=relaxed/simple;
	bh=3tZPxYBFECLR8fa9nk2BbNhz+a6N4wv/haJawemxz1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrrVLVdAKIZpzR83KSKSWC7K2ucwynRuJ0kg8Du02h7+4G+hOP0FLL3Y31cbmZSn+DQsHcbTMkqIMPTwhsvzs3dEJMY6KQppxUVF4ElwE1mEGxmrpyIvVuQPBIOTwENAVWO+nKjwrTAvzpmJiNGnt+YUqJo3TT2e0rFH3QcZCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eU+DPfda; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pKYPyVoX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jrj5vuVH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0QSv2ZpY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eU+DPfda";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pKYPyVoX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jrj5vuVH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0QSv2ZpY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B05B75AE5;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hzewhh5WmzqKKaO5ghTUffhXKKRWimvdYMR852igZc=;
	b=eU+DPfdafc2k579cYoczvW5O6IKg6Wt3FxAR56YlnuqTDWrEZRCBHSwZWbjstjZRty6EuD
	/SJT3FEDy7mKvKV18yj/OaLSm+hC/iTsX3/dQbdKSYqCTFErbUXF+H+brFpynysJ0EDJBB
	7ddhNZCtP7tXij+OU8/S106RGFZb6JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hzewhh5WmzqKKaO5ghTUffhXKKRWimvdYMR852igZc=;
	b=pKYPyVoX+RhQC4DaBMJ4o+bvp/0iIyF4km5aYZ4uWf3zExUEHn6peTL52VuVfewvNYDoFA
	drez8EFY7tWuraDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783499901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hzewhh5WmzqKKaO5ghTUffhXKKRWimvdYMR852igZc=;
	b=Jrj5vuVH/ueHOWtYhYDrxX+CGsG9ULVNZomXmbMOAqWWt+KKkutO9XFHIUwgFSlPJKacpl
	iBaNwtr1sP3vlLOZxkAzMwNx0fCAwP+dTzd00wFgIi7dTC0v1MJ/f2a36wwpMMjwCPeNCR
	lyerLxIN3tNrxVrhTjmbG39Nfv8Opu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783499901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hzewhh5WmzqKKaO5ghTUffhXKKRWimvdYMR852igZc=;
	b=0QSv2ZpYJ6mzPJjoYeDJBJ2k8VOrPBR4RIwnozE12KfTVd8ajHDlRnSaAG6GYiWB8QScWP
	x/CnYnbKaEi0IuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7392D779AF;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AEUOG30MTmpnIQAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 08 Jul 2026 08:38:21 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	rafael@kernel.org,
	msuchanek@suse.com
Subject: [PATCH 3/3] ACPI: Properly map BERT and CCEL acpi tables to their data tables
Date: Wed,  8 Jul 2026 10:37:49 +0200
Message-ID: <20260708083803.80734-4-trenn@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:url,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:email,suse.com:url];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

In case of multiple BERT ACPI tables one gets:
sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'

This is because both:
/firmware/acpi/tables/BERT1
/firmware/acpi/tables/BERT2
are tried to be mapped to the same data table:
/firmware/acpi/tables/data/BERT

This patch fixes this problem by passing and using the same filename
for data tables.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Reported-by: Michal Suchanek <msuchanek@suse.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1270211
---
 drivers/acpi/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 16eaa0af7d0b..265fbdb10aeb 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -316,6 +316,7 @@ struct acpi_table_attr {
 struct acpi_data_attr {
 	struct bin_attribute attr;
 	u64	addr;
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
 };
 
 static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
@@ -453,7 +454,6 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	}
 	data_attr->addr = bert->address;
 	data_attr->attr.size = bert->region_length;
-	data_attr->attr.attr.name = "BERT";
 
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
 }
@@ -469,7 +469,6 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
 	}
 	data_attr->addr = ccel->log_area_start_address;
 	data_attr->attr.size = ccel->log_area_minimum_length;
-	data_attr->attr.attr.name = "CCEL";
 
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
 }
@@ -504,6 +503,8 @@ static int acpi_table_data_init(struct acpi_table_attr *table_attr)
 			sysfs_attr_init(&data_attr->attr.attr);
 			data_attr->attr.read = acpi_data_show;
 			data_attr->attr.attr.mode = 0400;
+			strscpy(data_attr->filename, table_attr->filename);
+			data_attr->attr.attr.name = data_attr->filename;
 			return acpi_data_objs[i].fn(th, data_attr);
 		}
 	}
-- 
2.54.0

