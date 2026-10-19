Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E574E5339;
	Mon, 19 Oct 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410230; cv=none; b=bHUklj0F5fNbklOeswNDTmU6FbGs3xWiSFPvE+rlMeah2Tm9lhjygdmz1Pw1FOjeL0H7LNzyWkRSahPypfGUtYbq079K0gN29lOI8dZ40ErcTYQGll2NMHkKh9NAT0MfH0WFjnd4/+GfLgPaFvhuJpyf7jxnS2hvHR14QKp6vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410230; c=relaxed/simple;
	bh=RWhOAGuU3+oSj/PsRy4OYUyXTZo/8gIhsK590I99tuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVil/1jB21RFzzcIz0Y16/Ws5kdHh+utVGfSL461UL2DCkKnqk+dZnWRM/iJllL+EOpGj2xJaJrPj4DgHYx+RwLckw/NMi0au6iq/MrAM7w9An7Ef0uniZcLQar5vJ8MRf1UmVaRsuP24BripSwXAN/+9BTq2epBlD4Djp6HqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rWAfShGj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rWAfShGj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46551477;
	Mon, 19 Oct 2026 04:43:41 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD05D3F7D8;
	Mon, 19 Oct 2026 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792410225; bh=RWhOAGuU3+oSj/PsRy4OYUyXTZo/8gIhsK590I99tuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWAfShGjWXdk01AesvCOe4Wx2379RU4ZnHqE07B9/tqk/yMApPOlOzbwFrGRtN2KH
	 rh58w1hbsWTMPlFblqlQ1SxMMejeuSB5TM47VvWVgNb+4j5/0TLLkty8/TKo1M5HH/
	 ozr9QE0gFn9ShiUD1l2+Lo/QtBOeSmbmhawDf8uk=
Date: Mon, 19 Oct 2026 13:43:33 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] rust: add runtime PM support
Message-ID: <atYCU1_f-MhI8TBq@arm.com>
References: <20261005133857.1572243-1-beata.michalska@arm.com>
 <20261005133857.1572243-2-beata.michalska@arm.com>
 <20261016121230.3724323-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016121230.3724323-1-aliceryhl@google.com>

Hi Alice,
On Fri, Oct 16, 2026 at 12:12:29PM +0000, Alice Ryhl wrote:
> On Mon, Oct 05, 2026 at 03:37:39PM +0200, Beata Michalska wrote:
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index a5b7abc10ff0..538cbb104254 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -119,6 +119,9 @@ struct device_private {
> >  	const struct device_driver *async_driver;
> >  	char *deferred_probe_reason;
> >  	struct device *device;
> > +#ifdef CONFIG_RUST
> > +	void *rust_private;
> > +#endif
> >  	u8 dead:1;
> >  };
> 
> `scripts/kernel-doc -none drivers/base/base.h` warns that `rust_private` is
> not described in the kernel-doc comment for `struct device_private`.
> 
> > +/// Device's runtime power management status
> > +#[repr(i32)]
> > +pub enum RuntimePMState {
> > +    /// Runtime PM has not been initialized for this device yet.
> > +    Unknown = bindings::rpm_status_RPM_INVALID,
> > +    /// The device is expected to be runtime active and in its normal operating state
> > +    Resumed = bindings::rpm_status_RPM_ACTIVE,
> > +    /// The device is expected to be suspended, unavailable for normal operations
> > +    Suspended = bindings::rpm_status_RPM_SUSPENDED,
> > +}
> 
> Is `RuntimePMState::Unknown` needed? The only place that takes
> `RuntimePMState` is `PMContext::enable()`, which rejects `Unknown` with
> `EINVAL`. Removing `Unknown` would avoid having to handle an invalid state in
> `enable()`.
That one was a leftover from my changes. It is indeed not needed and will be
dropped.
> 
> > +impl<'a> ResumeScope<'a> {
> ...
> > +    fn release_inner(&self) -> Result {
> > +        let scope_mode = self.0.mode & !ModeFlag::Idle;
> > +
> > +        match self.0.mode {
> > +            mode if mode.contains(ModeFlag::Idle) => Request::idle(
> > +                self.0.dev,
> > +                scope_mode & (ModeFlag::Async | ModeFlag::Nowait),
> > +            ),
> > +            mode if mode.contains(ModeFlag::Auto) => {
> > +                Request::mark_last_busy(self.0.dev);
> > +                Request::suspend(self.0.dev, scope_mode)
> > +            }
> > +            _ => Request::suspend(self.0.dev, scope_mode),
> > +        }
> > +    }
> ...
> > +impl<'a> AwakeScope<'a> {
> > +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> > +        if !mode.contains(ModeFlag::Acquire) {
> > +            return Err(EINVAL);
> > +        }
> > +        // ModeFlag::Idle is internal so strip it off before passing further
> > +        match Request::resume(dev, mode & !ModeFlag::Idle) {
> > +            Ok(()) => {}
> > +            // For async/nowait requests, `EINPROGRESS` means the resume is in
> > +            // flight and the usage reference already keeps the device active.
> > +            Err(e) if e == EINPROGRESS && mode.contains_any(ModeFlag::Async | ModeFlag::Nowait) => {
> > +            }
> > +            Err(e) => {
> > +                Request::put_noidle(dev);
> > +                return Err(e);
> > +            }
> > +        }
> > +
> > +        Ok(Self(Scope::<Awake> {
> > +            dev,
> > +            mode,
> > +            _tag: PhantomData,
> > +        }))
> > +    }
> > +
> > +    fn release_inner(&self) -> Result {
> > +        let scope_mode = self.0.mode & !ModeFlag::Idle;
> > +        match self.0.mode {
> > +            mode if mode.contains(ModeFlag::Idle) => Request::idle(self.0.dev, scope_mode),
> 
> In `ResumeScope::release_inner()`, the `ModeFlag::Idle` arm masks out
> `ModeFlag::Auto` (`scope_mode & (ModeFlag::Async | ModeFlag::Nowait)`),
> whereas here in `AwakeScope::release_inner()` it passes `scope_mode` unmasked.
> Should this also strip `ModeFlag::Auto`?
Actually the masking is not really needed in either case: `ModeFlag::Idle` needs
to be stripped as that one is not recognized by the pm framework.
`ModeFlag::Auto` is added by `rpm_suspend`  so it's bit redundant to use.
'ModeFlag::Acquire` is not allowed here , which leave only the `ModeFlag::Async`
and `ModeFlag::Nowait', and those are the only ones passed.
`AwakeScope` actually requires `ModeFlags::Acquire` which is why the flags are
passed as is. I will drop the masking from `ResumeScope::release_inner` to get
rid of this confusion.
> 
> Also, in `AwakeScope::new()`, when `ModeFlag::Nowait` is set without
> `ModeFlag::Async`, `__pm_runtime_resume()` returns `-EINPROGRESS` if a
> concurrent suspend or resume is in progress without queueing an async resume.
> Swallowing `EINPROGRESS` when only `Nowait` is set means `get()` returns
> `Ok(AwakeScope)` even though the device is not resumed (and might be
> suspending). Should `EINPROGRESS` only be treated as `Ok(())` for
> `ModeFlag::Async`?
> 
That's a good catch.
> > +impl<'a> RetainScope<'a> {
> ...
> > +    fn release_inner(&self) {
> > +        Request::put_noidle(self.0.dev);
> > +    }
> 
> In the v3 discussion with Sami [1], you agreed that `RetainScope` should call
> `put` rather than `put_noidle` on release so that dropping the last reference
> triggers idle/suspend handling, looks like this was missed in v4.
> 
> [1]: https://lore.kernel.org/r/apaYNvQSSUCkMTjn@arm.com
I did intentionally skip that change. The reason is that the C pm framework
allows that passive hold and the rust abstraction was intended to reflect it.
I do see how that might be misleading but amending the code here means deviating
from the C part. That API is purely for manipulating the usage count.
> 
> > +#[cfg(not(CONFIG_PM))]
> > +impl Request {
> > +    #[inline]
> > +    fn active(_dev: &device::Device<device::Bound>) -> bool {
> > +        false
> > +    }
> 
> `include/linux/pm_runtime.h` already provides `!CONFIG_PM` stub
> implementations for all of these functions. If you add `#ifndef CONFIG_PM`
> helpers in `rust/helpers/pm_runtime.c` for the functions that are `extern`
> under `CONFIG_PM` and `static inline` under `!CONFIG_PM`, you can drop the
> `#[cfg(not(CONFIG_PM))]` `Request` block and the `#[cfg(CONFIG_PM)]` guards in
> `apply_config()` altogether.
I should have probably done that earlier. Thanks for patiently pointing that
out.
> 
> > +struct PMPayload<P> {
> > +    in_flight: AtomicFlag,
> > +    inner: UnsafeCell<Option<P>>,
> > +}
> 
> Thanks for removing `Option` from the public `PMOps` trait methods! You can
> still use `ManuallyDrop<P>` instead of `Option<P>` inside `PMPayload` too,
> which avoids the extra discriminant and the unreachable `None` check in
> `transition()`.
Consider it done.
> 
> > +    /// Enable runtime PM
> > +    pub fn enable(&self, state: RuntimePMState) -> Result {
> > +        self.inner.state
> > +            .cmpxchg(
> > +                PMContextState::Disabled,
> > +                PMContextState::Enabled,
> > +                ordering::Full
> > +            )
> > +            .map_err(|old| match old {
> > +                PMContextState::Dead => ENODEV,
> > +                PMContextState::Enabled => EBUSY,
> > +                _ => EINVAL, // unreachable
> > +            })?;
> > +
> > +        Self::apply_config(self.inner.dev, &self.inner.configs);
> > +
> > +        match state {
> > +            RuntimePMState::Resumed => Request::mark_active(self.inner.dev),
> > +            RuntimePMState::Suspended => Request::mark_suspended(self.inner.dev),
> > +            _ => Err(EINVAL),
> > +        }.inspect_err(|_| {
> > +            self.inner.state.store(PMContextState::Disabled, ordering::Release);
> > +        })?;
> > +
> > +        Request::runtime_enable(self.inner.dev);
> > +        Ok(())
> > +    }
> 
> If `match state` fails (for instance if `mark_active()` or `mark_suspended()`
> returns an error), `Self::apply_config()` has already run and its side effects
> (such as `pm_runtime_irq_safe()` incrementing the parent's usage count or
> `pm_runtime_no_callbacks()`) are not undone. Could `mark_active()` /
> `mark_suspended()` be called before `apply_config()`?
I think only the `pm_runtime_irq_safe` might turn out being problematic here,
although if that fails I would imagine the driver to fail probe as well, which
would lead to removing the device and restoring the parent dev state.
But the point stands so I will move `Self::apply_config` after marking
the devices state.
> 
> > +    /// Runs a closure while holding a `ResumeScope`.
> > +    pub fn with_resume<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> > +        if profile.0.contains(ModeFlag::Async) {
> > +            return Err(EINVAL);
> > +        }
> > +        let _scope = self.resume(profile)?;
> > +        f()
> > +    }
> > +    /// Runs a closure while holding an `AwakeScope`.
> > +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> > +        if profile.0.contains_any(ModeFlag::Async | ModeFlag::Nowait) {
> > +            return Err(EINVAL);
> > +        }
> > +        let _scope = self.get(profile)?;
> > +        f()
> > +    }
> 
> Should `with_resume()` also reject `ModeFlag::Nowait` like `with_get()` does?
Tha t is the consequence on how `AwakeScope::new` is hadling the `EINPROGRESS`,
which would mean that it would succeed in creating the scope even if
`ModeFlag::Nowait` was used and there was a pm transition in progress.
The `ResumeScope` would fail so the closure would not run. But as suggested,
`AwakeScope::new()` should not allow `EINPROGRESS` for `ModeFlag::Nowait` , this
method will also get amended and will only reject `ModeFlag::Async`.
> 
> > +    fn apply_config(dev: &device::Device<device::Bound>, opts: &[PMConfig]) {
> > +        #[cfg(not(CONFIG_PM))]
> > +        let _ = opts;
> > +        let _ = dev;
> 
> `let _ = dev;` is outside `#[cfg(not(CONFIG_PM))]` here (though as noted
> above, using C helpers for `!CONFIG_PM` removes the need for `#[cfg]` here
> entirely).
Will be removed.
> 
> > +#[repr(C)]
> > +#[pin_data]
> > +struct RegistrationData<'a, T: PMOps> {
> > +    #[pin]
> > +    data: PMPayload<T::RuntimePayloadType>,
> > +    _marker: PhantomData<&'a mut T>,
> > +}
> 
> Does `RegistrationData` need `#[pin_data]`? `PMPayload` moves the payload in
> and out by value and doesn't use structural pinning, so a plain `KBox::new()`
> should suffice.
Indeed.
> 
> > +impl<'a, T: PMOps> Registration<'a, T> {
> > +    /// Creates a runtime PM registration for `dev`.
> > +    ///
> > +    /// The provided profiles and configuration are stored in the associated
> > +    /// [`PMContext`]. The `payload` is stored as a Registration data
> > +    /// and is used to service PM transitions.
> > +    ///
> > +    /// The device must use the callback represented by `ops`, generated
> > +    /// for the same bus adapter and driver pair `(D, T)`.
> > +    pub fn new(
> > +        dev: &'a device::Device<device::Core<'_>>,
> > +        ops: &'static DevPMOps<T>,
> > +        profiles: Option<KVec<PMProfile>>,
> > +        configs: Option<KVec<PMConfig>>,
> > +        payload: T::RuntimePayloadType,
> > +    ) -> Result<Self> {
> ...
> > +        unsafe {
> > +            let ptr = (*(*dev.as_raw()).p).rust_private;
> > +            if !ptr.is_null() {
> > +                return Err(EBUSY);
> > +            }
> > +            (*(*dev.as_raw()).p).rust_private = payload.into_foreign();
> > +        }
> > +
> > +        Ok(Self {
> > +            ctx: PMContext { inner: inner_ctx },
> > +        })
> > +    }
> 
> What happens if a driver calls `core::mem::forget(pm_reg)` (which is safe in
> Rust)?
> 
> If `Registration::drop` never runs when the driver unbinds:
> 1. Runtime PM remains enabled on the device (and `pm_runtime_reinit()` in
>    `device_unbind_cleanup()` is a no-op while runtime PM is enabled).
> 2. `rust_private` remains non-null, pointing to `RegistrationData<'a, T>`
>    after `'a` has ended and after the device has unbound from `T`.
> 
> Other registrations tied to `'bound` (such as `drm::Registration::new()` and
> `irq::Registration::new()`) make `Registration::new()` an `unsafe fn` with the
> safety requirement that the caller must not `mem::forget()` the returned
> `Registration` or otherwise prevent its `Drop` implementation from running
> before `'a` ends. Doing the same here would also allow `RuntimePayloadType<'a>`
> to be non-`'static`, so drivers can hold `'bound`-scoped resources like
> `IoMem<'bound>` in the runtime PM payload.
>
Right, the `core::mem::fotget` ...
Thanks for pointing that out. Though that got me thinking the same can apply to
all the PM scopes, consequences of which are less daring but still.
They also could be marked as `unsafe` but then what's the point of having those
if it still requires unsafe code from the drivers .....
> Also, there are a few leftover `#[allow(unused)]` attributes in this file (on
> `mark_active`, `mark_suspended`, `runtime_resume_callback`,
> `runtime_suspend_callback`, `DevPMOps`, and `PayloadGuard`) that can be
> removed.
Will get clean up.

Thank you for the review. Much appreciated.
---
BR
Beata
> 
> Alice
