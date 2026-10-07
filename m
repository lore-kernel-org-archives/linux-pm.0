Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1F486E46;
	Wed,  7 Oct 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384162; cv=none; b=rMZLSFXw1EGAHQryVcbVvTIZzkH5r8KApkOBt7dPoSFC7zNY2HsHBpFXBAT+QCh1bbdfKFBg2E7AE0bL5ACZ5pZ7v2iA4+Fe4coAns87ldzXeTwaB/0xuk+3hw3m2v0+8AoBXmouGPDK+sW3cS0EMeHtkgYFKgZmWi5etf16fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384162; c=relaxed/simple;
	bh=X3YiN4S3r7+mqDyWIb5gVp0CLPH1QCgcG42V9S2Jdek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMadaaF9GxBoSn5U8vxv6sE5TGwh0y7jX64RpE6da+VQSk2g+77IAjkY6m3ZHvgB2bjxEYBmRs9TMLt6koWsFEajQlOIMlfMHXgDicrRjqIrYe1nzsWY/4hxiqIkIwWbj/ubd7QifB7/LrkddAEIOKdCugKClhtHnGBGNDXjrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zNL+Mdvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QnmN3pLX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPvGBFSC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ajCPjjvl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zNL+Mdvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnmN3pLX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPvGBFSC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ajCPjjvl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12C021F38E;
	Wed,  7 Oct 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791384153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O6YlskDkLoQ5JiQSfPpOQlVbhktilvfGbaXAzr/RsGY=;
	b=zNL+MdvwSgfuELo3aW8bouBVIpOLPXpVvxdyOZZbKXgEjxOjdd2ASPXUNfVKVddmZmi2b1
	JVvadWzuHzPw3VNydSv5sXr9HS1qsi6JBfV4MXz5s/9weNP8/OiQTbFfQW2jp04/r10p8q
	1khBt9Psgz3uxtYJrQUOmwjwd9WxuXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791384153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O6YlskDkLoQ5JiQSfPpOQlVbhktilvfGbaXAzr/RsGY=;
	b=QnmN3pLXI47y91x/GSWSdrylgUwTXlsOdO73id+OWAjQZmDSy1A1nT3N9kp+XADz7ZmTpb
	9ZZqu5prry2GNdCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791384152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O6YlskDkLoQ5JiQSfPpOQlVbhktilvfGbaXAzr/RsGY=;
	b=lPvGBFSCg54y26M/49QGBup7hQNRwLMGH8YGLlzGuMuaLPx44w3QJrC67IK21Yf1p2mUVc
	x9OYGLfZp1zKik1PQQlVmbgxbb4z8EITi86zPP5ysvD5hbzee22ldtnuB9DfFDMKyOYrln
	vqvDJ96shuJ+59rZ7O5C85TQ2j52ZdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791384152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O6YlskDkLoQ5JiQSfPpOQlVbhktilvfGbaXAzr/RsGY=;
	b=ajCPjjvlK+sToOG8U3gUBaQ7TIi2+JUxlx9DqWwn4MuDLT1h0cHUomAJU+lwnycptohAR6
	gdGk2yA+qB6/wvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BD6A13354;
	Wed,  7 Oct 2026 14:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vUd7CVdaxmozXAAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Wed, 07 Oct 2026 14:42:31 +0000
From: Giovanni Gherdovich <ggherdovich@suse.cz>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for TRX40-based motherboards
Date: Wed,  7 Oct 2026 16:41:50 +0200
Message-ID: <20261007144150.15113-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Some motherboard based on the TRX40 chipset has been reported to ship
firmware lacking lowest and nominal frequency values in the
_CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
Firmware updates aren't available.

amd-pstate requires explicit knowledge of nominal frequency, so it
can't load on this hardware. The driver already has a mechanism (the
so-called "quirks") to accommodate for missing nominal freq in ACPI
tables, so here we use it to match against CPU family, model, core
count, and BIOS version.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8bfd46d60843..532ff16dd076 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
+static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
+	.nominal_freq = 3800,
+	.lowest_freq = 550,
+};
+
 static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
 	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
@@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	return 0;
 }
 
+static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
+{
+	/**
+	 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
+	 */
+	if (boot_cpu_data.x86 == 0x17 &&
+	    boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
+	    topology_num_cores_per_package() == 24) {
+		quirks = dmi->driver_data;
+		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
+		return 1;
+	}
+
+	return 0;
+}
+
 static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
 	{
 		.callback = dmi_matched_7k62_bios_bug,
@@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
 		},
 		.driver_data = &quirk_amd_7k62,
 	},
+	{
+		.callback = dmi_matched_trx40_bios_bug,
+		.ident = "AMD Ryzen Threadripper 3000",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
+			DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
+			DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
+		},
+		.driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
-- 
2.43.0

