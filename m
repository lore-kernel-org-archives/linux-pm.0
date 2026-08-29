Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F73FE67B
	for <linux-pm@vger.kernel.org>; Sat, 29 Aug 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788019833; cv=none; b=EmyxP/7TmKLr7eJSP3ZAyJz75PoJI9QyRlSlSZqHRCvgfXYjYgD1hOLQ/d4MARLiEdOwMODY+AEFY6j6ZSiSRD1vyMy5kT4MWo8YrSAJY3qnD8OQ8jhWxKWapF7uAkmYg9P7RHlclVlpfhlFMj1XmTOn1jP3vEeG1Fm7mvsU4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788019833; c=relaxed/simple;
	bh=tz0jWWQTpodY19HeFvg6WNoeFkXiXO6opCc4a24Hdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGWU1spI5q2wDS2+xRyAliNQntthO5EgXNta68pdxjzJH2bu76WW3GEqo8E4J9g2wKblxsI1ouWYDnBEJDbV+qRojIM72eVWiuI5I6gDynU75ss2uJD8yad3Y/lioRrGhCcZmCvslAFK2dqeJvAnVoIJZs+8Z78oPHV9UcV4JyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFBvJ++J; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFBvJ++J"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48436216a98so61440f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 29 Aug 2026 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788019830; x=1788624630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgJ9jtAoeYlks4PDRyS9bvaYSTRudzDH89X7ZOwziXY=;
        b=mFBvJ++JJwu1tx/dcGd2i8HJ9jTIGzCwcd+Si2UTfe7azta4QhcqV6wO4CjdV/XjH4
         TcznmIdYWhuv7jYd+uc7jEgQO6Y68SxkN84DCatWS+T77zfHkx4k5MBY+yRP1rWY+roF
         u+OqkgJYnyXXrcwvpcfHClKxZa2DZvtYzSqptLs3lmipsbKop4ngmt2H8SvoajO9BR7X
         McH7gB6HcUdjXrMtCa/Vdn4kZhA91gRHVRoUZyJOt/9CraacYR03k6lu7NPYwi3mdCzZ
         JIgWP+54PCli/5ER6gmzLqk7PU9rPqkeM0Fqqhn77i77CklOe8bpngfwEiCKxyO+rfIR
         YeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788019830; x=1788624630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgJ9jtAoeYlks4PDRyS9bvaYSTRudzDH89X7ZOwziXY=;
        b=a6dI4pNJBh25BZPFpBel4eD8YvKXcJJFMbKiiNsxWctzs+j66q2bSYPOS0r7wNaC0Z
         MfrSz2DXJgvW44ak4J7cPsCYU0jN9H2tQ9gZwgu07IdttU2eWNhV7THqEyBTRL5yuMLk
         gwSsQLno9cd8NaIS1oA+nZnlTj+4fKUdFrAZtCB6u9dghQEnYVw58sNrkp4YknwxsqFV
         8HR035Q8m41EzXxz4uksGlZmi5zhwm983uUMQSa6k4bBHPFY6MkyESfzcFYwNCrqTAY6
         SsowU+uFWnw2dHgsH+zitCBo4fSlQtlfcJO3/5WXAPm/WtKNtAAOQUKc7n5Gq3Wsx/5o
         WM0w==
X-Forwarded-Encrypted: i=1; AKwUvBx53729vHsjvtvIni4kUrFxknPEoiZqXS8P8J2O/1KHxZX3k+T0APkre/lsaTixUeTQq8bWiE7oIw==@vger.kernel.org
X-Gm-Message-State: AFuF++kqBvr9AHF/ZSIWK4MDXPe8CcGjKTkpora/3V/0ut+C4bin7XTX
	kgvGIEol6q2/7pcD8nmH3cKiyqLET5HICkcnoipWl8USGX6elF68+Y5H
X-Gm-Gg: AYBFou09Br+SEbaiS8LZt5epVUbBAqTLPBStQqe5q7jI2n7n0dO77u50RpDgB5awz74
	LytrcJd+PBIQsZaz5C727EkiF5soqsmvUbQL4m4ykTUw7eMfAtHGaWpoqWcv/jmRP86L7XAVc6O
	RQD0EYm5FqaorRAYXJ0t8ak4bA5RM1U/Pljrt1uXlDUfB664Cy77t0i5j9TACZgcXbYXT5rFjIe
	aPrU8PEWsH1LMjx8casb3CxrvPDMFVxmm64CAnyVSQZdeQUto+oRd6SEutRpMdIv5Rm12i5jXk1
	fawN5IL/JDhvxF/4KfyX5C/h/0Zwuvhw/BG4X1y5qZA6RgyPC52ESaaTYHc2ZSZeXcKBVnA+FbU
	8QRK1JDXdXBNFanHkupmHX5Sv5r3I53kWPxyBAUID3Z2Oev+YEoy33rCGSrQwlPvqyDcVeAVr3U
	Acf7MoZVAMzuTC0cC0QYoQBQFCMXX4yso3v9phf77pO6PW3TYy4/oSAAXNahZnfw==
X-Received: by 2002:a05:6000:38f:b0:484:3317:a1a with SMTP id ffacd0b85a97d-48433170bb5mr5978519f8f.27.1788019829637;
        Sat, 29 Aug 2026 09:10:29 -0700 (PDT)
Received: from main ([176.237.234.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab41sm3581883f8f.7.2026.08.29.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:10:28 -0700 (PDT)
From: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org
Cc: boqun@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Sat, 29 Aug 2026 19:10:13 +0300
Message-ID: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
Changes in v3:
- Add Cc: stable@vger.kernel.org.

Changes in v2:
- Format modified imports using the kernel's vertical import style.

v2: https://lore.kernel.org/r/20260828161834.29539-1-mehmet.mkoseoglu@gmail.com

 rust/kernel/cpufreq.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index affa2b9490ef..4b992ea9a0f0 100644
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
             // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
             // the returned reference.
-            unsafe { Policy::from_raw_mut(ptr) },
+            unsafe { Policy::from_raw_mut(ptr.as_ptr()) },
         ))
     }
 }
-- 
2.55.0
