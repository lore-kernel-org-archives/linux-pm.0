Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520183;
	b=WZWVWEAb1yWHPdMF4JxlhqcMkztLbEAQVZ6RtkxKZs4cCvUK2ls2t2wBna755iD3IbJS
	 GhOiUtYOeJdh8YeJfIXu8/xB+KbaG9yM0qf/h894xw4lUTNd8zHN13pbsNln7c0gTf4ie
	 L5KOlek/gaP4uqryOVjmsdT/sfbRnzRmnL8awDCJHYJBKzmmqGYPQatyGBfaWLijqHaK8
	 BojLBMaJcJiHBhHRqDYT6N1nBSRU/O21oQ1Yad/Nrd0aI6OOVC3lSo6uzlWdpLwgB/1o1
	 rX/9MSgWIe8766LaYWGZ43s+nCNE7y3nj4GRlbIxJqhHYw9i9Nzcm1R547UlrSYT0IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520183;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bkfFNcZNr1xtI726kQ+MdCMSiSANG76hQ61zNt//wtQ=;
	b=0WCmpAGQH9HjwakuWbfHAljliCvzDC9uhsAYEWG+UDdEVmCBL8F0MUy0cZNXzHO/E8kv
	 q7mLG0F4KQn43OlC+07oqKE/4CyCnXQbz6aLIi0IJWepQayT8CjP5pxksBCfhmPBV6Z9a
	 kVckXs9O2GjsaqVspfoi4JNUgcP/mEKfPjeU8aqwsAQeHD6P8VaOtpW9p/cAhv20q+rLV
	 8wF6Ez2GRo9dKwS6JkBTGdErAVOW92cEr/uIjf9hBqMXFH1pSL8gN4TbcI9yLmsVVPYez
	 58ZDISRmeylP32ovaOltgqVliqiGvO3EU/CUatHhzFgxw9ks0bOQE0klevwQY7LZTUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JliSP9kV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDBB606A31E;
	Tue, 24 Nov 2026 11:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACDBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JliSP9kV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525EE339;
	Tue, 24 Nov 2026 03:36:19 -0800 (PST)
Received: from e143943.arm.com (unknown [10.57.70.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A1113F86F;
	Tue, 24 Nov 2026 03:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795520182; bh=5xqs0IHuK3xrnnJlcwySoPn1Md64FE2QsPCP6FKsw98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JliSP9kVvBj6sWswKPviiTTZPcrvCDxmq7qe57TPnPQUIsUWSyppguxP3jVnayl1H
	 sYw4YuVY9TQprZMtRjkeUmTu94/zsBA0imMpkCmzBG6WuHJUNS+Sk2vKMpSRe5qp67
	 Os4EC/mgQ5O3wKOMbqUwgJpkCSW6nc2hlA/1OCLA=
From: Beata Michalska <beata.michalska@arm.com>
To: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	aliceryhl@google.com
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	boris.brezillon@collabora.com,
	work@onurozkan.dev,
	samitolvanen@google.com,
	acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 2/3] rust: platform: wire runtime PM callbacks
Date: Tue, 24 Nov 2026 12:34:13 +0100
Message-ID: <20261124113555.2480381-3-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124113555.2480381-1-beata.michalska@arm.com>
References: <20261124113555.2480381-1-beata.michalska@arm.com>
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

Allow platform drivers to provide Rust runtime PM callbacks by exposing
typed `dev_pm_ops` through the platform driver trait and installing them
via the generated `platform_driver`.

Add a platform-specific constructor for `pm::Ops` that ties the
PM callbacks to `platform::Adapter<T>` and requires callbacks to use
a bound platform device. This keeps the unsafe generic PM ops constructor
internal while letting platform drivers opt into runtime PM without
affecting drivers that do not use it.

The platform glue only wires the callback table into the C driver model;
ownership of the callback payload and runtime PM teardown remain with
the pm module.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 rust/kernel/platform.rs | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ac0a012ae1bb..c9f2bd3d9aad 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -10,7 +10,8 @@
     container_of,
     device::{
         self,
-        Bound, //
+        Bound,
+        pm, //
     },
     driver,
     error::{
@@ -72,6 +73,11 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        #[cfg(CONFIG_PM)]
+        let pm_ops = T::DEV_PM_OPS.map_or(core::ptr::null(), |ops| ops.as_raw());
+        #[cfg(not(CONFIG_PM))]
+        let pm_ops = core::ptr::null();
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
@@ -79,6 +85,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
             (*pdrv.get()).driver.acpi_match_table = acpi_table;
+            (*pdrv.get()).driver.pm = pm_ops;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -194,6 +201,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
+///
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
@@ -205,7 +213,7 @@ macro_rules! module_platform_driver {
 ///     }
 /// }
 ///```
-pub trait Driver {
+pub trait Driver: Sized {
     /// The type holding driver private data about each device id supported by the driver.
     // TODO: Use associated_type_defaults once stabilized:
     //
@@ -223,6 +231,9 @@ pub trait Driver {
     /// The table of ACPI device ids supported by the driver.
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
+    /// Provides driver's PM callbacks, if any.
+    const DEV_PM_OPS: Option<pm::AdapterOpsRef<'static, Adapter<Self>>> = None;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
@@ -587,3 +598,23 @@ unsafe impl Sync for Device {}
 // SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
 // `Bound` is a zero-sized type-state marker that does not affect thread safety.
 unsafe impl Sync for Device<device::Bound> {}
+
+#[allow(clippy::new_without_default)]
+impl<T> pm::Ops<T>
+where
+    T: Driver + pm::PMOps<
+        Adapter = Adapter<T>,
+        DeviceType = crate::platform::Device<device::Bound>,
+    >,
+{
+    /// Creates a platform driver's runtime PM callbacks for `T`.
+    ///
+    /// This constructor is available only when `T` is a platform driver and
+    /// its runtime PM callbacks accept a bound platform device.
+    #[inline]
+    pub const fn new() -> Self {
+        // SAFETY: `Adapter<T>` is the platform bus adapter for `T`, and the
+        // bound above forces PM callbacks to receive a platform bound device.
+        unsafe { pm::Ops::new_unchecked(pm::PMContext::<T>::PM_OPS) }
+    }
+}
-- 
2.43.0

