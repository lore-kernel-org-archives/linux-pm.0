Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6F4F405C
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737549; cv=none; b=iWYeJ+Itk7XWYHCqkatO1Xx3wGC69mSCEe3REQEJMteVz64Fa7x57bVhrOPybK1Sixwn9MkGyI7NwfELvhv/94O6D4qe8KxDajA7Z3gBiku3yHMKIfsoB9DAaxSmw5w7M45pgI3o3390WNlFdGAgvSlyzTUvhpDxfylpsx8WL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737549; c=relaxed/simple;
	bh=Ixxw6mUKGozOVNHy36L9BvzO5kqYLozMBT/gU9qeUOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ab5giJjhM3o62kvlxku9j7q8Nt9Hm9evKjWG6zyMP5Iv34WVZ5uhseOcB8NCxKdB1fepdkgVxKPZKILYkzISULnw8YkeWwKb3BrsBl133cAoKy3EvXUeKgy/ziEy6sQM7sBEfh4NuJyAHWZgfgXYVoTAWQjEiSzDYF3A1LM9Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1Eb7/rl; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1Eb7/rl"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e64b80b94so5225005e9.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737546; x=1790342346; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otp0k2i4YCw4bQ4ES7pDpC2btKFgr9S5MNUmkPBiGJY=;
        b=o1Eb7/rlK1f1qEgO9/FbW6pwr3Gmax3B9DId5N5XUuMB88+tQXobw01zLLj0TlxY/P
         qxxIUHURTc7oOyIih/rVhbD3BEP2mqPO6Ph5MRn0uwyFZ8GZLXRaAChSc6znq4wPI2pL
         j4aIOyM+MIJj9kQG+m0PM9G6VdlZ1RstChc0WEfLekX9mzB8YtfvG7zZf5k1++JEQoTZ
         fnebapytxT/jxSl6nb2G/K+OS12HQ/vZb6mx3OP7YT0azoVfGYcQMQuYdUz0Y1uINEpC
         OPWgi85jpu7+O4hcSwrcy/0/nv3Cak3BPAl/+EXk7phD4gmnBPG2f1ZuBZFKguBHT2n6
         sXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737546; x=1790342346;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otp0k2i4YCw4bQ4ES7pDpC2btKFgr9S5MNUmkPBiGJY=;
        b=s6Q1pN2SOFR3i1Z83fbW/kZ4IxYloUvuUKollFHg3CVzzt8laQK0IVjGgBQCdIKdWU
         DSuhrIH0n/uZnvcX8GZ6VgtbUqngV2k7SXtsAJ1vcl66czA49k8EWVRXgDTP8JSdocwO
         8GREZvwOrSggAwUjgvGhLxgCJ9Z91BaXZPgXpyPz70aRztYSnsTLv8fpgzLE36Yf2vuh
         hYXgUbKEGlyfzZD5fJAxjgGEmmf1d7gNqbnmkrwIPGdJSbDltnHwkIvAmLxs9fpRBZht
         xy/aUljB18w98TTaT+nOqDfJvIkp+NAOjF3epq+um5NnDdiLmVVYy2TGQZe+OVx7tJEK
         i/4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzl78U7wT859eh4YkjevWEvHTs4XSCTIuDWcdeE8xWkZtRLqd82hwt2oNJ+c7xh1JQfPkSBgsRIxA==@vger.kernel.org
X-Gm-Message-State: AFuF++khPL6AX/iDKG8y29UCU9xLKhtizkSmVrSkiOOniGsCGDUX8pG0
	Y0jwUoNSIlOfqdmPD0XbxUXYZa+8fkAa6vcTJNlGIjVr4vijyeudAGI3sTBXORtysMJFbc/YljX
	1BK1wYgLHWBR7mJPVAgcOcw==
X-Received: from wmps28.prod.google.com ([2002:a05:600c:319c:b0:49c:caed:426c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64c5:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-49fc56aa4e7mr86535595e9.7.1789737545460;
 Fri, 18 Sep 2026 06:19:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:16:56 +0100
In-Reply-To: <20260918131656.3710047-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918131656.3710047-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918131656.3710047-5-vdonnefort@google.com>
Subject: [PATCH v1 4/4] arm64: mm: Allow can_set_direct_map() on BBML3 systems
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org
Cc: mark.rutland@arm.com, lenb@kernel.org, pavel@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thierry.reding@kernel.org, rppt@kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

On BBML3 systems, block mappings in the linear map can be split
dynamically at runtime without break-before-make faults. In such
systems, allow can_set_direct_map() to enable set_direct_map_* users.

split_kernel_leaf_mapping() must now allow splitting for BBML3 systems
where no feature requires a split (i.e. !linear_map_needs_set()). As a
consequence, it can't solely rely on linear_map_requires_bbml3 anymore.
Instead, deduce force_pte_mapping() value and filter out non-lm
addresses.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/mm/mmu.c      | 24 +++++++++++++++---------
 arch/arm64/mm/pageattr.c |  2 +-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c18ed601f0a8..4c345065d33f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -811,24 +811,30 @@ static bool linear_map_requires_bbml3;
 
 int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 {
+	bool force_pte;
 	int ret;
 
 	/*
 	 * If the region is within a pte-mapped area, there is no need to try to
-	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
-	 * change permissions from atomic context so for those cases (which are
-	 * always pte-mapped), we must not go any further because taking the
-	 * mutex below may sleep. Do not call force_pte_mapping() here because
-	 * it could return a confusing result if called from a secondary cpu
-	 * prior to finalizing caps. Instead, linear_map_requires_bbml3 gives us
-	 * what we need.
+	 * split:
+	 *
+	 * Do not call force_pte_mapping() here because it could return a
+	 * confusing result if called from a secondary cpu prior to finalizing
+	 * caps. Instead, retrieve that value with linear_map_requires_bbml3.
+	 *
+	 * Additionally, CONFIG_KFENCE may change permissions from atomic
+	 * context so for this case (which is always pte-mapped), we must not go
+	 * any further because taking the mutex below may sleep.
+	 *
+	 * Finally, set_memory_* can be called on PTE-mapped vmalloc mappings.
 	 */
-	if (!linear_map_requires_bbml3 || is_kfence_address((void *)start))
+	force_pte = !linear_map_requires_bbml3 && linear_map_needs_set();
+	if (force_pte || is_kfence_address((void *)start) || !__is_lm_address(__tag_reset(start)))
 		return 0;
 
 	if (!system_supports_bbml3()) {
 		/*
-		 * BBML3 systems should not be trying to change
+		 * Non-BBML3 systems should not be trying to change
 		 * permissions on anything that is not pte-mapped in the first
 		 * place. Just return early and let the permission change code
 		 * raise a warning if not already pte-mapped.
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index c1ba74eb602f..f952cc125705 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -89,7 +89,7 @@ bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
 {
-	return linear_map_needs_set();
+	return linear_map_needs_set() || system_supports_bbml3();
 }
 
 static int update_range_prot(unsigned long start, unsigned long size,
-- 
2.55.0.1082.g2b9226bbc0-goog

