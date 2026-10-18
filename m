Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6DC3DB31E;
	Sun, 18 Oct 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341459; cv=none; b=jQFhEPQm+4Sr1+qCdUCxnfbLUFdd5XP7R2q9Sl45ep7rrZIyXsQ1J1U01jowk0bc9vyNB0qHnQnTqoRJEcJWyagd5JKOTbqJVejoFRevzKh79OxOAq7FS4I2i7BEgPlIsxZ5JRxNINm4+KMTjF1fY+EQy7ZSGGpbb5HXeAnO3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341459; c=relaxed/simple;
	bh=LhLriU2jTVBhkvGlqF8Mt9Nl2w5WiVn28qIQFmEsZDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avahiHb0+FVMwG4VLV5y7uy6EGY20g6JACzTQLrARVuUfYscxkcnMNX3cZkI9g6wiuP1WYs0MnAhzSLd7+bIijzZS03uNIqdMqZvSeL6qmaNuNDfYXp7G0DljThmpmkxy9drDFJxfllgRjSMTzoRySqyM5X5YNx0/04b9HK9rJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQP9Rdim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQP9Rdim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0761F000C4;
	Sun, 18 Oct 2026 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341449;
	bh=xOpqNbkQdHQ0X8bWSJqa/bsHNtJiN9L+QaclF1tobZ8=;
	h=From:To:Cc:Subject:Date;
	b=IQP9RdimAxtyz7C2HTtvOFiHt8GTvRdXe00w4C5efYphFnCiO1CXCzCgUCHzIpyfl
	 ux4zF68QnU0Ssyos1SeOD5ubtc68/OYy7jYjtZY7dVvrzv91PVTqLtFJvc28cislWS
	 48DVbIv4AYAqiqM+NSXvHIBr5sdnY5JsOUrpvcAZeaHpjZbF9KGiOo2Kf+8n2mdalo
	 Rr2qUpWX1dnsMdKIsTWHORLBMfZ22ZTlvK82gZg8wSZsovcT1URKFiMQp5yS9Db/oo
	 Udv5lSXVEeoMWazsCwGjCdPPEA+2NjFGlsAAfxdYsWxrIR5hLtbjlcylAxkDaXj+jJ
	 uKWU1ULVisv8g==
From: Miguel Ojeda <ojeda@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-pm@vger.kernel.org,
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
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: cpufreq: fix `undocumented_unsafe_blocks` in `PolicyCpu::from_cpu()`
Date: Sun, 18 Oct 2026 18:37:19 +0200
Message-ID: <20261018163719.81691-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Rust <= 1.86, Clippy triggers after commit 02c5d7bfa872 ("rust:
cpufreq: reject NULL from cpufreq_cpu_get()"):

    warning: unsafe block missing a safety comment
       --> rust/kernel/cpufreq.rs:700:26
        |
    700 |             NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) }).ok_or(ENODEV)?;
        |                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: consider adding a safety comment on the preceding line
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
        = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`

Thus clean it up.

Fixes: 02c5d7bfa872 ("rust: cpufreq: reject NULL from cpufreq_cpu_get()")
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/cpufreq.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b75d692846a2..5f5beedec88b 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -695,9 +695,11 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
 
 impl<'a> PolicyCpu<'a> {
     fn from_cpu(cpu: CpuId) -> Result<Self> {
-        // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
-        let ptr =
-            NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) }).ok_or(ENODEV)?;
+        let ptr = NonNull::new(
+            // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
+            unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) },
+        )
+        .ok_or(ENODEV)?;
 
         Ok(Self(
             // SAFETY: `ptr` is non-NULL and `cpufreq_cpu_get()` took a reference on it, so it is

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.56.0

