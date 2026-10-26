Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016346;
	b=QeAWhVp+vdwbyYbbOxz6Kfh38uYW5wYPCuzrJasrxoo6EMzd5ca3B1faHkcyMJ1vxv5Z
	 SD/0xnvrTxYq5TSRQXUAurl0G3m2JJra6uDUCJWwM/EgsM3FQxbE23Xhx/vlvOJA+bgGr
	 yqNYmSKduQsdPx/v9At13xz5ucWwrYibgmjg6Xwer8AhZ9t5v+/dpTaWh+KtCjRUXtjb3
	 z24cTLiU5/mooP1I1XkeMZ41cObNffWpjU3WxrEnKosG+oEOb0NnfE+5i56euMGNTe3nP
	 RhxcFbf6bg9MyFJmqUPU+tnyHcE4T/xa+ClotLwUy/BtuYPAeuH89OTa+kBeoJEKnoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016346;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sFgv2iGtnUuQY/DWEoqHSroL6twj/lAeRU+L/sXOWVo=;
	b=lMnIiBKBues0y47UKaxO5xwnJuq852oAByFEfVsbZi7HsaUIr2X8HbFwrkiA6lIFS0DJ
	 O32/2ayuqDahXhMkRGDmStHv5LPHhfD3f3FLVgkFkUvZrDAz2Ts5btMbBtfnoG3y+ZmGk
	 PUXgPsZoK6h9EvtunKstV3ite76WVDULKS9OLXkDRu06M2qPGqMrnWA4ROyQPz7EuGnAN
	 fhsQ2Jm/MLXP9hH7TyuYCyeTi0HgY4cf6Wpow7J5TRyKzX+BE8d1pLuN8aMNkj4Zq1smy
	 XEzx8tSuj9wV1jbH+1g+gOgIAaHoXg486r+A3YNowuFNZ63GcRXcHmBxKLHtR1hzYSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WqBQfwPt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D38606A336;
	Mon, 26 Oct 2026 12:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D38606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WqBQfwPt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FA628C7;
	Mon, 26 Oct 2026 05:05:40 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.58.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 294223F7B4;
	Mon, 26 Oct 2026 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793016343; bh=BLs/Dg1fioqLRrBFux4TGBSVtHNlcyWpLwLcu+yQwtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqBQfwPt3c+QWhspARDVHf9l8hqQLsZCPwXbIES/nRYOu0SKE1478KT7/Xu8Rz9Wb
	 mVTP8WTO7nGMAOqbn2p345QFQHpYjf8FxVJiorCGZOYQ7MDYuzcgG2740RSnPGB9Ks
	 3BMlTgDc7xwbY85rw5tCaIxoMOCU7fz0ZsvBdNgc=
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
Subject: [PATCH v5 1/3] rust: add runtime PM support
Date: Mon, 26 Oct 2026 13:05:06 +0100
Message-ID: <20261026120523.526942-2-beata.michalska@arm.com>
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

Add a Rust abstraction for Linux runtime PM, allowing Rust drivers to
register runtime PM callbacks and use scoped runtime PM requests while
retaining the behavior and guarantees of the underlying C PM core.

Runtime PM is managed through a registration object tied to the device
lifetime. The registration stores the callback payload and 'ensures'
that the registration, its `PMContext`, and the payload do not outlive
the device. All that while `PMContext` holds a lifetime-annotated
device reference so that runtime PM requests are made only while
the device remains bound.

Drivers define runtime PM callbacks through the `PMOps` trait. The
generated `dev_pm_ops` callbacks take the stored payload, pass
ownership to the corresponding Rust callback, and store the returned
payload for the next invocation. Each callback must return a valid
payload, regardless of whether the power transition succeeds or not.

`PMContext` provides scoped helpers for common runtime PM operations:

- `ResumeScope` resumes the device for the lifetime of the scope.
- `AwakeScope`  resumes the device and holds a runtime PM usage
		reference.
- `RetainScope` increments the runtime PM usage count without
		resuming the device.

Each scope performs the corresponding inverse operation when dropped,
according to the selected driver-defined profile.

The abstraction does not change the semantics of the C runtime PM API.
Asynchronous requests may only queue work, non-waiting requests may
fail instead of sleeping, and callbacks remain subject to the existing
driver core rules.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/base/base.h             |    4 +
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |   89 +++
 rust/kernel/lib.rs              |    1 +
 rust/kernel/pm.rs               | 1106 +++++++++++++++++++++++++++++++
 6 files changed, 1202 insertions(+)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/pm.rs

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..e79108bc754a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -103,6 +103,7 @@ struct driver_private {
  *			   dev_err_probe() for later retrieval via debugfs
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
+ * @rust_private: private data used exclusively by the Rust driver core
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -119,6 +120,9 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+#ifdef CONFIG_RUST
+	void *rust_private;
+#endif
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index cd0317418f14..05e402996d8f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -79,6 +79,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2c5eecc091c4..6bae79979610 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -82,6 +82,7 @@
 #include "pci.c"
 #include "pid_namespace.c"
 #include "platform.c"
+#include "pm_runtime.c"
 #include "poll.c"
 #include "processor.c"
 #include "property.c"
diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
new file mode 100644
index 000000000000..f06f3cc0d407
--- /dev/null
+++ b/rust/helpers/pm_runtime.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pm_runtime.h>
+
+__rust_helper
+void rust_helper_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+}
+
+__rust_helper
+void rust_helper_pm_runtime_put_noidle(struct device *dev)
+{
+	pm_runtime_put_noidle(dev);
+}
+
+__rust_helper
+void rust_helper_pm_runtime_mark_last_busy(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+}
+
+__rust_helper
+bool rust_helper_pm_runtime_active(struct device *dev)
+{
+	return pm_runtime_active(dev);
+}
+
+__rust_helper
+bool rust_helper_pm_runtime_suspended(struct device *dev)
+{
+	return pm_runtime_suspended(dev);
+}
+
+__rust_helper
+void rust_helper_pm_suspend_ignore_children(struct device *dev, bool enable)
+{
+	pm_suspend_ignore_children(dev, enable);
+}
+
+__rust_helper
+int rust_helper_pm_runtime_set_active(struct device *dev)
+{
+	return pm_runtime_set_active(dev);
+}
+
+__rust_helper
+int rust_helper_pm_runtime_set_suspended(struct device *dev)
+{
+	return pm_runtime_set_suspended(dev);
+}
+
+#ifndef CONFIG_PM
+__rust_helper
+int rust_helper___pm_runtime_resume(struct device *dev, int rpmflags)
+{
+	return __pm_runtime_resume(dev, rpmflags);
+}
+
+__rust_helper
+int rust_helper___pm_runtime_idle(struct device *dev, int rpmflags)
+{
+	return __pm_runtime_idle(dev, rpmflags);
+}
+
+__rust_helper
+int rust_helper___pm_runtime_suspend(struct device *dev, int rpmflags)
+{
+	return __pm_runtime_suspend(dev, rpmflags);
+}
+
+__rust_helper
+int rust_helper_pm_runtime_get_if_active(struct device *dev)
+{
+	return pm_runtime_get_if_active(dev);
+}
+
+__rust_helper void rust_helper_pm_runtime_enable(struct device *dev) {}
+__rust_helper void rust_helper___pm_runtime_disable(struct device *dev, bool c) {}
+__rust_helper void rust_helper_pm_runtime_barrier(struct device *dev) {}
+__rust_helper void rust_helper_pm_runtime_no_callbacks(struct device *dev) {}
+__rust_helper void rust_helper_pm_runtime_irq_safe(struct device *dev) {}
+__rust_helper
+void rust_helper___pm_runtime_use_autosuspend(struct device *dev, bool use)
+{}
+__rust_helper
+void rust_helper_pm_runtime_set_autosuspend_delay(struct device *dev, int delay)
+{}
+#endif /* CONFIG_PM */
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f9ef36217bb5..790998dfdb17 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -116,6 +116,7 @@
 pub mod pci;
 pub mod pid_namespace;
 pub mod platform;
+pub mod pm;
 pub mod prelude;
 pub mod print;
 pub mod processor;
diff --git a/rust/kernel/pm.rs b/rust/kernel/pm.rs
new file mode 100644
index 000000000000..1cfd72baf4af
--- /dev/null
+++ b/rust/kernel/pm.rs
@@ -0,0 +1,1106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Runtime Power Management abstraction.
+//!
+//! C header: [`include/linux/pm_runtime.h`](srctree/include/linux/pm_runtime.h)
+
+use crate::{
+    bindings,
+    bits::bit_u32,
+    device::{
+        self,
+        AsBusDevice, //
+    },
+    driver,
+    error::{
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    prelude::*,
+    sync::atomic::{
+        ordering,
+        Atomic,
+        AtomicFlag,
+        AtomicType, //
+    },
+    sync::Arc,
+    types::ForeignOwnable, //
+};
+
+use core::{cell::UnsafeCell, marker::PhantomData, mem::ManuallyDrop};
+
+kernel::impl_flags! {
+    /// Runtime Power Management modes that determine how a particular PM
+    /// transition is to be carried out.
+    /// Corresponds to C Runtime PM flag argument bits:
+    /// - `RPM_ASYNC`
+    /// - `RPM_NOWAIT`
+    /// - `RPM_GET_PUT`
+    /// - `RPM_AUTO`
+    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
+    pub struct Mode(u32);
+
+    /// Single RPM mode
+    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
+    pub enum ModeFlag {
+        /// Synchronous PM operations - default.
+        Sync = 0,
+        /// Allow asynchronous PM operations.
+        Async = bindings::RPM_ASYNC,
+        /// Do not wait for any pending requests to finish.
+        Nowait = bindings::RPM_NOWAIT,
+        /// Acquire a runtime-PM usage reference.
+        Acquire = bindings::RPM_GET_PUT,
+        /// Use autosuspend.
+        Auto = bindings::RPM_AUTO,
+        /// Additional mode for devices supporting idle states.
+        /// No counterpart.
+        Idle = bit_u32(16),
+    }
+}
+
+impl From<Mode> for core::ffi::c_int {
+    #[inline]
+    fn from(mode: Mode) -> core::ffi::c_int {
+        mode.0 as core::ffi::c_int
+    }
+}
+
+/// Device's runtime power management status
+#[repr(i32)]
+pub enum RuntimePMState {
+    /// The device is expected to be runtime active and in its normal operating state
+    Resumed = bindings::rpm_status_RPM_ACTIVE,
+    /// The device is expected to be suspended, unavailable for normal operations
+    Suspended = bindings::rpm_status_RPM_SUSPENDED,
+}
+
+/// Runtime power transition scope.
+pub struct Scope<'a, Tag> {
+    dev: &'a device::Device<device::Bound>,
+    mode: Mode,
+    _tag: PhantomData<Tag>,
+}
+
+/// Device resumed without incrementing the device's usage count
+pub struct Resume;
+/// Device resumed with the device's usage count being incremented
+pub struct Awake;
+/// Device with increased usage reference
+pub struct Retain;
+
+/// Resumes the device without acquiring the usage reference.
+/// Note: This does not guarantee the device will be kept active
+/// for the lifetime of the scope due to potential pending/incoming
+/// suspend requests.
+///
+/// On drop:
+/// - If `ModeFlag::Idle`, calls `__pm_runtime_idle()`:
+///   triggers idle notification before attempting to suspend
+/// - If `ModeFlag::Auto`, marks last busy then calls `__pm_runtime_suspend()`.
+/// - Otherwise calls `__pm_runtime_suspend()`.
+///
+/// The guard must be dropped from a context matching the requested transition
+/// mode: sync vs async.
+#[must_use = "dropping this guard issues the matching runtime PM release request"]
+pub struct ResumeScope<'a>(Scope<'a, Resume>);
+
+/// Acquires a runtime-PM usage reference and keeps the device powered.
+///
+/// Requires `ModeFlag::Acquire`. Drop behavior matches `ResumeScope`.
+/// The guard must be dropped from a context matching the requested transition
+/// mode: sync vs async.
+#[must_use = "dropping this guard releases its runtime PM hold"]
+pub struct AwakeScope<'a>(Scope<'a, Awake>);
+
+/// Prevents the device from getting suspended by holding the usage reference
+/// count.
+///
+/// On drop, calls `pm_runtime_put_noidle()`.
+#[must_use = "dropping this guard releases its runtime PM hold"]
+pub struct RetainScope<'a>(Scope<'a, Retain>);
+
+impl<'a> ResumeScope<'a> {
+    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
+        if mode.contains(ModeFlag::Acquire) {
+            // ModeFlag::Acquire is intended to be used with Awake scope
+            // Avoid mixing the modes.
+            return Err(EINVAL);
+        }
+
+        // ModeFlag::Idle is internal so strip it off before passing further
+        Request::resume(dev, mode & !ModeFlag::Idle).map(|()| {
+            Self(Scope::<Resume> {
+                dev,
+                mode,
+                _tag: PhantomData,
+            })
+        })
+    }
+
+    fn release_inner(&self) -> Result {
+        let scope_mode = self.0.mode & !ModeFlag::Idle;
+
+        match self.0.mode {
+            mode if mode.contains(ModeFlag::Idle) => Request::idle(self.0.dev, scope_mode),
+            mode if mode.contains(ModeFlag::Auto) => {
+                Request::mark_last_busy(self.0.dev);
+                Request::suspend(self.0.dev, scope_mode)
+            }
+            _ => Request::suspend(self.0.dev, scope_mode),
+        }
+    }
+
+    /// Explicitly release the scope
+    /// This should be used in favor of regular drop
+    /// when error handling is required.
+    pub fn release(self) -> Result {
+        let result = self.release_inner();
+        core::mem::forget(self);
+        result
+    }
+}
+
+impl<'a> Drop for ResumeScope<'a> {
+    fn drop(&mut self) {
+        let _ = self.release_inner();
+    }
+}
+
+impl<'a> AwakeScope<'a> {
+    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
+        if !mode.contains(ModeFlag::Acquire) {
+            return Err(EINVAL);
+        }
+        // ModeFlag::Idle is internal so strip it off before passing further
+        match Request::resume(dev, mode & !ModeFlag::Idle) {
+            Ok(()) => {}
+            // For async/nowait requests, `EINPROGRESS` means the resume is in
+            // flight and the usage reference already keeps the device active.
+            Err(e) if e == EINPROGRESS && mode.contains(ModeFlag::Async) => {}
+            Err(e) => {
+                Request::put_noidle(dev);
+                return Err(e);
+            }
+        }
+
+        Ok(Self(Scope::<Awake> {
+            dev,
+            mode,
+            _tag: PhantomData,
+        }))
+    }
+
+    fn release_inner(&self) -> Result {
+        let scope_mode = self.0.mode & !ModeFlag::Idle;
+        match self.0.mode {
+            mode if mode.contains(ModeFlag::Idle) => Request::idle(self.0.dev, scope_mode),
+            mode if mode.contains(ModeFlag::Auto) => {
+                Request::mark_last_busy(self.0.dev);
+                Request::suspend(self.0.dev, scope_mode)
+            }
+            _ => Request::suspend(self.0.dev, scope_mode),
+        }
+    }
+
+    /// Explicitly release the scope
+    /// This should be used in favor of regular drop
+    /// when error handling is required.
+    pub fn release(self) -> Result {
+        let result = self.release_inner();
+        core::mem::forget(self);
+        result
+    }
+}
+
+impl<'a> Drop for AwakeScope<'a> {
+    fn drop(&mut self) {
+        let _ = self.release_inner();
+    }
+}
+
+impl<'a> RetainScope<'a> {
+    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        Request::get_noresume(dev);
+        Ok(Self(Scope::<Retain> {
+            dev,
+            mode: Mode(ModeFlag::Sync as u32),
+            _tag: PhantomData,
+        }))
+    }
+
+    fn try_new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        Request::get_if_active(dev)?;
+        Ok(Self(Scope::<Retain> {
+            dev,
+            mode: Mode(ModeFlag::Sync as u32),
+            _tag: PhantomData,
+        }))
+    }
+
+    fn release_inner(&self) {
+        Request::put_noidle(self.0.dev);
+    }
+
+    /// Explicitly release the scope
+    /// This should be used in favor of regular drop
+    /// when error handling is required.
+    pub fn release(self) -> Result {
+        self.release_inner();
+        core::mem::forget(self);
+        Ok(())
+    }
+}
+
+impl<'a> Drop for RetainScope<'a> {
+    fn drop(&mut self) {
+        self.release_inner();
+    }
+}
+
+/// Runtime PM helpers - wrappers around C runtime PM interface.
+/// All methods require a reference to a bound device.
+struct Request;
+
+impl Request {
+    #[inline]
+    fn active(dev: &device::Device<device::Bound>) -> bool {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_active(dev.as_raw()) }
+    }
+
+    #[inline]
+    fn suspended(dev: &device::Device<device::Bound>) -> bool {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_suspended(dev.as_raw()) }
+    }
+
+    #[inline]
+    fn resume(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        to_result(unsafe { bindings::__pm_runtime_resume(dev.as_raw(), mode.into()) })
+    }
+
+    #[inline]
+    fn suspend(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        to_result(unsafe { bindings::__pm_runtime_suspend(dev.as_raw(), mode.into()) })
+    }
+
+    #[inline]
+    fn get_noresume(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_get_noresume(dev.as_raw()) };
+    }
+
+    #[inline]
+    fn get_if_active(dev: &device::Device<device::Bound>) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        match unsafe { bindings::pm_runtime_get_if_active(dev.as_raw()) } {
+            ret if ret < 0 => Err(Error::from_errno(ret)),
+            0 => Err(EAGAIN),
+            _ => Ok(()),
+        }
+    }
+
+    #[inline]
+    fn idle(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        to_result(unsafe { bindings::__pm_runtime_idle(dev.as_raw(), mode.into()) })
+    }
+
+    #[inline]
+    fn put_noidle(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_put_noidle(dev.as_raw()) };
+    }
+
+    #[inline]
+    fn mark_active(dev: &device::Device<device::Bound>) -> Result {
+        to_result(
+            // SAFETY: `dev.as_raw()` must provide a valid pointer to
+            // `struct device` for the duration of the call.
+            // The `Device<Bound>` reference provides that guarantee.
+            unsafe { bindings::pm_runtime_set_active(dev.as_raw()) },
+        )
+    }
+
+    #[inline]
+    fn mark_suspended(dev: &device::Device<device::Bound>) -> Result {
+        to_result(
+            // SAFETY: `dev.as_raw()` must provide a valid pointer to
+            // `struct device` for the duration of the call.
+            // The `Device<Bound>` reference provides that guarantee.
+            unsafe { bindings::pm_runtime_set_suspended(dev.as_raw()) },
+        )
+    }
+
+    #[inline]
+    fn mark_last_busy(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe {
+            bindings::pm_runtime_mark_last_busy(dev.as_raw());
+        }
+    }
+
+    #[inline]
+    fn runtime_enable(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_enable(dev.as_raw()) }
+    }
+
+    #[inline]
+    fn runtime_disable(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::__pm_runtime_disable(dev.as_raw(), true) };
+    }
+
+    #[inline]
+    fn barrier(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe {
+            bindings::pm_runtime_barrier(dev.as_raw());
+        }
+    }
+}
+
+/// Common runtime PM callback entry point
+///
+/// The generated extern "C" callbacks call into this helper with the raw
+/// `struct device *` provided by the PM core. It rebuilds the Rust device
+/// reference, retrieves the device's PM registration data and performs
+/// handoff to corresponding driver callback.
+#[cfg(CONFIG_PM)]
+fn runtime_pm_callback<T, F>(dev: *mut bindings::device, cb: F) -> Result
+where
+    T: PMOps,
+    F: FnOnce(
+        &<T as PMOps>::DeviceType,
+        <T as PMOps>::RuntimePayloadType,
+    ) -> PMCallbackResult<<T as PMOps>::RuntimePayloadType>,
+{
+    let dev: &device::Device<device::Bound>  =
+             // SAFETY: `dev` is provided by the PM core and remains
+             // valid for the duration of the callback.
+            unsafe { device::Device::from_raw(dev) };
+
+    // SAFETY: `dev` is provided by the PM core and remains
+    // valid for the duration of the callback.
+    let ptr = unsafe { (*(*dev.as_raw()).p).rust_private };
+
+    if ptr.is_null() {
+        return Err(ENODEV);
+    }
+
+    // SAFETY: The runtime PM callback can only be triggered for bound device
+    // and once the runtime PM is enabled.
+    // `rust_private` is guaranteed to be valid and points to
+    // associated RegistrationData<T> type object at least for the duration
+    // of this call.
+    let payload: Pin<&RegistrationData<'_, T>> =
+        unsafe { <Pin<KBox<RegistrationData<'_, T>>> as ForeignOwnable>::borrow(ptr) };
+
+    let pm_dev: &T::DeviceType =
+        // SAFETY: The generated `dev_pm_ops` for `T` is installed on devices whose
+        // bus-specific type is `T::DeviceType`. Therefore the base `Device<Bound>`
+        // passed by the PM core is embedded in a valid `T::DeviceType`; the
+        // `AsBusDevice` implementation supplies the correct offset for this cast.
+        unsafe { T::DeviceType::from_device(dev) };
+
+    payload.data.transition(|payload| cb(pm_dev, payload))
+}
+
+/// Runtime resume PM callback.
+///
+/// # Safety
+///
+/// `dev` must be a valid `struct device *` supplied by the PM core for a device
+/// whose runtime PM callbacks and PM registration data were both created
+/// for `T`.
+#[cfg(CONFIG_PM)]
+unsafe extern "C" fn runtime_resume_callback<T>(dev: *mut bindings::device) -> core::ffi::c_int
+where
+    T: PMOps,
+{
+    runtime_pm_callback::<T, _>(dev, T::runtime_resume)
+        .map(|()| 0)
+        .unwrap_or_else(|e| e.to_errno())
+}
+/// Runtime suspend PM callback.
+///
+/// # Safety
+///
+/// `dev` must be a valid `struct device *` supplied by the PM core for a device
+/// whose runtime PM callbacks and PM registration data were both created
+/// for `T`.
+#[cfg(CONFIG_PM)]
+unsafe extern "C" fn runtime_suspend_callback<T>(dev: *mut bindings::device) -> core::ffi::c_int
+where
+    T: PMOps,
+{
+    runtime_pm_callback::<T, _>(dev, T::runtime_suspend)
+        .map(|()| 0)
+        .unwrap_or_else(|e| e.to_errno())
+}
+
+/// Default empty Runtime PM ops
+pub const PMOPS_NONE: bindings::dev_pm_ops =
+    // SAFETY:
+    // bindings::dev_pm_ops is #[repr(C)], implements Default
+    // and the struct itself is all nullable function pointers.
+    // There is no padding and all zero bit-pattern is valid
+    //
+    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().assume_init() };
+
+/// Typed reference to a driver's runtime PM ops.
+///
+/// Instances of this type are generated from static [`DevPMOps`]
+/// and are used by bus registration code to install the matching
+/// C `dev_pm_ops` pointer into the driver object.
+/// The `A` parameter identifies the bus adapter that is allowed
+/// to install the table.
+pub struct DevPMOpsRef<'a, A> {
+    #[cfg_attr(not(CONFIG_PM), allow(unused))]
+    ops: &'a bindings::dev_pm_ops,
+    _p: PhantomData<fn() -> *const A>,
+}
+
+// SAFETY: `DevPMOpsRef` only contains a shared reference to an immutable
+// `dev_pm_ops` table and a type marker. Sharing it between threads cannot
+// introduce mutation or aliasing of Rust-owned state.
+unsafe impl<A> Sync for DevPMOpsRef<'_, A> {}
+
+impl<A> DevPMOpsRef<'_, A> {
+    #[cfg_attr(not(CONFIG_PM), allow(unused))]
+    #[inline]
+    pub(crate) const fn as_raw(&self) -> *const bindings::dev_pm_ops {
+        self.ops
+    }
+}
+
+/// Runtime PM ops for a driver.
+///
+/// Parameterized by:
+///  - The first type parameter identifies the bus adapter that installs the C
+///    [`bindings::dev_pm_ops`].
+///  - The second type parameter identifies the Rust driver implementation
+///    that provides the runtime PM callbacks and associated payload.
+///
+/// Intended to be constructed by bus-specific helpers, allowing
+/// the bus to ensure that the callback device type matches the device
+/// supplied by the C driver core.
+pub struct DevPMOps<T: PMOps> {
+    raw: bindings::dev_pm_ops,
+    _p: PhantomData<fn() -> T>,
+}
+
+impl<T: PMOps> DevPMOps<T> {
+    /// Creates a typed runtime PM ops.
+    ///
+    /// # Safety
+    ///
+    /// The caller must guarantee that `T::Adapter` is the bus adapter that
+    /// will install this ops into the C driver object for `T`, and
+    /// that `T::DeviceType` is the bus device type corresponding to
+    /// that adapter. Safe bus-specific constructors should wrap this
+    /// function with those bounds.
+    pub(crate) const unsafe fn new_unchecked(raw: bindings::dev_pm_ops) -> Self {
+        Self {
+            raw,
+            _p: PhantomData,
+        }
+    }
+
+    /// Provides a typed reference to this runtime PM ops
+    ///
+    /// Bus registration code uses the returned value to install
+    /// the ops into the corresponding C driver object.
+    /// The returned reference is tied to `T::Adapter`.
+    pub const fn pm_ops(&'static self) -> DevPMOpsRef<'static, T::Adapter> {
+        DevPMOpsRef {
+            ops: &self.raw,
+            _p: PhantomData,
+        }
+    }
+
+    /// Returns the raw C runtime PM operations table.
+    #[inline]
+    pub const fn as_raw(&'static self) -> *const bindings::dev_pm_ops {
+        &self.raw
+    }
+}
+
+/// Result type returned by runtime PM callbacks.
+pub type PMCallbackResult<T> = Result<T, (T, Error)>;
+
+/// Runtime PM callbacks implemented by a driver.
+///
+/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm_ops`].
+///
+/// The Adapter associated type identifies the bus adapter that installs
+/// the generated PM ops.
+/// Implementations should normally be enabled through a
+/// bus-specific constructor for [`DevPMOps`], which constrains
+/// [`Self::DeviceType`] to the correct bound device type for that bus.
+///
+/// Each C callback recovers the Rust bus device from the raw
+/// `struct device *`, borrows the registered runtime PM payload, and delegates
+/// to the matching [`PMOps`] trait method.
+#[vtable]
+pub trait PMOps: Sized {
+    /// The bus adapter that installs the generated PM ops.
+    type Adapter: driver::DriverLayout + 'static;
+
+    /// Type of the bound bus device passed to runtime PM callbacks.
+    type DeviceType: AsBusDevice<device::Bound>;
+
+    /// Type of the payload moved through runtime PM transitions.
+    type RuntimePayloadType: Send + 'static;
+
+    /// Runtime resume callback.
+    fn runtime_resume<'a>(
+        _dev: &'a Self::DeviceType,
+        _payload: Self::RuntimePayloadType,
+    ) -> PMCallbackResult<Self::RuntimePayloadType> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Runtime suspend callback.
+    fn runtime_suspend<'a>(
+        _dev: &'a Self::DeviceType,
+        _payload: Self::RuntimePayloadType,
+    ) -> PMCallbackResult<Self::RuntimePayloadType> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// RAII guard for ongoing runtime PM payload transition.
+///
+/// For most of the callbacks this guard is not necessarily needed as
+/// the callbacks themselves are being serialized by the runtime PM C code.
+/// Still, some like runtime_idle are exempt from that.
+#[cfg_attr(not(CONFIG_PM), allow(unused))]
+struct PayloadGuard<'a> {
+    busy: &'a AtomicFlag,
+}
+
+impl Drop for PayloadGuard<'_> {
+    fn drop(&mut self) {
+        self.busy.store(false, ordering::Release);
+    }
+}
+
+#[cfg_attr(not(CONFIG_PM), allow(unused))]
+struct PMPayload<P> {
+    in_flight: AtomicFlag,
+    inner: UnsafeCell<ManuallyDrop<P>>,
+}
+
+#[cfg_attr(not(CONFIG_PM), allow(unused))]
+impl<P> PMPayload<P> {
+    /// Attempts to acquire exclusive access to the runtime PM payload.
+    ///
+    /// Returns `EBUSY` if another runtime PM callback is already transitioning the
+    /// payload.
+    fn acquire(&self) -> Result<PayloadGuard<'_>> {
+        self.in_flight
+            .cmpxchg(false, true, ordering::Acquire)
+            .map_err(|_| EBUSY)?;
+        Ok(PayloadGuard {
+            busy: &self.in_flight,
+        })
+    }
+
+    /// Runs a runtime PM transition with exclusive access to the stored payload.
+    ///
+    /// This method acquires the in-flight guard, temporarily takes the payload out
+    /// of storage. The closure must return the payload that should be stored
+    /// for the next transition.
+    ///
+    /// On success, the returned payload replaces the previous payload. On failure,
+    /// the closure returns the payload together with the error, and that payload is
+    /// restored before the error is propagated.
+    ///
+    /// Returns `EBUSY` if another runtime PM transition is already in progress.
+    fn transition(&self, f: impl FnOnce(P) -> Result<P, (P, Error)>) -> Result {
+        let _guard = self.acquire()?;
+        // SAFETY: Holding `_guard` means this callback successfully changed
+        // `in_flight` from false to true. No other caller can hold a `PayloadGuard`
+        // until `_guard` is dropped, so this function has exclusive access to `inner`.
+        let slot = unsafe { &mut *self.inner.get() };
+        // SAFETY: same as above
+        let payload = unsafe { ManuallyDrop::take(slot) };
+
+        match f(payload) {
+            Ok(new_payload) => {
+                *slot = ManuallyDrop::new(new_payload);
+                Ok(())
+            }
+            Err((old_payload, err)) => {
+                *slot = ManuallyDrop::new(old_payload);
+                Err(err)
+            }
+        }
+    }
+}
+
+impl<P> Drop for PMPayload<P> {
+    fn drop(&mut self) {
+        // SAFETY: teardown drained PM callbacks and the slot holds a `P`
+        unsafe {
+            ManuallyDrop::drop(self.inner.get_mut());
+        }
+    }
+}
+
+// SAFETY: Although PMPayload's `inner` is an `UnsafeCell`, it is only accessed
+// after `in_flight` has been acquired. The AtomicFlag flag serializes all mutable
+// access to the payload, and `PayloadGuard` clears the flag when the access ends.
+unsafe impl<P: Send> Sync for PMPayload<P> {}
+
+#[derive(Clone, Copy, PartialEq, Eq)]
+#[repr(i32)]
+enum PMContextState {
+    /// The PM registration is alive, but runtime PM has not been enabled.
+    Disabled = 0,
+    /// The runtime PM has been enabled. Intended to be balanced by
+    /// `disable()` or `Registration::drop()`
+    Enabled = 1,
+    /// The owning `Registration` is being dropped or has been dropped.
+    /// Stale cloned `PMContext`s may still exist, but once this state is
+    /// visible, runtime PM cannot be re-enabled.
+    Dead = 2,
+}
+
+// SAFETY: `PMContextState` has the same size and alignment as `i32`, and all
+// values written through `Atomic<PMContextState>` are valid `PMContextState`
+// discriminants.
+unsafe impl AtomicType for PMContextState {
+    type Repr = i32;
+}
+
+struct PMContextInner<'a, T: PMOps> {
+    dev: &'a device::Device<device::Bound>,
+    /// State owned by the runtime PM registration
+    state: Atomic<PMContextState>,
+    /// Optional driver-selected runtime PM request PMProfiles.
+    ///
+    /// Set of runtime PM predefined PMProfiles that can be used by the driver
+    /// when requesting a PM transition. This might be useful when a driver
+    /// has several different PM usage patterns.
+    /// See [PMProfile] for more details.
+    profiles: KVec<PMProfile>,
+    /// Set of PM config options applied for associated device.
+    configs: KVec<PMConfig>,
+    _marker: PhantomData<fn() -> T>,
+}
+
+/// Runtime PM context tied to a device.
+pub struct PMContext<'a, T: PMOps> {
+    // Preferably, PMContext could be shared via borrowed reference over
+    // a pm Registration's lifetime but that bears complications on its own
+    // when the context needs to be shared across different Registration types.
+    inner: Arc<PMContextInner<'a, T>>,
+}
+
+impl<'a, T: PMOps> PMContext<'a, T> {
+    /// Driver-provided runtime PM operations.
+    ///
+    /// A driver implements this trait to handle runtime PM
+    /// transitions for its device type.
+    ///
+    /// Each callback receives the device and the current payload.
+    /// On success, it returns the payload to keep for the next
+    /// transition. On failure, it returns the payload together
+    /// with the error so the previous, or otherwise sane state
+    /// can be preserved.
+    #[cfg(CONFIG_PM)]
+    pub(crate) const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
+        runtime_resume: if T::HAS_RUNTIME_RESUME {
+            Some(runtime_resume_callback::<T>)
+        } else {
+            None
+        },
+        runtime_suspend: if T::HAS_RUNTIME_SUSPEND {
+            Some(runtime_suspend_callback::<T>)
+        } else {
+            None
+        },
+        ..PMOPS_NONE
+    };
+
+    #[cfg(not(CONFIG_PM))]
+    pub(crate) const PM_OPS: bindings::dev_pm_ops = PMOPS_NONE;
+
+    /// Enable runtime PM
+    pub fn enable(&self, state: RuntimePMState) -> Result {
+        self.inner
+            .state
+            .cmpxchg(
+                PMContextState::Disabled,
+                PMContextState::Enabled,
+                ordering::Full,
+            )
+            .map_err(|old| match old {
+                PMContextState::Dead => ENODEV,
+                PMContextState::Enabled => EBUSY,
+                _ => EINVAL, // unreachable
+            })?;
+
+        match state {
+            RuntimePMState::Resumed => Request::mark_active(self.inner.dev),
+            RuntimePMState::Suspended => Request::mark_suspended(self.inner.dev),
+        }
+        .inspect_err(|_| {
+            self.inner
+                .state
+                .store(PMContextState::Disabled, ordering::Release);
+        })?;
+
+        Self::apply_config(self.inner.dev, &self.inner.configs);
+        Request::runtime_enable(self.inner.dev);
+        Ok(())
+    }
+    /// Disable runtime PM
+    pub fn disable(&self) -> Result {
+        self.inner
+            .state
+            .cmpxchg(
+                PMContextState::Enabled,
+                PMContextState::Disabled,
+                ordering::Full,
+            )
+            .map_err(|old| match old {
+                PMContextState::Dead => ENODEV,
+                PMContextState::Disabled => EINVAL,
+                _ => EINVAL, //unreachable
+            })?;
+
+        Self::apply_config(self.inner.dev, &[PMConfig::AutoSuspend(false)]);
+        Request::runtime_disable(self.inner.dev);
+        Ok(())
+    }
+
+    /// Returns whether the runtime PM state is active.
+    #[inline]
+    pub fn active(&self) -> bool {
+        Request::active(self.inner.dev)
+    }
+
+    /// Returns whether the runtime PM state is suspended.
+    #[inline]
+    pub fn suspended(&self) -> bool {
+        Request::suspended(self.inner.dev)
+    }
+
+    /// Creates a `ResumeScope` for the given PMProfile.
+    #[inline]
+    pub fn resume(&self, profile: PMProfile) -> Result<ResumeScope<'a>> {
+        ResumeScope::new(self.inner.dev, profile.0)
+    }
+
+    /// Creates an `AwakeScope` for the given PMProfile.
+    /// Note that for ASYNC request this does not guarantee
+    /// the device has been resumed at the time this function returns.
+    #[inline]
+    pub fn get(&self, profile: PMProfile) -> Result<AwakeScope<'a>> {
+        AwakeScope::new(self.inner.dev, profile.0 | ModeFlag::Acquire)
+    }
+
+    /// Creates a `RetainScope` for this device.
+    pub fn hold(&self) -> Result<RetainScope<'a>> {
+        RetainScope::new(self.inner.dev)
+    }
+
+    /// Creates a `RetainScope` for an active device.
+    pub fn try_hold_active(&self) -> Result<RetainScope<'a>> {
+        RetainScope::try_new(self.inner.dev)
+    }
+
+    /// Runs a closure while holding a `ResumeScope`.
+    pub fn with_resume<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
+        if profile.0.contains(ModeFlag::Async) {
+            return Err(EINVAL);
+        }
+        let _scope = self.resume(profile)?;
+        f()
+    }
+    /// Runs a closure while holding an `AwakeScope`.
+    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
+        if profile.0.contains(ModeFlag::Async) {
+            return Err(EINVAL);
+        }
+        let _scope = self.get(profile)?;
+        f()
+    }
+
+    /// Runs a closure while holding a `RetainScope`.
+    pub fn with_hold<R>(&self, f: impl FnOnce() -> Result<R>) -> Result<R> {
+        let _scope = self.hold()?;
+        f()
+    }
+
+    /// Applies runtime PM configuration options.
+    ///
+    /// Options are applied in the order provided. The currently supported
+    /// options do not report per-option failures.
+    fn apply_config(dev: &device::Device<device::Bound>, opts: &[PMConfig]) {
+        for opt in opts {
+            match opt {
+                // SAFETY: `self.dev` is a valid `&ARef<Device>`, so the underlying `Device` is
+                // guaranteed to be alive and `as_raw()` yields a valid pointer for the
+                // duration of this call.
+                PMConfig::IgnoreChildren(v) => unsafe {
+                    bindings::pm_suspend_ignore_children(dev.as_raw(), *v)
+                },
+                // SAFETY: `self.dev` is a valid `&ARef<Device>`, so the underlying `Device` is
+                // guaranteed to be alive and `as_raw()` yields a valid pointer for the
+                // duration of this call.
+                PMConfig::NoCallbacks => unsafe { bindings::pm_runtime_no_callbacks(dev.as_raw()) },
+                // SAFETY: `self.dev` is a valid `&ARef<Device>`, so the underlying `Device` is
+                // guaranteed to be alive and `as_raw()` yields a valid pointer for the
+                // duration of this call.
+                PMConfig::IrqSafe => unsafe { bindings::pm_runtime_irq_safe(dev.as_raw()) },
+                // SAFETY: `self.dev` is a valid `&ARef<Device>`, so the underlying `Device` is
+                // guaranteed to be alive and `as_raw()` yields a valid pointer for the
+                // duration of this call.
+                PMConfig::AutoSuspend(v) => unsafe {
+                    bindings::__pm_runtime_use_autosuspend(dev.as_raw(), *v);
+                },
+                // SAFETY: `self.dev` is a valid `&ARef<Device>`, so the underlying `Device` is
+                // guaranteed to be alive and `as_raw()` yields a valid pointer for the
+                // duration of this call.
+                PMConfig::AutoSuspendDelay(v) => unsafe {
+                    bindings::pm_runtime_set_autosuspend_delay(dev.as_raw(), *v);
+                    bindings::__pm_runtime_use_autosuspend(dev.as_raw(), true);
+                },
+            }
+        }
+    }
+
+    /// Get a borrowed reference to PM profiles associated with the PM context
+    pub fn profiles(&self) -> &[PMProfile] {
+        &self.inner.profiles
+    }
+
+    /// Get a borrowed reference to PM configs associated with the PM context
+    pub fn configs(&self) -> &[PMConfig] {
+        &self.inner.configs
+    }
+}
+
+// Preferably, PMContext could be shared via borrowed reference over
+// a pm Registration's lifetime but that bears complications on its own
+// when the context needs to be shared across different Registration types.
+impl<T: PMOps> Clone for PMContext<'_, T> {
+    fn clone(&self) -> Self {
+        Self {
+            inner: self.inner.clone(),
+        }
+    }
+}
+
+/// Runtime PM request PMProfile.
+pub struct PMProfile(Mode);
+
+impl PMProfile {
+    /// Creates a PMProfile with default SYNC mode set.
+    pub const fn new() -> Self {
+        Self(Mode(ModeFlag::Sync as u32))
+    }
+    /// Enables async PM operations for this PMProfile.
+    pub const fn r#async(self) -> Self {
+        Self(Mode(self.0 .0 | ModeFlag::Async as u32))
+    }
+    /// Use autosuspend
+    pub const fn auto(self) -> Self {
+        Self(Mode(self.0 .0 | ModeFlag::Auto as u32))
+    }
+    /// Requests idle handling for this PMProfile.
+    pub const fn idle(self) -> Self {
+        Self(Mode(self.0 .0 | ModeFlag::Idle as u32))
+    }
+    /// Do not wait for concurrent requests to finish.
+    pub const fn nowait(self) -> Self {
+        Self(Mode(self.0 .0 | ModeFlag::Nowait as u32))
+    }
+}
+
+impl Default for PMProfile {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// Configuration knobs for runtime PM.
+pub enum PMConfig {
+    /// Ignore child devices when suspending.
+    IgnoreChildren(bool),
+    /// Disable runtime PM callbacks.
+    NoCallbacks,
+    /// Mark device as IRQ-safe for runtime PM.
+    IrqSafe,
+    /// Enable or disable autosuspend.
+    AutoSuspend(bool),
+    /// Set autosuspend delay (milliseconds).
+    AutoSuspendDelay(i32),
+}
+
+/// Runtime PM data stored within the `struct device_private` during
+/// runtime PM registration.
+///
+/// The data is associated with PM transitions and it's conceptually owned
+/// by the Registration itself.
+///
+#[repr(C)]
+struct RegistrationData<'a, T: PMOps> {
+    data: PMPayload<T::RuntimePayloadType>,
+    _marker: PhantomData<&'a mut T>,
+}
+
+/// Runtime PM registration for a device.
+///
+/// A `Registration` installs the runtime PM payload used by the
+/// generated [`PMOps`] callbacks and owns the corresponding teardown.
+///
+/// Dropping the registration disables runtime PM, waits for in-flight runtime PM
+/// callbacks to complete, and then removes the stored registration data.
+pub struct Registration<'a, T: PMOps> {
+    ctx: PMContext<'a, T>,
+}
+
+impl<'a, T: PMOps> Registration<'a, T> {
+    /// Creates a runtime PM registration for `dev`.
+    ///
+    /// The provided profiles and configuration are stored in the associated
+    /// [`PMContext`]. The `payload` is stored as a Registration data
+    /// and is used to service PM transitions.
+    ///
+    /// The device must use the callback represented by `ops`, generated
+    /// for the same bus adapter and driver pair `(D, T)`.
+    ///
+    /// # Safety
+    ///
+    /// The returned [`Registration`] object cannot be mem::forgotten,
+    /// or it's [`Drop`] implementation cannot be skipped in any way.
+    ///
+    pub unsafe fn new(
+        dev: &'a device::Device<device::Core<'_>>,
+        ops: &'static DevPMOps<T>,
+        profiles: Option<KVec<PMProfile>>,
+        configs: Option<KVec<PMConfig>>,
+        payload: T::RuntimePayloadType,
+    ) -> Result<Self> {
+        // SAFETY: For the duration of this call, `dev` is a valid `Device<Core>`,
+        // and so is its raw `struct device` pointer.
+        unsafe {
+            let drv = (*dev.as_raw()).driver;
+            if drv.is_null() || (*drv).pm != ops.as_raw() {
+                return Err(EINVAL);
+            }
+        }
+
+        let payload = KBox::new(
+            RegistrationData::<T> {
+                data: PMPayload {
+                    in_flight: AtomicFlag::new(false),
+                    inner: UnsafeCell::new(ManuallyDrop::new(payload)),
+                },
+                _marker: PhantomData,
+            },
+            GFP_KERNEL,
+        )?;
+
+        let inner_ctx = Arc::new(
+            PMContextInner {
+                dev,
+                state: Atomic::new(PMContextState::Disabled),
+                profiles: profiles.unwrap_or_default(),
+                configs: configs.unwrap_or_default(),
+                _marker: PhantomData,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY: For the duration of this call, `dev` is a valid `Device<Core>`,
+        // and so is its raw `struct device` pointer.
+        // The payload allocation is converted into a foreign pointer
+        // and owned by this `Registration` until `Drop` clears
+        // `rust_private` and reconstructs the `KBox`.
+        unsafe {
+            let ptr = (*(*dev.as_raw()).p).rust_private;
+            if !ptr.is_null() {
+                return Err(EBUSY);
+            }
+            (*(*dev.as_raw()).p).rust_private = payload.into_foreign();
+        }
+
+        Ok(Self {
+            ctx: PMContext { inner: inner_ctx },
+        })
+    }
+    /// Returns the runtime PM context associated with this registration.
+    pub fn ctx(&self) -> &PMContext<'a, T> {
+        &self.ctx
+    }
+}
+
+impl<'a, T: PMOps> Drop for Registration<'a, T> {
+    fn drop(&mut self) {
+        // `self.ctx.inner.dev` is the device this registration was
+        // created for. Runtime PM is disabled first, and `pm_runtime_barrier`
+        // waits for pending runtime PM work/callbacks before the callback data
+        // is removed below.
+        // Furthermore, prevent any stale `PMContext`s from re-enabling runtime
+        // PM after teardown starts.
+        if self
+            .ctx
+            .inner
+            .state
+            .xchg(PMContextState::Dead, ordering::Full)
+            == PMContextState::Enabled
+        {
+            PMContext::<T>::apply_config(self.ctx.inner.dev, &[PMConfig::AutoSuspend(false)]);
+            Request::runtime_disable(self.ctx.inner.dev);
+        }
+        Request::barrier(self.ctx.inner.dev);
+
+        // SAFETY: The pointer, if non-null, was stored by `Registration::new`
+        // using `Pin<KBox<RegistrationData<T>>>::into_foreign`. Runtime PM has
+        // been disabled and drained above, so generated callbacks can no longer
+        // borrow this data. Clearing `rust_private` prevents later lookup, and
+        // `from_foreign` reconstructs the owning allocation so it is dropped.
+        unsafe {
+            let ptr = (*(*self.ctx.inner.dev.as_raw()).p).rust_private;
+
+            if !ptr.is_null() {
+                (*(*self.ctx.inner.dev.as_raw()).p).rust_private = core::ptr::null_mut();
+                KBox::<RegistrationData<'_, T>>::from_foreign(ptr);
+            }
+        }
+    }
+}
-- 
2.43.0

