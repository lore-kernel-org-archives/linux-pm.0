Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781593;
	b=Zh/c5k9FwAy9fKX52n0ezonjQlv1oCQSPGsz0vcQCReAYu/HbJYXXYohp57pakHRuak7
	 WsjRIoO6QhhmhcicYKEyKobMzuOELU5ygv02xQN42YUPKig5QCfbj+wjlsV1H0VmCZUoO
	 f4ImYYIVq+YEQATifGdj3Di09jFXAjQ0boMpH0X0NP0ZjfHVhghJZ5F1uK7mC9PBGZZT+
	 6gU+EqQf/DaCESgzJSpcQ9ZryVCliRhM5aWPdjPF4tVcy1BKUauWpzpL6VZPOMqhv/BDn
	 +srROzJfXhGaQSsqB8CptoETHiwNj1m54/u0yf9rFTSW43ya7rz8HQyK38fkJX8Hf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781593;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=RCnlPXVG8B0hg6oe9oQwTSo61ISvBdYmhBXoawrpce0=;
	b=gLbhsY88DOns2OdrhHpqg38mpntvdFYMPxSXMpCkWcCc60mivzLQE4rm7ytq2+vFP4Ik
	 3Za6McQqp1vbgjHzcDZj7qn7qPolIXwaM4idyNBkNCk+WxszUKEQ6bBkS31Dpo56jRuof
	 yDTRwockbiZAlAjPkk2xSMGNQLbBrnepkFOEyYWLjZxknSe8xP75EM9cCxWNZ2aBj05dk
	 xy9VorLo8Ua0yvhAbH4J1gqkmwVHDrNhezdbph8Nk+LqlKLixM/fgLhscoezi0cH+a9Er
	 Ihzg441x8jHqcl1N5ds02v9CuXcJIMPBRzCyvFTUuEkZNBP6c/VJwRnm6SKdAWgKjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=OZs8sNbP;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E19606A31C;
	Fri, 27 Nov 2026 12:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=OZs8sNbP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RC
	nlPXVG8B0hg6oe9oQwTSo61ISvBdYmhBXoawrpce0=; b=OZs8sNbPrAclQDdhLD
	gm7V+8yRi5EpzrKFaTT91IHIl9A3DyxhGLj173yCzu4sfXIvfTN7AQFGgYBVpISu
	6xBW0SQ6864pxa4vSoc1gzMEF8qCvkQzDjeP1GKTt/+jrW0E+vO+B8X9XYu22JmM
	uhg6ciCagjgAlgxRrYb4XCSWw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD37z+8cwlrQ7bQDQ--.52666S2;
	Fri, 27 Nov 2026 20:12:48 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bilal Hashim <AeeSec@126.com>
Subject: [PATCH] rust: cpufreq: mark Policy::data() as unsafe
Date: Fri, 27 Nov 2026 20:12:16 +0800
Message-ID: <20261127121216.1883-1-AeeSec@126.com>
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
X-CM-TRANSID:_____wD37z+8cwlrQ7bQDQ--.52666S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try8Gw1DAFW5Gry3KFWUtwb_yoW8XF4Upr
	W7WryY934FqFn2qwnruryS9rnrCan7Jw1UKa95W34I9w4qyF109w1DKF1FvayvvrWvgF43
	trs3Za13X3Z8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE0eH7UUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrQEqxGsJc8F33AAA35

Policy::data<T: ForeignOwnable>(&mut self) is currently a safe public
method that casts the untyped C pointer `policy->driver_data` via
`T::borrow(...)` for any caller-chosen type `T`.

Because `Policy` is not parameterized by `Driver::PData` and performs no
runtime type verification, any safe Rust caller with `&mut Policy` can
invoke `policy.data::<WrongType>()` and reinterpret `driver_data` as an
arbitrary `ForeignOwnable` type, causing type confusion and undefined
behavior in safe Rust.

Mark Policy::data() as `unsafe` and document the safety precondition that
`T` must match the exact `ForeignOwnable` type previously stored in the
policy's `driver_data`.

Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
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

