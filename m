Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBF384CE9
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262455; cv=none; b=CburwvcfaL8eVMTQIkRTSafPvyq4I7/KBvmKBrLYGTwvFGtdnHLAI8ptwygHhy2qXCwgEtvbylBm5vX6fQhlaaK/N6mywT/kRVs3kgOwY5ymap+DeVl5Q1WBR6vEb1jBm9mzrdKdk6Ir4kbg+diaEHwCSsB6yIN7TMVXagL6QpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262455; c=relaxed/simple;
	bh=cWXWqzgZ6EzkJijPSxMiirfRi4OQcwgKxYz+zIUuXYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyNuccoYSO4b3Jk1+s2v2L4NrMdAiP0DR0RlFeuLPEVEHOGhgh3UxmuFgJXMskbEQ+mZYedZaSD1t5Sf56BzSKlOgyFHhH5wHTUXE+X5oZTIAAEjyqpirAJXwgbplfKv4Kefyua8poglJW8/uABRYLVZgUIqoZY9fyE0hDyjVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuHZDuD0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuHZDuD0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf452def93so8424335ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 04:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262453; x=1788867253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5b4XLc/S0guAvnfK57cAFeTiBvZBRE21WVSi52BFiM=;
        b=XuHZDuD0OmbNtjQASTkIMoMDUEHLQEI9M+hIoHXjhNzPEQ1evx3MVUk0vCKWSijctK
         xSVeYe4Lg3n0yJ4uFAS3/h+scjmIvxje9KGdzByjSjC0RfM2Rw5OcGxfnEsXqu4ntLNB
         PH2ErJLbnc8PG83O3TIZf/xL1CM9y0ZIPfS61P7FX174lsPud6sqLbo/jkKzirrnjmIn
         QD1IVibJofzixRA20ky+8W/cOqOsthb9cUoBJbpoxEg+GM2Y2RIZOF2e/mvEXoPlFtlv
         ud6VsjDZV97sGoQ6UwUjGUSWtD/EY7xjqyVj9RMWaYTymhOld5/q3qYMcoOgHf+n4Cys
         u3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262453; x=1788867253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5b4XLc/S0guAvnfK57cAFeTiBvZBRE21WVSi52BFiM=;
        b=TtswQ3idn7hUnxUiqQmLFMlSgEXyhnBlTEMVDoOOIOZkf22mYdNOyHP0+8Z4z1eDfQ
         g4xe53RFbyrAMrjG9DGPhSpH3/McBgGqOpEh1RnejLvrm4UGEeCDvJwsbeTLVX/cs1Aq
         YxjoxaqquaQst6h0YtBRwQl0uXqCfqoX4fonEKi0Tai02RgsKJkMufE/2JxBVx0ljGxK
         VXmSseek1s8cbiR85gtiBXpy35NeM65Kiqtm7AtHG2/yATmFaM1PM6xEUl9wK2Fk+xXV
         W5UnYp7u0CczSymVBGAG504LNOOagElsOh+a8A7Cd+bM+w20KUOKfndug6KCzG1hlMYP
         gILg==
X-Forwarded-Encrypted: i=1; AKwUvBzaBMIWwGSQz9RKnnYLE+Zx3Tx8nAycu9Oj5XL5eMb7vT+jkVufjC9THFRRwW6mPS8yxsCmPS8ICw==@vger.kernel.org
X-Gm-Message-State: AFuF++nbQrtRk3nY0hA8AlLmOZC4Gq0Or562EwhCAGL+64o9WLvbJ13W
	VexD3FK8xIZDKX8wLphtk9KmjaIkhftbMmF3bcAhpGQsmbpdYDYj9clw
X-Gm-Gg: AYBFou2rMf0buBD5hS5sYk3ml89nt4tW7ORHwMndVy11lRtcxw3P6N+0hlieKY9voIy
	Bw5hDJRM2beuZKx2CGij6/E7VTHs597KkqmxlHg8YOwtXq45QFB2Y7rUM98SmRN3xi05uP1YNGS
	IRs5t7CREs9sP24GZKt0KIU9dmy7hQx41ncoy1VVXKhO7SeHo/7wg/4Fv6o2l+M8lPQzUsNvTZr
	bblkpZRiQnmGeqlxgyqTq2nzvl9SVuAYeJSdjiMBlWPqIUwmGONtVy3U3IEBpKMJXNbjXJNVNHT
	EnVSIJRjA1+gmw/Migzn6GzVFIlu96Zek1OhtKY/wE6efmvZNSM7/KcgjC9+hTXizjEjQDdUMih
	8mXlrH2hNTZedklmoLooSoOKoLKCWRkFsN7UPWbt0jmgFNu776MRjXYKRRt0pVB/S4Xa1ogXE5L
	z45/YU1yr1IVcrZQ755VuTh7e3+ZQitvfNi6fJGjA9IFCJK80cZvVCEFr7uNTXoIfja5zEEWt3b
	BO2nSejJZYj2M3TEa0buVVFaHJMixS6EJQ=
X-Received: by 2002:a17:90b:33c6:b0:398:ceed:b903 with SMTP id 98e67ed59e1d1-3990f7693e4mr4193506a91.11.1788262453118;
        Tue, 01 Sep 2026 04:34:13 -0700 (PDT)
Received: from overlord.home.arpa (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm41447470eec.8.2026.09.01.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:34:12 -0700 (PDT)
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
Subject: [PATCH v1 1/2] efi/libstub: Install memreserve table on x86
Date: Tue,  1 Sep 2026 04:34:07 -0700
Message-ID: <08dea57d1e1190a3dab0f6cd424c07a07b0760b8.1788259938.git.jasmeet.bhatia.us@gmail.com>
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

The generic EFI stub installs the Linux EFI memreserve configuration
table from efi_stub_common(), but x86 uses a separate EFI stub path.
Consequently, efi_mem_reserve_persistent() cannot be used on x86 when
no memreserve root has been installed.

Move install_memreserve_table() to the common stub helper code, expose
it through efistub.h, and invoke it from the x86 stub before exiting
boot services.

This allows x86 kernels to add persistent EFI memory reservations that
are carried across kexec.

Signed-off-by: Jasmeet (Jazz) Bhatia <jasmeet.bhatia.us@gmail.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 23 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       | 23 -------------------
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/x86-stub.c       |  2 ++
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f27f2e1f0019..9ea0ed0ed7d1 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -27,6 +27,29 @@ static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
 int efi_mem_encrypt;
 
+void install_memreserve_table(void)
+{
+	struct linux_efi_memreserve *rsv;
+	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
+			     (void **)&rsv);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate memreserve entry!\n");
+		return;
+	}
+
+	rsv->next = 0;
+	rsv->size = 0;
+	atomic_set(&rsv->count, 0);
+
+	status = efi_bs_call(install_configuration_table,
+			     &memreserve_table_guid, rsv);
+	if (status != EFI_SUCCESS)
+		efi_err("Failed to install memreserve config table!\n");
+}
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 42d6073bcd06..e378dd7db682 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -77,29 +77,6 @@ static struct sysfb_display_info *setup_primary_display(void)
 	return NULL;
 }
 
-static void install_memreserve_table(void)
-{
-	struct linux_efi_memreserve *rsv;
-	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
-	efi_status_t status;
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
-			     (void **)&rsv);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate memreserve entry!\n");
-		return;
-	}
-
-	rsv->next = 0;
-	rsv->size = 0;
-	atomic_set(&rsv->count, 0);
-
-	status = efi_bs_call(install_configuration_table,
-			     &memreserve_table_guid, rsv);
-	if (status != EFI_SUCCESS)
-		efi_err("Failed to install memreserve config table!\n");
-}
-
 static u32 get_supported_rt_services(void)
 {
 	const efi_rt_properties_table_t *rt_prop_table;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index fd91fc15ec81..8656d6a545e5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1168,6 +1168,7 @@ efi_enable_reset_attack_mitigation(void) { }
 #endif
 
 void efi_retrieve_eventlog(void);
+void install_memreserve_table(void);
 
 struct sysfb_display_info *alloc_primary_display(void);
 struct sysfb_display_info *__alloc_primary_display(void);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..4a24126ccfd9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1015,6 +1015,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	efi_retrieve_eventlog();
 
+	install_memreserve_table();
+
 	setup_graphics(boot_params);
 
 	setup_efi_pci(boot_params);
-- 
2.55.0

