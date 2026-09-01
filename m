Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DF930F924;
	Tue,  1 Sep 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254278; cv=none; b=H36bsUhvPtYi0Ejg8yLOHEmmbobKD0ToarlNXWYibOWxe6kgxSpbzwKY74QU52fkBmqVnCekOZCU+SESQUdQLY6ifrpPJfwbJIIytnzrb4HE46RUoI9MaIKf8SSZKHuRW7fBIjn0ZKeI16NMeIaxsVAQZCvsg+0OneqaT4jmcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254278; c=relaxed/simple;
	bh=ks9WM3PRQRqUGON47//b1Pmkqw5lx8iK3dx6XqExqyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oeql6AB5d+qJEvqwjOpdNaPpiZhCMvkJKT6HhZaGZfVSd2USQIDYUb5tAqmZelyIF6QzszvFk5L9oCpOnKOP7zBPPb9kqEsHIPYRd3KrNODcr8xHPx+8oIrzHGxzQHqDKAlfgHKBzb5miioyR/OKN60iYW1XRcHIzl7K9uTpFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nMv/UW7j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nMv/UW7j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2267F1692;
	Tue,  1 Sep 2026 02:17:51 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FC703F882;
	Tue,  1 Sep 2026 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788254274; bh=ks9WM3PRQRqUGON47//b1Pmkqw5lx8iK3dx6XqExqyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMv/UW7jL/CfUFZIEOAX4wlPj4g0NKuCatmZAvfp2d6bdCOlYsCtkffE4uiDCzs2l
	 /naRgpKXeGcCK3cvxTyNVtdYyomrbKmz1fjilV0kkhrtAWHOGasOngKobacWxAZ0yp
	 QFD+shJ6Kb3ze8xiBhYbpRbur/Mj0g9wlCEU4Xdo=
Date: Tue, 1 Sep 2026 11:17:42 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, boris.brezillon@collabora.com,
	work@onurozkan.dev, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: add runtime PM support
Message-ID: <apaYNvQSSUCkMTjn@arm.com>
References: <20260826131213.1820408-1-beata.michalska@arm.com>
 <20260826131213.1820408-2-beata.michalska@arm.com>
 <20260829003719.GA552219@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829003719.GA552219@google.com>

Hi Sami,

On Sat, Aug 29, 2026 at 12:37:19AM +0000, Sami Tolvanen wrote:
> Hi Beata,
> 
> On Wed, Aug 26, 2026 at 03:10:55PM +0200, Beata Michalska wrote:
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index a56ba6309594..43bbf4bce993 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -67,6 +67,7 @@ macro_rules! declare_err {
> >      declare_err!(EOVERFLOW, "Value too large for defined data type.");
> >      declare_err!(EMSGSIZE, "Message too long.");
> >      declare_err!(ETIMEDOUT, "Connection timed out.");
> > +    declare_err!(EINPROGRESS, "Operation now in progress.");
> 
> Looks like this is already upstream since commit b93fb6e76ec1.
Missed that.
> 
> > +/// Device's runtime power management status
> > +#[repr(i32)]
> > +pub enum RuntimePMState {
> > +    /// Runtime PM has not been initialized for this device yet.
> > +    UNKNOWN = bindings::rpm_status_RPM_INVALID,
> > +    /// The device is expected to be runtime active and in it's normal operating state
> 
> Nit: it's -> its.
Fixed for v4 (across all style-related comments: spelling, documentation
formatting, naming/CamelCase, etc.).
> 
> > +    RESUMED = bindings::rpm_status_RPM_ACTIVE,
> > +    /// The device is expected to be suspended, unavailable for normal operations
> > +    SUSPENDED = bindings::rpm_status_RPM_SUSPENDED,
> 
> Should the enum variant names use CamelCase?
> 
> > +impl<'a> ResumeScope<'a> {
> > +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> > +        if mode.contains(ModeFlag::Acquire) {
> > +            // ModeFlag::Acquire is intended to be used with Awake scope
> > +            // Avoid mixing the modes.
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // ModeFlag::Idle is internal so strip it of before passing further
> 
> Nit: of -> off. Also in the identical comment below.
> 
> > +impl<'a> AwakeScope<'a> {
> > +    fn new(dev: &'a device::Device<device::Bound>, mode: Mode) -> Result<Self> {
> > +        if !mode.contains(ModeFlag::Acquire) {
> > +            return Err(EINVAL);
> > +        }
> > +        // ModeFlag::Idle is internal so strip it of before passing further
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
> > +            mode if mode.contains(ModeFlag::Auto) => {
> > +                Request::mark_last_busy(self.0.dev);
> > +                Request::suspend(self.0.dev, scope_mode)
> > +            }
> > +            _ => Request::suspend(self.0.dev, scope_mode),
> 
> In v2 you had Request::idle in the default arm. I didn't see a note
> about this in the changelog. Was the change in behavior intentional?
This is intentional to match the resume request. Idle has a separate case.
Missed that from the changelog.
> 
> > +impl<'a> RetainScope<'a> {
> > +    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> > +        Request::get_noresume(dev);
> > +        Ok(Self(Scope::<Retain> {
> > +            dev,
> > +            mode: Mode(ModeFlag::Sync as u32),
> > +            _tag: PhantomData,
> > +        }))
> > +    }
> > +
> > +    fn try_new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> > +        Request::get_if_active(dev)?;
> > +        Ok(Self(Scope::<Retain> {
> > +            dev,
> > +            mode: Mode(ModeFlag::Sync as u32),
> > +            _tag: PhantomData,
> > +        }))
> > +    }
> > +
> > +    fn release_inner(&self) {
> > +        Request::put_noidle(self.0.dev);
> 
> What's the reason for using put_noidle here? It doesn't queue
> autosuspend, so wouldn't the try_hold_active pattern (i.e. grab if
> active, do something, drop) leave the device active until something
> else triggers a suspend?
You are right. This should call put.
> 
> > +/// SAFETY:
> > +/// bindings::dev_pm_ops is #[repr(C)], implements Default
> > +/// and the struct itself is all nullable function pointers.
> > +/// There is no padding and all zero bit-pattern is valid
> > +///
> > +pub const PMOPS_NONE: bindings::dev_pm_ops =
> > +    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().assume_init() };
> 
> The safety comment shouldn't be a doc comment.
> 
> > +/// Runtime PM context tied to a device.
> > +pub struct PMContext<'a, D: driver::DriverLayout, T: PMOps<D>> {
> > +    // Preferably, PMContext could be shared via borrowed reference over
> > +    // a pm Registration's lifetime but that bares complications on its own
> > +    // when the context needs to be shared across different Registration types.
> 
> Nit: bares -> bears. Also in the identical comment below.
> 
> > +impl<'a, D: driver::DriverLayout, T: PMOps<D>> PMContext<'a, D, T> {
> > +    /// Driver-provided runtime PM operations.
> > +    ///
> > +    /// A driver implements this trait to handle runtime PM
> > +    /// transitions for its device type.
> > +    ///
> > +    /// Each callback receives the device and the current payload.
> > +    /// On success, it returns the payload to keep for the next
> > +    /// transition. On failure, it returns the payload together
> > +    /// with the error so the previous, or otherwise sane state
> > +    /// can be preserved.
> > +    pub const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
> > +        runtime_resume: if T::HAS_RUNTIME_RESUME {
> > +            Some(runtime_resume_callback::<D, T>)
> > +        } else {
> > +            None
> > +        },
> > +        runtime_suspend: if T::HAS_RUNTIME_SUSPEND {
> > +            Some(runtime_suspend_callback::<D, T>)
> > +        } else {
> > +            None
> > +        },
> > +        ..PMOPS_NONE
> > +    };
> > +
> > +    /// Enable runtime PM
> > +    pub fn enable(&self, state: RuntimePMState) -> Result {
> > +        if self.inner.enabled.cmpxchg(false, true, ordering::Full).is_err() {
> > +            return Err(EBUSY);
> > +        }
> > +        Self::apply_config(self.inner.dev, &self.inner.configs);
> > +        match state {
> > +            RuntimePMState::RESUMED => Request::mark_active(self.inner.dev),
> > +            RuntimePMState::SUSPENDED => Request::mark_suspended(self.inner.dev),
> > +            _ => Err(EINVAL),
> > +        }.inspect_err(|_| self.inner.enabled.store(false, ordering::Release))?;
> 
> This always applies the config even if state is invalid. Should we
> validate the state before making changes?
We could but that should not be strictly necessary.
Those should not have any effect when rpm is not enabled.
> 
> > +    /// Runs a closure while holding an `AwakeScope`.
> > +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Result<R>) -> Result<R> {
> > +        if profile.0.contains(ModeFlag::Async) {
> > +            return Err(EINVAL);
> > +        }
> > +        let _scope = self.get(profile)?;
> > +        f()
> > +    }
> 
> Shouldn't this reject NoWait too to make sure the device will actually
> be powered when the closure is executed?
We should. Thanks for catching this.

Thank you for your feedback.\

---
BR
Beata
> 
> Sami
