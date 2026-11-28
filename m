Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826244;
	b=ugbjs26R7Ry1zfTHE/Z+2ss3yDovUD/+WzOCGGiEm7mDJplMXBg3sJzp1UILISXbKXUf
	 sfupvQ2c1Ukt/pjIos0Ma6kSE8UdYBY1BQIwpAWLkDPi5TM5mrYowWJBc/8L1zkmh9+Id
	 zVjUV/vSbgQdtFIV4jBF2O3GHqmDG3FdE2+8VTFryIdWQrGTw4Nr4X0+2YBbY6khMEsW5
	 qeReTqeVO1oo9wxy7CIPH62Y0VurmClNM/FBm1Lx0tT1mQ41zkFCjjeVe5ICv1O8kX8fu
	 5OFODyvOkbNgvh7Br2RXcuFot0K5O4qYZkFrmdV1k6H8F4/DQmBsa2tvT/Wyphp1F8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826244;
	h=Received:DKIM-Signature:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:Content-Transfer-Encoding:Mime-Version:References:In-Reply-To;
	bh=d0+OmjvQxBqsSwusrCWkRiZP1gq5UF2jUtzE+u6u9rk=;
	b=wzjlhptuIAf2wWtlEYQiB/GWuBuH9Ysqtth0qHJbzZK07FvNQ8lwSpiKdDVB220o7kNQ
	 pSKXoxYS3jMVRv6m7ifjMki3WFbRkHQ1l4DevUSNt9eGTiVENv1cJteqMzW6Lc/Trqsi7
	 Mh+lFpNhUE0oYLhfv1+Bpe1Wu7ppW692AioSak8jeE2uiiYPlDSmR+R5p+VK/fg1RgE1Y
	 MZhAOSL17t0EwxoCBlF4UKRhBcgfHgTJMpCI10tMS7axF08fN21dL3fXnTdmjT6Rc2KDb
	 bJIFd2Zpno57NwgW3vMlwDO/5Cvsz5YAIpIvxVg9RS+D/JFp76rDQYbbeSSvxB9Uqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN0ADRa5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7E606A31C;
	Sat, 28 Nov 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN0ADRa5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177F01F000C1;
	Sat, 28 Nov 2026 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795826244;
	bh=d0+OmjvQxBqsSwusrCWkRiZP1gq5UF2jUtzE+u6u9rk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=gN0ADRa5Mx7GrBwscD982xL9QHInoImbNrrFfHrKpz1PHoJGxXSEDp1Vkr6HN0iU3
	 3sh5wCPVU+zOtloZQOGbHcYlfgXSyKy3kY++Izg6xhK/rMZIvoLW2tJWMxTYqrVmnZ
	 cIBiuGBURXPAa8Dao/aNBheBClpzckzvIZRZ2GGTzUjpqxoNjPGrBZKDbAi19IIgrn
	 0ULzH24kizNJ9K9tyoVmncm2EPm77pNopQL5VyZ9s4ahbTHoLSxcDzAX/Lna+KYelW
	 sO7MsOG9Lsm98aI6qS2d78NUfXQQXyCTHaVX9A2+/DRbfBy50XWoUTMzwVvyE8Em1Q
	 lV1w0hd/fNVZw==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 01:37:18 +0100
Message-Id: <DN6F9SW1ZOLP.2Y47M5R9FB0C4@kernel.org>
Subject: Re: [PATCH v6 1/3] rust: add runtime PM support
Cc: "Beata Michalska" <beata.michalska@arm.com>, <ojeda@kernel.org>,
 <gregkh@linuxfoundation.org>, <aliceryhl@google.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <work@onurozkan.dev>, <samitolvanen@google.com>, <acourbot@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124113555.2480381-1-beata.michalska@arm.com>
 <20261124113555.2480381-2-beata.michalska@arm.com>
 <CAJZ5v0gBRi2HFuKhmBx+tqcsuuN91M-e6rrttaGt9-hWzWvSiA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBRi2HFuKhmBx+tqcsuuN91M-e6rrttaGt9-hWzWvSiA@mail.gmail.com>

On Fri Nov 27, 2026 at 9:08 PM CET, Rafael J. Wysocki (Intel) wrote:
> I think I know what's going on above this point (except for the places
> where I said I needed help), but the part below escapes me, more or
> less.
>
> Which is unfortunate because I need to understand it so I can tell you
> whether or not it all makes sense IMV.
>
> So how can we get there?  I'm not sure.

Most of the code below is for integration into the desgin of how the driver
lifecycle model is implemented in Rust.

I've given a talk about this topic this year at Kernel Recipes [1], with so=
me
continuation in my LPC talk later this year [2].

In the following I will try to summarize the fundamentals of how this works=
 in
Rust, and then try to tie it back to the PM code below, as it follows those=
 core
principles.

(If you want I think it could make sense to schedule a call where we can wa=
lk
through the code and discuss the details. Of course I can't speak for Beata
though.)

One common source of bugs when writing C drivers is getting the ordering an=
d
lifetime constraints of acquiring resources and initializing asynchronous
contexts (such as IRQs, class device, workqueues, etc.) and sharing resourc=
es
with such scope right.

For instance, when registering an IRQ in probe(), drivers have to make sure=
 that
all (the relevant) fields of the driver's bus device private data are prope=
rly
initialized before an IRQ can fire an access the driver's bus device privat=
e
data.

Similar ordering constraints apply on teardown on either remove() or
devres_release_all(), depending on which model has been chosen by the drive=
r
(and hopefully the driver didn't mix them up :).

(Of course you know all that, but I need an introduction. :)

In Rust we can basically break this down into three core mechanics to ensur=
e
correct ordering and make lifecycle guarantees:

  (1) Use Rust's core principles about ownership, borrowing and lifetimes.

  (2) Use pin-init to expand the principles from (1) to allow them for
      self-referencial, in-memory pinned structures.

  (3) Give asynchronous contexts their own object representation, and - thr=
ough
      (1) and (2) - allow them to borrow from sibling fields within their e=
ntire
      storage container (which typically is the driver's bus device private=
 data).

The object representation of (3) is typically called "Registration", for
instance there is an irq::Registration type, whose existance (or lifetime)
describes the scope in which a driver has an IRQ registered for its bound
device.

Since this is probably a bit abstract, let's have a look at a concrete exam=
ple.

Let's say this is a driver's bus device private data:

	struct DriverData<'bound> {
	    pdev: &'bound pci::Device<Bound>,
	    _enable: pci::DeviceEnableGuard<'bound>,
	    #[pin]
	    irq_handler: irq::Registration<'irq_vec, IrqHandler<'irq_vec>>,
	    irq_vec: pci::IrqVectorRegistration<'bound>,
	    bar: pci::Bar<'bound>,
	}

The first thing to notice is the 'bound lifetime annotation; semanically th=
is is
the lifetime of the driver being bound to the device.

For instance, Rust allows us to store a pci::Device<Bound> (i.e. a PCI devi=
ce
that has the type state guarantee to be bound) inside of this container, as=
 the
container trivially statisfies its lifetime requirement. It could also be s=
tored
in something that is shorter lived, but it can't be stored in a container t=
hat
is longer lived (as this would violate the 'Bound' type state).

(Most) Registration types, such as irq::Registration, require to be shorter
lived than 'bound, such that is guaranteed that their destructor is called
before 'bound expires, i.e. before the driver is unbound.

They also receive their own storage container; in the case above the
irq::Registration's private data is IrqHandler.

Note that this storage container is still part of the allocation of the dri=
ver's
bus device private data, i.e. DriverData. There's no separate allocation.

The lifetime it captures only means that pci::IrqVectorRegistration must be
longer lived than irq::Registration, because we can't free PCI IRQ vectors
before we free the IRQ itself.

You can't see it from the struct definition, but this ordering is enforced =
at
compile time, if the order would be changed it wouldn't compile.

Let's have a look at the storage container of irq::Registration now.

	struct IrqHandler<'handler> {
	    pdev: &'handler pci::Device<Bound>,
	    bar: &'handler pci::Bar<'handler>,
	}

The IrqHandler also stores a reference to the pci::Device<Bound>, which is =
valid
as the compiler ensures it can't outlive 'bound. And it also stores a refer=
ence
to the pci::Bar owned by DriverData, which it borrows from.

The point of this exercise is that with this it becomes impossible for the
driver to register and prime the IRQ first and then map the pci::Bar, which=
 the
IRQ handler could access concurrently. It is guaranteed that pci::Bar is
constructed before the irq::Registration.

We can easily see this from probe():

	impl Driver {
	    fn probe<'bound>(
	        pdev: &'bound pci::Device<Core<'_>>,
	        _id_info: Option<&'bound Self::IdInfo>,
	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
	        try_pin_init!(DriverData {
	            _enable: pdev.enable_device()
	                         .inspect(|_| pdev.set_master())?,

Here we create the pci::DeviceEnableGuard first and set bus mastering and s=
tore
it in DriverData.


	            bar: pdev.iomap_region_sized::<{ regs::END }>(
	                0, c"rust_driver_edu",
	            )?,

Here we map the pci::Bar and store it in DriverData as bar.

	            irq_vec: pdev.alloc_irq_vectors(
	                1, 1, IrqTypes::default().with(pci::IrqType::Msi),
	            )?,

Here we create the pci::IrqVectorRegistration and store it in DriverData as=
 irq_vec.

	            irq_handler <- irq::Registration::new(
	                irq_vec.index(0)?.into(),

Constructing irq::Registration requires the PCI IRQ vector index as Linux I=
RQ
number (the conversion happens through the into() call).

The resulting IrqRequest type, that captures the Linux IRQ number also capt=
ures
the lifetime from irq_vec, which establishes the relationship I explained a=
bove.

It also ensures correct initialization order, as there is a data dependency=
:
irq::Registration can't be constructed without pci::IrqVectorRegistration b=
eing
initialized in-place before.

	                Flags::TRIGGER_NONE,
	                c"rust_edu_irq",
	                try_pin_init!(IrqHandler {
	                    bar,
	                    pdev,
	                }),

Here we pass the private data of the irq::Registration; bar is a borrow of =
the
in-place initialized fields above. Through the data dependency the order is
guaranteed.

The driver core ensures that the destructor of DriverData runs on driver un=
bind,
which causes all fields to drop. The drop order is reverse of initializatio=
n
order (declaration order) which is guaranteed through pin-init. Those are a=
ll
compile time guarantees.

	            ),
=09
	            pdev,
	        })
	    }
	}

Finally to the runtime PM code. :)

It pretty much follows the same pattern, analogous to irq::Registration, th=
ere
is a pm::Registration type that serves as the container for private data th=
at is
accessible to runtime_resume() and runtime_suspend().

This is also what the pm_registration_data pointer is used for; it helps us=
 to
find the offset of the pm::Registration data container within the driver's =
bus
device private data.

You can think of pm::Registration as pretty much the same as
devm_pm_runtime_enable(), except that the lifetime management isn't done by
devres, but by Rust's ownership and lifetime model.

Of course, this doesn't work for all buses, but only for buses where driver=
s
should use devm_pm_runtime_enable(), or pm_runtime_{enable,disable}().

(I missed this part in my previous review; pm::Registration should only wor=
k for
buses where this pattern is supported, e.g. platform. So, there should prob=
ably
be a platform::pm::Registration that takes a platform::Device<Bound>.
pci::pm::Registration needs to be slightly different and should probably us=
e
pm_runtime_get_noresume() and pm_runtime_put_noidle() etc. instead.)

Now, let's have a look at how the PM callbacks work in this patch.

	impl PMOps for MyPlatformDriver {
	    type Adapter =3D platform::Adapter<MyPlatformDriver>;
	    type DeviceType =3D platform::Device<Bound>;
=09
	    type RegistrationData<'a> =3D MyPMRegistrationData<'a>;

This is the pm::Registration data container that can e.g. borrow resources =
owned
by the driver's bus device private data.

	    type ActivePayload<'a> =3D MyActivePayload;

This type represents data that only lives as long as the driver is not
suspended. It is currently constructed in when pm::Registration is construc=
ted
and passed by value to runtime_suspend() do the driver can either drop it o=
r
retain it via SuspendedPayload.

This type can be useful to allow drivers to change the type state of a type=
 that
represents a resource.

For instance, it could contain a Regulator<Enabled>. runtime_suspend() gets=
 the
container by value, takes out the Regulator<Enabled>, converts it to a
Regulator<Disabled> and stores it in SuspendedPayload.

Note that Regulator<Enabled> and Regulator<Disabled> are different types an=
d
hence having different container types, i.e. ActivePayload and SuspendedPay=
load
make sense.

	    type SuspendedPayload<'a> =3D MySuspendPayload;

This has mostly been covered above, but obvious SuspendedPayload only lives=
 as
long as the device is suspended and it is constructed by runtime_suspend() =
and
consumed by value by runtime_resume().

=09
	    fn runtime_suspend<'a>(
	        _dev: &'a Self::DeviceType,
	        _reg_data: &'a Self::RegistrationData<'a>,
	        payload: Self::ActivePayload<'a>,
	    ) -> Result<Self::SuspendedPayload<'a>, (Self::ActivePayload<'a>, Erro=
r)> {

The runtime_suspend() callback received the RegistrationData (i.e. the cont=
ainer
that can borrow from the driver's device private data) and the initial
ActivePayload, both passed to pm::Registration::new().

It can deconstruct ActivePayload and returns a SuspendedPayload, on failure=
 it
returns an error and the original ActivePayload.

	        ...
=09
	        Ok(payload)
	    }
=09
	    fn runtime_resume<'a>(
	        _dev: &'a Self::DeviceType,
	        _reg_data: &'a Self::RegistrationData<'a>,
	        payload: Self::SuspendedPayload<'a>,
	    ) -> Result<Self::ActivePayload<'a>, (Self::SuspendedPayload<'a>, Erro=
r)> {

As one would expect, the runtime_resume() callback works pretty much the sa=
me,
just in reverse.

	        ...
=09
	        Ok(payload)
	    }
	}

Both ActivePayload and SuspendedPayload can borrow from the RegistrationDat=
a and
allow drivers to use proper guard types and type states rather than needing
"manual calls" to switch between enabled/disabled states or balance referen=
ce
counts.

A lot of the code below is dealing with juggling ActivePayload and
SuspendedPayload around for this purpose. Functions like
with_registration_data() are accessors e.g. dealing with lifetime variance =
[3].

[1] https://kernel-recipes.org/en/2026/schedule/enforcing-device-driver-lif=
ecycle-rules-at-compile-time/
[2] https://youtu.be/3A2vGbc_rxs?t=3D668
[3] https://doc.rust-lang.org/nomicon/subtyping.html#variance

>> +/// Common runtime PM callback entry point.
>> +///
>> +/// Invokes a runtime PM callback with its registration data and curren=
t payload.
>> +///
>> +/// # Safety
>> +///
>> +/// The generated extern "C" callbacks call into this helper with the r=
aw
>> +/// `struct device *` provided by the PM core. As such, it is guarantee=
d that
>> +/// the `struct device` remains valid throughout the calls.
>> +#[cfg(CONFIG_PM)]
>> +unsafe fn with_registration_data<T, F>(dev: *mut bindings::device, cb: =
F) -> Result
>> +where
>> +    T: PMOps,
>> +    F: for <'a>FnOnce(
>> +        &'a <T as PMOps>::DeviceType,
>> +        &'a <T as PMOps>::RegistrationData<'a>,
>> +        RuntimeStatePayload<T::ActivePayload<'a>, T::SuspendedPayload<'=
a>>
>> +     ) -> PMCallbackResult<RuntimeStatePayload<T::ActivePayload<'a>, T:=
:SuspendedPayload<'a>>,
>> +                           RuntimeStatePayload<T::ActivePayload<'a>, T:=
:SuspendedPayload<'a>>>,
>> +{
>> +    // SAFETY: `dev` is provided by the PM core and remains valid
>> +    // for the duration of the callback.
>> +    let dev: &Device =3D unsafe { Device::from_raw(dev) };
>> +    // SAFETY: The runtime PM callback can only be triggered for a boun=
d device.
>> +    let dev: &Device<Bound> =3D  unsafe { dev.as_bound() };
>> +    let pm_dev: &T::DeviceType =3D
>> +        // SAFETY: The generated `dev_pm_ops` for `T` is installed on d=
evices whose
>> +        // bus-specific type is `T::DeviceType`. Therefore the base `De=
vice<Bound>`
>> +        // passed by the PM core is embedded in a valid `T::DeviceType`=
; the
>> +        // `AsBusDevice` implementation supplies the correct offset for=
 this cast.
>> +        unsafe { T::DeviceType::from_device(dev) };
>> +    // SAFETY:  The `RegistrationData` must have been successfully inst=
alled
>> +    // for a device and it is guaranteed that it reamins valid at least=
 until
>> +    // the last PM callback finishes.
>> +    let ptr =3D unsafe { (*(*dev.as_raw()).p).rust.pm_registration_data=
 };
>> +    // SAFETY: `Registration::new` stores a pointer to its initialized,=
 pinned
>> +    // `RegistrationData<T>` before enabling runtime PM. These callback=
s
>> +    // belong to the same `T`. Registration teardown disables runtime P=
M and
>> +    // drains callbacks before clearing the pointer and dropping the da=
ta, so
>> +    // it remains valid for this callback
>> +    let reg_data =3D unsafe { &*ptr.cast::<RegistrationData<'_, T>>() }=
;
>> +
>> +    let _guard =3D reg_data.payload.acquire()?;
>> +    // SAFETY: This callback alone acquired `in_flight`; it has exclusi=
ve
>> +    // access to the payload slot until `_guard` is dropped.
>> +    let slot =3D unsafe { &mut *reg_data.payload.inner.get() };
>> +    // SAFETY: `_guard` gives this callback exclusive access to `slot`,=
 which
>> +    // contains an initialized payload. Both callback outcomes provide =
a payload
>> +    // that is written back into `slot` before `_guard` is released.
>> +    let payload =3D unsafe { ManuallyDrop::take(slot) };
>> +
>> +    let (next, result) =3D match cb(pm_dev, &reg_data.data, payload) {
>> +                Ok(next) =3D> (next, Ok(())),
>> +                Err((current, err)) =3D> (current, Err(err)),
>> +    };
>> +
>> +    *slot =3D ManuallyDrop::new(next);
>> +    result
>> +}
>> +
>> +/// Runtime resume PM callback.
>> +///
>> +/// # Safety
>> +///
>> +/// `dev` is a valid `struct device *` supplied by the PM core for a de=
vice
>> +/// whose runtime PM callbacks and PM registration data were both creat=
ed
>> +/// for `T`.
>> +#[cfg(CONFIG_PM)]
>> +unsafe extern "C" fn runtime_resume_callback<T>(dev: *mut bindings::dev=
ice) -> c_int
>> +where
>> +    T: PMOps,
>> +{
>> +    // SAFETY: The callback's safety contract guarantees that `dev` rem=
ains
>> +    // valid for this call and has PM registration data created for `T`=
.
>> +    // These are the preconditions of `with_registration_data`.
>> +    unsafe {
>> +        with_registration_data::<T, _>(dev,
>> +            |pm_dev, data, payload| {
>> +                match payload {
>> +                    RuntimeStatePayload::Suspended(payload_data) =3D> {
>> +                        T::runtime_resume(pm_dev, data, payload_data)
>> +                            .map(RuntimeStatePayload::Active)
>> +                            .map_err(|(prev, err)| (RuntimeStatePayload=
::Suspended(prev), err))
>> +                    },
>> +                    other =3D> Err((other, EINVAL)),
>> +                }
>> +        })
>> +        .map(|()| 0)
>> +        .unwrap_or_else(|e| e.to_errno())
>> +    }
>> +}
>> +/// Runtime suspend PM callback.
>> +///
>> +/// # Safety
>> +///
>> +/// `dev` is a valid `struct device *` supplied by the PM core for a de=
vice
>> +/// whose runtime PM callbacks and PM registration data were both creat=
ed
>> +/// for `T`.
>> +#[cfg(CONFIG_PM)]
>> +unsafe extern "C" fn runtime_suspend_callback<T>(dev: *mut bindings::de=
vice) -> c_int
>> +where
>> +    T: PMOps,
>> +{
>> +    // SAFETY: The callback's safety contract guarantees that `dev` rem=
ains
>> +    // valid for this call and has PM registration data created for `T`=
.
>> +    // These are the preconditions of `with_registration_data`.
>> +    unsafe {
>> +        with_registration_data::<T, _>(dev,
>> +            |pm_dev, data, payload| {
>> +                match payload {
>> +                    RuntimeStatePayload::Active(payload_data) =3D> {
>> +                        T::runtime_suspend(pm_dev, data, payload_data)
>> +                            .map(RuntimeStatePayload::Suspended)
>> +                            .map_err(|(prev, err)| (RuntimeStatePayload=
::Active(prev), err))
>> +                    },
>> +                    other =3D> Err((other, EINVAL)),
>> +                }
>> +        })
>> +        .map(|()| 0)
>> +        .unwrap_or_else(|e| e.to_errno())
>> +    }
>> +}
>> +
>> +/// Default empty Runtime PM ops
>> +pub const PMOPS_NONE: bindings::dev_pm_ops =3D
>> +    // SAFETY:
>> +    // bindings::dev_pm_ops is #[repr(C)], implements Default
>> +    // and the struct itself is all nullable function pointers.
>> +    // There is no padding and all zero bit-pattern is valid
>> +    //
>> +    unsafe { core::mem::MaybeUninit::<bindings::dev_pm_ops>::zeroed().a=
ssume_init() };
>> +
>> +/// Typed reference to a driver's runtime PM ops.
>> +///
>> +/// Instances of this type are generated from static [`Ops`]
>> +/// and are used by bus registration code to install the matching
>> +/// C `dev_pm_ops` pointer into the driver object.
>> +/// The `A` parameter identifies the bus adapter that is allowed
>> +/// to install the table.
>> +pub struct AdapterOpsRef<'a, A> {
>> +    #[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +    ops: &'a bindings::dev_pm_ops,
>> +    _p: PhantomData<fn() -> *const A>,
>> +}
>> +
>> +/// Conveniance type alias
>> +pub type OpsRef<T> =3D AdapterOpsRef<'static, <T as PMOps>::Adapter>;
>> +
>> +// SAFETY: `AdapterOpsRef` only contains a shared reference to an immut=
able
>> +// `dev_pm_ops` table and a type marker. Sharing it between threads can=
not
>> +// introduce mutation or aliasing of Rust-owned state.
>> +unsafe impl<A> Sync for AdapterOpsRef<'_, A> {}
>> +
>> +impl<A> AdapterOpsRef<'_, A> {
>> +    #[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +    #[inline]
>> +    pub(crate) const fn as_raw(&self) -> *const bindings::dev_pm_ops {
>> +        self.ops
>> +    }
>> +}
>> +
>> +/// Runtime PM ops for a driver.
>> +///
>> +/// Intended to be constructed by bus-specific helpers, allowing
>> +/// the bus to ensure that the callback device type matches the device
>> +/// supplied by the C driver core.
>> +pub struct Ops<T: PMOps> {
>> +    raw: bindings::dev_pm_ops,
>> +    _p: PhantomData<fn() -> T>,
>> +}
>> +
>> +impl<T: PMOps> Ops<T> {
>> +    /// Creates a typed runtime PM ops.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must guarantee that `T::Adapter` is the bus adapter =
that
>> +    /// will install this ops into the C driver object for `T`, and
>> +    /// that `T::DeviceType` is the bus device type corresponding to
>> +    /// that adapter. Safe bus-specific constructors should wrap this
>> +    /// function with those bounds.
>> +    pub(crate) const unsafe fn new_unchecked(raw: bindings::dev_pm_ops)=
 -> Self {
>> +        const_assert!(
>> +            T::HAS_RUNTIME_RESUME =3D=3D T::HAS_RUNTIME_SUSPEND,
>> +            "runtime suspend and resume callbacks should be implemented=
 together"
>> +        );
>> +        Self {
>> +            raw,
>> +            _p: PhantomData,
>> +        }
>> +    }
>> +
>> +    /// Provides a typed reference to this runtime PM ops
>> +    ///
>> +    /// Bus registration code uses the returned value to install
>> +    /// the ops into the corresponding C driver object.
>> +    /// The returned reference is tied to `T::Adapter`.
>> +    pub const fn pm_ops(&'static self) -> OpsRef<T> {
>> +        AdapterOpsRef {
>> +            ops: &self.raw,
>> +            _p: PhantomData,
>> +        }
>> +    }
>> +
>> +    /// Returns the raw C runtime PM operations table.
>> +    #[inline]
>> +    pub const fn as_raw(&'static self) -> *const bindings::dev_pm_ops {
>> +        &self.raw
>> +    }
>> +}
>> +
>> +/// Result type returned by runtime PM callbacks.
>> +pub type PMCallbackResult<New, Current> =3D Result<New, (Current, Error=
)>;
>> +
>> +/// Runtime PM callbacks implemented by a driver.
>> +///
>> +/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_p=
m_ops`].
>> +///
>> +/// The Adapter associated type identifies the bus adapter that install=
s
>> +/// the generated PM ops.
>> +/// Implementations should normally be enabled through a
>> +/// bus-specific constructor for [`Ops`], which constrains
>> +/// [`Self::DeviceType`] to the correct bound device type for that bus.
>> +#[vtable]
>> +pub trait PMOps: Sized {
>> +    /// The bus adapter that installs the generated PM ops.
>> +    type Adapter: driver::DriverLayout + 'static;
>> +
>> +    /// Type of the bound bus device passed to runtime PM callbacks.
>> +    type DeviceType: AsBusDevice<Bound>;
>> +
>> +    /// Data associated with the `Registration`, tied to its lifetime.
>> +    type RegistrationData<'a>: Send + Sync + 'a;
>> +
>> +    /// Driver's specific data associated with suspended PM device stat=
e
>> +    type SuspendedPayload<'a>: Send + 'a;
>> +    /// Driver's specific data associated with active PM device states
>> +    type ActivePayload<'a>: Send + 'a;
>> +
>> +    /// Runtime resume callback.
>> +    fn runtime_resume<'a>(
>> +        _dev: &'a Self::DeviceType,
>> +        _reg_data: &'a Self::RegistrationData<'a>,
>> +        _payload: Self::SuspendedPayload<'a>,
>> +    ) -> PMCallbackResult<Self::ActivePayload<'a>, Self::SuspendedPaylo=
ad<'a>> {
>> +        build_error!(VTABLE_DEFAULT_ERROR)
>> +    }
>> +
>> +    /// Runtime suspend callback.
>> +    fn runtime_suspend<'a>(
>> +        _dev: &'a Self::DeviceType,
>> +        _reg_data: &'a Self::RegistrationData<'a>,
>> +        _payload: Self::ActivePayload<'a>,
>> +    ) -> PMCallbackResult<Self::SuspendedPayload<'a>, Self::ActivePaylo=
ad<'a>> {
>> +        build_error!(VTABLE_DEFAULT_ERROR)
>> +    }
>> +}
>> +
>> +/// RAII guard for ongoing runtime PM payload transition.
>> +///
>> +/// For most of the callbacks this guard is not necessarily needed as
>> +/// the callbacks themselves are being serialized by the runtime PM C c=
ode.
>> +/// Still, some like runtime_idle are exempt from that.
>> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +struct PayloadGuard<'a> {
>> +    busy: &'a AtomicFlag,
>> +}
>> +
>> +impl Drop for PayloadGuard<'_> {
>> +    fn drop(&mut self) {
>> +        self.busy.store(false, ordering::Release);
>> +    }
>> +}
>> +
>> +/// Payload associated with the given runtime power state of a device.
>> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +pub enum RuntimeStatePayload<Active, Suspended> {
>> +    /// Payload associated with the runtime active PM state of a device
>> +    Active(Active),
>> +    /// Payload associated with the runtime suspended PM state of a dev=
ice
>> +    Suspended(Suspended),
>> +}
>> +
>> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +struct Payload<'a, T:PMOps> {
>> +    in_flight: AtomicFlag,
>> +    inner: UnsafeCell<ManuallyDrop<RuntimeStatePayload<T::ActivePayload=
<'a>, T::SuspendedPayload<'a>>>>,
>> +}
>> +
>> +#[cfg_attr(not(CONFIG_PM), allow(unused))]
>> +impl<'a, T:PMOps> Payload<'a, T> {
>> +    /// Attempts to acquire exclusive access to the runtime PM payload.
>> +    ///
>> +    /// Returns `EBUSY` if another runtime PM callback is already trans=
itioning the
>> +    /// payload.
>> +    fn acquire(&self) -> Result<PayloadGuard<'_>> {
>> +        self.in_flight
>> +            .cmpxchg(false, true, ordering::Acquire)
>> +            .map_err(|_| EBUSY)?;
>> +        Ok(PayloadGuard {
>> +            busy: &self.in_flight,
>> +        })
>> +    }
>> +}
>> +
>> +impl<T:PMOps> Drop for Payload<'_, T> {
>> +    fn drop(&mut self) {
>> +        // SAFETY: teardown drained PM callbacks and the slot holds a `=
P`
>> +        unsafe {
>> +            ManuallyDrop::drop(self.inner.get_mut());
>> +        }
>> +    }
>> +}
>> +
>> +// SAFETY: Although Payload's `inner` is an `UnsafeCell`, it is only ac=
cessed
>> +// after `in_flight` has been acquired. The AtomicFlag flag serializes =
all mutable
>> +// access to the payload, and `PayloadGuard` clears the flag when the a=
ccess ends.
>> +unsafe impl<T:PMOps> Sync for Payload<'_, T> {}
>> +
>> +#[derive(Clone, Copy, PartialEq, Eq)]
>> +#[repr(i32)]
>> +enum PMContextState {
>> +    /// The PM registration is alive, but runtime PM has not been enabl=
ed.
>> +    Disabled =3D 0,
>> +    /// Enabling runtime PM has been initiated but has not completed ju=
st yet
>> +    Enabling =3D 1,
>> +    /// The runtime PM has been enabled. Intended to be balanced by
>> +    /// `disable()` or `Registration::drop()`
>> +    Enabled =3D 2,
>> +    /// Disabling runtime PM has been initiated but has not completed j=
ust yet
>> +    Disabling =3D 3,
>> +    /// The owning `Registration` is being dropped or has been dropped.
>> +    /// Stale cloned `PMContext`s may still exist, but once this state =
is
>> +    /// visible, runtime PM cannot be re-enabled.
>> +    Closing =3D 4,
>> +}
>> +
>> +// SAFETY: `PMContextState` has the same size and alignment as `i32`, a=
nd all
>> +// values written through `Atomic<PMContextState>` are valid `PMContext=
State`
>> +// discriminants.
>> +unsafe impl AtomicType for PMContextState {
>> +    type Repr =3D i32;
>> +}
>> +
>> +#[pin_data]
>> +struct PMContextInner<'a, T: PMOps> {
>> +    dev: &'a Device<Bound>,
>> +    /// State owned by the runtime PM registration
>> +    state: Atomic<PMContextState>,
>> +    /// A synchronization point for all pending callbacks to finish.
>> +    #[pin]
>> +    guard: Srcu,
>> +    /// Optional driver-selected runtime PM request PMProfiles.
>> +    ///
>> +    /// Set of runtime PM predefined PMProfiles that can be used by the=
 driver
>> +    /// when requesting a PM transition. This might be useful when a dr=
iver
>> +    /// has several different PM usage patterns.
>> +    /// See [PMProfile] for more details.
>> +    profiles: KVec<PMProfile>,
>> +    /// Set of PM config options applied for associated device.
>> +    configs: KVec<PMConfig>,
>> +    _marker: PhantomData<fn() -> T>,
>> +}
>> +
>> +/// Runtime PM context tied to a device.
>> +///
>> +/// Needs to be dropped from sleepable context.
>> +#[pin_data]
>> +pub struct PMContext<'r, 'a, T: PMOps> {
>> +    inner: &'r PMContextInner<'a, T>,
>> +}
>> +
>> +impl<'r, 'a, T: PMOps> PMContext<'r, 'a, T> {
>> +    /// Driver-provided runtime PM operations.
>> +    ///
>> +    /// A driver implements this trait to handle runtime PM
>> +    /// transitions for its device type.
>> +    ///
>> +    /// Each callback receives the device, its registration data
>> +    /// and the current payload.
>> +    /// On success, it returns the payload to keep for the next
>> +    /// transition. On failure, it returns the payload together
>> +    /// with the error so the previous, or otherwise sane state
>> +    /// can be preserved.
>> +    #[cfg(CONFIG_PM)]
>> +    pub(crate) const PM_OPS: bindings::dev_pm_ops =3D bindings::dev_pm_=
ops {
>> +        runtime_resume: if T::HAS_RUNTIME_RESUME {
>> +            Some(runtime_resume_callback::<T>)
>> +        } else {
>> +            None
>> +        },
>> +        runtime_suspend: if T::HAS_RUNTIME_SUSPEND {
>> +            Some(runtime_suspend_callback::<T>)
>> +        } else {
>> +            None
>> +        },
>> +        ..PMOPS_NONE
>> +    };
>> +
>> +    #[cfg(not(CONFIG_PM))]
>> +    pub(crate) const PM_OPS: bindings::dev_pm_ops =3D PMOPS_NONE;
>> +
>> +    #[inline]
>> +    fn state_transition(&self, expected: PMContextState, new: PMContext=
State) -> Result
>> +    {
>> +        self.inner.state.cmpxchg(expected, new, ordering::Full)
>> +        .map(|_| ())
>> +        .map_err(|actual| match (expected, actual) {
>> +            (_, PMContextState::Closing) =3D> ENODEV,
>> +            (PMContextState::Disabled, PMContextState::Disabling)
>> +            | (PMContextState::Enabled, PMContextState::Enabling) =3D> =
EBUSY,
>> +            _ =3D> EINVAL,
>> +        })
>> +   }
>> +
>> +    /// Enable runtime PM
>> +    pub fn enable(&self, state: RuntimePMState) -> Result {
>> +        let _transition_guard =3D self.inner.guard.read_lock();
>> +        self.state_transition(PMContextState::Disabled, PMContextState:=
:Enabling)?;
>> +        Self::apply_config(self.inner.dev, &self.inner.configs);
>> +
>> +        match state {
>> +                RuntimePMState::Active =3D> Request::mark_active(self.i=
nner.dev),
>> +                RuntimePMState::Suspended =3D> Request::mark_suspended(=
self.inner.dev),
>> +        }
>> +        .inspect_err(|_| {
>> +            Self::reset_config(self.inner.dev, &self.inner.configs);
>> +            let _ =3D self.state_transition(
>> +                    PMContextState::Enabling,
>> +                    PMContextState::Disabled,
>> +                );
>> +        })?;
>> +
>> +        Request::runtime_enable(self.inner.dev);
>> +        self.state_transition(
>> +                PMContextState::Enabling,
>> +                PMContextState::Enabled,
>> +        ).inspect_err(|e| {
>> +            if *e =3D=3D ENODEV {
>> +                Request::runtime_disable(self.inner.dev);
>> +                Self::reset_config(self.inner.dev, &self.inner.configs)=
;
>> +            }
>> +        })?;
>> +        Ok(())
>> +    }
>> +
>> +    /// Disable runtime PM
>> +    pub fn disable(&self) -> Result {
>> +        let _transition_guard =3D self.inner.guard.read_lock();
>> +        self.state_transition(
>> +                PMContextState::Enabled,
>> +                PMContextState::Disabling,
>> +        )?;
>> +
>> +        Request::runtime_disable(self.inner.dev);
>> +        Self::reset_config(self.inner.dev, &self.inner.configs);
>> +
>> +        let _  =3D self.state_transition(
>> +             PMContextState::Disabling,
>> +             PMContextState::Disabled
>> +        );
>> +        Ok(())
>> +    }
>> +
>> +    /// Returns whether the runtime PM state is active.
>> +    #[inline]
>> +    pub fn active(&self) -> bool {
>> +        Request::active(self.inner.dev)
>> +    }
>> +
>> +    /// Returns whether the runtime PM state is suspended.
>> +    #[inline]
>> +    pub fn suspended(&self) -> bool {
>> +        Request::suspended(self.inner.dev)
>> +    }
>> +
>> +    /// Creates a `ResumeScope` for the given PMProfile.
>> +    /// Note that for ASYNC/NOWAIT request this does not guarantee
>> +    /// the device has been resumed at the time this function returns.
>> +    #[inline]
>> +    pub fn resume(&self, profile: PMProfile) -> Result<ResumeScope<'r>>=
 {
>> +        ResumeScope::new(self.inner.dev, profile.0)
>> +    }
>> +
>> +    /// Creates an `AwakeScope` for the given PMProfile.
>> +    /// Note that for ASYNC/NOWAIT request this does not guarantee
>> +    /// the device has been resumed at the time this function returns.
>> +    #[inline]
>> +    pub fn get(&self, profile: PMProfile) -> Result<AwakeScope<'r>> {
>> +        AwakeScope::new(self.inner.dev, profile.0 | ModeFlag::Acquire)
>> +    }
>> +
>> +    /// Creates a `RetainScope` for this device.
>> +    pub fn hold(&self) -> Result<RetainScope<'r>> {
>> +        RetainScope::new(self.inner.dev)
>> +    }
>> +
>> +    /// Creates a `RetainScope` for an active device.
>> +    pub fn try_hold_active(&self) -> Result<RetainScope<'r>> {
>> +        RetainScope::try_new(self.inner.dev)
>> +    }
>> +
>> +    /// Runs a closure while holding a `ResumeScope`.
>> +    pub fn with_resume<R>(&self, profile: PMProfile, f: impl FnOnce() -=
> Result<R>) -> Result<R> {
>> +        if profile.0.contains_any(ModeFlag::Async| ModeFlag::Nowait) {
>> +            return Err(EINVAL);
>> +        }
>> +        let _scope =3D self.resume(profile)?;
>> +        f()
>> +    }
>> +    /// Runs a closure while holding an `AwakeScope`.
>> +    pub fn with_get<R>(&self, profile: PMProfile, f: impl FnOnce() -> R=
esult<R>) -> Result<R> {
>> +        if profile.0.contains_any(ModeFlag::Async | ModeFlag::Nowait) {
>> +            return Err(EINVAL);
>> +        }
>> +        let _scope =3D self.get(profile)?;
>> +        f()
>> +    }
>> +
>> +    /// Runs a closure while holding a `RetainScope`.
>> +    pub fn with_hold<R>(&self, f: impl FnOnce() -> Result<R>) -> Result=
<R> {
>> +        let _scope =3D self.hold()?;
>> +        f()
>> +    }
>> +
>> +    /// Applies runtime PM configuration options.
>> +    ///
>> +    /// Options are applied in the order provided. The currently suppor=
ted
>> +    /// options do not report per-option failures.
>> +    fn apply_config(dev: &Device<Bound>, opts: &[PMConfig]) {
>> +        for opt in opts {
>> +            match opt {
>> +                // SAFETY: The `Device<Bound>` reference guarantees tha=
t `dev.as_raw()`
>> +                // yields a valid pointer to `struct device` for the du=
ration of this call.
>> +                PMConfig::IgnoreChildren(v) =3D> unsafe {
>> +                    bindings::pm_suspend_ignore_children(dev.as_raw(), =
*v)
>> +                },
>> +                // SAFETY: The `Device<Bound>` reference guarantees tha=
t `dev.as_raw()`
>> +                // yields a valid pointer to `struct device` for the du=
ration of this call.
>> +                PMConfig::NoCallbacks =3D> unsafe { bindings::pm_runtim=
e_no_callbacks(dev.as_raw()) },
>> +                // SAFETY: The `Device<Bound>` reference guarantees tha=
t `dev.as_raw()`
>> +                // yields a valid pointer to `struct device` for the du=
ration of this call.
>> +                PMConfig::IrqSafe =3D> unsafe {
>> +                    // Do not attempt to call that more than once
>> +                    if !bindings::pm_runtime_is_irq_safe(dev.as_raw()) =
{
>> +                        bindings::pm_runtime_irq_safe(dev.as_raw());
>> +                    }
>> +                },
>> +                // SAFETY: The `Device<Bound>` reference guarantees tha=
t `dev.as_raw()`
>> +                // yields a valid pointer to `struct device` for the du=
ration of this call.
>> +                PMConfig::AutoSuspend(v) =3D> unsafe {
>> +                    bindings::__pm_runtime_use_autosuspend(dev.as_raw()=
, *v);
>> +                },
>> +                // SAFETY: The `Device<Bound>` reference guarantees tha=
t `dev.as_raw()`
>> +                // yields a valid pointer to `struct device` for the du=
ration of this call.
>> +                PMConfig::AutoSuspendDelay(v) =3D> unsafe {
>> +                    bindings::pm_runtime_set_autosuspend_delay(dev.as_r=
aw(), *v);
>> +                    bindings::__pm_runtime_use_autosuspend(dev.as_raw()=
, true);
>> +                },
>> +            }
>> +        }
>> +    }
>> +
>> +    fn reset_config(dev: &Device<Bound>, opts: &[PMConfig]) {
>> +        if opts.iter().any(|opt| {
>> +            matches!(opt, PMConfig::AutoSuspend(_) | PMConfig::AutoSusp=
endDelay(_))
>> +        }) {
>> +             // SAFETY: `dev` remains bound and valid for this call
>> +             unsafe { bindings::__pm_runtime_use_autosuspend(dev.as_raw=
(), false) };
>> +        }
>> +
>> +        if opts.iter().any(|opt| {
>> +            matches!(opt, PMConfig::IgnoreChildren(_))
>> +        }) {
>> +             // SAFETY: `dev` remains bound and valid for this call
>> +             unsafe { bindings::pm_suspend_ignore_children(dev.as_raw()=
, false) };
>> +        }
>> +    }
>> +
>> +    /// Get a borrowed reference to PM profiles associated with the PM =
context
>> +    pub fn profiles(&self) -> &[PMProfile] {
>> +        &self.inner.profiles
>> +    }
>> +
>> +    /// Get a borrowed reference to PM configs associated with the PM c=
ontext
>> +    pub fn configs(&self) -> &[PMConfig] {
>> +        &self.inner.configs
>> +    }
>> +}
>> +
>> +/// Runtime PM request profile.
>> +#[derive(Copy, Clone)]
>> +pub struct PMProfile(Mode);
>> +
>> +impl PMProfile {
>> +    /// Creates a PMProfile with default SYNC mode set.
>> +    pub const fn new() -> Self {
>> +        Self(Mode::empty())
>> +    }
>> +    /// Enables async PM operations for this PMProfile.
>> +    pub const fn r#async(self) -> Self {
>> +        Self(Mode(self.0 .0 | ModeFlag::Async as u32))
>> +    }
>> +    /// Use autosuspend
>> +    pub const fn auto(self) -> Self {
>> +        Self(Mode(self.0 .0 | ModeFlag::Auto as u32))
>> +    }
>> +    /// Requests idle handling for this PMProfile.
>> +    pub const fn idle(self) -> Self {
>> +        Self(Mode(self.0 .0 | ModeFlag::Idle as u32))
>> +    }
>> +    /// Do not wait for concurrent requests to finish.
>> +    pub const fn nowait(self) -> Self {
>> +        Self(Mode(self.0 .0 | ModeFlag::Nowait as u32))
>> +    }
>> +}
>> +
>> +impl Default for PMProfile {
>> +    fn default() -> Self {
>> +        Self::new()
>> +    }
>> +}
>> +
>> +/// Configuration knobs for runtime PM.
>> +pub enum PMConfig {
>> +    /// Ignore child devices when suspending.
>> +    IgnoreChildren(bool),
>> +    /// Disable runtime PM callbacks.
>> +    NoCallbacks,
>> +    /// Mark device as IRQ-safe for runtime PM.
>> +    /// Runtime PM callbacks run with local interrupts
>> +    /// disabled and must not sleep
>> +    IrqSafe,
>> +    /// Enable or disable autosuspend.
>> +    AutoSuspend(bool),
>> +    /// Set autosuspend delay (milliseconds).
>> +    AutoSuspendDelay(i32),
>> +}
>> +
>> +/// Runtime PM data stored within the `struct device_private` during
>> +/// runtime PM registration.
>> +///
>> +#[repr(C)]
>> +#[pin_data]
>> +struct RegistrationData<'a, T: PMOps> {
>> +    payload: Payload<'a, T>,
>> +    #[cfg_attr(not(CONFIG_PM), allow(dead_code))]
>> +    #[pin]
>> +    data: T::RegistrationData<'a>,
>> +    _marker: PhantomData<&'a mut T>,
>> +}
>> +
>> +/// Runtime PM registration for a device.
>> +///
>> +/// A `Registration` installs the `RegistrationData` alonw with the run=
time
>> +/// payload, used by the generated [`PMOps`] callbacks and owns
>> +/// the corresponding teardown.
>> +///
>> +/// Dropping the registration disables runtime PM, waits for in-flight =
runtime PM
>> +/// callbacks to complete, and then removes the stored registration dat=
a.
>> +#[pin_data(PinnedDrop)]
>> +pub struct Registration<'a, T>
>> +where
>> +    T:PMOps,
>> +{
>> +    ctx: PMContext<'inner, 'a,  T>,
>> +    #[pin]
>> +    inner: PMContextInner<'a, T>,
>> +    #[pin]
>> +    data: RegistrationData<'a, T>,
>> +}
>> +
>> +impl<'a, T: PMOps> Registration<'a, T> {
>> +    /// Creates a runtime PM registration for `dev`.
>> +    ///
>> +    /// The provided profiles and configuration are stored in the assoc=
iated
>> +    /// [`PMContext`]. The `initial_payload` is expected to reflect cur=
rent
>> +    /// power state of the device.
>> +    ///
>> +    /// The device must use the callback represented by `ops`, generate=
d
>> +    /// for the same bus adapter and driver pair `(D, T)`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The returned [`Registration`] object cannot be mem::forgotten,
>> +    /// or it's [`Drop`] implementation cannot be skipped in any way.
>> +    ///
>> +    pub unsafe fn new<E>(
>> +        dev: &'a Device<Core<'_>>,
>> +        ops: &'static Ops<T>,
>> +        profiles: Option<KVec<PMProfile>>,
>> +        configs: Option<KVec<PMConfig>>,
>> +        data: impl PinInit<<T as PMOps>::RegistrationData<'a>, E> + 'a,
>> +        initial_payload: RuntimeStatePayload<T::ActivePayload<'a>, T::S=
uspendedPayload<'a>>,
>> +    ) -> impl PinInit<Self, Error> + 'a
>> +    where
>> +        Error: From<E>,
>> +    {
>> +         let dev: &'a Device<Bound> =3D dev;
>> +
>> +       try_pin_init!(Self {
>> +           _: {
>> +               // SAFETY: For the duration of this call, `dev` is a val=
id `Device<Core>`,
>> +               // and so is its raw `struct device` pointer.
>> +               let pm =3D  unsafe { (*(*dev.as_raw()).driver).pm };
>> +               if  pm !=3D ops.as_raw() && (cfg!(CONFIG_PM) || !pm.is_n=
ull()) {
>> +                   return Err(EINVAL);
>> +               }
>> +               // SAFETY: Construction has exclusive access to this slo=
t.
>> +               if !unsafe {
>> +                    (*(*dev.as_raw()).p).rust.pm_registration_data
>> +               }.is_null() {
>> +                   return Err(EBUSY);
>> +               }
>> +           },
>> +           inner <- try_pin_init!(PMContextInner {
>> +               dev,
>> +               state: Atomic::new(PMContextState::Disabled),
>> +               guard <- new_srcu!("rpm"),
>> +               profiles: profiles.unwrap_or_default(),
>> +               configs: configs.unwrap_or_default(),
>> +               _marker: PhantomData,
>> +           }),
>> +           ctx : PMContext { inner: inner.get_ref(), },
>> +           data <- try_pin_init!(RegistrationData {
>> +                data <- data,
>> +                payload: Payload {in_flight: AtomicFlag::new(false), in=
ner: UnsafeCell::new(ManuallyDrop::new(initial_payload))},
>> +                _marker: PhantomData
>> +            }? E),
>> +            _: {
>> +                let ptr: NonNull<RegistrationData<'a, T>> =3D
>> +                    NonNull::from(data.as_ref().get_ref());
>> +                // SAFETY: The device is not yet registered, and neithe=
r is
>> +                // the runtime pm beingenabled - as such, there is no
>> +                // cuncurency here
>> +                unsafe {
>> +                    (*(*dev.as_raw()).p).rust.pm_registration_data =3D
>> +                        ptr.cast::<core::ffi::c_void>().as_ptr();
>> +                };
>> +
>> +            }
>> +       })
>> +
>> +   }
>> +    /// Returns the runtime PM context associated with this registratio=
n.
>> +    pub fn get_ctx(&self) -> PMContext<'_, 'a,  T> {
>> +        PMContext{ inner: &self.inner }
>> +    }
>> +}
>> +
>> +#[pinned_drop]
>> +impl<'a, T: PMOps> PinnedDrop for Registration<'a, T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // `self.inner.dev` is the device this registration was
>> +        // created for. Runtime PM is disabled first, and `pm_runtime_b=
arrier`
>> +        // waits for pending runtime PM work/callbacks before the callb=
ack data
>> +        // is removed below.
>> +        // Furthermore, prevent any stale `PMContext`s from re-enabling=
 runtime
>> +        // PM after teardown starts.
>> +        let prev =3D self.inner.state.xchg(PMContextState::Closing, ord=
ering::Full);
>> +
>> +        self.inner.guard.synchronize();
>> +
>> +        if prev =3D=3D PMContextState::Enabled {
>> +            Request::runtime_disable(self.inner.dev);
>> +            PMContext::<T>::reset_config(self.inner.dev, &self.inner.co=
nfigs);
>> +        }
>> +
>> +        Request::barrier(self.inner.dev);
>> +
>> +        // SAFETY: The pointer  was stored by `Registration::new`.
>> +        // Runtime PM has been disabled and drained above, so generated
>> +        // callbacks can no longer borrow this data.
>> +        unsafe {
>> +            (*(*self.inner.dev.as_raw()).p).rust.pm_registration_data =
=3D core::ptr::null_mut();
>> +        }
>> +    }
>> +}
>> --

