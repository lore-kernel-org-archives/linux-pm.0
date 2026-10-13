Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243B4F7CAB;
	Tue, 13 Oct 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911377; cv=pass; b=ipK2Qjpy8mWn/8h8aIlJ7c0vHyDGusqGKIq7Wy1YiLMbZD+kf8+eol84TiFusnF3+R3yT5msfFXR0QnkarjOFdcYDknPsAIyqve1YXAAcYwv8rVNtumK72Z6azPRPXGBiWCcYH8v+q/lJQh48XN6EPeirkIYYXOacBsz2G5lM0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911377; c=relaxed/simple;
	bh=xe9jc5MKPrrilsemWynuMnPPtOFcx7rR2l/U2U1sXsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFTLSvcZUvLaBSqL8yw9WY9w1hqJv3BGxGRJTixO/dLX8u+rnY+r5rtineNeuJ7K2yihkEQDc2O0VZ0vPZf79YdZdccQGZxoqljI1SmfE24m3/6lR7LmZtg8y3KAjVx37Dw43iRvjow2T/ckKcYcow/SRky/9O+TJXun4fMBSuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=SaAL5Pt+; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="SaAL5Pt+"
ARC-Seal: i=1; a=rsa-sha256; t=1791911319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZZq7le/HXg6exPpxMwFNkM7/XAADQTDGBCwPEc9RYp2Bw9gRv6NPq4eNS75zGIrT7CX+5/rl+/HcUw42D5Dnnj0IS/Gc5VjFG5E33DdftnyaqreQudb74LJDKQajUjsfG+pACkLIBkNWyAZd1OJx4orqfcOLqGFxDPPczT2jCaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791911319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C0J/Blktj+zmLGhoGfI37+j4DcotykTEqpNQSdrFKMI=; 
	b=klVehSr5eHzB/zLISPz6POMDGwCSfKfPtFVL+JB1PbJ8JXbkYh/uvB7DMDR7EkhTSb0leDnh0MaNi3BSwpWM6CAq9nuv9OU5bWMm9M7XsZU/4grXyYIYf+h8Rrc73w7uW9plvHvA7ngf5H91XmDN9btdWaPVWT8sMQpVuLqgSaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911319;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=C0J/Blktj+zmLGhoGfI37+j4DcotykTEqpNQSdrFKMI=;
	b=SaAL5Pt+LCePVeo8uS8kwO/Lcn6vY7N/I5xSHheG24vYKEXOeTef5TFcunOUFvcW
	6R2Foxna5uG3PfW0p2HYUwWEYXwsmciGMLetL7VYWB5AhaImmTgfIPtB5Jx79cSUaNz
	nLlX0ShbxOhfuMpQlW9DDl1sGszZxXjTrGPXsTJ0=
Received: by smtp.zohomail.com with SMTPS id 1791911318427942.2855356613999;
	Tue, 13 Oct 2026 10:08:38 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:43 -0300
Subject: [PATCH v6 4/7] rust: clk: add guards for scoped prepare and enable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-4-a5e9977b3509@collabora.com>
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

The state transitions consume the Clk, so a driver that keeps a
Clk<Prepared> in its data cannot enable it for a short section without
moving it out and back in. A clock handle also holds at most one count
of clk_prepare() and one of clk_enable().

Add EnabledGuard, PreparedGuard and PrepareEnabledGuard, returned by
Clk::enable_guard(), Clk::prepare_guard() and
Clk::prepare_enable_guard(). Each guard borrows the Clk, takes its count
when it is created and releases it when it is dropped. It dereferences
to the clock in the higher state, so a function that takes a
&Clk<Enabled> also accepts an EnabledGuard. Several guards may borrow the
same Clk, and the borrow keeps the Clk from being dropped or moved to
another state while a guard is alive.

There are no users yet.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 218 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index c0812331c490..93b4dc17f0ad 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -109,6 +109,7 @@ mod common_clk {
     use core::{
         marker::PhantomData,
         mem::ManuallyDrop,
+        ops::Deref,
         ptr, //
     };
 
@@ -228,6 +229,11 @@ fn from(err: Error<State>) -> Self {
     /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
     /// count of both `clk_prepare()` and `clk_enable()`.
     ///
+    /// A shared reference to a [`Clk<Prepared>`] or a [`Clk<Enabled>`] may also
+    /// be obtained from a [`PreparedGuard`], an [`EnabledGuard`] or a
+    /// [`PrepareEnabledGuard`]. In that case, the guard owns the counts of that
+    /// state for as long as the reference is alive.
+    ///
     /// All states are associated with a single count of `clk_get()`.
     ///
     /// # Examples
@@ -314,6 +320,43 @@ fn from(err: Error<State>) -> Self {
     /// }
     /// ```
     ///
+    /// Drivers that keep a clock around in a lower state can take a guard
+    /// instead of moving the clock through the states, e.g. to have it running
+    /// for a short section:
+    ///
+    /// ```
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Hertz,
+    ///     Prepared,
+    ///     Unprepared,
+    /// };
+    ///
+    /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {
+    ///     let enabled = clk.enable_guard()?;
+    ///
+    ///     // The clock is enabled until `enabled` goes out of scope.
+    ///     Ok(enabled.rate())
+    /// }
+    ///
+    /// fn touch_registers(clk: &Clk<Unprepared>) -> Result {
+    ///     {
+    ///         let prepared = clk.prepare_guard()?;
+    ///         let _enabled = prepared.enable_guard()?;
+    ///
+    ///         // `_enabled` borrows `prepared`, so the clock is disabled before
+    ///         // it is unprepared.
+    ///     }
+    ///
+    ///     // Or, alternatively:
+    ///     {
+    ///         let _enabled = clk.prepare_enable_guard()?;
+    ///     }
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    ///
     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
     #[repr(transparent)]
     pub struct Clk<T: ClkState> {
@@ -414,6 +457,43 @@ pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>> {
                     clk: ManuallyDrop::into_inner(clk),
                 })
         }
+
+        /// Prepares the clock for the lifetime of the returned guard.
+        ///
+        /// Unlike [`Clk::prepare`], this does not consume `self`. The guard
+        /// dereferences to a [`Clk<Prepared>`].
+        ///
+        /// Equivalent to the kernel's [`clk_prepare`] API.
+        ///
+        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+        #[inline]
+        pub fn prepare_guard(&self) -> Result<PreparedGuard<'_>> {
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for `clk_prepare()`.
+            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })?;
+
+            // INVARIANT: `clk_prepare()` succeeded, so the guard owns a single
+            // count of it.
+            Ok(PreparedGuard { clk: self })
+        }
+
+        /// Prepares and enables the clock for the lifetime of the returned guard.
+        ///
+        /// Unlike [`Clk::prepare`] followed by [`Clk::enable`], this does not
+        /// consume `self`. The guard dereferences to a [`Clk<Enabled>`].
+        ///
+        /// Equivalent to calling [`Clk::prepare_guard`] followed by
+        /// [`Clk::enable_guard`], with a single guard holding both counts.
+        #[inline]
+        pub fn prepare_enable_guard(&self) -> Result<PrepareEnabledGuard<'_>> {
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for `clk_prepare_enable()`.
+            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })?;
+
+            // INVARIANT: `clk_prepare_enable()` succeeded, so the guard owns a
+            // single count of both `clk_prepare()` and `clk_enable()`.
+            Ok(PrepareEnabledGuard { clk: self })
+        }
     }
 
     impl Clk<Prepared> {
@@ -482,6 +562,27 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
                     clk: ManuallyDrop::into_inner(clk),
                 })
         }
+
+        /// Enables the clock for the lifetime of the returned guard.
+        ///
+        /// Unlike [`Clk::enable`], this does not consume `self`, so it can be used
+        /// on a [`Clk<Prepared>`] that is shared or stored in driver data. The
+        /// clock stays [`Prepared`] through `self`, and the guard dereferences to
+        /// a [`Clk<Enabled>`].
+        ///
+        /// Equivalent to the kernel's [`clk_enable`] API.
+        ///
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        #[inline]
+        pub fn enable_guard(&self) -> Result<EnabledGuard<'_>> {
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for `clk_enable()`.
+            to_result(unsafe { bindings::clk_enable(self.as_raw()) })?;
+
+            // INVARIANT: `clk_enable()` succeeded, so the guard owns a single
+            // count of it.
+            Ok(EnabledGuard { clk: self })
+        }
     }
 
     impl Clk<Enabled> {
@@ -582,6 +683,123 @@ fn drop(&mut self) {
             unsafe { bindings::clk_put(self.as_raw()) };
         }
     }
+
+    /// A guard that keeps a [`Clk`] enabled.
+    ///
+    /// Returned by [`Clk::enable_guard`]. Dropping it disables the clock again,
+    /// while the borrowed [`Clk<Prepared>`] keeps it prepared. It dereferences to
+    /// [`Clk<Enabled>`], so it can be passed wherever an enabled clock is
+    /// expected.
+    ///
+    /// # Invariants
+    ///
+    /// The guard owns a single count of `clk_enable()` on `clk`, taken by
+    /// [`Clk::enable_guard`].
+    #[must_use = "if unused, the clock will be disabled immediately"]
+    pub struct EnabledGuard<'a> {
+        clk: &'a Clk<Prepared>,
+    }
+
+    impl Deref for EnabledGuard<'_> {
+        type Target = Clk<Enabled>;
+
+        #[inline]
+        fn deref(&self) -> &Clk<Enabled> {
+            // SAFETY: `Clk<T>` is `#[repr(transparent)]` over the `struct clk`
+            // pointer for every `T`, so `Clk<Prepared>` and `Clk<Enabled>` have
+            // the same layout. By the type invariants, the guard owns an enable
+            // count for as long as the returned reference is alive, and a shared
+            // reference cannot be used to drop the `Clk`.
+            unsafe { &*ptr::from_ref(self.clk).cast::<Clk<Enabled>>() }
+        }
+    }
+
+    impl Drop for EnabledGuard<'_> {
+        #[inline]
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, the guard owns a `clk_enable()`
+            // count on `self.clk`, which this releases.
+            unsafe { bindings::clk_disable(self.clk.as_raw()) };
+        }
+    }
+
+    /// A guard that keeps a [`Clk`] prepared.
+    ///
+    /// Returned by [`Clk::prepare_guard`]. Dropping it unprepares the clock
+    /// again, which may sleep. It dereferences to [`Clk<Prepared>`], so it can be
+    /// passed wherever a prepared clock is expected.
+    ///
+    /// # Invariants
+    ///
+    /// The guard owns a single count of `clk_prepare()` on `clk`, taken by
+    /// [`Clk::prepare_guard`].
+    #[must_use = "if unused, the clock will be unprepared immediately"]
+    pub struct PreparedGuard<'a> {
+        clk: &'a Clk<Unprepared>,
+    }
+
+    impl Deref for PreparedGuard<'_> {
+        type Target = Clk<Prepared>;
+
+        #[inline]
+        fn deref(&self) -> &Clk<Prepared> {
+            // SAFETY: `Clk<T>` is `#[repr(transparent)]` over the `struct clk`
+            // pointer for every `T`, so `Clk<Unprepared>` and `Clk<Prepared>`
+            // have the same layout. By the type invariants, the guard owns a
+            // prepare count for as long as the returned reference is alive, and
+            // a shared reference cannot be used to drop the `Clk`.
+            unsafe { &*ptr::from_ref(self.clk).cast::<Clk<Prepared>>() }
+        }
+    }
+
+    impl Drop for PreparedGuard<'_> {
+        #[inline]
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, the guard owns a `clk_prepare()`
+            // count on `self.clk`, which this releases.
+            unsafe { bindings::clk_unprepare(self.clk.as_raw()) };
+        }
+    }
+
+    /// A guard that keeps a [`Clk`] prepared and enabled.
+    ///
+    /// Returned by [`Clk::prepare_enable_guard`]. Dropping it disables and
+    /// unprepares the clock again, which may sleep. It dereferences to
+    /// [`Clk<Enabled>`], so it can be passed wherever an enabled clock is
+    /// expected.
+    ///
+    /// # Invariants
+    ///
+    /// The guard owns a single count of both `clk_prepare()` and `clk_enable()`
+    /// on `clk`, taken by [`Clk::prepare_enable_guard`].
+    #[must_use = "if unused, the clock will be disabled and unprepared immediately"]
+    pub struct PrepareEnabledGuard<'a> {
+        clk: &'a Clk<Unprepared>,
+    }
+
+    impl Deref for PrepareEnabledGuard<'_> {
+        type Target = Clk<Enabled>;
+
+        #[inline]
+        fn deref(&self) -> &Clk<Enabled> {
+            // SAFETY: `Clk<T>` is `#[repr(transparent)]` over the `struct clk`
+            // pointer for every `T`, so `Clk<Unprepared>` and `Clk<Enabled>`
+            // have the same layout. By the type invariants, the guard owns a
+            // prepare and an enable count for as long as the returned reference
+            // is alive, and a shared reference cannot be used to drop the `Clk`.
+            unsafe { &*ptr::from_ref(self.clk).cast::<Clk<Enabled>>() }
+        }
+    }
+
+    impl Drop for PrepareEnabledGuard<'_> {
+        #[inline]
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, the guard owns a count of both
+            // `clk_prepare()` and `clk_enable()` on `self.clk`, which this
+            // releases.
+            unsafe { bindings::clk_disable_unprepare(self.clk.as_raw()) };
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.56.0

