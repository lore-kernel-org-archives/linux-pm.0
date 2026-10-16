Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD803CF1F2
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152756; cv=none; b=f3NL8WB9EeK0Z+lEecCVNsmNqb+5UdPj6AODr7HQBFizOlQnx72ZYFtc0CoOmk6IUOky1ToEprjvrEcefani5L8DykZ2D3UKWTjueNQ5W/CX2Qcq90vs7POpxXbMzUWSA+asWoHNzvefPklGD5KiMcx9/JdzVf0vQF03WKLiGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152756; c=relaxed/simple;
	bh=FqH0bdEQPmPJbirwxtsgL2Ei9yv+vqHf2QbfzRnaG+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHc8ZWrX83yITHq3S0OD4sPOXFfyPbKGkRejR2N0cd+1LuKS2yiJcm5VhAPSFEHjyBynoWV7aKFX4xw3qlJW6Zwjk+Dr9DXaPb2CK73HgqSzqg3LCfDGkTAYilS0DPTRLrifnrioeGXXmD39HAKW8hM1mhjDbAKjNj9LQ65v/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYudvH1x; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYudvH1x"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so49043885e9.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792152752; x=1792757552; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YNQ5s//J8IJmFZANY5I3f9Gqs72fdd1AkgujEl+yjSY=;
        b=gYudvH1xwO3ySY3u+HB8wlm8hINlJLiHVaJJCRVdeyGrpjqs3RwpSL05th1bYlsmvP
         ps1aaycbNSXuvVpygi+LNfu/ZFa+o5k7dQfU+DsM1kbycIgfg45EcqcKYig3q/VEb21H
         Vai/uDWFpD+N6HRqpzsyNkMHcX4NA6A3E8oWCOvB7Nd4X054lzkA6DqQSQU+W4MlYLOf
         FhczboyXYqzxv3DQl0MOFpvfWV7ah38WHLa3Z5dwWKWFpkbQ9gon3jrYMnPJElo7l6xq
         Hk2RAoCz6WjwJanMmCqTKl6/KsW2xUsiDOxErjQcRL1NGOoOtOyaT+GyL4iaZxFZ3rLI
         RywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152752; x=1792757552;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNQ5s//J8IJmFZANY5I3f9Gqs72fdd1AkgujEl+yjSY=;
        b=aB5ekf39f7kuO1kVKWArT0kSMHAHoRCZHA2Ac5W06gAY6PmqxBQuvK1T+tec2hEMtM
         omW4Y9P6ucBR2qQ5sdcP7EgSdRWib0tLGdTB282J1LOVByL6OqcCnSh2k4QES/v9lV6y
         5uUnqrYjDgmNh4cIn7kSmnWEmEPTwouT5lmIMYxNYISdI0bXI6mhRz4xxSNzcflV/j6q
         lKjYkXLLV0xfJNWbD84Y0oTTnX4DcnbMQRkqxg/z8ARh0MhrQner4loHFhcTOSTO8sWL
         AksUzzMMeeQjJV/qVDEMKbCVEeMoeDg9T4mm8sy/gLncpQYMtwqolmFD59pPituHSw+v
         gZxA==
X-Forwarded-Encrypted: i=1; AKwUvBwbpQosZ4midsA+Ajg5J4OwdoTEJ+JMNett0OPrcNKSaoZW28EhCDRF+mbW2tue+kmYLh5ozTyDrg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKl3QwVlXAa0Vwz8eSoUJyH9XKugKJHnQdQW6/vWo8SzfDtcRK3
	PDr6+6qhq+UldSaYPUYp6+b0mNqEJVxdZXEGDzymzfGxOsu8CJtihS1XEW7OBDumNPqEHXVw+PR
	KYVDw/YGDZ6SYua4vUA==
X-Received: from wmbjr14.prod.google.com ([2002:a05:600c:560e:b0:4a1:d05f:3f13])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3488:b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a18e4c05d9mr443132905e9.21.1792152751449;
 Fri, 16 Oct 2026 05:12:31 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:12:29 +0000
In-Reply-To: <20261005133857.1572243-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005133857.1572243-1-beata.michalska@arm.com> <20261005133857.1572243-2-beata.michalska@arm.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016121230.3724323-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 1/3] rust: add runtime PM support
From: Alice Ryhl <aliceryhl@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, dakr@kernel.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	acourbot@nvidia.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 05, 2026 at 03:37:39PM +0200, Beata Michalska wrote:
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..538cbb104254 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -119,6 +119,9 @@ struct device_private {
>  	const struct device_driver *async_driver;
>  	char *deferred_probe_reason;
>  	struct device *device;
> +#ifdef CONFIG_RUST
> +	void *rust_private;
> +#endif
>  	u8 dead:1;
>  };

`scripts/kernel-doc -none drivers/base/base.h` warns that `rust_private` is
not described in the kernel-doc comment for `struct device_private`.

> +/// Device's runtime power management status
> +#[repr(i32)]
> +pub enum RuntimePMState {
> +    /// Runtime PM has not been initialized for this device yet.
> +    Unknown = bindings::rpm_status_RPM_INVALID,
> +    /// The device is expected to be runtime active and in its normal operating state
> +    Resumed = bindings::rpm_status_RPM_ACTIVE,
> +    /// The device is expected to be suspended, unavailable for normal operations
> +    Suspended = bindings::rpm_status_RPM_SUSPENDED,
> +}

Is `RuntimePMState::Unknown` needed? The only place that takes
`RuntimePMState` is `PMContext::enable()`, which rejects `Unknown` with
`EINVAL`. Removing `Unknown` would avoid having to handle an invalid state in
`enable()`.

> +impl<'a> ResumeScope<'a> {
...
> +    fn release_inner(&self) -> Result {
> +        let scope_mode = self.0.mode & !ModeFlag::Idle;
> +
> +        match self.0.mode {
> +            mode if mode.contains(ModeFlag::Idle) => Request::idle(
> +                self.0.dev,
> +                scope_mode & (ModeFlag::Async | ModeFlag::Nowait),
> +            ),
> +            mode if mode.contains(ModeFlag::Auto) => {
> +                Request::mark_last_busy(self.0.dev);
> +                Request::suspend(self.0.dev, scope_mode)
> +            }
> +            _ => Request::suspend(self.0.dev, scope_mode),
> +        }
> +    }
...
> +impl<'a> AwakeScope<'a> {
> +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> +        if !mode.contains(ModeFlag::Acquire) {
> +            return Err(EINVAL);
> +        }
> +        // ModeFlag::Idle is internal so strip it off before passing further
> +        match Request::resume(dev, mode & !ModeFlag::Idle) {
> +            Ok(()) => {}
> +            // For async/nowait requests, `EINPROGRESS` means the resume is in
> +            // flight and the usage reference already keeps the device active.
> +            Err(e) if e == EINPROGRESS && mode.contains_any(ModeFlag::Async | ModeFlag::Nowait) => {
> +            }
> +            Err(e) => {
> +                Request::put_noidle(dev);
> +                return Err(e);
> +            }
> +        }
> +
> +        Ok(Self(Scope::<Awake> {
> +            dev,
> +            mode,
> +            _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn release_inner(&self) -> Result {
> +        let scope_mode = self.0.mode & !ModeFlag::Idle;
> +        match self.0.mode {
> +            mode if mode.contains(ModeFlag::Idle) => Request::idle(self.0.dev, scope_mode),

In `ResumeScope::release_inner()`, the `ModeFlag::Idle` arm masks out
`ModeFlag::Auto` (`scope_mode & (ModeFlag::Async | ModeFlag::Nowait)`),
whereas here in `AwakeScope::release_inner()` it passes `scope_mode` unmasked.
Should this also strip `ModeFlag::Auto`?

Also, in `AwakeScope::new()`, when `ModeFlag::Nowait` is set without
`ModeFlag::Async`, `__pm_runtime_resume()` returns `-EINPROGRESS` if a
concurrent suspend or resume is in progress without queueing an async resume.
Swallowing `EINPROGRESS` when only `Nowait` is set means `get()` returns
`Ok(AwakeScope)` even though the device is not resumed (and might be
suspending). Should `EINPROGRESS` only be treated as `Ok(())` for
`ModeFlag::Async`?

> +impl<'a> RetainScope<'a> {
...
> +    fn release_inner(&self) {
> +        Request::put_noidle(self.0.dev);
> +    }

In the v3 discussion with Sami [1], you agreed that `RetainScope` should call
`put` rather than `put_noidle` on release so that dropping the last reference
triggers idle/suspend handling, looks like this was missed in v4.

[1]: https://lore.kernel.org/r/apaYNvQSSUCkMTjn@arm.com

> +#[cfg(not(CONFIG_PM))]
> +impl Request {
> +    #[inline]
> +    fn active(_dev: &device::Device<device::Bound>) -> bool {
> +        false
> +    }

`include/linux/pm_runtime.h` already provides `!CONFIG_PM` stub
implementations for all of these functions. If you add `#ifndef CONFIG_PM`
helpers in `rust/helpers/pm_runtime.c` for the functions that are `extern`
under `CONFIG_PM` and `static inline` under `!CONFIG_PM`, you can drop the
`#[cfg(not(CONFIG_PM))]` `Request` block and the `#[cfg(CONFIG_PM)]` guards in
`apply_config()` altogether.

> +struct PMPayload<P> {
> +    in_flight: AtomicFlag,
> +    inner: UnsafeCell<Option<P>>,
> +}

Thanks for removing `Option` from the public `PMOps` trait methods! You can
still use `ManuallyDrop<P>` instead of `Option<P>` inside `PMPayload` too,
which avoids the extra discriminant and the unreachable `None` check in
`transition()`.

> +    /// Enable runtime PM
> +    pub fn enable(&self, state: RuntimePMState) -> Result {
> +        self.inner.state
> +            .cmpxchg(
> +                PMContextState::Disabled,
> +                PMContextState::Enabled,
> +                ordering::Full
> +            )
> +            .map_err(|old| match old {
> +                PMContextState::Dead => ENODEV,
> +                PMContextState::Enabled => EBUSY,
> +                _ => EINVAL, // unreachable
> +            })?;
> +
> +        Self::apply_config(self.inner.dev, &self.inner.configs);
> +
> +        match state {
> +            RuntimePMState::Resumed => Request::mark_active(self.inner.dev),
> +            RuntimePMState::Suspended => Request::mark_suspended(self.inner.dev),
> +            _ => Err(EINVAL),
> +        }.inspect_err(|_| {
> +            self.inner.state.store(PMContextState::Disabled, ordering::Release);
> +        })?;
> +
> +        Request::runtime_enable(self.inner.dev);
> +        Ok(())
> +    }

If `match state` fails (for instance if `mark_active()` or `mark_suspended()`
returns an error), `Self::apply_config()` has already run and its side effects
(such as `pm_runtime_irq_safe()` incrementing the parent's usage count or
`pm_runtime_no_callbacks()`) are not undone. Could `mark_active()` /
`mark_suspended()` be called before `apply_config()`?

> +    /// Runs a closure while holding a `ResumeScope`.
> +    pub fn with_resume<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> +        if profile.0.contains(ModeFlag::Async) {
> +            return Err(EINVAL);
> +        }
> +        let _scope = self.resume(profile)?;
> +        f()
> +    }
> +    /// Runs a closure while holding an `AwakeScope`.
> +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> +        if profile.0.contains_any(ModeFlag::Async | ModeFlag::Nowait) {
> +            return Err(EINVAL);
> +        }
> +        let _scope = self.get(profile)?;
> +        f()
> +    }

Should `with_resume()` also reject `ModeFlag::Nowait` like `with_get()` does?

> +    fn apply_config(dev: &device::Device<device::Bound>, opts: &[PMConfig]) {
> +        #[cfg(not(CONFIG_PM))]
> +        let _ = opts;
> +        let _ = dev;

`let _ = dev;` is outside `#[cfg(not(CONFIG_PM))]` here (though as noted
above, using C helpers for `!CONFIG_PM` removes the need for `#[cfg]` here
entirely).

> +#[repr(C)]
> +#[pin_data]
> +struct RegistrationData<'a, T: PMOps> {
> +    #[pin]
> +    data: PMPayload<T::RuntimePayloadType>,
> +    _marker: PhantomData<&'a mut T>,
> +}

Does `RegistrationData` need `#[pin_data]`? `PMPayload` moves the payload in
and out by value and doesn't use structural pinning, so a plain `KBox::new()`
should suffice.

> +impl<'a, T: PMOps> Registration<'a, T> {
> +    /// Creates a runtime PM registration for `dev`.
> +    ///
> +    /// The provided profiles and configuration are stored in the associated
> +    /// [`PMContext`]. The `payload` is stored as a Registration data
> +    /// and is used to service PM transitions.
> +    ///
> +    /// The device must use the callback represented by `ops`, generated
> +    /// for the same bus adapter and driver pair `(D, T)`.
> +    pub fn new(
> +        dev: &'a device::Device<device::Core<'_>>,
> +        ops: &'static DevPMOps<T>,
> +        profiles: Option<KVec<PMProfile>>,
> +        configs: Option<KVec<PMConfig>>,
> +        payload: T::RuntimePayloadType,
> +    ) -> Result<Self> {
...
> +        unsafe {
> +            let ptr = (*(*dev.as_raw()).p).rust_private;
> +            if !ptr.is_null() {
> +                return Err(EBUSY);
> +            }
> +            (*(*dev.as_raw()).p).rust_private = payload.into_foreign();
> +        }
> +
> +        Ok(Self {
> +            ctx: PMContext { inner: inner_ctx },
> +        })
> +    }

What happens if a driver calls `core::mem::forget(pm_reg)` (which is safe in
Rust)?

If `Registration::drop` never runs when the driver unbinds:
1. Runtime PM remains enabled on the device (and `pm_runtime_reinit()` in
   `device_unbind_cleanup()` is a no-op while runtime PM is enabled).
2. `rust_private` remains non-null, pointing to `RegistrationData<'a, T>`
   after `'a` has ended and after the device has unbound from `T`.

Other registrations tied to `'bound` (such as `drm::Registration::new()` and
`irq::Registration::new()`) make `Registration::new()` an `unsafe fn` with the
safety requirement that the caller must not `mem::forget()` the returned
`Registration` or otherwise prevent its `Drop` implementation from running
before `'a` ends. Doing the same here would also allow `RuntimePayloadType<'a>`
to be non-`'static`, so drivers can hold `'bound`-scoped resources like
`IoMem<'bound>` in the runtime PM payload.

Also, there are a few leftover `#[allow(unused)]` attributes in this file (on
`mark_active`, `mark_suspended`, `runtime_resume_callback`,
`runtime_suspend_callback`, `DevPMOps`, and `PayloadGuard`) that can be
removed.

Alice
