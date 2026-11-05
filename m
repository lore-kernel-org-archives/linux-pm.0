Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897254;
	b=GT4ymnKLq06UHkFINEffaLqjHRhCskF4Ump0/s1zIwJ5NunGrvgfhq5Uy8AS8u/qXkOm
	 JKfeZlYHkZiRry1PLwaZmEO1Eb1MPJx2vOD/17pxLCyaocddHoJrGolhJrTMcSo6bOGDG
	 +JXZKqCO0dvW7HmsBPNINqK1oqTOeSmfyW53/awE9uqHFoELSSRnR0v4O6+DlUVaQxAyf
	 Mg2w0D3GMSTLgTj7LU/XiIvdkSBmO6pZv4atJJnV+VqXou8rhDzOOMwSdRHuDnOg2km1B
	 ltIDHzg2ouaOiZ2Qn0NPjWLJq+jihpe7fciOaPGwb1V1LST83zx8yiVG9tvcrinoCeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897254;
	h=Received:DKIM-Signature:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:Mime-Version:Content-Transfer-Encoding:References:In-Reply-To;
	bh=n/Nb1M7Wjdn2Q02uzRfmomGG9EAmUu41HnSfsPMt16I=;
	b=pEx03+ih9EPNSiFF7qTb0oHQ9562+Tysfg87ugsUf/3WbqhtKxNJGkOAtaA5f1XN1m4v
	 BSf7Hkm4PsuCtALRWbpzbY7gzgsvWuWEN5TItziOvzNF4ma7dm86f5zcHNS0SzB3a1V48
	 57wqLwvOwGcmuEytI37PZolJ3Hgojj1ofqFrBXjAN2znJm7y664VpSGF0vPVoei0gSTsK
	 IjLj4ZTYy7eNpI9v9s4dtuOql4ldnk7DbaBmZ2JRppm+q94uaW8xQ97C/DZV/2TxvFjQW
	 JeJHou8iPkD6pKsCLdGj64Ra194DZk+RaEkQMie04jeQh0RnZ8ply96/v8MCucvmlPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU3JsF83;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C8606A328;
	Thu,  5 Nov 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU3JsF83
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41131F00919;
	Thu,  5 Nov 2026 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897253;
	bh=n/Nb1M7Wjdn2Q02uzRfmomGG9EAmUu41HnSfsPMt16I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=SU3JsF83cgmIhwrMxQ6tEcVQ6WV4woH2W3aj2MUWqRbbxiR5u0PDL7m8tHqsTiqt5
	 hAGdO7XSqPo9Z/bb6SVshj2QEVEDtzmbh7AVqbyebuJgmCMvTdA64o7+BbGd10ONtM
	 qTChhUNvMinDSF+6AEpADZnvyYBAqvm39w032qLFSwkME1iKH0sBSbQ0HHWTi/zW2u
	 NNzEbYwMa+IeWDo0JelbGhogd1sWPd13yWQds47eCm9UJMxkLh+MprGvAtzF+X4WNI
	 d1kxYp+yumkvNNuMpUX5xbZ5CfUZ22XiQv2GJKhWNE7faTBHCqLiz+HqrZ2vBG1H9C
	 sjvfILnRUr29g==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 17:47:28 +0100
Message-Id: <DMNFI31C8X12.3L2J0GKKNJN81@kernel.org>
Subject: Re: [PATCH v5 1/3] rust: add runtime PM support
Cc: <ojeda@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <work@onurozkan.dev>,
 <samitolvanen@google.com>, <acourbot@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
To: "Beata Michalska" <beata.michalska@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20261026120523.526942-1-beata.michalska@arm.com>
 <20261026120523.526942-2-beata.michalska@arm.com>
In-Reply-To: <20261026120523.526942-2-beata.michalska@arm.com>

On Mon Oct 26, 2026 at 1:05 PM CET, Beata Michalska wrote:
>  drivers/base/base.h             |    4 +
>  rust/bindings/bindings_helper.h |    1 +
>  rust/helpers/helpers.c          |    1 +
>  rust/helpers/pm_runtime.c       |   89 +++
>  rust/kernel/lib.rs              |    1 +
>  rust/kernel/pm.rs               | 1106 +++++++++++++++++++++++++++++++

I think this fits better under rust/kernel/device/pm.rs. This would also av=
oid
naming like DevPMOps, which can then just be device::PMOps.

We should also add the file to POWER MANAGEMENT CORE in MAINTAINERS.

> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff0..e79108bc754a 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -103,6 +103,7 @@ struct driver_private {
>   *			   dev_err_probe() for later retrieval via debugfs
>   * @device: pointer back to the struct device that this structure is
>   *	    associated with.
> + * @rust_private: private data used exclusively by the Rust driver core
>   * @dead: This device is currently either in the process of or has been
>   *	  removed from the system. Any asynchronous events scheduled for this
>   *	  device should exit without taking any action.
> @@ -119,6 +120,9 @@ struct device_private {
>  	const struct device_driver *async_driver;
>  	char *deferred_probe_reason;
>  	struct device *device;
> +#ifdef CONFIG_RUST
> +	void *rust_private;

Let's call this pointer pm_registration_data_rust. Or even just add

	struct {
		void *pm_registration_data;
	} rust;
=09
> +use core::{cell::UnsafeCell, marker::PhantomData, mem::ManuallyDrop};

NIT: Formatting.

> +impl From<Mode> for core::ffi::c_int {
> +    #[inline]
> +    fn from(mode: Mode) -> core::ffi::c_int {
> +        mode.0 as core::ffi::c_int
> +    }
> +}

You can just use c_int, as it comes from the prelude. Also note that the pr=
elude
takes it from ::ffi, rather than ::core.

> +    /// Explicitly release the scope
> +    /// This should be used in favor of regular drop
> +    /// when error handling is required.

NIT:

	// Explicitly release the scope.
	//
	// This should be used in favor of regular drop when error handling is
	// required.

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
> +/// Runtime PM helpers - wrappers around C runtime PM interface.
> +/// All methods require a reference to a bound device.

I'd rather say a few words about what those helpers are. The fact they requ=
ire a
&Device<Bound> is rather obvious from the signature; if at all I'd rather
mention why that is.

> +struct Request;
> +
> +impl Request {
> +    #[inline]
> +    fn active(dev: &device::Device<device::Bound>) -> bool {
> +        // SAFETY: `dev.as_raw()` must provide a valid pointer to
> +        // `struct device` for the duration of the call.

This reads like a requirement, but it rather is the justifiation for this
requirement coming from pm_runtime_active().

> +        // The `Device<Bound>` reference provides that guarantee.

Plus that we are in a scope where the device is guaranteed that the device
remains bound to the driver, which is a requirement as well.

> +/// Common runtime PM callback entry point
> +///
> +/// The generated extern "C" callbacks call into this helper with the ra=
w
> +/// `struct device *` provided by the PM core. It rebuilds the Rust devi=
ce
> +/// reference, retrieves the device's PM registration data and performs
> +/// handoff to corresponding driver callback.
> +#[cfg(CONFIG_PM)]
> +fn runtime_pm_callback<T, F>(dev: *mut bindings::device, cb: F) -> Resul=
t

This function has to be unsafe, given that it takes a raw pointer.

> +where
> +    T: PMOps,
> +    F: FnOnce(
> +        &<T as PMOps>::DeviceType,
> +        <T as PMOps>::RuntimePayloadType,
> +    ) -> PMCallbackResult<<T as PMOps>::RuntimePayloadType>,
> +{
> +    let dev: &device::Device<device::Bound>  =3D
> +             // SAFETY: `dev` is provided by the PM core and remains
> +             // valid for the duration of the callback.
> +            unsafe { device::Device::from_raw(dev) };

Please prefer Device::from_raw() plus Device::as_bound().

> +
> +    // SAFETY: `dev` is provided by the PM core and remains
> +    // valid for the duration of the callback.
> +    let ptr =3D unsafe { (*(*dev.as_raw()).p).rust_private };
> +
> +    if ptr.is_null() {
> +        return Err(ENODEV);
> +    }

How can we ever reach this?

> +/// Typed reference to a driver's runtime PM ops.
> +///
> +/// Instances of this type are generated from static [`DevPMOps`]
> +/// and are used by bus registration code to install the matching
> +/// C `dev_pm_ops` pointer into the driver object.
> +/// The `A` parameter identifies the bus adapter that is allowed
> +/// to install the table.
> +pub struct DevPMOpsRef<'a, A> {
> +    #[cfg_attr(not(CONFIG_PM), allow(unused))]
> +    ops: &'a bindings::dev_pm_ops,
> +    _p: PhantomData<fn() -> *const A>,
> +}

I'd probably rename this to pm::AdapterOpsRef<'a, A> and add a type alias:

	pub type OpsRef<T> =3D AdapterOpsRef<'static, <T as PMOps>::Adapter>;

so it looks cleaner in drivers:

	 const DEV_PM_OPS: Option<device::pm::OpsRef<Self>> =3D Some(TYR_PM_OPS.pm=
_ops());

(I'd probably also rename DevPMOps to device::pm::Ops, as I think that read=
s
cleaner.)

> +/// Runtime PM callbacks implemented by a driver.
> +///
> +/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm=
_ops`].
> +///
> +/// The Adapter associated type identifies the bus adapter that installs
> +/// the generated PM ops.
> +/// Implementations should normally be enabled through a
> +/// bus-specific constructor for [`DevPMOps`], which constrains
> +/// [`Self::DeviceType`] to the correct bound device type for that bus.
> +///
> +/// Each C callback recovers the Rust bus device from the raw
> +/// `struct device *`, borrows the registered runtime PM payload, and de=
legates
> +/// to the matching [`PMOps`] trait method.

This kind of implementation detail doesn't belong in this doc-comment.

> +#[vtable]
> +pub trait PMOps: Sized {
> +    /// The bus adapter that installs the generated PM ops.
> +    type Adapter: driver::DriverLayout + 'static;
> +
> +    /// Type of the bound bus device passed to runtime PM callbacks.
> +    type DeviceType: AsBusDevice<device::Bound>;
> +
> +    /// Type of the payload moved through runtime PM transitions.
> +    type RuntimePayloadType: Send + 'static;

I got back to this type after writing the below, because at first I thought=
 this
is purely the data type that is cycled through suspend() and resume().

However, reading further this is currently the Registration's private data.=
 This
won't work. The Registration's private data must not require 'static as we =
need
device resources in this data.

So, there should be at least two separate types:

  (1) The private data of pm::Registration.

  (2) An object that is created and returned by suspend() and passed by val=
ue to
      resume(), so it can store e.g. reverse guard types (see below).

This should also get us rid of the PMPayload magic.

> +
> +    /// Runtime resume callback.

It would be good to expand this doc-comment explaining the semantics of
RuntimePayloadType.

> +    fn runtime_resume<'a>(
> +        _dev: &'a Self::DeviceType,
> +        _payload: Self::RuntimePayloadType,
> +    ) -> PMCallbackResult<Self::RuntimePayloadType> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Runtime suspend callback.
> +    fn runtime_suspend<'a>(
> +        _dev: &'a Self::DeviceType,
> +        _payload: Self::RuntimePayloadType,
> +    ) -> PMCallbackResult<Self::RuntimePayloadType> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }

I think for Tyr it so far is sufficient to have a single RuntimePayloadType=
 that
keeps cycling through the callbacks, but there will be use-cases where the =
types
differ.

For instance, for a PCI driver you will have DeviceDisableGuard stored in
suspend() and then you'll want to drop it in resume() so the device gets en=
abled
again.

We should also avoid requiring 'static, as reverse guards will borrow the
regular guard, e.g. pci::DeviceDisableGuard will borrow from
pci::DeviceEnableGuard.

For runtime_resume() I think of something like:

	fn runtime_resume<'a>(
	    dev: &Self::DeviceType,
	    suspended: Self::SuspendData<'a>,
	) -> Result<(), (Self::SuspendData<'a>, Error)>;


> +/// Runtime PM context tied to a device.
> +pub struct PMContext<'a, T: PMOps> {
> +    // Preferably, PMContext could be shared via borrowed reference over
> +    // a pm Registration's lifetime but that bears complications on its =
own
> +    // when the context needs to be shared across different Registration=
 types.
> +    inner: Arc<PMContextInner<'a, T>>,

Since we now have self-referencial pin-init, can we please avoid this Arc?

> +impl<'a, T: PMOps> Registration<'a, T> {
> +    /// Creates a runtime PM registration for `dev`.
> +    ///
> +    /// The provided profiles and configuration are stored in the associ=
ated
> +    /// [`PMContext`]. The `payload` is stored as a Registration data
> +    /// and is used to service PM transitions.
> +    ///
> +    /// The device must use the callback represented by `ops`, generated
> +    /// for the same bus adapter and driver pair `(D, T)`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned [`Registration`] object cannot be mem::forgotten,
> +    /// or it's [`Drop`] implementation cannot be skipped in any way.
> +    ///
> +    pub unsafe fn new(
> +        dev: &'a device::Device<device::Core<'_>>,
> +        ops: &'static DevPMOps<T>,
> +        profiles: Option<KVec<PMProfile>>,
> +        configs: Option<KVec<PMConfig>>,
> +        payload: T::RuntimePayloadType,

This should be impl PinInit<T::PMRegistrationData<'a>, E> + 'a.

> +    ) -> Result<Self> {

This should be impl PinInit<Self, Error> + 'a.

> +        // SAFETY: For the duration of this call, `dev` is a valid `Devi=
ce<Core>`,
> +        // and so is its raw `struct device` pointer.
> +        unsafe {

Please use separate unsafe blocks per unsafe operation.

> +            let drv =3D (*dev.as_raw()).driver;
> +            if drv.is_null() || (*drv).pm !=3D ops.as_raw() {

drv.is_null() can't happen as we require Device<Core>.

> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        let payload =3D KBox::new(
> +            RegistrationData::<T> {
> +                data: PMPayload {
> +                    in_flight: AtomicFlag::new(false),
> +                    inner: UnsafeCell::new(ManuallyDrop::new(payload)),
> +                },
> +                _marker: PhantomData,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        let inner_ctx =3D Arc::new(
> +            PMContextInner {
> +                dev,
> +                state: Atomic::new(PMContextState::Disabled),
> +                profiles: profiles.unwrap_or_default(),
> +                configs: configs.unwrap_or_default(),
> +                _marker: PhantomData,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        // SAFETY: For the duration of this call, `dev` is a valid `Devi=
ce<Core>`,
> +        // and so is its raw `struct device` pointer.
> +        // The payload allocation is converted into a foreign pointer
> +        // and owned by this `Registration` until `Drop` clears
> +        // `rust_private` and reconstructs the `KBox`.
> +        unsafe {

Same as above.

> +            let ptr =3D (*(*dev.as_raw()).p).rust_private;

This is accessed a couple of time, let's add a helper for this.

> +            if !ptr.is_null() {
> +                return Err(EBUSY);
> +            }
> +            (*(*dev.as_raw()).p).rust_private =3D payload.into_foreign()=
;
> +        }
> +
> +        Ok(Self {
> +            ctx: PMContext { inner: inner_ctx },
> +        })
> +    }
