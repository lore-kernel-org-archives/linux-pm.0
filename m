Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DD468C1A
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850150; cv=none; b=kALu8WHpsMEw/HIV59SXkqeHwhBNOo9yp3B9yvqkaJMaxMTAbjYK7V4m7gKCs1Wbw5VF7FVKWBkioaZrulzXCxPm19ACgFvg23SJK+ZXQCGA2cjLkzQKLq7Ce5gpbtDM/q4L7zvnil8E6E/EvmDGMT/wDsMf++fohAHGZFOYl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850150; c=relaxed/simple;
	bh=VnVU8bPLJLWfbtAdNiLdfbQJCPObLTqpHbQuXDlr2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxtyz/h0u1xiJV2Wszs2Cj86Lp9ce3fVw3XUR77susXr1Xe8OecFvPDVWkQ0o9NZwChFpbQiZIaM65LnYG06w4ZueEAXkkWa+cF6MZAwA0qf1jonxS2pGu5P9kum9A7SHktGzoF3YMwURgtIZcKg+DK8/ouVNjLnGHwBorBebzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcoasWwK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcoasWwK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso28808095e9.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790850146; x=1791454946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFzLuRrxO1MNqfhxtzwDFW5LDm+149ISNFd1xuYHuCg=;
        b=YcoasWwKANqhJAT6ITRJApGZlPhldlCa3xeDRxEfwNSU7DdcpSvcZbECqojDb+i15L
         iTz2NxaLca/myE23nQbmPyIMSRIthvctpPeXyyxfi8r1qmMc4zC/alrLzYLdN3ouN5D2
         U4iTFWDDoj7ixO4ig1FDmEZ9qfc5myNxyc8kq9DjFl8/BqobYHyE2x/01WxvzLUZjZ3O
         Jzl48w2XjO4J4HAerMfCJ1+OKjrbJulAhazaEQuzk4XQiwDdO2SKTC5azlLMoQnNlSJh
         K8IgfpJ8xoftjXCuBTDZ5P83xNg9cMCi+bbTQriNhuGkHGaEWUXaFY4F/qUBDs/MX2Yr
         Ihzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850146; x=1791454946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFzLuRrxO1MNqfhxtzwDFW5LDm+149ISNFd1xuYHuCg=;
        b=Bb9/udOKEwhZZMNTRv2Z88cPM95O1SzHE1enaiNZsJHWT1pez2BgcMEGtv6szwKBNJ
         zUNiHJcovR5MnjKGCl9ek2sT5emTHhiAgePbmHByIuVN2X9z3HHNFHmFR24mVKzOkbkg
         grqMWzlDUFBe20EDfT6u35SBhA+axn0g2cHkMUOlRSeTjVrgDJ9/xyUsoIfw9COrVjQs
         Eqrvlr8sKCZsEjHCgVTcrCqbwKOmxMyUieQ/J2xLFNZCrNDMYsRzZfbtWvq/o7O/X9P4
         ZOjPEjsGBSMAGznxYYJqIzejK5ruUCIBGuW1xjL3Tmzm4dPUnjprTY3sWyn9gijePnib
         kkTg==
X-Forwarded-Encrypted: i=1; AKwUvBz7+3X2E7Zti52X8a+4SJZZ8B968b8Un4YkdHb+HO9OLh2vXlzX43oCA1SzYfRsObGhP4ETqOb83Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kI+gP7RNgQH7DoKmQcN3gfYm3ZnGdwUQS9b2LDVz2IkWd4Zzbs
	LN3hXcdmSDl4xp3NSVwMRjRLeQr/n05vQVuQvslT/nev2Ysviqj6RcJJ
X-Gm-Gg: AYBFou12MNy3Gw+hChBlov9vOP1GHn+bTqt0utqo+5I+DwAtz1Vjzb3q+jmaNJpVz7k
	sBBwTCck+muqcEzF7E54GVlbgOXVI78dyhPfuJqYGH5J1JRRozNS4cVRjaAYtxaOQhMSKmNjq8H
	Y3rRBcWBX1K7QtE5xR/tNwt0saGmcteHk17NLVLYay6AHZ3ztITXR+RITCaA48queyQO9AfU8q6
	BqW0b7uL3K/8VjVwW5uHRQeYjIg1ADVnGe1VzMoUkj2c2C57VYeR+e7POCiAXyVmJW0NkvwWTJa
	Ta772nBxJsOeVpxIehoX/1uY1Q7q/goODoHkhnOb9WmsNR26Jtvc1usE/vfBCvO1RXBy4a/O/Pq
	pgTPtoqeP3IjpmGYu7xXCYUVuseYwVDJbeZVCCaID2ivgfRn96lF2RFcw1UOOzjej5qCy+GuPc7
	zR7tlE6h3f3usAgrLvTgJAt9aD/Q+ncBMBonZN2bxBdPQoeunKn0vzDTN33t+zkp9l5mY=
X-Received: by 2002:a05:600c:6815:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a01b0031a5mr65592665e9.16.1790850145677;
        Thu, 01 Oct 2026 03:22:25 -0700 (PDT)
Received: from main ([5.27.43.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa15e51sm58094425e9.2.2026.10.01.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:22:25 -0700 (PDT)
From: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org
Cc: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuyiwen14@gmail.com,
	miguel.ojeda.sandonis@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Thu,  1 Oct 2026 13:19:15 +0300
Message-ID: <20261001102213.45437-1-mehmet.mkoseoglu@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com>
References: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get() returns either a referenced policy or NULL.
PolicyCpu::from_cpu() passed its return value to from_err_ptr(), which
rejects ERR_PTR values but accepts NULL.

If the lookup fails, Policy::from_raw_mut() therefore constructs a mutable
reference from NULL. Dropping the resulting PolicyCpu then passes the
invalid pointer to cpufreq_cpu_put(), causing an oops in kobject_put().

Reject NULL with NonNull before constructing the Policy reference. Return
ENODEV instead.

A KUnit negative-control run reproduced the oops with the original
conversion. The same test passed with this change. The reproducer is
available on request.

Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and driver ops")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: spidermana <xuyiwen14@gmail.com>
---
No worries at all, here is a v4 update with the comment update and
review tags.

Changes in v4:
- Clarify that the policy pointer is non-NULL and cpufreq_cpu_get() holds
  a reference for the lifetime of the returned reference.
- Add Reviewed-by tags from Onur Özkan and spidermana (using the corrected
  tag from spidermana's follow-up).
- Resend at Viresh's request to replace the previously applied v3.

Changes in v3:
- Add Cc: stable@vger.kernel.org.

Changes in v2:
- Format modified imports using the kernel's vertical import style.

v3: https://lore.kernel.org/r/20260829161013.102967-1-mehmet.mkoseoglu@gmail.com
v2: https://lore.kernel.org/r/20260828161834.29539-1-mehmet.mkoseoglu@gmail.com

 rust/kernel/cpufreq.rs | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index affa2b9490ef..b75d692846a2 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -14,7 +14,13 @@
     cpumask,
     device::{Bound, Device},
     devres,
-    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
+    error::{
+        code::*,
+        from_result,
+        to_result,
+        Result,
+        VTABLE_DEFAULT_ERROR, //
+    },
     ffi::{c_char, c_ulong},
     prelude::*,
     types::ForeignOwnable,
@@ -29,7 +35,10 @@
     marker::PhantomData,
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr,
+    ptr::{
+        self,
+        NonNull, //
+    },
 };
 
 use macros::vtable;
@@ -687,12 +696,13 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
 impl<'a> PolicyCpu<'a> {
     fn from_cpu(cpu: CpuId) -> Result<Self> {
         // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
-        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) })?;
+        let ptr =
+            NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) }).ok_or(ENODEV)?;
 
         Ok(Self(
-            // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
-            // the returned reference.
+            // SAFETY: `ptr` is non-NULL and `cpufreq_cpu_get()` took a reference on it, so it is
+            // valid for writing and remains valid for the lifetime of the returned reference.
-            unsafe { Policy::from_raw_mut(ptr) },
+            unsafe { Policy::from_raw_mut(ptr.as_ptr()) },
         ))
     }
 }
-- 
2.55.0
