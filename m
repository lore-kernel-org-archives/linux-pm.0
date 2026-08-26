Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5942378F;
	Wed, 26 Aug 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749962; cv=none; b=EWex187H2Zc/y+eE/omHZbqHUpy3jUZeLitEN2q2rRp5GGJBZB7HrCD12hCYj6xOd6XaZPbHnJvNNmkTbwwD7GpauGmu5lcX0xTY8xO+fhl7OtIdaBQ97rJ/uZIsmsDypKbghTfilY2/qMFWfayFpSNVtYRAuvjo0cL4DB3dgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749962; c=relaxed/simple;
	bh=Dvr4w21SPqsUlFm1HpiovnkkPGGs5VIPTNOVgtfJKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJEbpyw31814gNI77Ax62LXbu7TIXBhJznzNf8M3d7IrrXkBIsvaTvzAde8aUG60QnLHTFESmIMiPqIO36H4+MPmrGCEGer+7xsZiip1Gj4WxW1n3ju9ai4990heIyJvnHS4H3LIL9hflepcolOy4GmC29wChyjejg2qcPZM9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sY2UK0Po; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sY2UK0Po"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60CF01BCA;
	Wed, 26 Aug 2026 06:12:35 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.1.236])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C83563F66F;
	Wed, 26 Aug 2026 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787749959; bh=Dvr4w21SPqsUlFm1HpiovnkkPGGs5VIPTNOVgtfJKNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY2UK0Po6szluYqY8Z8GTZnrr7a/9R65v7OSIKAz/aNti+8KV3oHhrbHE9NXtQpp2
	 HwTubWfctascRsPogLpotUWsuvRoLEobG3gVyQCLfrdH6wuQpLaEppZTZgdxibusrX
	 UVVbOyrlbBCy2G+MRymzI7dpbcZixXjNNceDLEdg=
From: Beata Michalska <beata.michalska@arm.com>
To: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
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
Subject: [PATCH v3 2/3] rust: platform: wire runtime PM callbacks
Date: Wed, 26 Aug 2026 15:10:56 +0200
Message-ID: <20260826131213.1820408-3-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826131213.1820408-1-beata.michalska@arm.com>
References: <20260826131213.1820408-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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
 rust/kernel/platform.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..3da2a5ed4857 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -72,6 +72,10 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let pm_ops = T::dev_pm_ops()
+            .map(|ops| ops.as_raw())
+            .unwrap_or(core::ptr::null());
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
@@ -79,6 +83,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
             (*pdrv.get()).driver.acpi_match_table = acpi_table;
+            (*pdrv.get()).driver.pm = pm_ops;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -195,6 +200,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
+///
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
@@ -224,6 +230,14 @@ pub trait Driver {
     /// The table of ACPI device ids supported by the driver.
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
+    /// Provides driver's PM callbacks, if any.
+    fn dev_pm_ops() -> Option<crate::pm::DevPMOps<Adapter<Self>, Self>>
+    where
+        Self: Sized,
+    {
+        None
+    }
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
@@ -571,3 +585,19 @@ unsafe impl Sync for Device {}
 // SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
 // `Bound` is a zero-sized type-state marker that does not affect thread safety.
 unsafe impl Sync for Device<device::Bound> {}
+
+#[allow(clippy::new_without_default)]
+impl<T> crate::pm::DevPMOps<Adapter<T>, T>
+where
+    T: Driver + crate::pm::PMOps<Adapter<T>, DeviceType = Device<device::Bound>>,
+{
+    /// Creates a platform driver's runtime PM callbacks for `T`.
+    ///
+    /// This constructor is available only when `T` is a platform driver and
+    /// its runtime PM callbacks accept a bound platform device.
+    pub const fn new() -> Self {
+        // SAFETY: `Adapter<T>` is the platform bus adapter for `T`, and the
+        // bound above forces PM callbacks to receive a platform bound device.
+        unsafe { crate::pm::DevPMOps::new_unchecked() }
+    }
+}
-- 
2.43.0

