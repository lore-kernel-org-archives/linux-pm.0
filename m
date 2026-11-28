Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874648;
	b=qgt9Zhoypa+t/mFG1tObKA1q78nU+Q98bsgeJ7REXgN5iQhxs10GdufbbKHbHM+SphJ+
	 RPGyQ6VGTG88qsOi3sO44dABvKR/FqFI01HnTWkk8AL7lu7fMp+656uRvlt5PgPAECYSA
	 fM7moYzc3N4QHUpIEzj5EV6v/xqV1Jj+/ENSkIOn5GQE3H5h16gUXwmnZIePfqlBhK7Vm
	 s1QtW7TtZsqtZFw4MFAHK9vRfZ8IXA8peCAX2OZcnBxHJqZJG+kSalZrdkLekh2u8KiwB
	 oucIK9vGLSdg8+vV9CyfJOVyJZlmOawQCLKMYgaXyyaslLuDkfs4RiMPtssFUlKIMvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874648;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=g+aU33rCaXGGIUCW4L8T8mUG9pYVHyVForkS2T2eczE=;
	b=ly6deCRNHKiGZ5udsQIdhpj/TEKbSwKQBly1MG3i+JqH/jgsxS5lkOyz/P0lUdpEDfKv
	 C8hLkzAHGvFvUnb8EuRbUE5103VtZ2PYqqCcyBwIJ015bhdi3fY3RljDLwqi3Wh5gJ2T3
	 PqAj/P4yPTEuYeAAuKcHA/2lAL0LLX9AiYpHETPGt9ARta26km2jZTAY2ttzRjGP690my
	 Wf202G8wDMh12KXqW8OO+j0C8yGKxNxqs/NM5wMy7EDtL7SNzZi2BLy6ghu6DXqYwxzHt
	 Fz1RqXg56ydAmOv04MhvUg5PAM60E4lg3HmBVMlx1E3tFXp5HTEKoFxBxd5ykruSXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=EhA+9Lx7;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0ED606A31C;
	Sat, 28 Nov 2026 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=EhA+9Lx7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=g+
	aU33rCaXGGIUCW4L8T8mUG9pYVHyVForkS2T2eczE=; b=EhA+9Lx7sC4GtFdYTd
	PUZbjeAeKCwja42CR828/Qekyp6KPpd4nwz2mapKPu3HAevLuVJyYWSE/oKFl1u0
	q3maeGyLKrULXomIaFIUh/6MbCfEonmVRSHme+9V0kjXv2naEVSNQYgb6hYXQflG
	AO/+ull8LtDFjJamQoKf+Eu60=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgC3hecn3wprDmJYDg--.24441S2;
	Sat, 28 Nov 2026 22:03:20 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bilal Hashim <AeeSec@126.com>
Subject: [PATCH v2] rust: cpufreq: mark Policy::data() as unsafe
Date: Sat, 28 Nov 2026 22:02:53 +0800
Message-ID: <20261128140253.1927-1-AeeSec@126.com>
X-Mailer: git-send-email 2.47.0.windows.2
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgC3hecn3wprDmJYDg--.24441S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try8Gw1DAFWfXF4fXw15CFg_yoW8KrykpF
	WUWrWqyry0qFsrtwnrCryj93WYkws7JrWUKrWkG34Fvwn8AF109w1DKFyrXF9Yvryvgr4a
	yrs8Za1aqFs8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_EfoUUUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrAlf+WsK3ylDjAAA3b

Policy::data<T: ForeignOwnable>(&mut self) is currently a safe public
method that casts the untyped C pointer `policy->driver_data` via
`T::borrow(...)` for any caller-chosen type `T`.

Because `Policy` is not parameterized by `Driver::PData` and performs no
runtime type verification, any safe Rust caller with `&mut Policy` can
invoke `policy.data::<WrongType>()` and reinterpret `driver_data` as an
arbitrary `ForeignOwnable` type, causing type confusion and undefined
behavior in safe Rust.

Mark Policy::data() as `unsafe`, document the safety precondition that
`T` must match the exact `ForeignOwnable` type previously stored in the
policy's `driver_data`, and update the in-tree caller in
drivers/cpufreq/rcpufreq_dt.rs.

Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and driver ops")
Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
Changes in v2:
- Update caller in drivers/cpufreq/rcpufreq_dt.rs to wrap
  policy.data::<Self::PData>() in an unsafe block with a SAFETY comment.
- Add Fixes: tag.
---
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -178,7 +178,9 @@ impl cpufreq::Driver for CPUFreqDTDriver {
     }
 
     fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result {
-        let Some(data) = policy.data::<Self::PData>() else {
+        // SAFETY: `policy`'s private data was initialized with `Self::PData` in `Self::init()`.
+        let Some(data) = (unsafe { policy.data::<Self::PData>() }) else {
             return Err(ENOENT);
         };
 
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -648,9 +648,15 @@ impl Policy {
     /// Returns the [`Policy`]'s private data.
-    pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `T` is the exact [`ForeignOwnable`] type previously stored in
+    /// this [`Policy`]'s `driver_data`.
+    pub unsafe fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
         if self.as_ref().driver_data.is_null() {
             None
         } else {
-            // SAFETY: The data is earlier set from [`set_data`].
+            // SAFETY: The caller guarantees that `T` matches the type previously stored via
+            // [`set_data`].
             Some(unsafe { T::borrow(self.as_ref().driver_data.cast()) })
         }
     }

