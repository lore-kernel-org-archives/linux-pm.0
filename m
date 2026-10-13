Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419944F7CAB;
	Tue, 13 Oct 2026 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911363; cv=pass; b=HbjQX2kqD0hJQTq5e1q5ujSri+OfIu0CRONbdK6JGvJWEvPOB3sHBpcoiT+fZk7s8RqfTE4xWsqIL27nR/MKEEEQFq29IK97SO7gVL4slZ05VExOpkFJEGF4rZUO9M7/kd5iEyrZqIUV0TWljdLVywLcHB5hguVjDQtVmbIy5Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911363; c=relaxed/simple;
	bh=fjUU3Hu2ehrIbM1xPw7QiK7M5t3g8bqVw9n+Nje+PPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hN2BeQttdMW+F4FVj8C1StWbIw6HoVwq2biWpyzPhzlYXkoBXgBOHEWq9eGP72b3VCO5XM+hy+qLIO88jao4GCLfDJT9knYs3971fBFLwRkxruKo1s9CJ03B61D1P2ITqPV+fwKT3Xn40JpxW9lPS1eVM+I35dNUu4wa6DagnBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Vm4Vejs/; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Vm4Vejs/"
ARC-Seal: i=1; a=rsa-sha256; t=1791911314; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dqv+ui5f2rluJgefNMoNeVNpFoPfEvv1rDI9Iv11ez6TE8RYgNtdf/D+fLDT6dctbXNLZcQHnGSJ9wKS+OqwKh07YCWlv2lQ/LA6iREHIi1yJfvmTAOxLEV6Vg/tKXCLWAQCCyviQf8N3TgrG84n0cKz3bzYWhMMBvCGvFxJrao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791911314; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q+HT5/w7wHfjPXZFwzTHhrPxHsRvkrL1lrafDhA66mE=; 
	b=B0SuuRdoWSRhClGgdGnfukapKGsBHPxSlgdd7tnRT4+085G7KUI8oM+VUKgFvyEHkOzXxNGy7/he5/xLCOQrylY9/lMLoKNMUpu1h3Cxj6hkgO2oa84upWvu0qT8Ip7HeEc/xMsqj2ULvMruHvVeRV7KCNrR4R1d5juaHh1Nzq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911313;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Q+HT5/w7wHfjPXZFwzTHhrPxHsRvkrL1lrafDhA66mE=;
	b=Vm4Vejs/wAeNQ/3PQXIjkrLTMC2i5U6TOrJ6okgbASmbivGJMxWJzVq7nwpTYeXK
	P65myPN9+U4Bs8uY9qBuYj7aCFhNfSgWE4aBB4xbJdyxzLhqVV5xauG0mGpg0jA9OhN
	dy/DsCHrUcypid9757PF6eHqyrQYWDkkNKqXNle4=
Received: by smtp.zohomail.com with SMTPS id 1791911310965790.4532634897736;
	Tue, 13 Oct 2026 10:08:30 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:42 -0300
Subject: [PATCH v6 3/7] rust: clk: use the type-state pattern
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
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

The current Clk abstraction can still be improved on the following issues:

a) It only keeps track of a count to clk_get(), which means that users have
to manually call disable() and unprepare(), or a variation of those, like
disable_unprepare().

b) It allows repeated calls to prepare() or enable(), but it keeps no track
of how often these were called, i.e., it's currently legal to write the
following:

clk.prepare();
clk.prepare();
clk.enable();
clk.enable();

And nothing gets undone on drop().

c) It does not let a user express the state of the clk through the
type system. For example, there is currently no way to encode that a Clk is
enabled via the type system alone.

Following the Regulator abstraction, switch this abstraction to use the
type-state pattern instead. It solves both a) and b) by establishing a
number of states and the valid ways to transition between them. It also
automatically undoes any call to clk_get(), clk_prepare() and clk_enable()
as applicable on drop(), so users do not have to do anything special
before Clk goes out of scope.

It solves c) by directly encoding the state of the Clk into the type, e.g.:
Clk<Enabled> is now known to be a Clk that is enabled.

The INVARIANTS section for Clk is expanded to highlight the relationship
between the states and the respective reference counts that are owned by
each of them.

The examples are expanded to highlight how a user can transition between
states, as well as highlight some of the shortcuts built into the API.

The current implementation is also more flexible, in the sense that it
allows for more states to be added in the future. This lets us implement
different strategies for handling clocks, including one that mimics the
current API, allowing for multiple calls to prepare() and enable().

The users (cpufreq, rcpufreq_dt, tyr and pwm-th1520) are updated by this
patch (and not a separate one) to reflect the new changes. This is needed,
because otherwise this patch would break the build.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/cpufreq/rcpufreq_dt.rs |   7 +-
 drivers/gpu/drm/tyr/driver.rs  |  35 ++--
 drivers/pwm/pwm_th1520.rs      |  20 +-
 rust/kernel/clk.rs             | 438 ++++++++++++++++++++++++++++++++++-------
 rust/kernel/cpufreq.rs         |   8 +-
 5 files changed, 393 insertions(+), 115 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index d7ead60bf8c2..9a79f382fe3c 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -3,7 +3,10 @@
 //! Rust based implementation of the cpufreq-dt driver.
 
 use kernel::{
-    clk::Clk,
+    clk::{
+        Clk,
+        Unprepared, //
+    },
     cpu,
     cpufreq, //
     cpumask::CpumaskVar,
@@ -47,7 +50,7 @@ struct CPUFreqDTDevice {
     freq_table: opp::FreqTable,
     _mask: CpumaskVar,
     _token: Option<opp::ConfigToken>,
-    _clk: Clk,
+    _clk: Clk<Unprepared>,
 }
 
 #[derive(Default)]
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c382a26904ee..b387c4b9bff3 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
-    clk::Clk,
+    clk::{
+        Clk,
+        Enabled, //
+    },
     device::{
         Bound,
         Core,
@@ -113,13 +116,9 @@ fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
-        let stacks_clk = Clk::get_optional(pdev.as_ref(), Some(c"stacks"))?;
-        let coregroup_clk = Clk::get_optional(pdev.as_ref(), Some(c"coregroup"))?;
-
-        core_clk.prepare_enable()?;
-        stacks_clk.prepare_enable()?;
-        coregroup_clk.prepare_enable()?;
+        let core_clk = Clk::<Enabled>::get(pdev.as_ref(), Some(c"core"))?;
+        let stacks_clk = Clk::<Enabled>::get_optional(pdev.as_ref(), Some(c"stacks"))?;
+        let coregroup_clk = Clk::<Enabled>::get_optional(pdev.as_ref(), Some(c"coregroup"))?;
 
         let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
@@ -160,9 +159,9 @@ fn probe<'bound>(
                 pdev,
                 fw: firmware,
                 clks <- new_mutex!(Clocks {
-                    core: core_clk,
-                    stacks: stacks_clk,
-                    coregroup: coregroup_clk,
+                    _core: core_clk,
+                    _stacks: stacks_clk,
+                    _coregroup: coregroup_clk,
                 }),
                 regulators <- new_mutex!(Regulators {
                     _mali: mali_regulator,
@@ -215,17 +214,9 @@ impl drm::Driver for TyrDrmDriver {
 }
 
 struct Clocks {
-    core: Clk,
-    stacks: Clk,
-    coregroup: Clk,
-}
-
-impl Drop for Clocks {
-    fn drop(&mut self) {
-        self.core.disable_unprepare();
-        self.stacks.disable_unprepare();
-        self.coregroup.disable_unprepare();
-    }
+    _core: Clk<Enabled>,
+    _stacks: Clk<Enabled>,
+    _coregroup: Clk<Enabled>,
 }
 
 struct Regulators {
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 728993998446..5180b912efad 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -21,7 +21,10 @@
 //!
 
 use kernel::{
-    clk::Clk,
+    clk::{
+        Clk,
+        Enabled, //
+    },
     device::{
         Bound,
         Core,
@@ -87,11 +90,11 @@ struct Th1520WfHw {
 }
 
 /// The driver's private data struct. It holds all necessary devres managed resources.
-#[pin_data(PinnedDrop)]
+#[pin_data]
 struct Th1520PwmDriverData {
     #[pin]
     iomem: DevresIoMem<TH1520_PWM_REG_SIZE>,
-    clk: Clk,
+    clk: Clk<Enabled>,
 }
 
 impl pwm::PwmOps for Th1520PwmDriverData {
@@ -294,13 +297,6 @@ fn write_waveform(
     }
 }
 
-#[pinned_drop]
-impl PinnedDrop for Th1520PwmDriverData {
-    fn drop(self: Pin<&mut Self>) {
-        self.clk.disable_unprepare();
-    }
-}
-
 struct Th1520PwmPlatformDriver;
 
 kernel::of_device_table!(
@@ -321,9 +317,7 @@ fn probe<'bound>(
         let dev = pdev.as_ref();
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-        let clk = Clk::get(dev, None)?;
-
-        clk.prepare_enable()?;
+        let clk = Clk::<Enabled>::get(dev, None)?;
 
         // TODO: Get exclusive ownership of the clock to prevent rate changes.
         // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1de2484df8cf..c0812331c490 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -95,7 +95,10 @@ fn from(freq: Hertz) -> Self {
 mod common_clk {
     use super::Hertz;
     use crate::{
-        device::Device,
+        device::{
+            Bound,
+            Device, //
+        },
         error::{
             from_err_ptr,
             to_result, //
@@ -103,12 +106,116 @@ mod common_clk {
         prelude::*, //
     };
 
-    use core::ptr;
+    use core::{
+        marker::PhantomData,
+        mem::ManuallyDrop,
+        ptr, //
+    };
+
+    mod private {
+        pub trait Sealed {}
+
+        impl Sealed for super::Unprepared {}
+        impl Sealed for super::Prepared {}
+        impl Sealed for super::Enabled {}
+    }
+
+    /// A trait representing the different states that a [`Clk`] can be in.
+    pub trait ClkState: private::Sealed {
+        /// Whether the clock is enabled in this state.
+        const ENABLED: bool;
+
+        /// Whether the clock is prepared in this state.
+        const PREPARED: bool;
+    }
+
+    /// A state where the [`Clk`] is not prepared and not enabled.
+    pub struct Unprepared;
+
+    /// A state where the [`Clk`] is prepared but not enabled.
+    pub struct Prepared;
+
+    /// A state where the [`Clk`] is both prepared and enabled.
+    pub struct Enabled;
+
+    impl ClkState for Unprepared {
+        const ENABLED: bool = false;
+        const PREPARED: bool = false;
+    }
+
+    impl ClkState for Prepared {
+        const ENABLED: bool = false;
+        const PREPARED: bool = true;
+    }
+
+    impl ClkState for Enabled {
+        const ENABLED: bool = true;
+        const PREPARED: bool = true;
+    }
+
+    /// An error that can occur when trying to convert a [`Clk`] between states.
+    pub struct Error<State: ClkState> {
+        /// The error that occurred.
+        pub error: kernel::error::Error,
+
+        /// The [`Clk`] that caused the error, so that the operation may be
+        /// retried.
+        pub clk: Clk<State>,
+    }
+
+    impl<State: ClkState> core::fmt::Debug for Error<State> {
+        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+            self.error.fmt(f)
+        }
+    }
+
+    impl<State: ClkState> From<Error<State>> for kernel::error::Error {
+        /// Discards the [`Clk`] and keeps only the error code.
+        ///
+        /// This makes the fallible state transitions usable with the `?`
+        /// operator when the caller does not need to retry the operation on the
+        /// original [`Clk`], e.g.:
+        ///
+        /// ```
+        /// use kernel::clk::{
+        ///     Clk,
+        ///     Enabled,
+        ///     Unprepared,
+        /// };
+        /// use kernel::device::{
+        ///     Bound,
+        ///     Device,
+        /// };
+        ///
+        /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> {
+        ///     let clk = Clk::<Unprepared>::get(dev, Some(c"apb_clk"))?
+        ///         .prepare()?
+        ///         .enable()?;
+        ///     Ok(clk)
+        /// }
+        /// ```
+        #[inline]
+        fn from(err: Error<State>) -> Self {
+            err.error
+        }
+    }
 
     /// A reference-counted clock.
     ///
     /// Rust abstraction for the C [`struct clk`].
     ///
+    /// A [`Clk`] instance represents a clock that can be in one of several
+    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
+    ///
+    /// No action needs to be taken when a [`Clk`] is dropped. The calls to
+    /// `clk_disable()` and `clk_unprepare()` will be made as applicable.
+    /// Since `clk_unprepare()` may sleep, a [`Clk<Prepared>`] or a
+    /// [`Clk<Enabled>`] must not be dropped in atomic context.
+    ///
+    /// An optional [`Clk`] is treated like a regular [`Clk`], but its
+    /// inner `struct clk` pointer is `NULL`. This interfaces correctly with the
+    /// C API and also exposes all the methods of a regular [`Clk`] to users.
+    ///
     /// # Invariants
     ///
     /// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C
@@ -117,6 +224,12 @@ mod common_clk {
     /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
     /// allocation remains valid for the lifetime of the [`Clk`].
     ///
+    /// The [`Prepared`] state is associated with a single count of
+    /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
+    /// count of both `clk_prepare()` and `clk_enable()`.
+    ///
+    /// All states are associated with a single count of `clk_get()`.
+    ///
     /// # Examples
     ///
     /// The following example demonstrates how to obtain and configure a clock for a device.
@@ -124,14 +237,30 @@ mod common_clk {
     /// ```
     /// use kernel::clk::{
     ///     Clk,
+    ///     Enabled,
     ///     Hertz,
+    ///     Prepared,
+    ///     Unprepared,
+    /// };
+    /// use kernel::device::{
+    ///     Bound,
+    ///     Device,
     /// };
-    /// use kernel::device::Device;
     ///
-    /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = Clk::get(dev, Some(c"apb_clk"))?;
+    /// fn configure_clk(dev: &Device<Bound>) -> Result {
+    ///     // Each state has its own `Clk::get`, e.g.:
+    ///     let clk: Clk<Enabled> = Clk::<Enabled>::get(dev, Some(c"apb_clk"))?;
+    ///
+    ///     // Any other state is also possible, e.g.:
+    ///     let clk: Clk<Prepared> = Clk::<Prepared>::get(dev, Some(c"bus_clk"))?;
     ///
-    ///     clk.prepare_enable()?;
+    ///     // Later:
+    ///     //
+    ///     // `?` works directly thanks to `From<Error<State>>`. The failed
+    ///     // `Clk` is dropped on error. Match on the returned `Error<State>`
+    ///     // instead (its `clk` field is the original `Clk`) if you want to
+    ///     // retry the operation.
+    ///     let clk: Clk<Enabled> = clk.enable()?;
     ///
     ///     let expected_rate = Hertz::from_ghz(1);
     ///
@@ -139,37 +268,102 @@ mod common_clk {
     ///         clk.set_rate(expected_rate)?;
     ///     }
     ///
-    ///     clk.disable_unprepare();
+    ///     // Nothing is needed here. The drop implementation will undo any
+    ///     // operations as appropriate.
+    ///     Ok(())
+    /// }
+    ///
+    /// fn shutdown(clk: Clk<Enabled>) -> Result {
+    ///     // The states can also be traversed in reverse:
+    ///     let clk: Clk<Prepared> = clk.disable();
+    ///
+    ///     // This is of type `Clk<Unprepared>`.
+    ///     let clk = clk.unprepare();
+    ///
     ///     Ok(())
     /// }
     /// ```
     ///
+    /// Drivers that need to change a clock's state at runtime (for example to
+    /// enable it on resume and disable it on suspend) can keep it in an enum
+    /// and move between the variants:
+    ///
+    /// ```
+    /// use kernel::clk::{Clk, Enabled, Prepared};
+    /// use kernel::error::Result;
+    ///
+    /// enum DeviceClk {
+    ///     Suspended(Clk<Prepared>),
+    ///     Resumed(Clk<Enabled>),
+    /// }
+    ///
+    /// impl DeviceClk {
+    ///     fn resume(self) -> Result<Self> {
+    ///         Ok(match self {
+    ///             DeviceClk::Suspended(clk) => DeviceClk::Resumed(clk.enable()?),
+    ///             resumed => resumed,
+    ///         })
+    ///     }
+    ///
+    ///     fn suspend(self) -> Result<Self> {
+    ///         Ok(match self {
+    ///             DeviceClk::Resumed(clk) => DeviceClk::Suspended(clk.disable()),
+    ///             suspended => suspended,
+    ///         })
+    ///     }
+    /// }
+    /// ```
+    ///
     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
     #[repr(transparent)]
-    pub struct Clk(*mut bindings::clk);
+    pub struct Clk<T: ClkState> {
+        inner: *mut bindings::clk,
+        _phantom: core::marker::PhantomData<T>,
+    }
 
     // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
-    unsafe impl Send for Clk {}
+    unsafe impl<T: ClkState> Send for Clk<T> {}
 
     // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
     // methods are synchronized internally.
-    unsafe impl Sync for Clk {}
+    unsafe impl<T: ClkState> Sync for Clk<T> {}
 
-    impl Clk {
-        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
+    impl Clk<Unprepared> {
+        /// Gets [`Clk`] corresponding to a bound [`Device`] and a connection
+        /// id.
         ///
         /// Equivalent to the kernel's [`clk_get`] API.
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        #[inline]
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
+            Self::get_unbound(dev, name)
+        }
+
+        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id,
+        /// without requiring the device to be bound.
+        ///
+        /// This is sound because [`clk_get`] and [`clk_put`] do not depend on the
+        /// device being bound to a driver. It is `pub(crate)` because a driver
+        /// should obtain its clocks through a bound device (see [`Clk::get`]). It
+        /// is meant for the few in-tree abstractions that operate on a device
+        /// outside a bind scope, such as the generic DT cpufreq driver.
+        ///
+        /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
+        /// [`clk_put`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_put
+        #[inline]
+        pub(crate) fn get_unbound(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
             let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
-            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
-            //
+            // SAFETY: It is safe to call `clk_get()` for a valid device pointer
+            // and any `con_id`, including NULL.
+            let inner = from_err_ptr(unsafe { bindings::clk_get(dev.as_raw(), con_id) })?;
+
             // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
-            Ok(Self(from_err_ptr(unsafe {
-                bindings::clk_get(dev.as_raw(), con_id)
-            })?))
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
         /// Behaves the same as [`Self::get`], except when there is no clock
@@ -180,100 +374,179 @@ pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
         ///
         /// [`clk_get_optional`]:
         /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
-        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        #[inline]
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
             let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
-            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
-            //
+            // SAFETY: It is safe to call `clk_get_optional()` for a valid device
+            // pointer and any `con_id`, including NULL.
+            let inner = from_err_ptr(unsafe { bindings::clk_get_optional(dev.as_raw(), con_id) })?;
+
             // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
-            Ok(Self(from_err_ptr(unsafe {
-                bindings::clk_get_optional(dev.as_raw(), con_id)
-            })?))
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
-        /// Obtain the raw [`struct clk`] pointer.
+        /// Attempts to convert the [`Clk`] to a [`Prepared`] state.
+        ///
+        /// Equivalent to the kernel's [`clk_prepare`] API.
+        ///
+        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
         #[inline]
-        pub fn as_raw(&self) -> *mut bindings::clk {
-            self.0
+        pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>> {
+            // The `clk_get()` count moves to the returned `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for `clk_prepare()`.
+            to_result(unsafe { bindings::clk_prepare(clk.as_raw()) })
+                // INVARIANT: `clk_prepare()` succeeded, so the returned
+                // `Clk<Prepared>` owns a single count of it, which is released
+                // when it leaves the [`Prepared`] state.
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
         }
+    }
 
-        /// Enable the clock.
+    impl Clk<Prepared> {
+        /// Obtains a [`Clk`] from a bound [`Device`] and a connection id and
+        /// prepares it.
         ///
-        /// Equivalent to the kernel's [`clk_enable`] API.
-        ///
-        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`].
         #[inline]
-        pub fn enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_enable`].
-            to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Prepared>> {
+            Ok(Clk::<Unprepared>::get(dev, name)?.prepare()?)
         }
 
-        /// Disable the clock.
-        ///
-        /// Equivalent to the kernel's [`clk_disable`] API.
-        ///
-        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
         #[inline]
-        pub fn disable(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable`].
-            unsafe { bindings::clk_disable(self.as_raw()) };
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Prepared>> {
+            Ok(Clk::<Unprepared>::get_optional(dev, name)?.prepare()?)
         }
 
-        /// Prepare the clock.
+        /// Converts the [`Clk`] to an [`Unprepared`] state.
         ///
-        /// Equivalent to the kernel's [`clk_prepare`] API.
+        /// Equivalent to the kernel's [`clk_unprepare`] API.
         ///
-        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
         #[inline]
-        pub fn prepare(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare`].
-            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+        pub fn unprepare(self) -> Clk<Unprepared> {
+            // The `clk_get()` count moves to the returned `Clk<Unprepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for `clk_unprepare()`.
+            unsafe { bindings::clk_unprepare(clk.as_raw()) }
+
+            // INVARIANT: The `clk_prepare()` count was released above, so the
+            // returned `Clk<Unprepared>` owns only the `clk_get()` count.
+            Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            }
         }
 
-        /// Unprepare the clock.
+        /// Attempts to convert the [`Clk`] to an [`Enabled`] state.
         ///
-        /// Equivalent to the kernel's [`clk_unprepare`] API.
+        /// Equivalent to the kernel's [`clk_enable`] API.
         ///
-        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
         #[inline]
-        pub fn unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_unprepare`].
-            unsafe { bindings::clk_unprepare(self.as_raw()) };
+        pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
+            // The `clk_get()` and `clk_prepare()` counts move to the returned
+            // `Clk<Enabled>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for `clk_enable()`.
+            to_result(unsafe { bindings::clk_enable(clk.as_raw()) })
+                // INVARIANT: `clk_enable()` succeeded, so the returned
+                // `Clk<Enabled>` owns a single count of it, which is released
+                // when it leaves the [`Enabled`] state.
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
         }
+    }
 
-        /// Prepare and enable the clock.
+    impl Clk<Enabled> {
+        /// Gets [`Clk`] corresponding to a bound [`Device`] and a connection id
+        /// and then prepares and enables it.
         ///
-        /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`],
+        /// followed by [`Clk::enable`].
+        #[inline]
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Enabled>> {
+            Ok(Clk::<Prepared>::get(dev, name)?.enable()?)
+        }
+
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
         #[inline]
-        pub fn prepare_enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare_enable`].
-            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Enabled>> {
+            Ok(Clk::<Prepared>::get_optional(dev, name)?.enable()?)
         }
 
-        /// Disable and unprepare the clock.
+        /// Disables the [`Clk`] and converts it to the [`Prepared`] state.
         ///
-        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
+        /// Equivalent to the kernel's [`clk_disable`] API.
+        ///
+        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
         #[inline]
-        pub fn disable_unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable_unprepare`].
-            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+        pub fn disable(self) -> Clk<Prepared> {
+            // The `clk_get()` and `clk_prepare()` counts move to the returned
+            // `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for `clk_disable()`.
+            unsafe { bindings::clk_disable(clk.as_raw()) };
+
+            // INVARIANT: The `clk_enable()` count was released above, so the
+            // returned `Clk<Prepared>` owns the `clk_get()` and `clk_prepare()`
+            // counts.
+            Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            }
+        }
+    }
+
+    impl<T: ClkState> Clk<T> {
+        /// Obtain the raw [`struct clk`] pointer.
+        #[inline]
+        pub fn as_raw(&self) -> *mut bindings::clk {
+            self.inner
         }
 
         /// Get clock's rate.
         ///
         /// Equivalent to the kernel's [`clk_get_rate`] API.
         ///
+        /// The returned rate is only guaranteed to reflect what the hardware is
+        /// doing once the clock is [`Enabled`].
+        ///
         /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_rate
         #[inline]
         pub fn rate(&self) -> Hertz {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_get_rate`].
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for `clk_get_rate()`.
             Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
         }
 
@@ -284,15 +557,28 @@ pub fn rate(&self) -> Hertz {
         /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_set_rate
         #[inline]
         pub fn set_rate(&self, rate: Hertz) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_set_rate`].
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for `clk_set_rate()`.
             to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
         }
     }
 
-    impl Drop for Clk {
+    impl<T: ClkState> Drop for Clk<T> {
         fn drop(&mut self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
+            if T::ENABLED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for `clk_disable()`.
+                unsafe { bindings::clk_disable(self.as_raw()) };
+            }
+
+            if T::PREPARED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for `clk_unprepare()`.
+                unsafe { bindings::clk_unprepare(self.as_raw()) };
+            }
+
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid
+            // argument for `clk_put()`.
             unsafe { bindings::clk_put(self.as_raw()) };
         }
     }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index affa2b9490ef..4c4ec14b0568 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -558,8 +558,12 @@ pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
     /// The caller must guarantee that the returned [`Clk`] is not dropped while it is getting used
     /// by the C code.
     #[cfg(CONFIG_COMMON_CLK)]
-    pub unsafe fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<Clk> {
-        let clk = Clk::get(dev, name)?;
+    pub unsafe fn set_clk(
+        &mut self,
+        dev: &Device,
+        name: Option<&CStr>,
+    ) -> Result<Clk<crate::clk::Unprepared>> {
+        let clk = Clk::<crate::clk::Unprepared>::get_unbound(dev, name)?;
         self.as_mut_ref().clk = clk.as_raw();
         Ok(clk)
     }

-- 
2.56.0

