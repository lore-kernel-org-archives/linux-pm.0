Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074243BE16F;
	Mon,  6 Jul 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348743; cv=pass; b=nQsXbRNKgWY/VgYWMPcKX4I7INv7hM3pwmnx3LdVXqagBNqBmxBdnzwW5/k6DFFrG3qKqaXOzPYZFZB/eV06pqHheD740pGZLUS+JlwrZACLzHsB9fzf1hflvbQDhurLrlzJNWCMgIACTr6i5bnNt+WVLdVSH09Y9ZcunRs5ygk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348743; c=relaxed/simple;
	bh=5A0PYDl79o9DLnwKyHykq+EZHEycomHcdZN/jGd2oHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHx20JZnZaMNUAu2Vllh32ai8YphxyLXXzBJ//l/kB0rc1GWRjNa+o8+3knV/Hc90xy4h1FWpZWyTDFPJcqHGuHw8DoG25sC+oQOIaYJ5MYYBdC7wN9Xi1k3B//wcfrTkonJVKRMBGgTaAgfi7nlnZF7jmKrS6F2l6xXmIL2zak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VNI81rIS; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VNI81rIS"
ARC-Seal: i=1; a=rsa-sha256; t=1783348680; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MIOfhPRszk4c+sgy9Q6NAwEV1CdSkvErbwZmp5rbzyb565vspKxBHgnMfVxVORa+T3hEDUwKW8M+np6CCmV3JStrcyarSbIfNKuXRA8TmSDtPCyQYIi30L8eHntU5aaEqZgsNNVLmMDJ1QAxw4qqNDwzgZE/EnxMAhKhlRH3cFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783348680; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2E6p0yq7ndvFPYl6q3MG80gHOfGZKjQpLPchEo0gBIw=; 
	b=Cg2VMHYUsOaNGsrCn2kVDjfMDV5+rjPn6OREHq8DhhUBmOPoi87YXY9zXjuuGqXy97MUOUUObzkky7dp9ibnqiZCRmrGCnFw1UKRJzOcbR63uEji6pWFCD1qwTEhqm87A4QAAZsjE9JJ6qEN+6MXO3hL13r4Z58cXl5CV7SrwjU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783348680;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=2E6p0yq7ndvFPYl6q3MG80gHOfGZKjQpLPchEo0gBIw=;
	b=VNI81rIS2LH0loqTTo9Vvthp9xxFAqm7CpfYOWYizZW/sK7SZPkKZQw9BscJYd+l
	7GDHTG2ITjvDvaGRb67ulHDrG6sDrsNJCXDuTD/nxWSgjE1vidtf6XRWDRNlfOryUK1
	5YQlXfYKEEW0EICTFIc4UmpeNy8ll8I+iTdw9jBU=
Received: by mx.zohomail.com with SMTPS id 178334867955355.454678121945676;
	Mon, 6 Jul 2026 07:37:59 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 06 Jul 2026 11:37:15 -0300
Subject: [PATCH v5 4/4] rust: clk: use 'kernel vertical style' for imports
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-clk-type-state-v5-4-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
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
 Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Maurice <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Convert all imports to use the new import style. This will make it easier
to land new changes in the future.

No change of functionality implied.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 66 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index b9a44f83843a..e677156ffd21 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -80,13 +80,23 @@ fn from(freq: Hertz) -> Self {
 mod common_clk {
     use super::Hertz;
     use crate::{
-        device::{Bound, Device},
-        error::{from_err_ptr, to_result, Result},
+        device::{
+            Bound,
+            Device, //
+        },
+        error::{
+            from_err_ptr,
+            to_result, //
+        },
         prelude::*,
-        sync::Arc,
+        sync::Arc, //
     };
 
-    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
+    use core::{
+        marker::PhantomData,
+        mem::ManuallyDrop,
+        ptr, //
+    };
 
     mod private {
         pub trait Sealed {}
@@ -193,9 +203,15 @@ impl<State: ClkState> From<Error<State>> for kernel::error::Error {
         /// original [`Clk`], e.g.:
         ///
         /// ```
-        /// use kernel::clk::{Clk, Enabled, Unprepared};
-        /// use kernel::device::{Bound, Device};
-        /// use kernel::error::Result;
+        /// use kernel::clk::{
+        ///     Clk,
+        ///     Enabled,
+        ///     Unprepared, //
+        /// };
+        /// use kernel::device::{
+        ///     Bound,
+        ///     Device, //
+        /// };
         ///
         /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> {
         ///     let clk = Clk::<Unprepared>::get(dev, Some(c"apb_clk"))?
@@ -245,9 +261,17 @@ fn from(err: Error<State>) -> Self {
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
-    /// use kernel::device::{Bound, Device};
-    /// use kernel::error::Result;
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
     ///
     /// fn configure_clk(dev: &Device<Bound>) -> Result {
     ///     // The fastest way is to use a version of `Clk::get` for the desired
@@ -292,8 +316,11 @@ fn from(err: Error<State>) -> Self {
     /// and move between the variants:
     ///
     /// ```
-    /// use kernel::clk::{Clk, Enabled, Prepared};
-    /// use kernel::error::Result;
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Enabled,
+    ///     Prepared, //
+    /// };
     ///
     /// enum DeviceClk {
     ///     Suspended(Clk<Prepared>),
@@ -323,8 +350,11 @@ fn from(err: Error<State>) -> Self {
     /// enable a clone of it:
     ///
     /// ```
-    /// use kernel::clk::{Clk, Enabled, Prepared};
-    /// use kernel::error::Result;
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Enabled,
+    ///     Prepared, //
+    /// };
     ///
     /// fn use_clk(prepared_clk: &Clk<Prepared>) -> Result {
     ///     let enabled_clk: Clk<Enabled> = prepared_clk.clone().enable()?;
@@ -556,8 +586,12 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
         /// clock or threading it through an intermediate state, e.g.:
         ///
         /// ```
-        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};
-        /// use kernel::error::Result;
+        /// use kernel::clk::{
+        ///     Clk,
+        ///     Enabled,
+        ///     Hertz,
+        ///     Prepared, //
+        /// };
         ///
         /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {
         ///     clk.with_enabled(|clk: &Clk<Enabled>| clk.rate())

-- 
2.54.0

