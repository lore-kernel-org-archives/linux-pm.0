Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2373932D5
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262457; cv=none; b=JAoHo+lWDysQcGoyeDtiLKpOhq8NefyinaMEOrLB56QK7552t9aZYRZzJ13rHzEAV7hukeMMvhp79G3ZQf9MQ6hDJX1qdsKoFWXNFIzPT6kBpz0ZNMjgoXiP6+HVQhJlio7o16USp5nj9a90wQ9a8Z/zu934PwN2HNiU6HMvICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262457; c=relaxed/simple;
	bh=fhx1FsZvbL+7Z6ubNkIzzDm1cdSx/W9etVKPIrEFWWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/IqNWlfiMMHRFDJZ0nOhaaC27yj4beWr9NqRQsEiJ7HKFdW30Tu12DPvH/o/7k7+vKTytQ/gdg6//dAvZDEJ+AyayhDBWulusqN9XZyUzgwYoQJdjvLwt95gnn/6cedMJPNgQQqOgszxuotqqHiSRc9UCBeto22eVxb6JICMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDXs6rlR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDXs6rlR"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e7391839cso887152a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262454; x=1788867254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSTftTM7ayeET7JuSORVBV3fyBOCZeg8g4qShMXHwdI=;
        b=ZDXs6rlRWdJ+X50i+AUCwVmzre12nqiOv66epithl0tCHf5Hipwo4/kAaZUJ0fx1oG
         Y+GOugguLqQr+kiVJByBtHCsFEgygg6KtiNEL/URa6Fdbwe2HJ5bh5j8+8hxIzG3vYXB
         +BkmLXXfuqnNZ3rBs3vyMDLKRM1PWy3ZbdxsL5YBocMkL361HBvWJVvwG7M0Bcd9MbgL
         JQYDue1y9JFrOWwe5heAett2YYY+tWrasnFl/kr50a7vA61v75tSzUmjtCm6LafRzcaf
         AV/0rETb6Dp8/hMyEyv+gNLUJF2DzpwTr++T/eTEEbu2Am8aiWvYyHdCQlJ57CvKeqYT
         Bc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262454; x=1788867254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSTftTM7ayeET7JuSORVBV3fyBOCZeg8g4qShMXHwdI=;
        b=GKaPLpKE1fE2jeZE6cb52l0Q9grKiPmKBHG18P9zqBbMtc6/I72PaZy4wFhNpYnaEk
         Lwe4uD40sKtxVO1u2eRAet/6ikApg889qJklGsyfO7V6jQ+14iY4J9Z0hD4agoFIstl4
         ib1gsJeezLRgNszbfAh5ScHEvBkCfwHdIDTBwb+Wbqc5+faVM2A5Et5o5UpDZule12UV
         BJnbndkw6Aso3cYsz1HXN6NrtRr+t61Ju73tyOjuapzThQwupA3ckp8eC7rzHqMG36Bh
         je1n9y+ckiZlxi+lfCulTGTLq9+VQnOHc4DV7FUzS30IBBALBdelssDSAd8FJFnTIpz9
         ggYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXbDDoCnIhpxGF5vsw7ILjcLR3UVdPLj09BsO9jGWcl/B6ZBzyHXuy2GtWMFhkgqmctZN/Jthr0g==@vger.kernel.org
X-Gm-Message-State: AFuF++lHXJLrlAttopPoSkHc7nAm6Sbw8i9i3K/9ity9BzvFLftN0ZSW
	JR/XsCxft/30AvCssPTl3E3EeMbicbGECYZ3HtC9qoHw2xd+p+L3LEln
X-Gm-Gg: AYBFou3xmlrgMQF3Zxk22wsyIkCXmGUcy89+CwSg2as3HWl2+yEtgukGVgiitKlORTH
	XdYjN4Z2iKSSRuJ8f/dP6loa4T9vwtH+c3h344McGmGsLYGE9z2TVsqGuQJZ+ay1ivIxmr8lTxN
	gfsTkijcFT+Zg2rb/181FCo0uz18rSkqBp4TJcfS3deHwg7WZEJx5IfabKilVcSTEkKzrWmTMcv
	EVH5zKENsEyJ9PF5OtfO63KBSFTD23hcKthVutBKWeCsDs2nobTTZqmNZe4r8IvOz99maN/OuRe
	P/rNI2pIS4aH2Jza34NPIGHEXvOAxV8xSo/2H9NU8GLkKBUyNf4nbqzClToPdEC9g+YGElupQln
	HrgHeV+HTw4XXJCMCjGDYBxuu+DA89lxw2RuQjYcgdPfMyVeovbG6oFw4PVYkAP6r0psIAi9rH5
	K9aG1rrZBNfvaYIN8jyPweAsHkC3BGqJSpzH/wqYKGYS9VY+KLBvGNVkVCQaAr/zNS80Wbgykl8
	p1VH2Ab7EJIdusg4dRoOibVD1RF5hFiloz6g765jR5QZA==
X-Received: by 2002:a17:90a:1c97:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-398b1eb1c02mr20501909a91.9.1788262454195;
        Tue, 01 Sep 2026 04:34:14 -0700 (PDT)
Received: from overlord.home.arpa (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm41447470eec.8.2026.09.01.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:34:13 -0700 (PDT)
From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	rafael@kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
Subject: [PATCH v1 2/2] efi/tpm: Persistently reserve the TPM event log
Date: Tue,  1 Sep 2026 04:34:08 -0700
Message-ID: <f6a746a26d2d02ce9de279db9d5928da72eba610.1788259938.git.jasmeet.bhatia.us@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
log to avoid corruption") changed the TPM event log allocation from
EFI_LOADER_DATA to EFI_ACPI_RECLAIM_MEMORY so that the memory would
remain reserved across kexec.

On x86, EFI_ACPI_RECLAIM_MEMORY is represented as ACPI data in the
E820 map. If the EFI allocator places the event log at a different
physical address on a subsequent boot, this changes the firmware E820
map.

x86 hibernation records architecture-specific information derived
from that map and rejects the image when it differs on resume:

  Hibernate inconsistent memory map detected!
  PM: hibernation: Image mismatch: architecture specific data

This occurs on a Framework Laptop 16 (AMD Ryzen AI 300 Series), where
the EFI allocation backing the TPM event log was observed at different
addresses across otherwise ordinary boots.

Allocate the event log from EFI_LOADER_DATA again so that the
Linux-created allocation does not appear as an E820 ACPI region.
Preserve the kexec protection provided by commit 77d48d39e991
("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
by adding the event log range to the Linux EFI persistent memreserve
table.

On Linux 7.2, the stock kernel failed hibernation resume because of the
E820 mismatch, while both an EFI_LOADER_DATA-only diagnostic build and
this series resumed successfully.

With this series, the TPM event log range remained reserved across
both kexec_file_load() and kexec_load(). The contents exported through
binary_bios_measurements were byte-for-byte identical before and after
both kexec tests.

Fixes: 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
Link: https://lore.kernel.org/all/DL3MNWW4VEBR.K3K6A92WMHUY@gmail.com/
Signed-off-by: Jasmeet (Jazz) Bhatia <jasmeet.bhatia.us@gmail.com>
---
 drivers/firmware/efi/libstub/tpm.c |  2 +-
 drivers/firmware/efi/tpm.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a5c6c4f163fc..8e04aaf428d0 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	}
 
 	/* Allocate space for the logs and copy them. */
-	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index cdd431027065..9771cc91d71e 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -15,6 +15,9 @@
 
 int efi_tpm_final_log_size;
 EXPORT_SYMBOL(efi_tpm_final_log_size);
+#ifdef CONFIG_KEXEC_CORE
+static unsigned int efi_tpm_eventlog_size __initdata;
+#endif
 
 static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
 {
@@ -68,6 +71,10 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
+#ifdef CONFIG_KEXEC_CORE
+	efi_tpm_eventlog_size = tbl_size;
+#endif
+
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
 		goto out;
@@ -114,3 +121,23 @@ int __init efi_tpm_eventlog_init(void)
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_CORE
+static int __init efi_tpm_eventlog_reserve_persistent(void)
+{
+	int ret;
+
+	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR ||
+	    !efi_tpm_eventlog_size)
+		return 0;
+
+	ret = efi_mem_reserve_persistent(efi.tpm_log,
+					 efi_tpm_eventlog_size);
+	if (ret)
+		pr_warn("Failed to persistently reserve TPM Event Log: %d\n",
+			ret);
+
+	return 0;
+}
+late_initcall(efi_tpm_eventlog_reserve_persistent);
+#endif
+
-- 
2.55.0

