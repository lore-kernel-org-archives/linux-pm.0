Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA8357D0F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931767; cv=none; b=ZVMLOSY2wQSEOWj5iZeEeSK+MAf52jKA4xma/wX9RlULIWDSTgKeWrxVTny/TKGdX2SGKoEl7DpRI1o/4y0TVE/eLw75LqI8PDb+gtjVyNYeZna25kcP6NKw0ttJNJEeiafn3hnKMIsSaolCEstVcGcv6vei0ztlgw4PHCn9WZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931767; c=relaxed/simple;
	bh=CBOYWU5KwtzTq95ftVPMi+1AX/qvyPysCgyFMT0deyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/J9c0YLdq1A5ETxoOCuIlMtQW6QCZbutixLBq+oGEYUs2vEVHNeJ50NaPH2PiSkNeI1h/Qg/k1uL7HLNNzABNTF8mUc5rvLRFKqWUv76jzitUvNSlL9sb1Oe1OvjjGW2A3b9yYMtgI8Njuvo3SmjBtGISM0c4MYtKc0W9pVB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKVwE47+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKVwE47+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fd4531020so641604f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931763; x=1788536563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Il1nKTj4PJSO6PrUY+686DiZ64VrBPAafI4EqiNmen4=;
        b=cKVwE47+UjYZ4DWk/hThBCkFvuINKuFNPNcbNS6W5WcIRMjPPW1UkTDGoO/BD1q2CG
         hcyybFx3AFdObMCf/m1rqbm0o2QyK9ELsh8nZcLGz4WFw3VMYuFUXV5fLQUjW910bLXE
         DFX+RjPvhIdG8IbVFrnbtNwf6pqZ332nBFGS9W9lQZ0rNuEcVBAQtYfRAujj1Gar7woE
         8qjj3itTC0JRVUw+WRmUCxeC1/BqVkkZiYaGc/ICLonvnUs8QF4dRRndbvfeKq+4/ZTi
         hlv0ySPMBHFSS6fxivxkBy0Vz9FaQAGljbMuctuyiEhualILDTpdISWGG98ho6nAYtdZ
         Ld1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931763; x=1788536563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Il1nKTj4PJSO6PrUY+686DiZ64VrBPAafI4EqiNmen4=;
        b=f8KrdgEOIA1gutYk5695lpKSorNZdxVCHEHWj+aVtL9QZt+UZiNXaUS8IYH3nPEDrZ
         ajZDsALYAONd6G8qXxPW+prjMv13LhkpT+RBO8OWy+iS2f6gX1405dr0mtD7E/UTjsj1
         JEnyuh/OyMGYPXHXAsslqr/GTUUQ/4cotUTOqkRN5OcWy7r25FwSs2dfhZ+5MzM+dH42
         DunLEfXrg57WxP8NWintfKgn7NdxVf5N4xM0RkM1czpDByF/84pYPoJ5rZE1oYEeDeuP
         OJotvQOhl6yFUQOoHc4lmnosVSXk4WRVSwmUQMx4TxZgmrwBUb+fW8bh4RV7Hklxzi3J
         QPRg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt2NyUv90lcV0Q53Vbh9Y1E9wNCOgdp4UMWxc1v7BvfJz8iCqcXdvXwD4W3QJ2HEhNvoTYMFIPtw==@vger.kernel.org
X-Gm-Message-State: AFuF++lIrCo8Kd13Q59mov6B6SBgECcldEY2fD/3QU+n+RUlujr/ea2Z
	iL6VtlPvLyQ46Sxl15TR1sgdQs8q4xnYO8m4qlVlnmlvPnANpr33QNFa
X-Gm-Gg: AR+sD12Qx48Uysu55FlNGTN9jD409nVZjjM68h+m7os/UTCEp0c+yF+bu1CFqQ1vmzj
	9ITddOoGwIGtT8Qtqq8uR7gFAUiNFAmv9Xx2cRyxbGyPBbLrK8s5vLyLXqOrhv+M4rDrwXcrptv
	rOxWS+Hl9q3rcFY36hxbewEXicXgp8wCOleI/gUNWvNGghiCzLSEbY68QSukM5jjM0AZ/W3qC/H
	FwIxaWHC6udMB/hMp6A5k0PIagHfaZLcWBhvVplT4tweBFzg5tSNfPPkx7iCdDTyJVqQfiBoMgJ
	Vfdvm5lmxfrOu+066Uv97RssbAADWWCS7ColquTfy5ydbaaDfP5SA+psjOy/uobiKkLG7sbTd0a
	uzmBRo2EtxQ4ycoAXHdCHK7NEgJnFf7W28DJSHjO0cUvX2/6Sjxf5CYBFLR1ayKV1Y+tm33hXy9
	rDkuKnHDar7OX9fJ5l32UC+MDK5y124SGozQp1ac9ARdLykCQe/4xM0ycnF5hYlg==
X-Received: by 2002:a05:6000:25e5:b0:482:fe64:1717 with SMTP id ffacd0b85a97d-482fe641751mr5140630f8f.7.1787931762527;
        Fri, 28 Aug 2026 08:42:42 -0700 (PDT)
Received: from main ([176.237.234.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb278f7sm5610793f8f.26.2026.08.28.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:42:41 -0700 (PDT)
From: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Fri, 28 Aug 2026 18:41:32 +0300
Message-ID: <20260828154235.17315-1-mehmet.mkoseoglu@gmail.com>
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
available on request. Validated on a VM as well.

Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and driver ops")
Assisted-by: LLM
Signed-off-by: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
---
 rust/kernel/cpufreq.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index affa2b9490ef..1c0b6d6a9773 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -14,7 +14,7 @@
     cpumask,
     device::{Bound, Device},
     devres,
-    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
+    error::{code::*, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_char, c_ulong},
     prelude::*,
     types::ForeignOwnable,
@@ -29,7 +29,7 @@
     marker::PhantomData,
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr,
+    ptr::{self, NonNull},
 };
 
 use macros::vtable;
@@ -687,12 +687,13 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
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

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
-- 
2.55.0

