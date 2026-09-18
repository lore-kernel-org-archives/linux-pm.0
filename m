Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF14F30DC
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737547; cv=none; b=c/UkSwm1SpkcStPpFW2PItnnr57tdWkkMbrbgbvWNwkbBXKzD8AJHLupHGyptWrvqws43iJo6iqXAV6lAqWWhtNZ8RAmFOK3tAVGvTd+rOHC+DLtdWto6nyQRncD2c70Ay3iZs8UeWRDsSEbnsy+GoGvj3moKWoitvIFVe/tEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737547; c=relaxed/simple;
	bh=GrzDV6cczkYxjO5tC/93Uw9vwmtlbRDBmm6zE9MIKJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gylF9n624GNcDJgypQFXjDGcPYht7YAvBI5YnO2mGS8+QrC/VSjCwFtF2SxvcpUZXkrvdK69ICSDTY4UvC7ICDBKATMuAgW3FQ19YVASiQF/R6C1mt3BKfCk1i487xk7hcoPAgCq4LrlbU79uTK3mG4vcz9pTOj4o0ZDOlldKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/JFIC4z; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/JFIC4z"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843e59c32dso636643f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737544; x=1790342344; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aOX9z3d/XK6ZHrErASZL6mYBZmtA4GVOMC24/C+YOg=;
        b=R/JFIC4zEEQpEff/oP2df94bgAiDtd+SE/pejnaF/QeIS71LUweyItTE7HpAxCZ2fP
         xl2bZHyQhulpFc5LSOlYLF5L5Q9fwgKT69h0TUjNwap7yIi2RK0Zr2T5X0BFMdK+zucw
         8Y06uQ9jD4KqyUvXg6UWPeLOUcoN8jdtsRZYZo+16sK3sYyDoAPW1k1q/IOfuQpAxVKj
         8RMfBoAM5/p1Gf5FP93KmZOUtrfqy90KrHdQ8ld8JGMrVJfvdN7LuYepmpeBnV5CyY5e
         UQk2vMQxiMHymM0k/0Co7Dy/adOvSO7gwweFfJPbjNe8d3t7NQmMMgixVv6+xNZIDGtp
         kjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737544; x=1790342344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aOX9z3d/XK6ZHrErASZL6mYBZmtA4GVOMC24/C+YOg=;
        b=W5+5UpVWV7x7d19TctXzha4v59YxmdpdX+MBUzyn7G1A9AsusndbJkyfOaX2t6u7qT
         MZuYuwwsWJflHbDWayLCXsRszAvS8qqzEjXEXKTqAamdVXb6Lg6zLvhAkgvIyg5fVtbQ
         FcIMod54cLpYkaF+QAwmVgj1+LQlvU0MqRZz9oNXWWOnCSZ6DzGGCUaSq5IbcJmDKuIN
         VBcTEjpHywPGoSvW1rI6pVS4B5YujgzMMLonu/shCkVgydRWWNx5JkL4NMKgNkWAdjr0
         6ew6tkzVVRlhmtVKjCJcpVO1LLCsDdnD+2g/vmw0K6jQgtjVtdE2B/cS9BYG4eiXC/5c
         MqEA==
X-Forwarded-Encrypted: i=1; AKwUvBwuHA9iHDL7VyWNnY4T1Up6Rkig1Gk2II9IKxqnOyWtNziKQROq0on8oPUGkWmRGoM3r9nd8JTOMA==@vger.kernel.org
X-Gm-Message-State: AFuF++mqZNZCB5uiUXTLvd2rJOhIAZAPsIOa+LzAKbCZou8KdFgBMn0S
	7Sj4UFjKGTI84ypB5K9s1gSLynHE/aCtpWfXTrurRVU79DsMVA41eTkjn3cHdJhoyF/O+O++hsY
	+RjslmGAUSfXHeZZz28Vm+Q==
X-Received: from wrdf12.prod.google.com ([2002:a5d:58ec:0:b0:487:11c9:7de9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2884:b0:487:360:5be1 with SMTP id ffacd0b85a97d-4871e2112femr3684285f8f.8.1789737544221;
 Fri, 18 Sep 2026 06:19:04 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:16:55 +0100
In-Reply-To: <20260918131656.3710047-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918131656.3710047-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918131656.3710047-4-vdonnefort@google.com>
Subject: [PATCH v1 3/4] arm64: mm: Introduce linear_map_needs_set() helper
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org
Cc: mark.rutland@arm.com, lenb@kernel.org, pavel@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thierry.reding@kernel.org, rppt@kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

can_set_direct_map() is intended as an external query function, but is
also being called internally by map_mem() to initialise
linear_map_requires_bbml3, duplicating the feature checks already
present in force_pte_mapping().

Factor the list of features that require modifying linear map attributes
into a shared helper linear_map_needs_set().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/mm/mmu.c          | 22 ++++++++++++++++++++--
 arch/arm64/mm/pageattr.c     | 12 +-----------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..12ed21e2d0d7 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -70,6 +70,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
+extern bool linear_map_needs_set(void);
 extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
 extern void linear_map_maybe_split_to_ptes(void);
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..c18ed601f0a8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -776,6 +776,24 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	return ret;
 }
 
+/*
+ * True if the linear map needs to be modified for one of the following
+ * features:
+ *
+ * rodata_full and DEBUG_PAGEALLOC need to protect/unprotect pages in
+ * the linear map.
+ *
+ * KFENCE pool needs to protect/unprotect pages in the linear map if
+ * initialized late.
+ *
+ * Realms need to mark pages shared/protected in the linear map.
+ */
+bool linear_map_needs_set(void)
+{
+	return rodata_full || debug_pagealloc_enabled() ||
+	       arm64_kfence_can_set_direct_map() || is_realm_world();
+}
+
 static inline bool force_pte_mapping(void)
 {
 	const bool bbml3 = system_capabilities_finalized() ?
@@ -785,7 +803,7 @@ static inline bool force_pte_mapping(void)
 		return true;
 	if (bbml3)
 		return false;
-	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
+	return linear_map_needs_set();
 }
 
 static DEFINE_MUTEX(pgtable_split_lock);
@@ -1203,7 +1221,7 @@ static void __init map_mem(void)
 
 	arm64_kfence_map_pool();
 
-	linear_map_requires_bbml3 = !force_pte_mapping() && can_set_direct_map();
+	linear_map_requires_bbml3 = !force_pte_mapping() && linear_map_needs_set();
 
 	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c..c1ba74eb602f 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -89,17 +89,7 @@ bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
 {
-	/*
-	 * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
-	 * map to be mapped at page granularity, so that it is possible to
-	 * protect/unprotect single pages.
-	 *
-	 * KFENCE pool requires page-granular mapping if initialized late.
-	 *
-	 * Realms need to make pages shared/protected at page granularity.
-	 */
-	return rodata_full || debug_pagealloc_enabled() ||
-		arm64_kfence_can_set_direct_map() || is_realm_world();
+	return linear_map_needs_set();
 }
 
 static int update_range_prot(unsigned long start, unsigned long size,
-- 
2.55.0.1082.g2b9226bbc0-goog

