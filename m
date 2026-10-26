Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016349;
	b=Pk+XHQmIXdDDKD1mostvbS628QpX+IWsrGcye3kq7xCUMsxOQOiGk6ObvCeudVbhcIZ2
	 A5t8yae97s/ueGl70thidTSmTu181aj3P4rDNyDC1cU9Poz1B5JVDoW+EJjz296KlQ5SK
	 9U9cIwguhJ/vH5sYdiZsM//JoDpYsF8oD1RSH2LkEOdzGgs0ZuvH7ikGNOEcpyeHNch8i
	 h/F4DrI2jN7te0ufgMZKMUNByut34n6aq7QTvYK+8qR7+7EJtfKn2z/FzyGkIVIZ4X/PZ
	 2u7QSH8RB6f/g7vaIOy7tQ+sFLXb68+oBnFqKCoyvwR+TSQa3wklrni4MgiJRFXMrcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016349;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZilW0XB6BHhrRULiOzNG1HXi3S6umgE4jXpLhpUC0xg=;
	b=2hYUea+3gO5ncWRv2WU9sjlb7KNwwxOze1tTjY4XWqPloP1LwlRGAA0v5PvBF0r8ka4M
	 bRopeunOu8yxUtvCxt9WLhvRpzA1kG1NOsJxaUUgGBxVXM2mHkZH/Oz1XSv8FmIbSpRFV
	 3Iv3n4fjlhtHkF/FEp9UffmibPgTDUdElbV/uoCvR3Ke8p7LQv3h8eN2hwnOme6V1vF/a
	 oM11TOL6bVZZfTYfgODUe3aaH1P5s5JZGgJZwjqTSGaFtzWX8OnoBp5DPH/UinmY3Z/A/
	 aMTGFVn/tKqelLy1NP+FISqy0HgAPi8Wn+8LSexmdmD5yCOsLH2LEYLdViq/ueZOFFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nsjTFYq7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D142F60A2616;
	Mon, 26 Oct 2026 12:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D142F60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nsjTFYq7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8F128FA;
	Mon, 26 Oct 2026 05:05:45 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.58.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBB103F7B4;
	Mon, 26 Oct 2026 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793016348; bh=5OfVdPR2UF1mCgifE+HNKGU16EFUcd/A6Dxc9hV2iyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsjTFYq7q6CdSI5Nwm3sWwJUDsCkAOgRxwrO7FHGVD3npJYHo8XSZFp2oby7kElyE
	 XL4qZGjJ3COktAWRsSevd4mTOykSCPI2P9D3jUMs/IMoG1V3ND2AB5BF93CAEvSUK0
	 CfgP4E1CoIic3lZcus7YbxWTNZ9nOi9EOaVrweFs=
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
Subject: [PATCH v5 2/3] rust: platform: wire runtime PM callbacks
Date: Mon, 26 Oct 2026 13:05:07 +0100
Message-ID: <20261026120523.526942-3-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026120523.526942-1-beata.michalska@arm.com>
References: <20261026120523.526942-1-beata.michalska@arm.com>
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

Add a platform-specific constructor for `pm::DevPMOps` that ties the
PM callbacks to `platform::Adapter<T>` and requires callbacks to use
a bound platform device. This keeps the unsafe generic PM ops constructor
internal while letting platform drivers opt into runtime PM without
affecting drivers that do not use it.

The platform glue only wires the callback table into the C driver model;
ownership of the callback payload and runtime PM teardown remain with
the pm module.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 rust/kernel/platform.rs | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ac0a012ae1bb..ae1ef7daa1fa 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -72,6 +72,11 @@ unsafe fn register(
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
@@ -79,6 +84,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
             (*pdrv.get()).driver.acpi_match_table = acpi_table;
+            (*pdrv.get()).driver.pm = pm_ops;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -194,6 +200,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
+///
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
@@ -205,7 +212,7 @@ macro_rules! module_platform_driver {
 ///     }
 /// }
 ///```
-pub trait Driver {
+pub trait Driver: Sized {
     /// The type holding driver private data about each device id supported by the driver.
     // TODO: Use associated_type_defaults once stabilized:
     //
@@ -223,6 +230,9 @@ pub trait Driver {
     /// The table of ACPI device ids supported by the driver.
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
+    /// Provides driver's PM callbacks, if any.
+    const DEV_PM_OPS: Option<crate::pm::DevPMOpsRef<'static, Adapter<Self>>> = None;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
@@ -587,3 +597,23 @@ unsafe impl Sync for Device {}
 // SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
 // `Bound` is a zero-sized type-state marker that does not affect thread safety.
 unsafe impl Sync for Device<device::Bound> {}
+
+#[allow(clippy::new_without_default)]
+impl<T> crate::pm::DevPMOps<T>
+where
+    T: Driver + crate::pm::PMOps<
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
+        unsafe { crate::pm::DevPMOps::new_unchecked(crate::pm::PMContext::<T>::PM_OPS) }
+    }
+}
-- 
2.43.0

