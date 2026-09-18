Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94437A85B
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737546; cv=none; b=F//LugT2YPn28OQvagcy7f0g+dl1g0WFiJkv+C5DmO9QO8L5OlCR+cJRnI/bfvshv06a6wpZF1zi6dCinRxnDgnmauFqCnO0mmFFhYK/LxUdFyZzGKCS0JVxHn6mAo9E0oVRjl6N61r8d9UZQN5eEm8xuVM2D3ikQDZM60Bew9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737546; c=relaxed/simple;
	bh=ncZg2VuW+AySF8gMan+UeGIC3Uxuyips31vZXC/8WFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcKcspDl9/HOw//AVjwKZ5+VpwhU0aX8Ssmu9lfKNuS535oAy6Z7ir7TFUI1Ryd2v2yZnovkhcgJn2aSiWQqFAHCbJQ5pEzw2+8y6YV75gAmlGeVk/fCeGk5ak42PTGjpU98C2go4bEuOg9QdwzTIJ2S8xeowBirBiG1WfpInbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/gWKm33; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/gWKm33"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so5968705e9.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737543; x=1790342343; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R10EWAoqeqiwKYs38V4/eu87hmfK6YBmKaV1HjMgWDg=;
        b=B/gWKm33uRLY8ViiqpqQuf3gOS2bqWPrpt4nqhleSfJMIhc9LdiVIL2w0IDp/6k/Lc
         JNCb0mU7s4bdXBF1ZsECVKDFwtPUmHcrdNkcToZDR0XqPKwB+WdwdCVva541OcOlFKgp
         wgciMsVAidAgQb4nJEtz17JpYV3RjCE/5jR0IZNDM8kb1NoXGX8YK6LxuRaQy/yrJOBl
         khrcf4Q4rG1cdTMS5RugwSu1SKR3SnvhcFky8wxPleTqaKn1QoZc5tTbeVkNfrGxV6Li
         Z6KQU3HjbL5ipHnlNUz3wHEwh1YeMSvBKM+O/k+v1c0Y6kX5vtTsPOnztwf6+Xxb9sxx
         Wavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737543; x=1790342343;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R10EWAoqeqiwKYs38V4/eu87hmfK6YBmKaV1HjMgWDg=;
        b=tKn/iETx+MjlElY59zpbWixqmtz6xtdFjbzw5VlwEQcre7fO7nwOhnusMbTBSR35TO
         THaFa14Svm2VXKNRb4TPVDWKvRQtQvhV51sUVR2wAPl30JcbdBkcPOVI5PhLUn6g/3Di
         9R+vGzL6mBL6J3f2KFqFWc/0r+ZqMBdfOnqjTJX/TlEjSwVdn40qwy612IZEvShuskPB
         KTD7DmSUN5qO/4n/TokQXlU8lSe44kL0ze31ueFqaogGCehi++sbh/jCgdNcHZXmB6st
         8jAP1Pt3/X6i5zAgflQfuSf4g2iGElMcK0L+6Q55oIrW2skF3ybdrH9hODejPqVWBTE9
         1evQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4WNu3XREEgKrMi8ws80tRHKT+Y6V8oq7WkRfea6Mn/pmWILvsOwLt6Yd3CqmfSt2OuNTYuYUIzw==@vger.kernel.org
X-Gm-Message-State: AFuF++kpQMPrvc3YrrBnpM/R0xpbOx2m2OtYZwEb6gjC2Esr2x8nlQHU
	XI7//NTn5YAntWQQzBaGZ+edWDKyEJpzCnRPrxjicTnMjVzqpZAscwWAlkAzh0P02xIogpW/Ibm
	wac8GoUT1VcqYgIJV2uYXuQ==
X-Received: from wmsl26.prod.google.com ([2002:a05:600c:1d1a:b0:49e:6680:860c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1993:b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49fc56dbc54mr34667275e9.3.1789737542981;
 Fri, 18 Sep 2026 06:19:02 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:16:54 +0100
In-Reply-To: <20260918131656.3710047-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918131656.3710047-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918131656.3710047-3-vdonnefort@google.com>
Subject: [PATCH v1 2/4] arm64: hibernate: Use fixmap for hibernate_map/unmap_page
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org
Cc: mark.rutland@arm.com, lenb@kernel.org, pavel@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thierry.reding@kernel.org, rppt@kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The default implementation for hibernate_map_page uses the direct map.
This creates an unnecessary limitation for BBML3 enabled systems which
can split linear map blocks and can enable memfd_secret users regardless
of the linear map mapping level.

Block splitting acquires a mutex (pgtable_split_lock) and as a
consequence is incompatible with hibernation. We know hibernation would
only call set_direct_map*() on a PTE-level region since it was
previously split by memfd_secret. But let's avoid special casing
hibernation in split_kernel_leaf_mapping().

On hibernation, do not modify the direct map and instead use a fixmap,
better suited for a transient mapping hibernation needs to copy the page
content. It removes the need for handling atomic context in
split_kernel_leaf_mapping() altogether.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/fixmap.h |  3 +++
 arch/arm64/kernel/hibernate.c   | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 170c3502d723..c8a65fd8584d 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -73,6 +73,9 @@ enum fixed_addresses {
 	FIX_ENTRY_TRAMP_TEXT1,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT1))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+#ifdef CONFIG_HIBERNATION
+	FIX_HIBERNATE,
+#endif
 	__end_of_permanent_fixed_addresses,
 
 	/*
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 7bf117427777..bbd0779081fa 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -21,6 +21,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/daifflags.h>
+#include <asm/fixmap.h>
 #include <asm/irqflags.h>
 #include <asm/kexec.h>
 #include <asm/memory.h>
@@ -213,6 +214,17 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	return 0;
 }
 
+void *hibernate_map_page(struct page *page)
+{
+	set_fixmap(FIX_HIBERNATE, page_to_phys(page));
+	return (void *)__fix_to_virt(FIX_HIBERNATE);
+}
+
+void hibernate_unmap_page(struct page *page)
+{
+	clear_fixmap(FIX_HIBERNATE);
+}
+
 #ifdef CONFIG_ARM64_MTE
 
 static DEFINE_XARRAY(mte_pages);
-- 
2.55.0.1082.g2b9226bbc0-goog

