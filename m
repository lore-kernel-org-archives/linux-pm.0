Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6C25B0B8
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737545; cv=none; b=b9Q3aXZO0kwU1XwrZwWtt8NrYxWGzhqeUeyaHUhbrOFmkOGdBr3MygmnTC9M8KpTLeWR0iWmRIb78TY6ZlXSW8QvywXx7bTYZSA6rTCqrOLZE4j0qNyauLao96RhNq/CXMdKNrVIoOeTfzhBfxFeOaCJjqkenZ8BV5tWbEzOU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737545; c=relaxed/simple;
	bh=LNeh7zm2p73PrVkoXPGxxYDKl/Dawye1sRPQQGYDQUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=We0+GZzdSE+KO9bPrQwpTHru5iCBOhla8zcnrtZp+DZLAIy2p6hnr9Iiy0spSzn2RV0xOZH1NoqTorJz1x+GARAl9kRXYpDLYSq7YXiLynWYynLKRMogO06JV1zTLO/PCFF7deIABp5tyoRHedPYYqszMVrgZ/wNdGwK+KL1hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkH2B9ew; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkH2B9ew"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49953abe51fso5357425e9.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737542; x=1790342342; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lo1KsoI1XuIoEcDs+Ce0ZXJLIqJlsl+upMRklAIDXKY=;
        b=jkH2B9ewBvDogcSCWHJKJIoq/E0sO5yeZz+l0xIIx27/rE6uQaOyZKWghRpsbjhf77
         HuVrom5088a0ylxgjCNFdNv+7zTtwtB1/5YvmU+BnEDSk6bGjzhHZURoeoH8kJ3Q5u/P
         82L0GBuvY/u50AYirQCMPU27pncx4BTecQDQPmPSSTV/OLp2zroVivBjNBIhTvDKD8Px
         cm/xiBn9qU84PP7hK7cOF0rmQicexuN+FCUllPCSc3CQwO5bcr56CbRkM0XK3lWy27V8
         PCXPTz/l7w+cOuPZDvDZSDPsF+q1wedTevEUUzxtIT+5ctD1nZJpqkrqO/slalxC5EWg
         CXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737542; x=1790342342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lo1KsoI1XuIoEcDs+Ce0ZXJLIqJlsl+upMRklAIDXKY=;
        b=rtPCvh7u4MCZIJQkaAuHzpc4oiRK6xMzRROzj+2vY5WWoKFCRAN2P19okx7gJg9Tfq
         eMxH7fC4A03MkrJ7+hIKPBBF4DOjXc21bd+Kpef5Dh444SBvAnBwZkzJlXF3lvoR5YTW
         lF6AJY7+KvKxp6hOayfJnAmxW1PixvxmRBmKazK/3eek0xdJaJxYM6bSfcSN7poYXJSH
         +b5qqbIFolsmfeaVAWdR9lJJeJrk2fng8ZB6nX+NP1Mqwvv721mGCnJgTnr9KxfPmsM0
         3DKovVXAOQFRm6Pbt8GQpg2QXsfOzDWn1csGML3T7HNkXK0CT1+6DXzFJqOq9HaW7q8p
         LIeg==
X-Forwarded-Encrypted: i=1; AKwUvBx09SksfUlK3o2tHJ4vpWsJY6tY1+GS5nk+uy9WvHq3tvNUiBUBZhSTad44eph3mc3A4zXhQ2abjg==@vger.kernel.org
X-Gm-Message-State: AFuF++kEefou7dSIwq2hh3+dBKdYSTL+FJnbUarBKkL3HEWm7fwdcLbN
	+xjIjXNMd0XCV/m6trveh6bABcVgTJXbtb70DqjLV1j1RhyUh/vL6dYTv/OcmxUDmfP/3DoruNI
	uNMxuJuP/SZBNAkPf30Ypgg==
X-Received: from wmbje21.prod.google.com ([2002:a05:600c:1f95:b0:49e:6e7c:4200])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3550:b0:49e:7d74:7b7a with SMTP id 5b1f17b1804b1-49fc56db8f3mr33347175e9.6.1789737541522;
 Fri, 18 Sep 2026 06:19:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:16:53 +0100
In-Reply-To: <20260918131656.3710047-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918131656.3710047-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918131656.3710047-2-vdonnefort@google.com>
Subject: [PATCH v1 1/4] PM: hibernate: Add arch specific hooks for hibernate_map/unmap_page
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org
Cc: mark.rutland@arm.com, lenb@kernel.org, pavel@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thierry.reding@kernel.org, rppt@kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

hibernate_map_page() is called from an atomic context. This is
problematic for Arm BBML3 systems where the linear map may contain
blocks and is allowed to split as splitting is a sleepable operation.

Add arch hook so arm64 can define its own implementation without relying
on the direct map.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/suspend.h |  2 ++
 kernel/power/snapshot.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..10fe2298d94e 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -401,6 +401,8 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data);
 int hibernate_resume_nonboot_cpu_disable(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
+void *hibernate_map_page(struct page *page);
+void hibernate_unmap_page(struct page *page);
 
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index b209712cb2c3..b41952f1de2a 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -85,7 +85,7 @@ static inline int hibernate_restore_unprotect_page(void *page_address) {return 0
  * It is still worth to have a warning here if something changes and this
  * will no longer be the case.
  */
-static inline void hibernate_map_page(struct page *page)
+void * __weak hibernate_map_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		int ret = set_direct_map_default_noflush(page);
@@ -95,9 +95,10 @@ static inline void hibernate_map_page(struct page *page)
 	} else {
 		debug_pagealloc_map_pages(page, 1);
 	}
+	return page_address(page);
 }
 
-static inline void hibernate_unmap_page(struct page *page)
+void __weak hibernate_unmap_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
@@ -1456,8 +1457,9 @@ static bool safe_copy_page(void *dst, struct page *s_page)
 	if (kernel_page_present(s_page)) {
 		zeros_only = do_copy_page(dst, page_address(s_page));
 	} else {
-		hibernate_map_page(s_page);
-		zeros_only = do_copy_page(dst, page_address(s_page));
+		void *src = hibernate_map_page(s_page);
+
+		zeros_only = do_copy_page(dst, src);
 		hibernate_unmap_page(s_page);
 	}
 	return zeros_only;
-- 
2.55.0.1082.g2b9226bbc0-goog

