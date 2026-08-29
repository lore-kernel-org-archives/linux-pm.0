Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FE1D5CFB
	for <linux-pm@vger.kernel.org>; Sat, 29 Aug 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787963848; cv=none; b=P6KA9IOeET7SaQKR2GxXsB0pYkKU4UV537Ap6Q4sXoPN+ralG2mSJqW2nLEwAELMZIngkKf8uIkt09dhVQptVUKgiEmaP/m9k72TI+XYlIqT8p3E6ws1bEH4lqf1ucjXq9gykeTbc+BwmS5AQGpSPCW/t5xy5h8nHKp2uTmBURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787963848; c=relaxed/simple;
	bh=OtxXdRbEIGEUvC22NlhP7/3e6oEXzFZ8KbdBRC4HXds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuDbLBSeVqh2alVp2GUT2PaFJZ4f6BmP4y5ESGDGIdN+pUNXvLn25TMcOssy2Hc/+Y9TxiLCslCKBenkzotl+JOvGi3hzKaRagvlbaAlv6IWnd1+0mEhSu+7BkawPbfNv7gNaHPHlAIQ8IQg8gcp8sIqp4y4hhnjk6muoZt2yA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDmMrTlS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDmMrTlS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso39565ad.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787963846; x=1788568646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9wbpSofY68EGnEexQqy0QFzqyttXM3qSmfFpYwxrkcA=;
        b=pDmMrTlScrDby58rUTwtKnYdPsuM5DDZdq8bxgP2zL9ZC/q46uc5nFl7AAtXc1GlEI
         +2IooUHEgA0fyp5P+1WdJQvofq0qsA/NvLXK+nuBhEpoNQZrN9U5wo7nFaZq5xkGDzZp
         7NUjv6Pma/L0/2nntZvYo3Iqos3S7NhaFJ8RtkfBptLR2ILyl3RXFgmnJtxtrCN9LrOk
         eHxn1nWEae43DhN+EDGh887nLLG+BpZGjF7Uq0mstdrJ84+EGpLWgsji3cUPrPdsnTsB
         9zlu+/p0ySdmVd2dtFZe0RIFZapoWmOKGa+GlDgyq0BsgWwERm26FXrOMBGGDnFfinmg
         WicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787963846; x=1788568646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wbpSofY68EGnEexQqy0QFzqyttXM3qSmfFpYwxrkcA=;
        b=foKiQJm9X7VOLYYeaUleWDYVaxxiouv/rFMP3w/23AQpocsZ9RMnwK5PYtQSNh4C0N
         SYO75IEBeIU7cpDnPnF7caSSTdlu+76J92ZjbKww0l+JpBtD7N0PKUgxyCnnhbjscQCO
         w5k5fBP9XIVkY8QvMKXsWsE0D//vUgZezP8mw4KzZQZ/D6SrFMqcBvKRvxgSmV9KWCyG
         aY2zKer/boi6B357fAcpvB9TWRijqxchWG/Pbv22mwpPoHNcXC//uhGWIYen+7J8teIi
         Y4eay+1BDB1V87Ubv27z6OXZzud21FQi84MrrTJRjvwKU9bELZxB0rNeES/R022PpGqm
         jp2w==
X-Forwarded-Encrypted: i=1; AKwUvBy4gMn3ETQs7HGOpPQahF2kzUZDx0ZIgxMVNAjigQNV1od4NkNMdfqRxiGDEacSb6MAb+M/ru4inw==@vger.kernel.org
X-Gm-Message-State: AFuF++maKIVfdQcthj8OfGm4XjO702y77oAOi7Yid7y7GeEAjQtTZLi3
	m/+SHn5a02eJgiC8cdJ50/hEp8Gk3PIo1umG1MTxchRYOb2zvhFt4oxxtAoHaNH8UQ==
X-Gm-Gg: AYBFou0ccOKGuYI2s4zHeFRPmi3DXrxaRhOgZXsecfcreNR02QZt62sVDsdZWDciciO
	CiUjUHRcEvEaKiq4M0lyMckMbUyznH9Od+js3R5hgqqvhhXeDjy/WsyVHyE81pQJPCWpL6U0TAP
	FPYCiANg0mAe2XpI9QtaL6e12gMOWRTzQg9sVGbJNqQNUuBEm7GX6w8gm6By3jfF+qGJ7XbU+2j
	ybeJl888P00saUQcDKv9XZVUAZO1XwIzkXIL2chOLp669iYO0REd08MjReQOTUWRwva8q1tNFyo
	3kSAZmLiWBwchDqrmdSWXL+qqRW0LmqUdowebZACfLDUExfO8wxzkw+ipb6Xq6Rq0WxDsWqDAqQ
	TvfabkM/RrDQUedaX5Kj2YzSI8LmtRTvFd1x1QPT55KBATmKH7asg1y9FbMRpMVrzXNC74oWeGN
	ufYQHereQK55ol44pYLCR9tZnp5oAoxUUkWqa6VYg7x1NjzXJef9zynOVyQJl2WwNwRM9t9Ij3d
	T6XT+Ktgq3L9jTPFUCBjo8lPIsoQbM=
X-Received: by 2002:a17:902:f642:b0:2d5:db38:800f with SMTP id d9443c01a7336-2d8df554483mr2980505ad.14.1787963845250;
        Fri, 28 Aug 2026 17:37:25 -0700 (PDT)
Received: from google.com (89.163.16.34.bc.googleusercontent.com. [34.16.163.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398a2f5187fsm545730a91.1.2026.08.28.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 17:37:24 -0700 (PDT)
Date: Sat, 29 Aug 2026 00:37:19 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, boris.brezillon@collabora.com,
	work@onurozkan.dev, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: add runtime PM support
Message-ID: <20260829003719.GA552219@google.com>
References: <20260826131213.1820408-1-beata.michalska@arm.com>
 <20260826131213.1820408-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826131213.1820408-2-beata.michalska@arm.com>

Hi Beata,

On Wed, Aug 26, 2026 at 03:10:55PM +0200, Beata Michalska wrote:
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index a56ba6309594..43bbf4bce993 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -67,6 +67,7 @@ macro_rules! declare_err {
>      declare_err!(EOVERFLOW, "Value too large for defined data type.");
>      declare_err!(EMSGSIZE, "Message too long.");
>      declare_err!(ETIMEDOUT, "Connection timed out.");
> +    declare_err!(EINPROGRESS, "Operation now in progress.");

Looks like this is already upstream since commit b93fb6e76ec1.

> +/// Device's runtime power management status
> +#[repr(i32)]
> +pub enum RuntimePMState {
> +    /// Runtime PM has not been initialized for this device yet.
> +    UNKNOWN = bindings::rpm_status_RPM_INVALID,
> +    /// The device is expected to be runtime active and in it's normal operating state

Nit: it's -> its.

> +    RESUMED = bindings::rpm_status_RPM_ACTIVE,
> +    /// The device is expected to be suspended, unavailable for normal operations
> +    SUSPENDED = bindings::rpm_status_RPM_SUSPENDED,

Should the enum variant names use CamelCase?

> +impl<'a> ResumeScope<'a> {
> +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> +        if mode.contains(ModeFlag::Acquire) {
> +            // ModeFlag::Acquire is intended to be used with Awake scope
> +            // Avoid mixing the modes.
> +            return Err(EINVAL);
> +        }
> +
> +        // ModeFlag::Idle is internal so strip it of before passing further

Nit: of -> off. Also in the identical comment below.

> +impl<'a> AwakeScope<'a> {
> +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> +        if !mode.contains(ModeFlag::Acquire) {
> +            return Err(EINVAL);
> +        }
> +        // ModeFlag::Idle is internal so strip it of before passing further
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
> +            mode if mode.contains(ModeFlag::Auto) => {
> +                Request::mark_last_busy(self.0.dev);
> +                Request::suspend(self.0.dev, scope_mode)
> +            }
> +            _ => Request::suspend(self.0.dev, scope_mode),

In v2 you had Request::idle in the default arm. I didn't see a note
about this in the changelog. Was the change in behavior intentional?

> +impl<'a> RetainScope<'a> {
> +    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> +        Request::get_noresume(dev);
> +        Ok(Self(Scope::<Retain> {
> +            dev,
> +            mode: Mode(ModeFlag::Sync as u32),
> +            _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn try_new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> +        Request::get_if_active(dev)?;
> +        Ok(Self(Scope::<Retain> {
> +            dev,
> +            mode: Mode(ModeFlag::Sync as u32),
> +            _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn release_inner(&self) {
> +        Request::put_noidle(self.0.dev);

What's the reason for using put_noidle here? It doesn't queue
autosuspend, so wouldn't the try_hold_active pattern (i.e. grab if
active, do something, drop) leave the device active until something
else triggers a suspend?

> +/// SAFETY:
> +/// bindings::dev_pm_ops is #[repr(C)], implements Default
> +/// and the struct itself is all nullable function pointers.
> +/// There is no padding and all zero bit-pattern is valid
> +///
> +pub const PMOPS_NONE: bindings::dev_pm_ops =
> +    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().assume_init() };

The safety comment shouldn't be a doc comment.

> +/// Runtime PM context tied to a device.
> +pub struct PMContext<'a, D: driver::DriverLayout, T: PMOps<D>> {
> +    // Preferably, PMContext could be shared via borrowed reference over
> +    // a pm Registration's lifetime but that bares complications on its own
> +    // when the context needs to be shared across different Registration types.

Nit: bares -> bears. Also in the identical comment below.

> +impl<'a, D: driver::DriverLayout, T: PMOps<D>> PMContext<'a, D, T> {
> +    /// Driver-provided runtime PM operations.
> +    ///
> +    /// A driver implements this trait to handle runtime PM
> +    /// transitions for its device type.
> +    ///
> +    /// Each callback receives the device and the current payload.
> +    /// On success, it returns the payload to keep for the next
> +    /// transition. On failure, it returns the payload together
> +    /// with the error so the previous, or otherwise sane state
> +    /// can be preserved.
> +    pub const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
> +        runtime_resume: if T::HAS_RUNTIME_RESUME {
> +            Some(runtime_resume_callback::<D, T>)
> +        } else {
> +            None
> +        },
> +        runtime_suspend: if T::HAS_RUNTIME_SUSPEND {
> +            Some(runtime_suspend_callback::<D, T>)
> +        } else {
> +            None
> +        },
> +        ..PMOPS_NONE
> +    };
> +
> +    /// Enable runtime PM
> +    pub fn enable(&self, state: RuntimePMState) -> Result {
> +        if self.inner.enabled.cmpxchg(false, true, ordering::Full).is_err() {
> +            return Err(EBUSY);
> +        }
> +        Self::apply_config(self.inner.dev, &self.inner.configs);
> +        match state {
> +            RuntimePMState::RESUMED => Request::mark_active(self.inner.dev),
> +            RuntimePMState::SUSPENDED => Request::mark_suspended(self.inner.dev),
> +            _ => Err(EINVAL),
> +        }.inspect_err(|_| self.inner.enabled.store(false, ordering::Release))?;

This always applies the config even if state is invalid. Should we
validate the state before making changes?

> +    /// Runs a closure while holding an `AwakeScope`.
> +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> +        if profile.0.contains(ModeFlag::Async) {
> +            return Err(EINVAL);
> +        }
> +        let _scope = self.get(profile)?;
> +        f()
> +    }

Shouldn't this reject NoWait too to make sure the device will actually
be powered when the closure is executed?

Sami
