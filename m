Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263446AA96;
	Tue, 21 Jul 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648226; cv=none; b=UnusgKjXXL+b1hEqPdBpOR6lnEQpa01ZSfmwms4wM4T44r4c1UrBIkVnjUgKicO+CzimudOURgEi3TFj8xDXb5ocW6yjBmA9z2kgWm2zc6KQjDBOk6lrt3AOk3MJ0pzxH91gvIbsOP6O+gJvzJA3eHBk2goR5+AfKKHSFNPOwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648226; c=relaxed/simple;
	bh=W5QGBv22ixvrQPi6u7d+Yi7+JKDLfL8AqDy9e9m5SJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2ZqD1GAsYgtnIBJXb8x3g0CP6NjGjvWSsBK7hEo6t0QwPTrQ2VC+ImXFz88AtvsNPnyV2ryF9H0rgSuFo5U4ogf4RvLhQfGGCfwEET3BceET4tLoKDr9QS2IV3E0VKltAbq+ULQaTJbXVuy1oSJdBAKx5rpTs0iJesheFNKYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RVwojfzR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RVwojfzR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF85D152B;
	Tue, 21 Jul 2026 08:36:57 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.39.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE4DE3F58B;
	Tue, 21 Jul 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784648222; bh=W5QGBv22ixvrQPi6u7d+Yi7+JKDLfL8AqDy9e9m5SJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVwojfzRRpnhHYfTHCfIHz3hTz0RS4wl9ydO3NnDNNSdyQJQtTGlKvf73mnnCyhZ0
	 m7OfJeltKOqDM6LTLnJPn/mh3zDcSY+QdsEyNVEBTXHjYrw5UbY0fe/Mm4HaXfgDjh
	 KN8AhYTLEX2sH78bpqRHSd6RSdKZHNSr7MQY+ZU4=
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
Subject: [PATCH v2 1/3] rust: add runtime PM support
Date: Tue, 21 Jul 2026 17:34:02 +0200
Message-ID: <20260721153617.869933-2-beata.michalska@arm.com>
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

Add a Rust abstraction for Linux runtime PM, allowing Rust drivers to
register runtime PM callbacks and use scoped runtime PM requests while
retaining the behavior and guarantees of the underlying C PM core.

Runtime PM is managed through a registration object tied to the device
lifetime. The registration stores the callback payload and 'ensures' that
the registration, its `PMContext`, and the payload do not outlive the
device. All that while `PMContext` holds a lifetime-annotated device reference
so that runtime PM requests are made only while the device remains bound.

Drivers define runtime PM callbacks through the `PMOps` trait. The
generated `dev_pm_ops` callbacks take the stored payload, pass ownership
to the corresponding Rust callback, and store the returned payload for
the next invocation. Each callback must return a valid payload,
regardless of whether the power transition succeeds or not.

`PMContext` provides scoped helpers for common runtime PM operations:

- `ResumeScope` resumes the device for the lifetime of the scope.
- `AwakeScope`  resumes the device and holds a runtime PM usage reference.
- `RetainScope` increments the runtime PM usage count without resuming the
  		device.

Each scope performs the corresponding inverse operation when dropped,
according to the selected driver-defined profile.

The abstraction does not change the semantics of the C runtime PM API.
Asynchronous requests may only queue work, non-waiting requests may fail
instead of sleeping, and callbacks remain subject to the existing driver
core rules.

The current implementation requires the PM registration and `PMOps`
implementation to use the same type because callback dispatch interprets
the stored registration data using that relationship. This requirement is
not yet fully enforced by the type system.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/base/base.h             |    3 +
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |   44 ++
 rust/kernel/lib.rs              |    1 +
 rust/kernel/pm.rs               | 1020 +++++++++++++++++++++++++++++++
 6 files changed, 1070 insertions(+)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/pm.rs

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a19f4cda2c83..c49303e4a86a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -119,6 +119,9 @@ struct device_private {
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
index 1124785e210b..78a9153c6a01 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -77,6 +77,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 4488a87223b9..14d93a5d8b1f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -76,6 +76,7 @@
 #include "pci.c"
 #include "pid_namespace.c"
 #include "platform.c"
+#include "pm_runtime.c"
 #include "poll.c"
 #include "processor.c"
 #include "property.c"
diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
new file mode 100644
index 000000000000..d0d71fcb0097
--- /dev/null
+++ b/rust/helpers/pm_runtime.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pm_runtime.h>
+
+__rust_helper void rust_helper_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+}
+
+__rust_helper void rust_helper_pm_runtime_put_noidle(struct device *dev)
+{
+	pm_runtime_put_noidle(dev);
+}
+
+__rust_helper void rust_helper_pm_runtime_mark_last_busy(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev) ;
+}
+
+__rust_helper bool rust_helper_pm_runtime_active(struct device *dev)
+{
+	return pm_runtime_active(dev);
+}
+
+__rust_helper bool rust_helper_pm_runtime_suspended(struct device *dev)
+{
+	return pm_runtime_suspended(dev);
+}
+
+__rust_helper void rust_helper_pm_suspend_ignore_children(struct device *dev,
+							  bool enable)
+{
+	pm_suspend_ignore_children(dev, enable);
+}
+
+__rust_helper int rust_helper_pm_runtime_set_active(struct device *dev)
+{
+	return pm_runtime_set_active(dev);
+}
+
+__rust_helper int rust_helper_pm_runtime_set_suspended(struct device *dev)
+{
+	return pm_runtime_set_suspended(dev);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d..7e51e497e2f0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -105,6 +105,7 @@
 pub mod pci;
 pub mod pid_namespace;
 pub mod platform;
+pub mod pm;
 pub mod prelude;
 pub mod print;
 pub mod processor;
diff --git a/rust/kernel/pm.rs b/rust/kernel/pm.rs
new file mode 100644
index 000000000000..b6a884fbe1ba
--- /dev/null
+++ b/rust/kernel/pm.rs
@@ -0,0 +1,1020 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Runtime Power Management abstraction.
+//!
+//! C header: [`include/linux/pm_runtime.h`](srctree/include/linux/pm_runtime.h)
+
+use crate::{
+    bindings,
+    device::{
+        self,
+        AsBusDevice, //
+    },
+    error::{
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    macros::paste,
+    prelude::*,
+    sync::atomic::{
+        ordering,
+        Atomic, //
+    },
+    sync::Arc,
+    types::ForeignOwnable, //
+};
+
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData
+};
+
+/// Runtime Power Management modes that determine how a particular PM
+/// transition is to be carried out.
+/// Corresponds to C Runtime PM flag argument bits:
+/// - `RPM_ASYNC`
+/// - `RPM_NOWAIT`
+/// - `RPM_GET_PUT`
+/// - `RPM_AUTO`
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+struct Mode(u32);
+
+impl Mode {
+    /// Synchronous PM operations - default.
+    const SYNC: Mode = Mode(0);
+    /// Allow asynchronous PM operations.
+    const ASYNC: Mode = Mode(bindings::RPM_ASYNC);
+    /// Do not wait for any pending requests to finish.
+    const NOWAIT: Mode = Mode(bindings::RPM_NOWAIT);
+    /// Acquire a runtime-PM usage reference.
+    const ACQUIRE: Mode = Mode(bindings::RPM_GET_PUT);
+    /// Use autosuspend.
+    const AUTO: Mode = Mode(bindings::RPM_AUTO);
+    /// Additional mode for devices supporting idle states.
+    /// No counterpart.
+    const IDLE: Mode = Mode(1 << 16);
+
+    const fn join(self, other: Self) -> Self {
+        Self(self.0 | other.0)
+    }
+
+    fn includes(self, other: Self) -> bool {
+        (self.0 & other.0) != 0
+    }
+}
+
+impl core::ops::BitOr for Mode {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Mode {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Mode {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
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
+/// Utility macro for combining multiple request modes
+macro_rules! mode {
+    ($mode:expr $(, $args:expr)+ $(,)?) => {{
+        let mut new_mode = $mode;
+        $( new_mode = new_mode.join($args); )+
+        new_mode
+    }};
+}
+
+/// Device's runtime power management status
+#[repr(i32)]
+pub enum RuntimePMState {
+    /// Runtime PM has not been initialized for this device yet.
+    UNKNOWN = bindings::rpm_status_RPM_INVALID,
+    /// The device is expected to be runtime active and in it's normal operating state
+    RESUMED = bindings::rpm_status_RPM_ACTIVE,
+    /// The device is expected to be suspended, unavailable for normal operations
+    SUSPENDED = bindings::rpm_status_RPM_SUSPENDED,
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
+/// - If `Mode::IDLE`, calls `__pm_runtime_idle()`:
+///   triggers idle notification before attempting to suspend
+/// - If `Mode::AUTO`, marks last busy then calls `__pm_runtime_suspend()`.
+/// - Otherwise calls `__pm_runtime_suspend()`.
+///
+/// The guard must be dropped from a context matching the requested transition
+/// mode: sync vs async.
+#[must_use = "dropping this guard issues the matching runtime PM release request"]
+pub struct ResumeScope<'a>(Scope<'a, Resume>);
+
+/// Acquires a runtime-PM usage reference and keeps the device powered.
+///
+/// Requires `Mode::ACQUIRE`. Drop behavior matches `ResumeScope`.
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
+        if mode.includes(Mode::ACQUIRE) {
+            // Mode::ACQUIRE is intended to be used with Awake scope
+            // Avoid mixing the modes.
+            return Err(EINVAL);
+        }
+
+        // Mode::IDLE is internal so strip it of before passing further
+        Request::resume(dev, mode & !Mode::IDLE).map(|()| {
+            Self(Scope::<Resume> {
+                dev,
+                mode,
+                _tag: PhantomData,
+            })
+        })
+    }
+
+    fn release_inner(&self) -> Result {
+        let scope_mode = self.0.mode & !Mode::IDLE;
+
+        match self.0.mode {
+            mode if mode.includes(Mode::IDLE) => {
+                Request::idle(self.0.dev, scope_mode & (Mode::ASYNC | Mode::NOWAIT))
+            }
+            mode if mode.includes(Mode::AUTO) => {
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
+        if !mode.includes(Mode::ACQUIRE) {
+            return Err(EINVAL);
+        }
+        // Mode::IDLE is internal so strip it of before passing further
+        Request::resume(dev, mode & !Mode::IDLE)
+            .inspect_err(|_| Request::put_noidle(dev))
+            .map(|()| {
+                Self(Scope::<Awake> {
+                    dev,
+                    mode,
+                    _tag: PhantomData,
+                })
+            })
+    }
+
+    fn release_inner(&self) -> Result {
+        let scope_mode = self.0.mode & !Mode::IDLE;
+        match self.0.mode {
+            mode if mode.includes(Mode::IDLE) => Request::idle(self.0.dev, scope_mode),
+            mode if mode.includes(Mode::AUTO) => {
+                Request::mark_last_busy(self.0.dev);
+                Request::suspend(self.0.dev, scope_mode)
+            }
+            _ => Request::idle(self.0.dev, scope_mode),
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
+            mode: Mode(0),
+            _tag: PhantomData,
+        }))
+    }
+
+    fn try_new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        Request::get_if_active(dev)?;
+        Ok(Self(Scope::<Retain> {
+            dev,
+            mode: Mode(0),
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
+#[cfg(CONFIG_PM)]
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
+    fn idle(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        to_result(unsafe { bindings::__pm_runtime_idle(dev.as_raw(), mode.into()) })
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
+    fn suspend(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        to_result(unsafe { bindings::__pm_runtime_suspend(dev.as_raw(), mode.into()) })
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
+}
+
+#[cfg(not(CONFIG_PM))]
+impl Request {
+    #[inline]
+    fn active(dev: &device::Device<device::Bound>) -> bool {
+        true
+    }
+
+    #[inline]
+    fn suspended(dev: &device::Device<device::Bound>) -> bool {
+        false
+    }
+
+    #[inline]
+    fn resume(_dev: &device::Device<device::Bound>, _mode: Mode) -> Result {
+        Ok(())
+    }
+
+    #[inline]
+    fn idle(_dev: &device::Device<device::Bound>, _mode: Mode) -> Result {
+        Err(ENOSYS)
+    }
+
+    #[inline]
+    fn mark_last_busy(_dev: &device::Device<device::Bound>) {}
+
+    #[inline]
+    fn suspend(_dev: &device::Device<device::Bound>, _mode: Mode) -> Result {
+        Err(ENOSYS)
+    }
+
+    #[inline]
+    fn get_if_active(dev: &device::Device<device::Bound>) -> Result {
+        Err(EINVAL)
+    }
+
+    #[inline]
+    fn runtime_enable(_dev: &device::Device<device::Bound>) {}
+
+    #[inline]
+    fn runtime_disable(dev: &device::Device<device::Bound>) {}
+}
+
+impl Request {
+    #[inline]
+    fn get_noresume(dev: &device::Device<device::Bound>) {
+        // SAFETY: `dev.as_raw()` must provide a valid pointer to
+        // `struct device` for the duration of the call.
+        // The `Device<Bound>` reference provides that guarantee.
+        unsafe { bindings::pm_runtime_get_noresume(dev.as_raw()) };
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
+    #[allow(unused)]
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
+    #[allow(unused)]
+    #[inline]
+    fn mark_suspended(dev: &device::Device<device::Bound>) -> Result {
+        to_result(
+            // SAFETY: `dev.as_raw()` must provide a valid pointer to
+            // `struct device` for the duration of the call.
+            // The `Device<Bound>` reference provides that guarantee.
+            unsafe { bindings::pm_runtime_set_suspended(dev.as_raw()) },
+        )
+    }
+}
+
+/// Common runtime PM callback entry point
+///
+/// The generated extern "C" callbacks call into this helper with the raw
+/// `struct device *` provided by the PM core. It rebuilds the Rust device
+/// reference, retrieves the device's PM registration data and performs
+/// handoff to corresponding driver callback.
+fn runtime_pm_callback<T, F>(dev: *mut bindings::device, cb: F) -> Result
+where
+    T: PMOps,
+    F: FnOnce(
+        &<T as PMOps>::DeviceType,
+        Option<<T as PMOps>::RuntimePayloadType>,
+    ) -> Result<
+        Option<<T as PMOps>::RuntimePayloadType>,
+        (Option<<T as PMOps>::RuntimePayloadType>, Error),
+    >,
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
+/// Defines generated C runtime PM callback.
+///
+/// This macro generates the corresponding `unsafe extern "C"` function for
+/// requested PM operation and forwards it to [`runtime_pm_callback`].
+///
+/// # Safety
+///
+/// The generated function may only be installed in a `dev_pm_ops` table for a
+/// device whose PM registration data was created by `Registration<T>`. In other
+/// words, the type parameter `T` used for the callback table must match the
+/// type parameter `T` used for the stored `RegistrationData<T>`.
+///
+/// The PM registration must keep the stored registration data alive and pinned
+/// until runtime PM is disabled and all in-flight PM callbacks have completed.
+macro_rules! define_pm_callback {
+    (@parse_desc $name:ident) => { define_pm_callback!(@default $name); };
+    (@default $name:ident) => {
+        paste!(
+          /// Generated runtime PM callback.
+          ///
+          /// # Safety
+          ///
+          /// `dev` must be a valid `struct device *` supplied by the PM core for a device
+          /// whose runtime PM callbacks and PM registration data were both created
+          /// for `T`.
+            unsafe extern "C" fn [<$name _callback>]<'a, T:PMOps>(
+                dev: *mut bindings::device
+            ) -> core::ffi::c_int
+                where
+                    <T as PMOps>::DeviceType: 'a
+            {
+               runtime_pm_callback::<T, _>(dev,T::$name).map(|_| 0).unwrap_or_else(|e| e.to_errno())
+            }
+        );
+
+    };
+}
+
+/// SAFETY:
+/// bindings::dev_pm_ops is #[repr(C)], implements Default
+/// and the struct itself is all nullable function pointers.
+/// There is no padding and all zero bit-pattern is valid
+///
+const PMOPS_NONE: bindings::dev_pm_ops =
+    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().assume_init() };
+
+/// Runtime PM callbacks implemented by a driver.
+///
+/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm_ops`].
+///
+/// Each generated C callback recovers the Rust bus device from the raw
+/// `struct device *`, borrows the registered runtime PM payload, and delegates
+/// to the matching [`PMOps`] trait method.
+///
+/// # Safety
+///
+/// `PMContext::<T>::PM_OPS` must only be installed for devices whose concrete
+/// bus type is `T::DeviceType`, and whose runtime PM registration data was
+/// installed by [`Registration::new`] for the same `T`.
+///
+macro_rules! define_pm_ops {
+    ($($name:ident $( : $desc:tt )? ),+ $(,)?) => {
+        $( define_pm_callback!( @parse_desc $name $( $desc )?); )+
+        define_pm_ops!(@common $( $name ), +);
+    };
+
+    (@common $( $name:ident),+ ) => {
+        /// Runtime PM callbacks implemented by a driver
+        #[vtable]
+        pub trait PMOps: Sized
+        {
+            /// Type of a bus device
+            type DeviceType: AsBusDevice<device::Bound>;
+            /// Type of the data associated with a PM transitions:
+            type RuntimePayloadType: Send;
+
+            $(
+                #[allow(missing_docs)]
+                // Callback-specific docs are provided by the generated `dev_pm_ops`
+                // contract on `PMOps`.
+
+                fn $name<'a>(
+                    _dev:  &'a Self::DeviceType,
+                    _payload: Option<Self::RuntimePayloadType>,
+                ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
+                    build_error!(VTABLE_DEFAULT_ERROR)
+                }
+            )+
+        }
+        paste!(
+            impl<'a, T:PMOps> PMContext<'a, T> {
+                /// Driver-provided runtime PM operations.
+                ///
+                /// A driver implements this trait to handle runtime PM
+                /// transitions for its device type.
+                ///
+                /// Each callback receives the device and the current payload.
+                /// On success, it returns the payload to keep for the next
+                /// transition. On failure, it returns the payload together
+                /// with the error so the previous, or otherwise sane state
+                /// can be preserved.
+                pub const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
+                    $( [<$name>]: if T::[<HAS_ $name:upper>] {
+                        Some([<$name _callback>]::<T>)
+                    } else {
+                        None
+                    }, )+
+                    ..PMOPS_NONE
+                };
+            }
+        );
+    }
+}
+
+/// RAII guard for ongoing runtime PM payload transition.
+///
+/// For most of the callbacks this guard is not necessairly needed as
+/// the callbacks themselves are being serialized by the runtime PM C code.
+/// Still, some like runtime_idle are exempt ftom that.
+#[allow(unused)]
+struct PayloadGuard<'a> {
+    busy: &'a Atomic<bool>,
+}
+
+impl Drop for PayloadGuard<'_> {
+    fn drop(&mut self) {
+        self.busy.store(false, ordering::Release);
+    }
+}
+
+struct PMPayload<P> {
+    in_flight: Atomic<bool>,
+    inner: UnsafeCell<Option<P>>,
+}
+
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
+    /// of storage The closure must return the payload that should be stored
+    /// for the next transition.
+    ///
+    /// On success, the returned payload replaces the previous payload. On failure,
+    /// the closure returns the payload together with the error, and that payload is
+    /// restored before the error is propagated.
+    ///
+    /// Returns `EBUSY` if another runtime PM transition is already in progress.
+    fn transition(
+        &self,
+        f: impl FnOnce(Option<P>) -> Result<Option<P>, (Option<P>, Error)>,
+    ) -> Result {
+        let _guard = self.acquire()?;
+        // SAFETY: Holding `_guard` means this callback successfully changed
+        // `in_flight` from false to true. No other caller can hold a `PayloadGuard`
+        // until `_guard` is dropped, so this function has exclusive access to `inner`.
+        let slot = unsafe { &mut *self.inner.get() };
+
+        let payload = slot.take();
+
+        match f(payload) {
+            Ok(new_payload) => {
+                *slot = new_payload;
+                Ok(())
+            }
+            Err((old_payload, err)) => {
+                *slot = old_payload;
+                Err(err)
+            }
+        }
+    }
+}
+
+// SAFETY: Although PMPayload's `inner` is an `UnsafeCell`, it is only accessed
+// after `in_flight` has been acquired. The atomic flag serializes all mutable
+// access to the payload, and `PayloadGuard` clears the flag when the access ends.
+unsafe impl<P: Send> Sync for PMPayload<P> {}
+
+struct PMContextInner<'a, T: PMOps> {
+    dev: &'a device::Device<device::Bound>,
+    /// Optional driver-selected runtime PM request PMProfiles.
+    ///
+    /// Set of runtime PM predefined PMProfiles that can be used by the driver
+    /// when requesting a PM transition. This might be useful when a driver
+    /// has several different PM usage patterns.
+    /// See [PMProfile] for more details.
+    profiles: KVec<PMProfile>,
+    /// Set of PM config options applied for associated device.
+    configs: KVec<PMConfig>,
+    _marker: PhantomData<T>,
+}
+
+/// Runtime PM context tied to a device.
+pub struct PMContext<'a, T: PMOps> {
+    // Preferably, PMContext could be shared via borrowed reference over
+    // a pm Registraion's lifetime but that bares complications on its own
+    // when the context needs to be shared across different Registration types.
+    inner: Arc<PMContextInner<'a, T>>,
+}
+
+impl<'a, T: PMOps> PMContext<'a, T> {
+    /// Enable runtime PM
+    pub fn enable(&self, state: RuntimePMState) -> Result {
+        Self::apply_config(self.inner.dev, &self.inner.configs);
+        match state {
+            RuntimePMState::RESUMED => Request::mark_active(self.inner.dev),
+            RuntimePMState::SUSPENDED => Request::mark_suspended(self.inner.dev),
+            _ => Err(EINVAL),
+        }?;
+        Request::runtime_enable(self.inner.dev);
+        Ok(())
+    }
+    /// Disable runtime PM
+    pub fn disable(&self) -> Result {
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
+    /// the device has been resumed at the time this funtion returns.
+    #[inline]
+    pub fn get(&self, profile: PMProfile) -> Result<AwakeScope<'a>> {
+        AwakeScope::new(self.inner.dev, profile.0 | Mode::ACQUIRE)
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
+        if profile.0.includes(Mode::ASYNC) {
+            return Err(EINVAL);
+        }
+        let _scope = self.resume(profile)?;
+        f()
+    }
+    /// Runs a closure while holding an `AwakeScope`.
+    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
+        if profile.0.includes(Mode::ASYNC) {
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
+        #[cfg(not(CONFIG_PM))]
+        let _ = opts;
+        let _ = dev;
+        #[cfg(CONFIG_PM)]
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
+                    bindings::pm_runtime_set_autosuspend_delay(dev.as_raw(), *v as i32);
+                    bindings::__pm_runtime_use_autosuspend(dev.as_raw(), true);
+                },
+            }
+        }
+    }
+
+    /// Get a borrowed reference to PM profiles asociated wiht the PM context
+    pub fn profiles(&self) -> &[PMProfile] {
+        &self.inner.profiles
+    }
+
+    /// Get a borrowed reference to PM configs asociated wiht the PM context
+    pub fn configs(&self) -> &[PMConfig] {
+        &self.inner.configs
+    }
+}
+
+// Preferably, PMContext could be shared via borrowed reference over
+// a pm Registraion's lifetime but that bares complications on its own
+// when the context needs to be shared across different Registration types.
+impl<T: PMOps> Clone for PMContext<'_, T> {
+    fn clone(&self) -> Self {
+        Self {
+            inner: self.inner.clone(),
+        }
+    }
+}
+
+define_pm_ops!(
+    // PM state change
+    runtime_suspend,
+    runtime_resume,
+);
+
+/// Runtime PM request PMProfile.
+pub struct PMProfile(Mode);
+
+impl PMProfile {
+    /// Creates a PMProfile with default SYNC mode set.
+    pub const fn new() -> Self {
+        Self(Mode::SYNC)
+    }
+    /// /Enables async PM operations for this PMProfile.
+    pub const fn r#async(self) -> Self {
+        Self(mode!(self.0, Mode::ASYNC))
+    }
+    /// Use autosuspend
+    pub const fn auto(self) -> Self {
+        Self(mode!(self.0, Mode::AUTO))
+    }
+    /// Requests idle handling for this PMProfile.
+    pub const fn idle(self) -> Self {
+        Self(mode!(self.0, Mode::IDLE))
+    }
+    /// Do not wait for concurrent requests to finish.
+    pub const fn nowait(self) -> Self {
+        Self(mode!(self.0, Mode::NOWAIT))
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
+    AutoSuspendDelay(u32),
+}
+
+/// Runtime PM data stored within the `struct device_private' during
+/// runtime PM registration.
+///
+/// The data is associated with PM transitions and it's conceptually owned
+/// by the Registration itself.
+///
+#[repr(C)]
+#[pin_data]
+struct RegistrationData<'a, T: PMOps> {
+    #[pin]
+    data: PMPayload<T::RuntimePayloadType>,
+    _marker: PhantomData<&'a mut ()>,
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
+    /// [`PMContext`]. The optional `payload` is stored as a Registration data
+    /// and is used to service PM transitions.
+    ///
+    /// The device must use the callback table generated for the same `T`.
+    pub fn new(
+        dev: &'a device::Device<device::Core<'_>>,
+        profiles: Option<KVec<PMProfile>>,
+        configs: Option<KVec<PMConfig>>,
+        payload: Option<T::RuntimePayloadType>,
+    ) -> Result<Self> {
+        let payload = KBox::pin_init(
+            RegistrationData::<T> {
+                data: PMPayload {
+                    in_flight: Atomic::new(false),
+                    inner: UnsafeCell::new(payload),
+                },
+                _marker: PhantomData,
+            },
+            GFP_KERNEL,
+        )?;
+
+        let inner_ctx = Arc::new(
+            PMContextInner {
+                dev,
+                profiles: profiles.unwrap_or_default(),
+                configs: configs.unwrap_or_default(),
+                _marker: PhantomData,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY: `dev` is a live `Device<Core>`, so its raw `struct device` pointer is
+        // valid for the duration of this call. The payload allocation is converted into
+        // a foreign pointer and owned by this `Registration` until `Drop` clears
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
+        // SAFETY: `self.ctx.inner.dev` is the device this registration was
+        // created for. Runtime PM is disabled first, and `pm_runtime_barrier`
+        // waits for pending runtime PM work/callbacks before the callback data
+        // is removed below.
+
+        unsafe {
+            bindings::__pm_runtime_disable(self.ctx.inner.dev.as_raw(), true);
+            bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw());
+        }
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
+                Pin::<KBox<RegistrationData<'_, T>>>::from_foreign(ptr);
+            }
+        }
+    }
+}
-- 
2.43.0

