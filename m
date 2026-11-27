Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810160;
	b=pdOe5Yf1oxjmGra3EJfdABbkkskqDBTwe2k1BxIqYgx4uPivJyCrGxSZYuxAYu9Ol6aK
	 yXXg3thDDhx510RBemBftAoTiwjxGv4mAV1QsJ+c63bEoSF2aNr7S466NiBM3rWsD5yY8
	 crlViITHBcJjqWYSyL7Wt95tpyW2dEL3i352hkdGwvxVdn4VR4iMwnUIX06xhlAUzb2mF
	 2bLk7mODsQ97K+u7HW5+1nS0e/LqN847uptGV/llHYvQAuUiCK83uLcdoYgnfgtCE2R4F
	 VTq2V9v+mR+kp2gIIyVtNdVDyRc+ArKIzLJrgE5RPUg2kX3rdhI2nGUId+e3h/7vh/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810160;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z0EfvXL2FGgN05cprT1rMjUIbQBaHBQRXmqEwN9TzeQ=;
	b=hYSd1TsfQv4ggGBz2gKWhdWv8JKWws9kMAZXLrbKrdelE5S7h5vo1vR9kIT1AWOnpBqR
	 o9gJIX/TVo1/BFozDThV8NzTuznRdFw2EN0lWMpz+6wSWpSOheoG0G4KIZiriH5TzD9Sy
	 W6C94BBxSvW0UfcPTLF8ens2IbJAWnuh7LqrURxyBuYSjkNDztcnQnady20g+wOXtsrKm
	 fQbljYX7aVZAIOMuHqFQ/5X+bod6yNENjYAygpVwa0by4scXHbqOaUXJgdEwtUPA8e7YE
	 ATaM9sHpB9btd2uMNGbHAqmy07FssHfp5MyDDtWYoGjBBr3v6Qd+UYvQcjwN6c4qePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956F606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 20:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C81F008A0
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810149;
	bh=z0EfvXL2FGgN05cprT1rMjUIbQBaHBQRXmqEwN9TzeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iZ+0w98fEcnQxNIyL/R4d/2Q79A5g0OX4fPJdFsmEYlFhyXYjrxSkiylIX4HkyK/w
	 ZSAWTzgIjMB1dwZOL+nmvS5S5ME+e/BLtivA0QKvOWV8AU/RwBE04oIcWtZosTSCdE
	 FQ3DtdFmNmT/KTiLS15MkwgLXCnGQBzMdoUtUhyuFcRPxnJC1aGUjxXW/CeY9NHhPF
	 zw5SX5NeFdGiNPUA2qlJv3hWjMbnzAat2W2QdRe5/ojJMEo2+t0UxPOF1V9oABilhq
	 si+blzx8hP+9aayp5qMvrGLxotKNc+DqA/F6HIyZ+SfxGsEkJO9RSmvq/QaHo2lOCC
	 ZF5NwZjjg0CZQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3afa1c39cbdso30888511fa.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:09:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF3wvJK4Jd+CGMawkH/MwBosklLrOQR7qXvzBsPmxA4cHV8t+eil0jFM9O2DU32cy8QAcogFFnfNQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cqla3aCDswqSOp473k+m6/pe/CXHKP3yX7yLTZIJRgBlCjPH9
	vlTpEs1LUKX2xkoIxzUvWZStp8/Dq4XcaWB6PVU6Tu4F6uth1rEgL5wVPv80oWF1ciBKeBcZT3Z
	j5+lVjOxfu7reeEyZ1WUbNRZBayot3lA=
X-Received: by 2002:a05:6512:1042:b0:5bf:d6a4:a133 with SMTP id
 2adb3069b0e04-5c1bc680388mr7902173e87.3.1795810146991; Fri, 27 Nov 2026
 12:09:06 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124113555.2480381-1-beata.michalska@arm.com> <20261124113555.2480381-2-beata.michalska@arm.com>
In-Reply-To: <20261124113555.2480381-2-beata.michalska@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 21:08:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gBRi2HFuKhmBx+tqcsuuN91M-e6rrttaGt9-hWzWvSiA@mail.gmail.com>
X-Gm-Features: Aa3M54q-qPMBQOF-8I8OWfKzwJhjRni5-2SxN4FvpsKtxxpG3gaLqiUYOKAFjhk
Message-ID: <CAJZ5v0gBRi2HFuKhmBx+tqcsuuN91M-e6rrttaGt9-hWzWvSiA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rust: add runtime PM support
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, aliceryhl@google.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	acourbot@nvidia.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 12:36=E2=80=AFPM Beata Michalska
<beata.michalska@arm.com> wrote:
>
> Add a Rust abstraction for Linux runtime PM, allowing Rust drivers to
> register runtime PM callbacks and use scoped runtime PM requests while
> retaining the behavior and guarantees of the underlying C PM core.

I need to understand what happens here, but unfortunately my general
experience with Rust is quite limited (let alone Rust in the kernel).

> Runtime PM is managed through a registration object tied to the device
> lifetime. The registration stores the callback payload and 'ensures'

What is the callback payload?

> that the registration, its `PMContext`, and the payload do not outlive
> the device. All that while `PMContext` holds a lifetime-annotated
> device reference so that runtime PM requests are made only while
> the device remains bound.

So the "do not outlive the device" part is not super-precise I think.
They actually cannot outlive driver unbinding, can they?

> Drivers define runtime PM callbacks through the `PMOps` trait. The
> generated `dev_pm_ops` callbacks take the stored payload, pass
> ownership to the corresponding Rust callback, and store the returned
> payload for the next invocation. Each callback must return a valid
> payload, regardless of whether the power transition succeeds or not.
>
> `PMContext` provides scoped helpers for common runtime PM operations:
>
> - `ResumeScope` resumes the device for the lifetime of the scope.
> - `AwakeScope`  resumes the device and holds a runtime PM usage
>                 reference.
> - `RetainScope` increments the runtime PM usage count without
>                 resuming the device.
>
> Each scope performs the corresponding inverse operation when dropped,
> according to the selected driver-defined profile.

So `AwakeScope` and `RetainScope` are kind of similar to the
pm_runtime_active and pm_runtime_noresume guards in C, if I understand
this correctly.

I'm not sure why `ResumeScope` is needed though, especially for
autosuspending devices.

> The abstraction does not change the semantics of the C runtime PM API.
> Asynchronous requests may only queue work, non-waiting requests may
> fail instead of sleeping, and callbacks remain subject to the existing
> driver core rules.

So it would be good to say something about how the above are supposed
to be used.

> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/base/base.h             |    6 +
>  rust/bindings/bindings_helper.h |    1 +
>  rust/helpers/helpers.c          |    1 +
>  rust/helpers/pm_runtime.c       |  101 +++
>  rust/kernel/device.rs           |    1 +
>  rust/kernel/device/pm.rs        | 1187 +++++++++++++++++++++++++++++++
>  6 files changed, 1297 insertions(+)
>  create mode 100644 rust/helpers/pm_runtime.c
>  create mode 100644 rust/kernel/device/pm.rs
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 866b2beb6baa..bc91d873318f 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -105,6 +105,7 @@ struct driver_private {
>   *                        dev_err_probe() for later retrieval via debugf=
s
>   * @device: pointer back to the struct device that this structure is
>   *         associated with.
> + * @rust_private: private data used exclusively by the Rust driver core
>   * @dead: This device is currently either in the process of or has been
>   *       removed from the system. Any asynchronous events scheduled for =
this
>   *       device should exit without taking any action.
> @@ -121,6 +122,11 @@ struct device_private {
>         const struct device_driver *async_driver;
>         char *deferred_probe_reason;
>         struct device *device;
> +#ifdef CONFIG_RUST
> +       struct {
> +               void *pm_registration_data;
> +       }rust;

This doesn't match the "rust_private" documented above (and a space
seems to be missing).

> +#endif
>         u8 dead:1;
>  };
>  #define to_device_private_parent(obj)  \
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3791af0aadc7..a630213039d9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -79,6 +79,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/poll.h>
>  #include <linux/property.h>
>  #include <linux/pwm.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index d62c7be1ca7b..2cfd0ee83ac1 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -83,6 +83,7 @@
>  #include "pci.c"
>  #include "pid_namespace.c"
>  #include "platform.c"
> +#include "pm_runtime.c"
>  #include "poll.c"
>  #include "processor.c"
>  #include "property.c"
> diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
> new file mode 100644
> index 000000000000..890cdc8d5c90
> --- /dev/null
> +++ b/rust/helpers/pm_runtime.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/pm_runtime.h>
> +
> +__rust_helper
> +void rust_helper_pm_runtime_get_noresume(struct device *dev)
> +{
> +       pm_runtime_get_noresume(dev);
> +}
> +
> +__rust_helper
> +void rust_helper_pm_runtime_put_noidle(struct device *dev)
> +{
> +       pm_runtime_put_noidle(dev);
> +}
> +
> +__rust_helper
> +void rust_helper_pm_runtime_mark_last_busy(struct device *dev)
> +{
> +       pm_runtime_mark_last_busy(dev);
> +}
> +
> +__rust_helper
> +bool rust_helper_pm_runtime_active(struct device *dev)
> +{
> +       return pm_runtime_active(dev);
> +}
> +
> +__rust_helper
> +bool rust_helper_pm_runtime_suspended(struct device *dev)
> +{
> +       return pm_runtime_suspended(dev);
> +}
> +
> +__rust_helper
> +void rust_helper_pm_suspend_ignore_children(struct device *dev, bool ena=
ble)
> +{
> +       pm_suspend_ignore_children(dev, enable);
> +}
> +
> +__rust_helper
> +int rust_helper_pm_runtime_set_active(struct device *dev)
> +{
> +       return pm_runtime_set_active(dev);
> +}
> +
> +__rust_helper
> +int rust_helper_pm_runtime_set_suspended(struct device *dev)
> +{
> +       return pm_runtime_set_suspended(dev);
> +}
> +
> +__rust_helper
> +bool rust_helper_pm_runtime_enabled(struct device *dev)
> +{
> +       return pm_runtime_enabled(dev);
> +}
> +
> +__rust_helper
> +bool rust_helper_pm_runtime_is_irq_safe(struct device *dev)
> +{
> +       return pm_runtime_is_irq_safe(dev);
> +}
> +
> +#ifndef CONFIG_PM
> +__rust_helper
> +int rust_helper___pm_runtime_resume(struct device *dev, int rpmflags)
> +{
> +       return __pm_runtime_resume(dev, rpmflags);
> +}
> +
> +__rust_helper
> +int rust_helper___pm_runtime_idle(struct device *dev, int rpmflags)
> +{
> +       return __pm_runtime_idle(dev, rpmflags);
> +}
> +
> +__rust_helper
> +int rust_helper___pm_runtime_suspend(struct device *dev, int rpmflags)
> +{
> +       return __pm_runtime_suspend(dev, rpmflags);
> +}
> +
> +__rust_helper
> +int rust_helper_pm_runtime_get_if_active(struct device *dev)
> +{
> +       return pm_runtime_get_if_active(dev);
> +}
> +
> +__rust_helper void rust_helper_pm_runtime_enable(struct device *dev) {}
> +__rust_helper void rust_helper___pm_runtime_disable(struct device *dev, =
bool c) {}
> +__rust_helper void rust_helper_pm_runtime_barrier(struct device *dev) {}
> +__rust_helper void rust_helper_pm_runtime_no_callbacks(struct device *de=
v) {}
> +__rust_helper void rust_helper_pm_runtime_irq_safe(struct device *dev) {=
}
> +__rust_helper
> +void rust_helper___pm_runtime_use_autosuspend(struct device *dev, bool u=
se)
> +{}
> +__rust_helper
> +void rust_helper_pm_runtime_set_autosuspend_delay(struct device *dev, in=
t delay)
> +{}

How do these empty __rust_helper functions work?  Or what are they for
(if that is a better question)?

> +#endif /* CONFIG_PM */
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849..7edcc6941deb 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -19,6 +19,7 @@
>      ptr, //
>  };
>
> +pub mod pm;
>  pub mod property;
>
>  /// The core representation of a device in the kernel's driver model.
> diff --git a/rust/kernel/device/pm.rs b/rust/kernel/device/pm.rs
> new file mode 100644
> index 000000000000..9abf5efe48fe
> --- /dev/null
> +++ b/rust/kernel/device/pm.rs
> @@ -0,0 +1,1187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust Runtime Power Management abstraction.
> +//!
> +//! C header: [`include/linux/pm_runtime.h`](srctree/include/linux/pm_ru=
ntime.h)
> +
> +use crate::{
> +    bindings,
> +    bits::bit_u32,
> +    device::{
> +        Device,
> +        Bound,
> +        Core,
> +        AsBusDevice, //
> +    },
> +    driver,
> +    error::{
> +        to_result,
> +        VTABLE_DEFAULT_ERROR, //
> +    },
> +    prelude::*,
> +    sync::atomic::{
> +        ordering,
> +        Atomic,
> +        AtomicFlag,
> +        AtomicType, //
> +    },
> +    sync::Srcu,
> +    sync::srcu::new_srcu, //
> +};
> +
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::ManuallyDrop,
> +    ptr::NonNull, //
> +};
> +
> +kernel::impl_flags! {
> +    /// Runtime Power Management modes that determine how a particular P=
M
> +    /// transition is to be carried out.
> +    /// Corresponds to C Runtime PM flag argument bits:
> +    /// - `RPM_ASYNC`
> +    /// - `RPM_NOWAIT`
> +    /// - `RPM_GET_PUT`
> +    /// - `RPM_AUTO`

Why do you need these flags at the Rust level?  The API users are not
supposed to pass them directly.

> +    /// Synchronous mode is represented as `Mode::empty()`,
> +    /// which is the default mode.
> +    #[derive(Clone, Copy, PartialEq, Eq, Default, Debug)]
> +    pub struct Mode(u32);
> +
> +    /// Single RPM mode
> +    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
> +    pub enum ModeFlag {
> +        /// Allow asynchronous PM operations.
> +        Async =3D bindings::RPM_ASYNC,
> +        /// Do not wait for any pending requests to finish.
> +        Nowait =3D bindings::RPM_NOWAIT,
> +        /// Acquire a runtime-PM usage reference.
> +        Acquire =3D bindings::RPM_GET_PUT,
> +        /// Use autosuspend.
> +        Auto =3D bindings::RPM_AUTO,
> +        /// Additional mode for devices supporting idle states.

What do you mean by "supporting idle states"?

> +        /// No counterpart.
> +        Idle =3D bit_u32(16),
> +    }
> +}
> +
> +impl From<Mode> for c_int {
> +    #[inline]
> +    fn from(mode: Mode) -> c_int {
> +        mode.0 as c_int
> +    }
> +}

Well, you need to tell me what the above means and does.

> +
> +/// Device's runtime power management status
> +#[derive(Copy,Clone)]
> +#[repr(i32)]
> +pub enum RuntimePMState {
> +    /// The device is expected to be runtime active and in its normal op=
erating state
> +    Active =3D bindings::rpm_status_RPM_ACTIVE,
> +    /// The device is expected to be suspended, unavailable for normal o=
perations
> +    Suspended =3D bindings::rpm_status_RPM_SUSPENDED,
> +}
> +
> +/// Device's scoped runtime-resumed state
> +pub struct Scope<'a, Tag> {
> +    dev: &'a Device<Bound>,
> +    mode: Mode,
> +    _tag: PhantomData<Tag>,
> +}

And same here.

> +
> +/// Device resumed without incrementing the device's usage count
> +struct Resume;
> +/// Device resumed with the device's usage count being incremented
> +struct Awake;
> +/// Device with increased usage reference count
> +struct Retain;
> +
> +/// Resumes the device without acquiring the usage reference.
> +/// Note: This does not guarantee the device will be kept active
> +/// for the lifetime of the scope due to potential pending/incoming
> +/// suspend requests.
> +/// Successfully obtaining the scope guard does not guarantee the device
> +/// has been resumed: subject to the requested mode:
> +/// `ModeFlag::Async` and `ModeFlag::Nowait`

RPM_NOWAIT is strictly internal, it should not be used outside
drivers/base/power/runtime.c.

> +///
> +/// On drop:
> +/// - If `ModeFlag::Idle`, calls `__pm_runtime_idle()`:
> +///   triggers idle notification before attempting to suspend
> +/// - If `ModeFlag::Auto`, marks last busy then calls `__pm_runtime_susp=
end()`.
> +/// - Otherwise calls `__pm_runtime_suspend()`.

First, why do you need to refer to the __pm_runtime_*() functions at
all?  There are wrappers around them defined already, what would be
wrong with using them?

Second, I'd recommend using pm_runtime_put() always unless you want to
bypass the autosuspend delay, in which case you can use
pm_runtime_put_sync_suspend() (with no async variant), especially
after very recent runtime PM core changes:

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dlinux-next&id=3D26236a3e8803f7e1ace104020d7f006edb220116
https://lore.kernel.org/linux-pm/4779892.LvFx2qVVIh@rafael.j.wysocki/

With the `ResumeScope` thing you can use pm_request_idle() most of the
time and pm_runtime_suspend() if you want to bypass the autosuspend
delay (but I'm still kind of unsure why you need that).

> +///
> +/// The guard must be dropped from a context matching the requested tran=
sition
> +/// mode: sync vs async.
> +#[must_use =3D "dropping this guard issues the matching runtime PM relea=
se request"]
> +pub struct ResumeScope<'a>(Scope<'a, Resume>);

Do I remember correctly that this defines a struct type based on Scope
and with the lifetime of 'a?

> +
> +/// Acquires a runtime-PM usage reference and keeps the device powered.
> +/// Successfully obtaining the scope guard does not guarantee the device
> +/// has been resumed: subject to the requested mode:
> +/// `ModeFlag::Async` and `ModeFlag::Nowait`.
> +///
> +/// Requires `ModeFlag::Acquire`.
> +/// Drop behavior matches `ResumeScope`.
> +///
> +/// The guard must be dropped from a context matching the requested tran=
sition
> +/// mode: sync vs async.
> +#[must_use =3D "dropping this guard releases its runtime PM hold"]
> +pub struct AwakeScope<'a>(Scope<'a, Awake>);
> +
> +/// Prevents the device from getting suspended by holding the usage refe=
rence
> +/// count.
> +///
> +/// On drop, calls `pm_runtime_put_noidle()`.
> +#[must_use =3D "dropping this guard releases its runtime PM hold"]
> +pub struct RetainScope<'a>(Scope<'a, Retain>);
> +
> +impl<'a> ResumeScope<'a> {
> +    fn new(dev: &'a Device<Bound>, mode: Mode) -> Result<Self> {
> +        if mode.contains(ModeFlag::Acquire) {
> +            // ModeFlag::Acquire is intended to be used with Awake scope
> +            // Avoid mixing the modes.
> +            return Err(EINVAL);
> +        }
> +
> +        // ModeFlag::Idle is internal so strip it off before passing fur=
ther
> +        match Request::resume(dev, mode & !ModeFlag::Idle) {
> +            Ok(()) =3D> {}
> +            //  if ModeFlag::Async is set, -EINPROGRESS signals ongoing =
resume,
> +            //  with ModeFlag::Nowait -> ongoing suspend with delayed re=
sume
> +            //  being queued
> +            Err(e) if e =3D=3D EINPROGRESS && mode.contains_any(ModeFlag=
::Async| ModeFlag::Nowait) =3D> {}
> +            Err(e) =3D> return Err(e),
> +        }
> +
> +        Ok(Self(Scope::<Resume> {
> +                dev,
> +                mode,
> +                _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn release_inner(&self) -> Result {
> +        if !cfg!(CONFIG_PM) {
> +            return Ok(())
> +        }
> +
> +        let mode =3D self.0.mode;
> +        let scope_mode =3D mode & !ModeFlag::Idle;
> +
> +        if mode.contains(ModeFlag::Auto) {
> +            Request::mark_last_busy(self.0.dev);

This may not be necessary after the core changes mentioned above.

> +        }
> +
> +        match self.0.mode {
> +            mode if mode.contains(ModeFlag::Idle) =3D> Request::idle(sel=
f.0.dev, scope_mode),
> +            _ =3D> Request::suspend(self.0.dev, scope_mode),
> +        }
> +    }
> +
> +    /// Explicitly release the scope
> +    ///
> +    /// This should be used in favor of regular drop when error handling=
 is
> +    /// required.
> +    pub fn release(self) -> Result {
> +        let result =3D self.release_inner();
> +        core::mem::forget(self);
> +        result
> +    }
> +}
> +
> +impl<'a> Drop for ResumeScope<'a> {
> +    fn drop(&mut self) {
> +        let _ =3D self.release_inner();
> +    }
> +}
> +
> +impl<'a> AwakeScope<'a> {
> +    fn new(dev: &'a Device<Bound>, mode: Mode) -> Result<Self> {
> +        if !mode.contains(ModeFlag::Acquire) {
> +            return Err(EINVAL);
> +        }
> +        // ModeFlag::Idle is internal so strip it off before passing fur=
ther
> +        match Request::resume(dev, mode & !ModeFlag::Idle) {
> +            Ok(()) =3D> {}
> +            // For async/nowait requests, `EINPROGRESS` means the resume=
 is
> +            // either in flight or pending.
> +            Err(e) if e =3D=3D EINPROGRESS && mode.contains_any(ModeFlag=
::Async | ModeFlag::Nowait) =3D> {}
> +            Err(e) =3D> {
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
> +        if !cfg!(CONFIG_PM) {
> +            return Ok(())
> +        }
> +
> +        let mode =3D self.0.mode;
> +        let scope_mode =3D mode & !ModeFlag::Idle;
> +
> +        if mode.contains(ModeFlag::Auto) {
> +            Request::mark_last_busy(self.0.dev);
> +        }
> +
> +        match self.0.mode {
> +            mode if mode.contains(ModeFlag::Idle) =3D> Request::idle(sel=
f.0.dev, scope_mode),
> +            _ =3D> Request::suspend(self.0.dev, scope_mode),
> +        }
> +    }
> +
> +    /// Explicitly release the scope
> +    ///
> +    /// This should be used in favor of regular drop when error handling=
 is
> +    /// required.
> +    pub fn release(self) -> Result {
> +        let result =3D self.release_inner();
> +        core::mem::forget(self);
> +        result
> +    }
> +}
> +
> +impl<'a> Drop for AwakeScope<'a> {
> +    fn drop(&mut self) {
> +        let _ =3D self.release_inner();
> +    }
> +}
> +
> +impl<'a> RetainScope<'a> {
> +    fn new(dev: &'a Device<Bound>) -> Result<Self> {
> +        Request::get_noresume(dev);
> +        Ok(Self(Scope::<Retain> {
> +            dev,
> +            mode: Mode::empty(),
> +            _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn try_new(dev: &'a Device<Bound>) -> Result<Self> {
> +        Request::get_if_active(dev)?;
> +        Ok(Self(Scope::<Retain> {
> +            dev,
> +            mode: Mode(u32::from(Mode::empty())),
> +            _tag: PhantomData,
> +        }))
> +    }
> +
> +    fn release_inner(&self) {
> +        Request::put_noidle(self.0.dev);
> +    }
> +
> +    /// Explicitly release the scope
> +    ///
> +    /// This should be used in favor of regular drop when error handling=
 is
> +    /// required.
> +    pub fn release(self) -> Result {
> +        self.release_inner();
> +        core::mem::forget(self);
> +        Ok(())
> +    }
> +}
> +
> +impl<'a> Drop for RetainScope<'a> {
> +    fn drop(&mut self) {
> +        self.release_inner();
> +    }
> +}
> +
> +/// Private entry points to the C runtime PM API.
> +///
> +/// Provides a centralized location for both, the C calls themsleves,
> +/// as well as for their safety requirements.
> +///
> +/// # Safety
> +///
> +/// Each method takes `&Device<Bound>`. `Device` guarantees that `as_raw=
()`
> +/// points to a valid `struct device` during the call. `Bound` guarantee=
s that
> +/// the driver remains attached while the PM core may invoke callbacks u=
sing
> +/// driver-owned data. For requests completed later, [`Registration`] ke=
eps
> +/// callback data alive and drains pending callbacks before dropping it.
> +struct Request;
> +
> +impl Request {
> +    #[inline]
> +    fn active(dev: &Device<Bound>) -> bool {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::pm_runtime_active(dev.as_raw()) }
> +    }
> +
> +    #[inline]
> +    fn suspended(dev: &Device<Bound>) -> bool {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::pm_runtime_suspended(dev.as_raw()) }
> +    }
> +
> +    #[inline]
> +    fn resume(dev: &Device<Bound>, mode: Mode) -> Result {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        to_result(unsafe { bindings::__pm_runtime_resume(dev.as_raw(), m=
ode.into()) })
> +    }
> +
> +    #[inline]
> +    fn suspend(dev: &Device<Bound>, mode: Mode) -> Result {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        to_result(unsafe { bindings::__pm_runtime_suspend(dev.as_raw(), =
mode.into()) })
> +    }
> +
> +    #[inline]
> +    fn get_noresume(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::pm_runtime_get_noresume(dev.as_raw()) };
> +    }
> +
> +    #[inline]
> +    fn get_if_active(dev: &Device<Bound>) -> Result {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        match unsafe { bindings::pm_runtime_get_if_active(dev.as_raw()) =
} {
> +            ret if ret < 0 =3D> Err(Error::from_errno(ret)),
> +            0 =3D> Err(EAGAIN),
> +            _ =3D> Ok(()),
> +        }
> +    }
> +
> +    #[inline]
> +    fn idle(dev: &Device<Bound>, mode: Mode) -> Result {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        to_result(unsafe { bindings::__pm_runtime_idle(dev.as_raw(), mod=
e.into()) })
> +    }
> +
> +    #[inline]
> +    fn put_noidle(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::pm_runtime_put_noidle(dev.as_raw()) };
> +    }
> +
> +    #[inline]
> +    fn mark_active(dev: &Device<Bound>) -> Result {
> +        to_result(
> +            // SAFETY: `dev` satisfies safety requirements documented on=
 `Request`.
> +            unsafe { bindings::pm_runtime_set_active(dev.as_raw()) },
> +        )
> +    }
> +
> +    #[inline]
> +    fn mark_suspended(dev: &Device<Bound>) -> Result {
> +        to_result(
> +            // SAFETY: `dev` satisfies safety requirements documented on=
 `Request`.
> +            unsafe { bindings::pm_runtime_set_suspended(dev.as_raw()) },
> +        )
> +    }
> +
> +    #[inline]
> +    fn mark_last_busy(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe {
> +            bindings::pm_runtime_mark_last_busy(dev.as_raw());
> +        }
> +    }
> +
> +    #[inline]
> +    fn runtime_enable(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::pm_runtime_enable(dev.as_raw()) }
> +    }
> +
> +    #[inline]
> +    fn runtime_disable(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe { bindings::__pm_runtime_disable(dev.as_raw(), true) };
> +    }
> +
> +    #[inline]
> +    fn barrier(dev: &Device<Bound>) {
> +        // SAFETY: `dev` satisfies safety requirements documented on `Re=
quest`.
> +        unsafe {
> +            bindings::pm_runtime_barrier(dev.as_raw());
> +        }
> +    }
> +}
> +

I think I know what's going on above this point (except for the places
where I said I needed help), but the part below escapes me, more or
less.

Which is unfortunate because I need to understand it so I can tell you
whether or not it all makes sense IMV.

So how can we get there?  I'm not sure.

> +/// Common runtime PM callback entry point.
> +///
> +/// Invokes a runtime PM callback with its registration data and current=
 payload.
> +///
> +/// # Safety
> +///
> +/// The generated extern "C" callbacks call into this helper with the ra=
w
> +/// `struct device *` provided by the PM core. As such, it is guaranteed=
 that
> +/// the `struct device` remains valid throughout the calls.
> +#[cfg(CONFIG_PM)]
> +unsafe fn with_registration_data<T, F>(dev: *mut bindings::device, cb: F=
) -> Result
> +where
> +    T: PMOps,
> +    F: for <'a>FnOnce(
> +        &'a <T as PMOps>::DeviceType,
> +        &'a <T as PMOps>::RegistrationData<'a>,
> +        RuntimeStatePayload<T::ActivePayload<'a>, T::SuspendedPayload<'a=
>>
> +     ) -> PMCallbackResult<RuntimeStatePayload<T::ActivePayload<'a>, T::=
SuspendedPayload<'a>>,
> +                           RuntimeStatePayload<T::ActivePayload<'a>, T::=
SuspendedPayload<'a>>>,
> +{
> +    // SAFETY: `dev` is provided by the PM core and remains valid
> +    // for the duration of the callback.
> +    let dev: &Device =3D unsafe { Device::from_raw(dev) };
> +    // SAFETY: The runtime PM callback can only be triggered for a bound=
 device.
> +    let dev: &Device<Bound> =3D  unsafe { dev.as_bound() };
> +    let pm_dev: &T::DeviceType =3D
> +        // SAFETY: The generated `dev_pm_ops` for `T` is installed on de=
vices whose
> +        // bus-specific type is `T::DeviceType`. Therefore the base `Dev=
ice<Bound>`
> +        // passed by the PM core is embedded in a valid `T::DeviceType`;=
 the
> +        // `AsBusDevice` implementation supplies the correct offset for =
this cast.
> +        unsafe { T::DeviceType::from_device(dev) };
> +    // SAFETY:  The `RegistrationData` must have been successfully insta=
lled
> +    // for a device and it is guaranteed that it reamins valid at least =
until
> +    // the last PM callback finishes.
> +    let ptr =3D unsafe { (*(*dev.as_raw()).p).rust.pm_registration_data =
};
> +    // SAFETY: `Registration::new` stores a pointer to its initialized, =
pinned
> +    // `RegistrationData<T>` before enabling runtime PM. These callbacks
> +    // belong to the same `T`. Registration teardown disables runtime PM=
 and
> +    // drains callbacks before clearing the pointer and dropping the dat=
a, so
> +    // it remains valid for this callback
> +    let reg_data =3D unsafe { &*ptr.cast::<RegistrationData<'_, T>>() };
> +
> +    let _guard =3D reg_data.payload.acquire()?;
> +    // SAFETY: This callback alone acquired `in_flight`; it has exclusiv=
e
> +    // access to the payload slot until `_guard` is dropped.
> +    let slot =3D unsafe { &mut *reg_data.payload.inner.get() };
> +    // SAFETY: `_guard` gives this callback exclusive access to `slot`, =
which
> +    // contains an initialized payload. Both callback outcomes provide a=
 payload
> +    // that is written back into `slot` before `_guard` is released.
> +    let payload =3D unsafe { ManuallyDrop::take(slot) };
> +
> +    let (next, result) =3D match cb(pm_dev, &reg_data.data, payload) {
> +                Ok(next) =3D> (next, Ok(())),
> +                Err((current, err)) =3D> (current, Err(err)),
> +    };
> +
> +    *slot =3D ManuallyDrop::new(next);
> +    result
> +}
> +
> +/// Runtime resume PM callback.
> +///
> +/// # Safety
> +///
> +/// `dev` is a valid `struct device *` supplied by the PM core for a dev=
ice
> +/// whose runtime PM callbacks and PM registration data were both create=
d
> +/// for `T`.
> +#[cfg(CONFIG_PM)]
> +unsafe extern "C" fn runtime_resume_callback<T>(dev: *mut bindings::devi=
ce) -> c_int
> +where
> +    T: PMOps,
> +{
> +    // SAFETY: The callback's safety contract guarantees that `dev` rema=
ins
> +    // valid for this call and has PM registration data created for `T`.
> +    // These are the preconditions of `with_registration_data`.
> +    unsafe {
> +        with_registration_data::<T, _>(dev,
> +            |pm_dev, data, payload| {
> +                match payload {
> +                    RuntimeStatePayload::Suspended(payload_data) =3D> {
> +                        T::runtime_resume(pm_dev, data, payload_data)
> +                            .map(RuntimeStatePayload::Active)
> +                            .map_err(|(prev, err)| (RuntimeStatePayload:=
:Suspended(prev), err))
> +                    },
> +                    other =3D> Err((other, EINVAL)),
> +                }
> +        })
> +        .map(|()| 0)
> +        .unwrap_or_else(|e| e.to_errno())
> +    }
> +}
> +/// Runtime suspend PM callback.
> +///
> +/// # Safety
> +///
> +/// `dev` is a valid `struct device *` supplied by the PM core for a dev=
ice
> +/// whose runtime PM callbacks and PM registration data were both create=
d
> +/// for `T`.
> +#[cfg(CONFIG_PM)]
> +unsafe extern "C" fn runtime_suspend_callback<T>(dev: *mut bindings::dev=
ice) -> c_int
> +where
> +    T: PMOps,
> +{
> +    // SAFETY: The callback's safety contract guarantees that `dev` rema=
ins
> +    // valid for this call and has PM registration data created for `T`.
> +    // These are the preconditions of `with_registration_data`.
> +    unsafe {
> +        with_registration_data::<T, _>(dev,
> +            |pm_dev, data, payload| {
> +                match payload {
> +                    RuntimeStatePayload::Active(payload_data) =3D> {
> +                        T::runtime_suspend(pm_dev, data, payload_data)
> +                            .map(RuntimeStatePayload::Suspended)
> +                            .map_err(|(prev, err)| (RuntimeStatePayload:=
:Active(prev), err))
> +                    },
> +                    other =3D> Err((other, EINVAL)),
> +                }
> +        })
> +        .map(|()| 0)
> +        .unwrap_or_else(|e| e.to_errno())
> +    }
> +}
> +
> +/// Default empty Runtime PM ops
> +pub const PMOPS_NONE: bindings::dev_pm_ops =3D
> +    // SAFETY:
> +    // bindings::dev_pm_ops is #[repr(C)], implements Default
> +    // and the struct itself is all nullable function pointers.
> +    // There is no padding and all zero bit-pattern is valid
> +    //
> +    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().as=
sume_init() };
> +
> +/// Typed reference to a driver's runtime PM ops.
> +///
> +/// Instances of this type are generated from static [`Ops`]
> +/// and are used by bus registration code to install the matching
> +/// C `dev_pm_ops` pointer into the driver object.
> +/// The `A` parameter identifies the bus adapter that is allowed
> +/// to install the table.
> +pub struct AdapterOpsRef<'a, A> {
> +    #[cfg_attr(not(CONFIG_PM), allow(unused))]
> +    ops: &'a bindings::dev_pm_ops,
> +    _p: PhantomData<fn() -> *const A>,
> +}
> +
> +/// Conveniance type alias
> +pub type OpsRef<T> =3D AdapterOpsRef<'static, <T as PMOps>::Adapter>;
> +
> +// SAFETY: `AdapterOpsRef` only contains a shared reference to an immuta=
ble
> +// `dev_pm_ops` table and a type marker. Sharing it between threads cann=
ot
> +// introduce mutation or aliasing of Rust-owned state.
> +unsafe impl<A> Sync for AdapterOpsRef<'_, A> {}
> +
> +impl<A> AdapterOpsRef<'_, A> {
> +    #[cfg_attr(not(CONFIG_PM), allow(unused))]
> +    #[inline]
> +    pub(crate) const fn as_raw(&self) -> *const bindings::dev_pm_ops {
> +        self.ops
> +    }
> +}
> +
> +/// Runtime PM ops for a driver.
> +///
> +/// Intended to be constructed by bus-specific helpers, allowing
> +/// the bus to ensure that the callback device type matches the device
> +/// supplied by the C driver core.
> +pub struct Ops<T: PMOps> {
> +    raw: bindings::dev_pm_ops,
> +    _p: PhantomData<fn() -> T>,
> +}
> +
> +impl<T: PMOps> Ops<T> {
> +    /// Creates a typed runtime PM ops.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee that `T::Adapter` is the bus adapter t=
hat
> +    /// will install this ops into the C driver object for `T`, and
> +    /// that `T::DeviceType` is the bus device type corresponding to
> +    /// that adapter. Safe bus-specific constructors should wrap this
> +    /// function with those bounds.
> +    pub(crate) const unsafe fn new_unchecked(raw: bindings::dev_pm_ops) =
-> Self {
> +        const_assert!(
> +            T::HAS_RUNTIME_RESUME =3D=3D T::HAS_RUNTIME_SUSPEND,
> +            "runtime suspend and resume callbacks should be implemented =
together"
> +        );
> +        Self {
> +            raw,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Provides a typed reference to this runtime PM ops
> +    ///
> +    /// Bus registration code uses the returned value to install
> +    /// the ops into the corresponding C driver object.
> +    /// The returned reference is tied to `T::Adapter`.
> +    pub const fn pm_ops(&'static self) -> OpsRef<T> {
> +        AdapterOpsRef {
> +            ops: &self.raw,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the raw C runtime PM operations table.
> +    #[inline]
> +    pub const fn as_raw(&'static self) -> *const bindings::dev_pm_ops {
> +        &self.raw
> +    }
> +}
> +
> +/// Result type returned by runtime PM callbacks.
> +pub type PMCallbackResult<New, Current> =3D Result<New, (Current, Error)=
>;
> +
> +/// Runtime PM callbacks implemented by a driver.
> +///
> +/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm=
_ops`].
> +///
> +/// The Adapter associated type identifies the bus adapter that installs
> +/// the generated PM ops.
> +/// Implementations should normally be enabled through a
> +/// bus-specific constructor for [`Ops`], which constrains
> +/// [`Self::DeviceType`] to the correct bound device type for that bus.
> +#[vtable]
> +pub trait PMOps: Sized {
> +    /// The bus adapter that installs the generated PM ops.
> +    type Adapter: driver::DriverLayout + 'static;
> +
> +    /// Type of the bound bus device passed to runtime PM callbacks.
> +    type DeviceType: AsBusDevice<Bound>;
> +
> +    /// Data associated with the `Registration`, tied to its lifetime.
> +    type RegistrationData<'a>: Send + Sync + 'a;
> +
> +    /// Driver's specific data associated with suspended PM device state
> +    type SuspendedPayload<'a>: Send + 'a;
> +    /// Driver's specific data associated with active PM device states
> +    type ActivePayload<'a>: Send + 'a;
> +
> +    /// Runtime resume callback.
> +    fn runtime_resume<'a>(
> +        _dev: &'a Self::DeviceType,
> +        _reg_data: &'a Self::RegistrationData<'a>,
> +        _payload: Self::SuspendedPayload<'a>,
> +    ) -> PMCallbackResult<Self::ActivePayload<'a>, Self::SuspendedPayloa=
d<'a>> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Runtime suspend callback.
> +    fn runtime_suspend<'a>(
> +        _dev: &'a Self::DeviceType,
> +        _reg_data: &'a Self::RegistrationData<'a>,
> +        _payload: Self::ActivePayload<'a>,
> +    ) -> PMCallbackResult<Self::SuspendedPayload<'a>, Self::ActivePayloa=
d<'a>> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// RAII guard for ongoing runtime PM payload transition.
> +///
> +/// For most of the callbacks this guard is not necessarily needed as
> +/// the callbacks themselves are being serialized by the runtime PM C co=
de.
> +/// Still, some like runtime_idle are exempt from that.
> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
> +struct PayloadGuard<'a> {
> +    busy: &'a AtomicFlag,
> +}
> +
> +impl Drop for PayloadGuard<'_> {
> +    fn drop(&mut self) {
> +        self.busy.store(false, ordering::Release);
> +    }
> +}
> +
> +/// Payload associated with the given runtime power state of a device.
> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
> +pub enum RuntimeStatePayload<Active, Suspended> {
> +    /// Payload associated with the runtime active PM state of a device
> +    Active(Active),
> +    /// Payload associated with the runtime suspended PM state of a devi=
ce
> +    Suspended(Suspended),
> +}
> +
> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
> +struct Payload<'a, T:PMOps> {
> +    in_flight: AtomicFlag,
> +    inner: UnsafeCell<ManuallyDrop<RuntimeStatePayload<T::ActivePayload<=
'a>, T::SuspendedPayload<'a>>>>,
> +}
> +
> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
> +impl<'a, T:PMOps> Payload<'a, T> {
> +    /// Attempts to acquire exclusive access to the runtime PM payload.
> +    ///
> +    /// Returns `EBUSY` if another runtime PM callback is already transi=
tioning the
> +    /// payload.
> +    fn acquire(&self) -> Result<PayloadGuard<'_>> {
> +        self.in_flight
> +            .cmpxchg(false, true, ordering::Acquire)
> +            .map_err(|_| EBUSY)?;
> +        Ok(PayloadGuard {
> +            busy: &self.in_flight,
> +        })
> +    }
> +}
> +
> +impl<T:PMOps> Drop for Payload<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: teardown drained PM callbacks and the slot holds a `P=
`
> +        unsafe {
> +            ManuallyDrop::drop(self.inner.get_mut());
> +        }
> +    }
> +}
> +
> +// SAFETY: Although Payload's `inner` is an `UnsafeCell`, it is only acc=
essed
> +// after `in_flight` has been acquired. The AtomicFlag flag serializes a=
ll mutable
> +// access to the payload, and `PayloadGuard` clears the flag when the ac=
cess ends.
> +unsafe impl<T:PMOps> Sync for Payload<'_, T> {}
> +
> +#[derive(Clone, Copy, PartialEq, Eq)]
> +#[repr(i32)]
> +enum PMContextState {
> +    /// The PM registration is alive, but runtime PM has not been enable=
d.
> +    Disabled =3D 0,
> +    /// Enabling runtime PM has been initiated but has not completed jus=
t yet
> +    Enabling =3D 1,
> +    /// The runtime PM has been enabled. Intended to be balanced by
> +    /// `disable()` or `Registration::drop()`
> +    Enabled =3D 2,
> +    /// Disabling runtime PM has been initiated but has not completed ju=
st yet
> +    Disabling =3D 3,
> +    /// The owning `Registration` is being dropped or has been dropped.
> +    /// Stale cloned `PMContext`s may still exist, but once this state i=
s
> +    /// visible, runtime PM cannot be re-enabled.
> +    Closing =3D 4,
> +}
> +
> +// SAFETY: `PMContextState` has the same size and alignment as `i32`, an=
d all
> +// values written through `Atomic<PMContextState>` are valid `PMContextS=
tate`
> +// discriminants.
> +unsafe impl AtomicType for PMContextState {
> +    type Repr =3D i32;
> +}
> +
> +#[pin_data]
> +struct PMContextInner<'a, T: PMOps> {
> +    dev: &'a Device<Bound>,
> +    /// State owned by the runtime PM registration
> +    state: Atomic<PMContextState>,
> +    /// A synchronization point for all pending callbacks to finish.
> +    #[pin]
> +    guard: Srcu,
> +    /// Optional driver-selected runtime PM request PMProfiles.
> +    ///
> +    /// Set of runtime PM predefined PMProfiles that can be used by the =
driver
> +    /// when requesting a PM transition. This might be useful when a dri=
ver
> +    /// has several different PM usage patterns.
> +    /// See [PMProfile] for more details.
> +    profiles: KVec<PMProfile>,
> +    /// Set of PM config options applied for associated device.
> +    configs: KVec<PMConfig>,
> +    _marker: PhantomData<fn() -> T>,
> +}
> +
> +/// Runtime PM context tied to a device.
> +///
> +/// Needs to be dropped from sleepable context.
> +#[pin_data]
> +pub struct PMContext<'r, 'a, T: PMOps> {
> +    inner: &'r PMContextInner<'a, T>,
> +}
> +
> +impl<'r, 'a, T: PMOps> PMContext<'r, 'a, T> {
> +    /// Driver-provided runtime PM operations.
> +    ///
> +    /// A driver implements this trait to handle runtime PM
> +    /// transitions for its device type.
> +    ///
> +    /// Each callback receives the device, its registration data
> +    /// and the current payload.
> +    /// On success, it returns the payload to keep for the next
> +    /// transition. On failure, it returns the payload together
> +    /// with the error so the previous, or otherwise sane state
> +    /// can be preserved.
> +    #[cfg(CONFIG_PM)]
> +    pub(crate) const PM_OPS: bindings::dev_pm_ops =3D bindings::dev_pm_o=
ps {
> +        runtime_resume: if T::HAS_RUNTIME_RESUME {
> +            Some(runtime_resume_callback::<T>)
> +        } else {
> +            None
> +        },
> +        runtime_suspend: if T::HAS_RUNTIME_SUSPEND {
> +            Some(runtime_suspend_callback::<T>)
> +        } else {
> +            None
> +        },
> +        ..PMOPS_NONE
> +    };
> +
> +    #[cfg(not(CONFIG_PM))]
> +    pub(crate) const PM_OPS: bindings::dev_pm_ops =3D PMOPS_NONE;
> +
> +    #[inline]
> +    fn state_transition(&self, expected: PMContextState, new: PMContextS=
tate) -> Result
> +    {
> +        self.inner.state.cmpxchg(expected, new, ordering::Full)
> +        .map(|_| ())
> +        .map_err(|actual| match (expected, actual) {
> +            (_, PMContextState::Closing) =3D> ENODEV,
> +            (PMContextState::Disabled, PMContextState::Disabling)
> +            | (PMContextState::Enabled, PMContextState::Enabling) =3D> E=
BUSY,
> +            _ =3D> EINVAL,
> +        })
> +   }
> +
> +    /// Enable runtime PM
> +    pub fn enable(&self, state: RuntimePMState) -> Result {
> +        let _transition_guard =3D self.inner.guard.read_lock();
> +        self.state_transition(PMContextState::Disabled, PMContextState::=
Enabling)?;
> +        Self::apply_config(self.inner.dev, &self.inner.configs);
> +
> +        match state {
> +                RuntimePMState::Active =3D> Request::mark_active(self.in=
ner.dev),
> +                RuntimePMState::Suspended =3D> Request::mark_suspended(s=
elf.inner.dev),
> +        }
> +        .inspect_err(|_| {
> +            Self::reset_config(self.inner.dev, &self.inner.configs);
> +            let _ =3D self.state_transition(
> +                    PMContextState::Enabling,
> +                    PMContextState::Disabled,
> +                );
> +        })?;
> +
> +        Request::runtime_enable(self.inner.dev);
> +        self.state_transition(
> +                PMContextState::Enabling,
> +                PMContextState::Enabled,
> +        ).inspect_err(|e| {
> +            if *e =3D=3D ENODEV {
> +                Request::runtime_disable(self.inner.dev);
> +                Self::reset_config(self.inner.dev, &self.inner.configs);
> +            }
> +        })?;
> +        Ok(())
> +    }
> +
> +    /// Disable runtime PM
> +    pub fn disable(&self) -> Result {
> +        let _transition_guard =3D self.inner.guard.read_lock();
> +        self.state_transition(
> +                PMContextState::Enabled,
> +                PMContextState::Disabling,
> +        )?;
> +
> +        Request::runtime_disable(self.inner.dev);
> +        Self::reset_config(self.inner.dev, &self.inner.configs);
> +
> +        let _  =3D self.state_transition(
> +             PMContextState::Disabling,
> +             PMContextState::Disabled
> +        );
> +        Ok(())
> +    }
> +
> +    /// Returns whether the runtime PM state is active.
> +    #[inline]
> +    pub fn active(&self) -> bool {
> +        Request::active(self.inner.dev)
> +    }
> +
> +    /// Returns whether the runtime PM state is suspended.
> +    #[inline]
> +    pub fn suspended(&self) -> bool {
> +        Request::suspended(self.inner.dev)
> +    }
> +
> +    /// Creates a `ResumeScope` for the given PMProfile.
> +    /// Note that for ASYNC/NOWAIT request this does not guarantee
> +    /// the device has been resumed at the time this function returns.
> +    #[inline]
> +    pub fn resume(&self, profile: PMProfile) -> Result<ResumeScope<'r>> =
{
> +        ResumeScope::new(self.inner.dev, profile.0)
> +    }
> +
> +    /// Creates an `AwakeScope` for the given PMProfile.
> +    /// Note that for ASYNC/NOWAIT request this does not guarantee
> +    /// the device has been resumed at the time this function returns.
> +    #[inline]
> +    pub fn get(&self, profile: PMProfile) -> Result<AwakeScope<'r>> {
> +        AwakeScope::new(self.inner.dev, profile.0 | ModeFlag::Acquire)
> +    }
> +
> +    /// Creates a `RetainScope` for this device.
> +    pub fn hold(&self) -> Result<RetainScope<'r>> {
> +        RetainScope::new(self.inner.dev)
> +    }
> +
> +    /// Creates a `RetainScope` for an active device.
> +    pub fn try_hold_active(&self) -> Result<RetainScope<'r>> {
> +        RetainScope::try_new(self.inner.dev)
> +    }
> +
> +    /// Runs a closure while holding a `ResumeScope`.
> +    pub fn with_resume<R>(&self, profile: PMProfile, f: impl FnOnce() ->=
 Result<R>) -> Result<R> {
> +        if profile.0.contains_any(ModeFlag::Async| ModeFlag::Nowait) {
> +            return Err(EINVAL);
> +        }
> +        let _scope =3D self.resume(profile)?;
> +        f()
> +    }
> +    /// Runs a closure while holding an `AwakeScope`.
> +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> Re=
sult<R>) -> Result<R> {
> +        if profile.0.contains_any(ModeFlag::Async | ModeFlag::Nowait) {
> +            return Err(EINVAL);
> +        }
> +        let _scope =3D self.get(profile)?;
> +        f()
> +    }
> +
> +    /// Runs a closure while holding a `RetainScope`.
> +    pub fn with_hold<R>(&self, f: impl FnOnce() -> Result<R>) -> Result<=
R> {
> +        let _scope =3D self.hold()?;
> +        f()
> +    }
> +
> +    /// Applies runtime PM configuration options.
> +    ///
> +    /// Options are applied in the order provided. The currently support=
ed
> +    /// options do not report per-option failures.
> +    fn apply_config(dev: &Device<Bound>, opts: &[PMConfig]) {
> +        for opt in opts {
> +            match opt {
> +                // SAFETY: The `Device<Bound>` reference guarantees that=
 `dev.as_raw()`
> +                // yields a valid pointer to `struct device` for the dur=
ation of this call.
> +                PMConfig::IgnoreChildren(v) =3D> unsafe {
> +                    bindings::pm_suspend_ignore_children(dev.as_raw(), *=
v)
> +                },
> +                // SAFETY: The `Device<Bound>` reference guarantees that=
 `dev.as_raw()`
> +                // yields a valid pointer to `struct device` for the dur=
ation of this call.
> +                PMConfig::NoCallbacks =3D> unsafe { bindings::pm_runtime=
_no_callbacks(dev.as_raw()) },
> +                // SAFETY: The `Device<Bound>` reference guarantees that=
 `dev.as_raw()`
> +                // yields a valid pointer to `struct device` for the dur=
ation of this call.
> +                PMConfig::IrqSafe =3D> unsafe {
> +                    // Do not attempt to call that more than once
> +                    if !bindings::pm_runtime_is_irq_safe(dev.as_raw()) {
> +                        bindings::pm_runtime_irq_safe(dev.as_raw());
> +                    }
> +                },
> +                // SAFETY: The `Device<Bound>` reference guarantees that=
 `dev.as_raw()`
> +                // yields a valid pointer to `struct device` for the dur=
ation of this call.
> +                PMConfig::AutoSuspend(v) =3D> unsafe {
> +                    bindings::__pm_runtime_use_autosuspend(dev.as_raw(),=
 *v);
> +                },
> +                // SAFETY: The `Device<Bound>` reference guarantees that=
 `dev.as_raw()`
> +                // yields a valid pointer to `struct device` for the dur=
ation of this call.
> +                PMConfig::AutoSuspendDelay(v) =3D> unsafe {
> +                    bindings::pm_runtime_set_autosuspend_delay(dev.as_ra=
w(), *v);
> +                    bindings::__pm_runtime_use_autosuspend(dev.as_raw(),=
 true);
> +                },
> +            }
> +        }
> +    }
> +
> +    fn reset_config(dev: &Device<Bound>, opts: &[PMConfig]) {
> +        if opts.iter().any(|opt| {
> +            matches!(opt, PMConfig::AutoSuspend(_) | PMConfig::AutoSuspe=
ndDelay(_))
> +        }) {
> +             // SAFETY: `dev` remains bound and valid for this call
> +             unsafe { bindings::__pm_runtime_use_autosuspend(dev.as_raw(=
), false) };
> +        }
> +
> +        if opts.iter().any(|opt| {
> +            matches!(opt, PMConfig::IgnoreChildren(_))
> +        }) {
> +             // SAFETY: `dev` remains bound and valid for this call
> +             unsafe { bindings::pm_suspend_ignore_children(dev.as_raw(),=
 false) };
> +        }
> +    }
> +
> +    /// Get a borrowed reference to PM profiles associated with the PM c=
ontext
> +    pub fn profiles(&self) -> &[PMProfile] {
> +        &self.inner.profiles
> +    }
> +
> +    /// Get a borrowed reference to PM configs associated with the PM co=
ntext
> +    pub fn configs(&self) -> &[PMConfig] {
> +        &self.inner.configs
> +    }
> +}
> +
> +/// Runtime PM request profile.
> +#[derive(Copy, Clone)]
> +pub struct PMProfile(Mode);
> +
> +impl PMProfile {
> +    /// Creates a PMProfile with default SYNC mode set.
> +    pub const fn new() -> Self {
> +        Self(Mode::empty())
> +    }
> +    /// Enables async PM operations for this PMProfile.
> +    pub const fn r#async(self) -> Self {
> +        Self(Mode(self.0 .0 | ModeFlag::Async as u32))
> +    }
> +    /// Use autosuspend
> +    pub const fn auto(self) -> Self {
> +        Self(Mode(self.0 .0 | ModeFlag::Auto as u32))
> +    }
> +    /// Requests idle handling for this PMProfile.
> +    pub const fn idle(self) -> Self {
> +        Self(Mode(self.0 .0 | ModeFlag::Idle as u32))
> +    }
> +    /// Do not wait for concurrent requests to finish.
> +    pub const fn nowait(self) -> Self {
> +        Self(Mode(self.0 .0 | ModeFlag::Nowait as u32))
> +    }
> +}
> +
> +impl Default for PMProfile {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +/// Configuration knobs for runtime PM.
> +pub enum PMConfig {
> +    /// Ignore child devices when suspending.
> +    IgnoreChildren(bool),
> +    /// Disable runtime PM callbacks.
> +    NoCallbacks,
> +    /// Mark device as IRQ-safe for runtime PM.
> +    /// Runtime PM callbacks run with local interrupts
> +    /// disabled and must not sleep
> +    IrqSafe,
> +    /// Enable or disable autosuspend.
> +    AutoSuspend(bool),
> +    /// Set autosuspend delay (milliseconds).
> +    AutoSuspendDelay(i32),
> +}
> +
> +/// Runtime PM data stored within the `struct device_private` during
> +/// runtime PM registration.
> +///
> +#[repr(C)]
> +#[pin_data]
> +struct RegistrationData<'a, T: PMOps> {
> +    payload: Payload<'a, T>,
> +    #[cfg_attr(not(CONFIG_PM), allow(dead_code))]
> +    #[pin]
> +    data: T::RegistrationData<'a>,
> +    _marker: PhantomData<&'a mut T>,
> +}
> +
> +/// Runtime PM registration for a device.
> +///
> +/// A `Registration` installs the `RegistrationData` alonw with the runt=
ime
> +/// payload, used by the generated [`PMOps`] callbacks and owns
> +/// the corresponding teardown.
> +///
> +/// Dropping the registration disables runtime PM, waits for in-flight r=
untime PM
> +/// callbacks to complete, and then removes the stored registration data=
.
> +#[pin_data(PinnedDrop)]
> +pub struct Registration<'a, T>
> +where
> +    T:PMOps,
> +{
> +    ctx: PMContext<'inner, 'a,  T>,
> +    #[pin]
> +    inner: PMContextInner<'a, T>,
> +    #[pin]
> +    data: RegistrationData<'a, T>,
> +}
> +
> +impl<'a, T: PMOps> Registration<'a, T> {
> +    /// Creates a runtime PM registration for `dev`.
> +    ///
> +    /// The provided profiles and configuration are stored in the associ=
ated
> +    /// [`PMContext`]. The `initial_payload` is expected to reflect curr=
ent
> +    /// power state of the device.
> +    ///
> +    /// The device must use the callback represented by `ops`, generated
> +    /// for the same bus adapter and driver pair `(D, T)`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned [`Registration`] object cannot be mem::forgotten,
> +    /// or it's [`Drop`] implementation cannot be skipped in any way.
> +    ///
> +    pub unsafe fn new<E>(
> +        dev: &'a Device<Core<'_>>,
> +        ops: &'static Ops<T>,
> +        profiles: Option<KVec<PMProfile>>,
> +        configs: Option<KVec<PMConfig>>,
> +        data: impl PinInit<<T as PMOps>::RegistrationData<'a>, E> + 'a,
> +        initial_payload: RuntimeStatePayload<T::ActivePayload<'a>, T::Su=
spendedPayload<'a>>,
> +    ) -> impl PinInit<Self, Error> + 'a
> +    where
> +        Error: From<E>,
> +    {
> +         let dev: &'a Device<Bound> =3D dev;
> +
> +       try_pin_init!(Self {
> +           _: {
> +               // SAFETY: For the duration of this call, `dev` is a vali=
d `Device<Core>`,
> +               // and so is its raw `struct device` pointer.
> +               let pm =3D  unsafe { (*(*dev.as_raw()).driver).pm };
> +               if  pm !=3D ops.as_raw() && (cfg!(CONFIG_PM) || !pm.is_nu=
ll()) {
> +                   return Err(EINVAL);
> +               }
> +               // SAFETY: Construction has exclusive access to this slot=
.
> +               if !unsafe {
> +                    (*(*dev.as_raw()).p).rust.pm_registration_data
> +               }.is_null() {
> +                   return Err(EBUSY);
> +               }
> +           },
> +           inner <- try_pin_init!(PMContextInner {
> +               dev,
> +               state: Atomic::new(PMContextState::Disabled),
> +               guard <- new_srcu!("rpm"),
> +               profiles: profiles.unwrap_or_default(),
> +               configs: configs.unwrap_or_default(),
> +               _marker: PhantomData,
> +           }),
> +           ctx : PMContext { inner: inner.get_ref(), },
> +           data <- try_pin_init!(RegistrationData {
> +                data <- data,
> +                payload: Payload {in_flight: AtomicFlag::new(false), inn=
er: UnsafeCell::new(ManuallyDrop::new(initial_payload))},
> +                _marker: PhantomData
> +            }? E),
> +            _: {
> +                let ptr: NonNull<RegistrationData<'a, T>> =3D
> +                    NonNull::from(data.as_ref().get_ref());
> +                // SAFETY: The device is not yet registered, and neither=
 is
> +                // the runtime pm beingenabled - as such, there is no
> +                // cuncurency here
> +                unsafe {
> +                    (*(*dev.as_raw()).p).rust.pm_registration_data =3D
> +                        ptr.cast::<core::ffi::c_void>().as_ptr();
> +                };
> +
> +            }
> +       })
> +
> +   }
> +    /// Returns the runtime PM context associated with this registration=
.
> +    pub fn get_ctx(&self) -> PMContext<'_, 'a,  T> {
> +        PMContext{ inner: &self.inner }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<'a, T: PMOps> PinnedDrop for Registration<'a, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // `self.inner.dev` is the device this registration was
> +        // created for. Runtime PM is disabled first, and `pm_runtime_ba=
rrier`
> +        // waits for pending runtime PM work/callbacks before the callba=
ck data
> +        // is removed below.
> +        // Furthermore, prevent any stale `PMContext`s from re-enabling =
runtime
> +        // PM after teardown starts.
> +        let prev =3D self.inner.state.xchg(PMContextState::Closing, orde=
ring::Full);
> +
> +        self.inner.guard.synchronize();
> +
> +        if prev =3D=3D PMContextState::Enabled {
> +            Request::runtime_disable(self.inner.dev);
> +            PMContext::<T>::reset_config(self.inner.dev, &self.inner.con=
figs);
> +        }
> +
> +        Request::barrier(self.inner.dev);
> +
> +        // SAFETY: The pointer  was stored by `Registration::new`.
> +        // Runtime PM has been disabled and drained above, so generated
> +        // callbacks can no longer borrow this data.
> +        unsafe {
> +            (*(*self.inner.dev.as_raw()).p).rust.pm_registration_data =
=3D core::ptr::null_mut();
> +        }
> +    }
> +}
> --
