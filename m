Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9F3C5826;
	Tue, 13 Oct 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911364; cv=pass; b=Ej3+W5DVJd034CY1+dfWrvNyYAAkt5zFVFCFbCD6/IOx+7sUi5RQbjepbabHeVA1caAzCXeUPUVjOloboSVzOCFTl6WB4ts/bTvdsfCtuDTfXS3TpNoHmLAzFY+GUZnz3BHrt1+AQxdCHP9+aLSSrnrqN9Uqs4KlaPGO5O7JtaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911364; c=relaxed/simple;
	bh=jtezbGC5lH7wFYrrfNEsAZ4Z/CihEoMU3agYUY1jtzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLHCUgYE6qhlCUkvflLNvP/NvA1Wvqzwwwssz3jHmhrIw6HPM7k7elIDaAlSLOGRyHVYKdg+hBmE0I9aWhEXid2aqvhFyiFVBNm8HziL0SO3QFl/t0ap6Ec3ILB5XuqQx34Qf3xNpAlIbCpf7huE664tK4/yUsp5+rge/ERRHKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KH+sEfDc; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KH+sEfDc"
ARC-Seal: i=1; a=rsa-sha256; t=1791911305; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IlcHkblCN52pkgXAAk/K7ekpCb1ZD1YNcc7sGxi7SqHdZUdLNgKC6VmK4/hxwMu7hYD6KhvWw84KIE/UVMJlb/YMQmwDsavxLgHv/PeMCmvZ8pS3K+6SmabAw43dbXwMk6T0YmFZbqpdOGOuwK4mgXC64S9P0ZI90oaEw3fbIAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791911305; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ILpqW1RV3YBzeKcgdsbXRsCeTLIqxgSLLgowM5WUL0k=; 
	b=hOVszWZeFv5A5YQrhEBef3R8Un4LPknO68IOjEaJVRMVMXbn1weXP0sNfPzLtnGHwR3rw6xxsRc2GTrDU3kcT3BGFWOH6UWWCjm07nQvJuafELzYW6IXgzXpBc0cL/N/ImNcB4tlebDKsCNDMX0Sis19+E/NvfDv8kFJJoiquCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911305;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ILpqW1RV3YBzeKcgdsbXRsCeTLIqxgSLLgowM5WUL0k=;
	b=KH+sEfDc80nVOoRf8Iul1ahPF2tKoZcdCGCza5NTgWQZT9MwU6RzYh8YbHVB3QKr
	npdCrKHtZB9h48f7BmOni27NYJ5hw3K473XVFsW/d/atAiRpE7fP6iY1m0SAluPSDAC
	F6zPxQ9shreDhF6vTAe8Ywq7qKZooDxKXc4lsKSs=
Received: by smtp.zohomail.com with SMTPS id 1791911303174895.2350669489024;
	Tue, 13 Oct 2026 10:08:23 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:41 -0300
Subject: [PATCH v6 2/7] rust: clk: replace `OptionalClk` with
 `Clk::get_optional()`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

OptionalClk wraps a Clk whose pointer may be NULL and derefs to it.
There is no struct optional_clk in C. clk_get_optional() returns a
struct clk pointer that is NULL when the clock has no producer, and the
clk functions that Clk wraps accept NULL. The type invariant of Clk
already allows a NULL pointer, so the wrapper is not needed.

Add Clk::get_optional() and remove OptionalClk. Convert tyr, its only
user.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 13 +++---
 rust/kernel/clk.rs            | 98 +++++++++----------------------------------
 2 files changed, 25 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bfb0ba19caff..c382a26904ee 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
-    clk::{
-        Clk,
-        OptionalClk, //
-    },
+    clk::Clk,
     device::{
         Bound,
         Core,
@@ -117,8 +114,8 @@ fn probe<'bound>(
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
-        let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
-        let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
+        let stacks_clk = Clk::get_optional(pdev.as_ref(), Some(c"stacks"))?;
+        let coregroup_clk = Clk::get_optional(pdev.as_ref(), Some(c"coregroup"))?;
 
         core_clk.prepare_enable()?;
         stacks_clk.prepare_enable()?;
@@ -219,8 +216,8 @@ impl drm::Driver for TyrDrmDriver {
 
 struct Clocks {
     core: Clk,
-    stacks: OptionalClk,
-    coregroup: OptionalClk,
+    stacks: Clk,
+    coregroup: Clk,
 }
 
 impl Drop for Clocks {
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index c73fe7c57251..1de2484df8cf 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -103,10 +103,7 @@ mod common_clk {
         prelude::*, //
     };
 
-    use core::{
-        ops::Deref,
-        ptr, //
-    };
+    use core::ptr;
 
     /// A reference-counted clock.
     ///
@@ -175,6 +172,25 @@ pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
             })?))
         }
 
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
+        ///
+        /// Equivalent to the kernel's [`clk_get_optional`] API.
+        ///
+        /// [`clk_get_optional`]:
+        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
+        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
+            //
+            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            Ok(Self(from_err_ptr(unsafe {
+                bindings::clk_get_optional(dev.as_raw(), con_id)
+            })?))
+        }
+
         /// Obtain the raw [`struct clk`] pointer.
         #[inline]
         pub fn as_raw(&self) -> *mut bindings::clk {
@@ -280,80 +296,6 @@ fn drop(&mut self) {
             unsafe { bindings::clk_put(self.as_raw()) };
         }
     }
-
-    /// A reference-counted optional clock.
-    ///
-    /// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`]
-    /// that a driver can function without but may improve performance or enable additional
-    /// features when available.
-    ///
-    /// # Invariants
-    ///
-    /// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or
-    /// `NULL` pointer.
-    ///
-    /// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
-    /// allocation remains valid for the lifetime of the [`OptionalClk`].
-    ///
-    /// # Examples
-    ///
-    /// The following example demonstrates how to obtain and configure an optional clock for a
-    /// device. The code functions correctly whether or not the clock is available.
-    ///
-    /// ```
-    /// use kernel::clk::{
-    ///     Hertz,
-    ///     OptionalClk,
-    /// };
-    /// use kernel::device::Device;
-    ///
-    /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = OptionalClk::get(dev, Some(c"apb_clk"))?;
-    ///
-    ///     clk.prepare_enable()?;
-    ///
-    ///     let expected_rate = Hertz::from_ghz(1);
-    ///
-    ///     if clk.rate() != expected_rate {
-    ///         clk.set_rate(expected_rate)?;
-    ///     }
-    ///
-    ///     clk.disable_unprepare();
-    ///     Ok(())
-    /// }
-    /// ```
-    ///
-    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
-    pub struct OptionalClk(Clk);
-
-    impl OptionalClk {
-        /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
-        ///
-        /// Equivalent to the kernel's [`clk_get_optional`] API.
-        ///
-        /// [`clk_get_optional`]:
-        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
-
-            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
-            //
-            // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of
-            // scope.
-            Ok(Self(Clk(from_err_ptr(unsafe {
-                bindings::clk_get_optional(dev.as_raw(), con_id)
-            })?)))
-        }
-    }
-
-    // Make [`OptionalClk`] behave like [`Clk`].
-    impl Deref for OptionalClk {
-        type Target = Clk;
-
-        fn deref(&self) -> &Clk {
-            &self.0
-        }
-    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.56.0

