Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83946AA8A;
	Tue, 21 Jul 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648231; cv=none; b=uEafZuPs88CjxEbVpVeEeBgUEsAtjEmNC/++06Wm6zWBuqGLF74vD709KTOR/JK+HdZ/+yoRwJWswpiCezPMJghyAWp84XPv4uMUF7vJh+UkEQfUhysS45HgyvHQ386dn2Zcxto5PdZZis0MIag0YGFMRWKDeb9M2dfRzv+DiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648231; c=relaxed/simple;
	bh=gv6XqnZO2E8j8RiCTtmGMSP9QoIU1GdqS7T9ZXr9UuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+Y2nt6cSkhydV08K8UBYnBmhyKuQTl0anMjBb01QSHB0eTjkdoCShMocLmOjWpppF5XkaTlDUvIlRrNZP7SU8K/Sv8DwKLBPAFzDNtA7SsnZ2YW0pkL7K+M1TR3qMyYCZnOgX5ENGGbB1KNyg5KeToO1AHuKjCO/GiKsCwdJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=plwKOh1d; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="plwKOh1d"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94781595;
	Tue, 21 Jul 2026 08:37:04 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.39.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D2BA3F58B;
	Tue, 21 Jul 2026 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784648228; bh=gv6XqnZO2E8j8RiCTtmGMSP9QoIU1GdqS7T9ZXr9UuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plwKOh1dLmOzOrP2+Pd9Y1ODt64TGcp1rbNJlezzbXhkmSMm0B2oaMYwXCfY6V7RO
	 wd5NU6Je8HeIhtFtfmOzJ6OE0nIV4HyrDg2D676SIN7DPytC7yh62YUT+tZC62ijhV
	 FamwtWHV+BxrcHoHuMsR0kM5qE8C8h1KzN8+UqpU=
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
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] rust: platform: wire runtime PM callbacks
Date: Tue, 21 Jul 2026 17:34:03 +0200
Message-ID: <20260721153617.869933-3-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721153617.869933-1-beata.michalska@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow Rust platform drivers to expose runtime PM callbacks to the driver core.

The runtime PM abstraction builds a dev_pm_ops table for the concrete driver
implementation, but the platform bus still needs to receive that table through
struct platform_driver. Add an optional PM_OPS associated constant to
platform::Driver and initialize the coresponding C device_driver struct
accordingly during registration. The platform glue only wires the callback
table into the C driver model; ownership of the callback payload and
runtime PM teardown remain with the pm module.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 rust/kernel/platform.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index d8d48f60b0b9..b7e422388634 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -72,6 +72,11 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let pm_ops = match T::PM_OPS {
+            Some(ops) => ops,
+            None => core::ptr::null(),
+        };
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
@@ -222,6 +228,9 @@ pub trait Driver {
     /// The table of ACPI device ids supported by the driver.
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
+    /// Runtime PM callbacks
+    const PM_OPS: Option<&'static bindings::dev_pm_ops> = None;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
-- 
2.43.0

