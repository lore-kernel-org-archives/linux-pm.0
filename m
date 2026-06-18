Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61A298CB2;
	Thu, 18 Jun 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754522; cv=pass; b=eK4UYe/HV8SOVY7Zm1CA+IFhnr4qmAXkvUMjsjBqMqmQ94fPnNmu5IAF3UaRz0POrtfeEhNVWtgwS8cltXZXL1hyfySNAqbyB0BYQVB+oMHO1Cyt8JM2pH1W27WI6zne/i+z9RA2Tw9+wlogoY42CNFcTP6aMb65hTotJ6WsHl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754522; c=relaxed/simple;
	bh=vmpQMgFf/eBZeeZ4Ycjvtn/NICT/KZSpluoGRjIPNdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUKJ2XvgN0enkWCqUL1ieiQPvonwrpwq+IpBbV7krduDVNCdUmW2V92GIRrQg6v1ndtqmUvL283S0B1Svt0UIfiAlJ25Yr4Fs17MWUEe2aSCG0xrPqrgpfZzstJkV0rkR58cx8d0Ej81NI0L08Ut0gFf76VvcZM1pqDRIg7sCII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=APn++8oq; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="APn++8oq"
ARC-Seal: i=1; a=rsa-sha256; t=1781754498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mNXOKcw9uzCiiYr5O9KI4cBXfISXVa5n9kATef+RRuQ7wWtji9H+phX7Vnl+CO1/cXeFBhbgYl41JnJ4OZKw+RBiz17jvQrCSJAYW3v6sVj0L6NRuUQV3sXeMmMAn82G//2YrkcSTsJUoFvddbu70aHG/LQF8wtbT3xx1WYpdjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781754498; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U2lJv0/DE3CCJO9+3Z4st8Eh7wfAyQlNJPVjWBCZG3U=; 
	b=hSjS4IQnIcFzPUorUV3amUfN+UL1yh7XGTtDtbKKFF8OtyNca7PeM1ZIAGWoTL1mpHEZw6RKaKvqkhepVdlv0+W0ejkpFFwbuqMO/j1w6RpQhb3OIVQ+r37PcY9C6PeXNoiPJsOpYqinastYnKDVWm0LfQ7CQytS8ByVo+EHwDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781754498;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=U2lJv0/DE3CCJO9+3Z4st8Eh7wfAyQlNJPVjWBCZG3U=;
	b=APn++8oq3SbVjjPkB0W+AeYEi4qEdpH7NvFESoL6kiFyxQkL2MlsJJSlh/Lmwtc6
	DhmWKbyWgbDZe0ChM4NFZj2zW8rc5KyW9TYaov4K1R1Uoe0EPvHiYb2n4D2fo/cftAF
	jYgn5x2BDFc2wOttOU4iVtD30mai4ZSz0VM5Zreg=
Received: by mx.zohomail.com with SMTPS id 1781754495642490.6198508965592;
	Wed, 17 Jun 2026 20:48:15 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 18 Jun 2026 00:46:37 -0300
Subject: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Convert all imports to use the new import style. This will make it easier
to land new changes in the future.

No change of functionality implied.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 692ee88ca772..1412a2f0aedf 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -80,12 +80,23 @@ fn from(freq: Hertz) -> Self {
 mod common_clk {
     use super::Hertz;
     use crate::{
-        device::{Bound, Device},
-        error::{from_err_ptr, to_result, Result},
-        prelude::*,
+        device::{
+            Bound,
+            Device, //
+        },
+        error::{
+            from_err_ptr,
+            to_result,
+            Result, //
+        },
+        prelude::*, //
     };
 
-    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
+    use core::{
+        marker::PhantomData,
+        mem::ManuallyDrop,
+        ptr, //
+    };
 
     mod private {
         pub trait Sealed {}
@@ -189,8 +200,15 @@ impl<State: ClkState> From<Error<State>> for kernel::error::Error {
         /// original [`Clk`], e.g.:
         ///
         /// ```
-        /// use kernel::clk::{Clk, Enabled, Unprepared};
-        /// use kernel::device::{Bound, Device};
+        /// use kernel::clk::{
+        ///     Clk,
+        ///     Enabled,
+        ///     Unprepared, //
+        /// };
+        /// use kernel::device::{
+        ///     Bound,
+        ///     Device, //
+        /// };
         /// use kernel::error::Result;
         ///
         /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> {
@@ -240,8 +258,17 @@ fn from(err: Error<State>) -> Self {
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
-    /// use kernel::device::{Bound, Device};
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Enabled,
+    ///     Hertz,
+    ///     Prepared,
+    ///     Unprepared, //
+    /// };
+    /// use kernel::device::{
+    ///     Bound,
+    ///     Device, //
+    /// };
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device<Bound>) -> Result {
@@ -287,7 +314,11 @@ fn from(err: Error<State>) -> Self {
     /// and move between the variants:
     ///
     /// ```
-    /// use kernel::clk::{Clk, Enabled, Prepared};
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Enabled,
+    ///     Prepared, //
+    /// };
     /// use kernel::error::Result;
     ///
     /// enum DeviceClk {
@@ -481,7 +512,12 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
         /// clock or threading it through an intermediate state, e.g.:
         ///
         /// ```
-        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};
+        /// use kernel::clk::{
+        ///     Clk,
+        ///     Enabled,
+        ///     Hertz,
+        ///     Prepared, //
+        /// };
         /// use kernel::error::Result;
         ///
         /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {

-- 
2.54.0

