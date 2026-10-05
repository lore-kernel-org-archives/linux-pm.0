Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C548C3FF;
	Mon,  5 Oct 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207565; cv=none; b=n0JKN3Kd+iPQ1YOEoW6UArt276NMBc8rByOwmCUBh8u5BoRblA0UoDbhAFntODXX184g1Mr0uN8MpUobT3UcjqE0F51vaPTfFwg7liRsPar+IkOn192JzBrCzXcLf6VLLmYj/e1chOLyKZkBpp7sD8W0KMVDTEk6EJw4mCa+QTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207565; c=relaxed/simple;
	bh=wKERfWdaHxuR7rSS9GtRijin0nURq0vVEtbGAqeK+VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOAg8mKMimAh3AteOTBqH7iQbZBRtMD7TCm8/YsE7UX83oHm6TKs38LQEo8U//AmJGMkkRXvboTlNH9ldKKiUoVWXLpPLueRDd8EaGVV3uv9tjjhps0dwXlusYfX7KEoBD+BYyd071oXAOuqKyYqWu1N9hax2c+xjA+19E3yBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MJzCS6BW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MJzCS6BW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCE1152B;
	Mon,  5 Oct 2026 06:39:20 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.12.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFD9F3F86F;
	Mon,  5 Oct 2026 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791207563; bh=wKERfWdaHxuR7rSS9GtRijin0nURq0vVEtbGAqeK+VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJzCS6BWHKRhDQB5gUopzXNPAKS3Oe9RAOfOBEaTe1qy8A0lLWh2n+9YG+9Fljzs6
	 CAk67WNVWNm+zLnjlVNwlgE02eUIdUr1OcqGGtY/5fkQxLNXbFeZ0UCAFW2Yng+8hb
	 h4wq1LI1mVH06fdW8UOnCvspEOcTpt70qVXsCKAI=
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
Subject: [PATCH v4 2/3] rust: platform: wire runtime PM callbacks
Date: Mon,  5 Oct 2026 15:37:40 +0200
Message-ID: <20261005133857.1572243-3-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005133857.1572243-1-beata.michalska@arm.com>
References: <20261005133857.1572243-1-beata.michalska@arm.com>
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
 rust/kernel/platform.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ac0a012ae1bb..37dc622c39aa 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -79,6 +79,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
             (*pdrv.get()).driver.acpi_match_table = acpi_table;
+            (*pdrv.get()).driver.pm = T::dev_pm_ops().map_or(core::ptr::null(), |ops| ops.as_raw());
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -194,6 +195,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
+///
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
@@ -223,6 +225,14 @@ pub trait Driver {
     /// The table of ACPI device ids supported by the driver.
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
+    /// Provides driver's PM callbacks, if any.
+    fn dev_pm_ops() -> Option<crate::pm::DevPMOpsRef<'static, Adapter<Self>>>
+    where
+        Self: Sized,
+    {
+        None
+    }
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
@@ -587,3 +597,22 @@ unsafe impl Sync for Device {}
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
+    pub const fn new() -> Self {
+        // SAFETY: `Adapter<T>` is the platform bus adapter for `T`, and the
+        // bound above forces PM callbacks to receive a platform bound device.
+        unsafe { crate::pm::DevPMOps::new_unchecked(crate::pm::PMContext::<T>::PM_OPS) }
+    }
+}
-- 
2.43.0

