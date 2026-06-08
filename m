Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396F34DB72
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895912; cv=none; b=nE6lb/zPI5AI7NN5Z+HwiORN50MNKjEMbnEXpT/x08qIPl6yT2Yts82jvNBijGf0bxKYEK+tFGaPpAAXKAcd02qBxuJHVJvymar8tiFgh+MsuDx1UMIDZoIKw63enVpHfs3RSHeSKiO1BQP04qNXavM76ItKRZxbzA5pj3iKqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895912; c=relaxed/simple;
	bh=yLAYC9rwUMzfygC3ZN37wBG2n0LVAeQEJOBmB2R/BaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoqI2PzkJC2LEJV3wW37X3dYGMA/ZDtTw8sd21u9i34iQro2hVohcXPitUYC6tSvYO2Dj4AE3nlX4P8xwDk3PEHShtbaCKGcB+BtM/Gb/4E4mmbK/TF0T8uuW85+CoAqdyvuMrXbC9uedxa+hyHh0G9Mv5oY9mRgJbUWAt9qDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Biub5MnD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Biub5MnD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Biub5MnD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Biub5MnD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 469576B5C9;
	Mon,  8 Jun 2026 05:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFEbREzR5iqeTOMUqyw9L1/xvoJ90/X69vhp/m4YJu0=;
	b=Biub5MnDnksIjW7Xk8qBzt9HF2wkMuuC8Se4UhCiT068M2I+wmDdlP+X/sCxgMRBGJeeRb
	FKw0HDft/KO9UGnMCBckNTZEtSdBoGsWwrVyHsl4hOzdwkoPrE6ubzAu9CkHpkJzSrQwFr
	Ebf5HTM0LZ25mebusDykX64UBXUWNYs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFEbREzR5iqeTOMUqyw9L1/xvoJ90/X69vhp/m4YJu0=;
	b=Biub5MnDnksIjW7Xk8qBzt9HF2wkMuuC8Se4UhCiT068M2I+wmDdlP+X/sCxgMRBGJeeRb
	FKw0HDft/KO9UGnMCBckNTZEtSdBoGsWwrVyHsl4hOzdwkoPrE6ubzAu9CkHpkJzSrQwFr
	Ebf5HTM0LZ25mebusDykX64UBXUWNYs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E693E779A7;
	Mon,  8 Jun 2026 05:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5DkzN6RQJmp+dQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 05:18:28 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 08/11] x86/msr: Switch rdmsr_safe_on_cpu() users to rdmsrq_safe_on_cpu()
Date: Mon,  8 Jun 2026 07:17:38 +0200
Message-ID: <20260608051741.3207435-9-jgross@suse.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:url,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

In order to prepare retiring rdmsr_safe_on_cpu() switch
rdmsr_safe_on_cpu() users to rdmsrq_safe_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
V2:
- instead of changing rdmsr_safe_on_cpu(), use rdmsrq_safe_on_cpu()
  (Ingo Molnar)
---
 arch/x86/kernel/msr.c             |  4 +--
 drivers/hwmon/coretemp.c          | 32 +++++++++++------------
 drivers/hwmon/via-cputemp.c       | 16 ++++++------
 drivers/thermal/intel/intel_tcc.c | 43 ++++++++++++++++---------------
 4 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 4469c784eaa0..60334317f30b 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -53,7 +53,7 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	u32 __user *tmp = (u32 __user *) buf;
-	u32 data[2];
+	u64 data;
 	u32 reg = *ppos;
 	int cpu = iminor(file_inode(file));
 	int err = 0;
@@ -63,7 +63,7 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 		return -EINVAL;	/* Invalid chunk size */
 
 	for (; count; count -= 8) {
-		err = rdmsr_safe_on_cpu(cpu, reg, &data[0], &data[1]);
+		err = rdmsrq_safe_on_cpu(cpu, reg, &data);
 		if (err)
 			break;
 		if (copy_to_user(tmp, &data, 8)) {
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1259c78c95c6..70711a7cca12 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -169,7 +169,7 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	int tjmax_ee = 85000;
 	int usemsr_ee = 1;
 	int err;
-	u32 eax, edx;
+	u64 val;
 	int i;
 	u16 devfn = PCI_DEVFN(0, 0);
 	struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
@@ -220,14 +220,14 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		 * http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
 		 * For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
 		 */
-		err = rdmsr_safe_on_cpu(id, 0x17, &eax, &edx);
+		err = rdmsrq_safe_on_cpu(id, 0x17, &val);
 		if (err) {
 			dev_warn(dev,
 				 "Unable to access MSR 0x17, assuming desktop"
 				 " CPU\n");
 			usemsr_ee = 0;
 		} else if (c->x86_vfm < INTEL_CORE2_PENRYN &&
-			   !(eax & 0x10000000)) {
+			   !(val & 0x10000000)) {
 			/*
 			 * Trust bit 28 up to Penryn, I could not find any
 			 * documentation on that; if you happen to know
@@ -235,8 +235,8 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 			 */
 			usemsr_ee = 0;
 		} else {
-			/* Platform ID bits 52:50 (EDX starts at bit 32) */
-			platform_id = (edx >> 18) & 0x7;
+			/* Platform ID bits 52:50 */
+			platform_id = (val >> 50) & 0x7;
 
 			/*
 			 * Mobile Penryn CPU seems to be platform ID 7 or 5
@@ -255,12 +255,12 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	}
 
 	if (usemsr_ee) {
-		err = rdmsr_safe_on_cpu(id, 0xee, &eax, &edx);
+		err = rdmsrq_safe_on_cpu(id, 0xee, &val);
 		if (err) {
 			dev_warn(dev,
 				 "Unable to access MSR 0xEE, for Tjmax, left"
 				 " at default\n");
-		} else if (eax & 0x40000000) {
+		} else if (val & 0x40000000) {
 			tjmax = tjmax_ee;
 		}
 	} else if (tjmax == 100000) {
@@ -278,7 +278,7 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 {
 	struct cpuinfo_x86 *c = &cpu_data(tdata->cpu);
 	int err;
-	u32 eax, edx;
+	u64 msrval;
 	u32 val;
 
 	/* use static tjmax once it is set */
@@ -289,11 +289,11 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 	 * A new feature of current Intel(R) processors, the
 	 * IA32_TEMPERATURE_TARGET contains the TjMax value
 	 */
-	err = rdmsr_safe_on_cpu(tdata->cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	err = rdmsrq_safe_on_cpu(tdata->cpu, MSR_IA32_TEMPERATURE_TARGET, &msrval);
 	if (err) {
 		dev_warn_once(dev, "Unable to read TjMax from CPU %u\n", tdata->cpu);
 	} else {
-		val = (eax >> 16) & 0xff;
+		val = (msrval >> 16) & 0xff;
 		if (val)
 			return val * 1000;
 	}
@@ -314,7 +314,7 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 
 static int get_ttarget(struct temp_data *tdata, struct device *dev)
 {
-	u32 eax, edx;
+	u64 val;
 	int tjmax, ttarget_offset, ret;
 
 	/*
@@ -324,14 +324,14 @@ static int get_ttarget(struct temp_data *tdata, struct device *dev)
 	if (tdata->tjmax)
 		return -ENODEV;
 
-	ret = rdmsr_safe_on_cpu(tdata->cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	ret = rdmsrq_safe_on_cpu(tdata->cpu, MSR_IA32_TEMPERATURE_TARGET, &val);
 	if (ret)
 		return ret;
 
-	tjmax = (eax >> 16) & 0xff;
+	tjmax = (val >> 16) & 0xff;
 
 	/* Read the still undocumented bits 8:15 of IA32_TEMPERATURE_TARGET. */
-	ttarget_offset = (eax >> 8) & 0xff;
+	ttarget_offset = (val >> 8) & 0xff;
 
 	return (tjmax - ttarget_offset) * 1000;
 }
@@ -560,7 +560,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct temp_data *tdata;
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	u32 eax, edx;
+	u64 val;
 	int err;
 
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
@@ -571,7 +571,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		return -ENOMEM;
 
 	/* Test if we can access the status register */
-	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
+	err = rdmsrq_safe_on_cpu(cpu, tdata->status_reg, &val);
 	if (err)
 		goto err;
 
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index a5c03ed59c1f..ec421201049d 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -65,28 +65,28 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct via_cputemp_data *data = dev_get_drvdata(dev);
-	u32 eax, edx;
+	u64 val;
 	int err;
 
-	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
+	err = rdmsrq_safe_on_cpu(data->id, data->msr_temp, &val);
 	if (err)
 		return -EAGAIN;
 
-	return sprintf(buf, "%lu\n", ((unsigned long)eax & 0xffffff) * 1000);
+	return sprintf(buf, "%lu\n", ((unsigned long)val & 0xffffff) * 1000);
 }
 
 static ssize_t cpu0_vid_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	struct via_cputemp_data *data = dev_get_drvdata(dev);
-	u32 eax, edx;
+	u64 val;
 	int err;
 
-	err = rdmsr_safe_on_cpu(data->id, data->msr_vid, &eax, &edx);
+	err = rdmsrq_safe_on_cpu(data->id, data->msr_vid, &val);
 	if (err)
 		return -EAGAIN;
 
-	return sprintf(buf, "%d\n", vid_from_reg(~edx & 0x7f, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(~(val >> 32) & 0x7f, data->vrm));
 }
 
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, SHOW_TEMP);
@@ -112,7 +112,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
 	struct via_cputemp_data *data;
 	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
 	int err;
-	u32 eax, edx;
+	u64 val;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
 			    GFP_KERNEL);
@@ -143,7 +143,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
 	}
 
 	/* test if we can access the TEMPERATURE MSR */
-	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
+	err = rdmsrq_safe_on_cpu(data->id, data->msr_temp, &val);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Unable to access TEMPERATURE MSR, giving up\n");
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index ab61fb122937..c6772a5e073a 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -181,17 +181,17 @@ static u32 get_temp_mask(bool pkg)
  */
 int intel_tcc_get_tjmax(int cpu)
 {
-	u32 low, high;
+	struct msr msrval;
 	int val, err;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &msrval.l, &msrval.h);
 	else
-		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &msrval.q);
 	if (err)
 		return err;
 
-	val = (low >> 16) & 0xff;
+	val = (msrval.l >> 16) & 0xff;
 
 	return val ? val : -ENODATA;
 }
@@ -208,17 +208,17 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, "INTEL_TCC");
  */
 int intel_tcc_get_offset(int cpu)
 {
-	u32 low, high;
+	struct msr val;
 	int err;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &val.h);
 	else
-		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	if (err)
 		return err;
 
-	return (low >> 24) & intel_tcc_temp_masks.tcc_offset;
+	return (val.l >> 24) & intel_tcc_temp_masks.tcc_offset;
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, "INTEL_TCC");
 
@@ -235,7 +235,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, "INTEL_TCC");
 
 int intel_tcc_set_offset(int cpu, int offset)
 {
-	u32 low, high;
+	struct msr val;
 	int err;
 
 	if (!intel_tcc_temp_masks.tcc_offset)
@@ -245,23 +245,23 @@ int intel_tcc_set_offset(int cpu, int offset)
 		return -EINVAL;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &val.h);
 	else
-		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &low, &high);
+		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	if (err)
 		return err;
 
 	/* MSR Locked */
-	if (low & BIT(31))
+	if (val.l & BIT(31))
 		return -EPERM;
 
-	low &= ~(intel_tcc_temp_masks.tcc_offset << 24);
-	low |= offset << 24;
+	val.l &= ~(intel_tcc_temp_masks.tcc_offset << 24);
+	val.l |= offset << 24;
 
 	if (cpu < 0)
-		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, low, high);
+		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
 	else
-		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, low, high);
+		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC");
 
@@ -279,7 +279,8 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC");
 int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 {
 	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
-	u32 low, high, mask;
+	u32 mask;
+	struct msr val;
 	int tjmax, err;
 
 	tjmax = intel_tcc_get_tjmax(cpu);
@@ -287,19 +288,19 @@ int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 		return tjmax;
 
 	if (cpu < 0)
-		err = rdmsr_safe(msr, &low, &high);
+		err = rdmsr_safe(msr, &val.l, &val.h);
 	else
-		err = rdmsr_safe_on_cpu(cpu, msr, &low, &high);
+		err = rdmsrq_safe_on_cpu(cpu, msr, &val.q);
 	if (err)
 		return err;
 
 	/* Temperature is beyond the valid thermal sensor range */
-	if (!(low & BIT(31)))
+	if (!(val.l & BIT(31)))
 		return -ENODATA;
 
 	mask = get_temp_mask(pkg);
 
-	*temp = tjmax - ((low >> 16) & mask);
+	*temp = tjmax - ((val.l >> 16) & mask);
 
 	return 0;
 }
-- 
2.54.0

