Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F78486E74
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333529; cv=none; b=CkEC0t/N6pJizrFbxXGf3To6s8YbgccokxvS3awPjbj/oFGACQ7cwKGCJCzrXy4wnyi5ET72LYZ/p0Iq6IKObzxB38WnI0xBTt9uyAsgniFdqeJC9pc06/4cAKhjojlqBbva8lBrmh6sLVJEoL5auG4LONvSRKytVVj2TiVsBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333529; c=relaxed/simple;
	bh=7agwiNjT2Zbo4oK3OhnP10yj1z22bzUitQFouWfo0V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLNqNUirGgax8kI1kN0i7o8L8cVse5/L3/LNpmSzrdJzbJOzvJ5w8/bJ0pqFasJuNnOY9HYvj2DQ0UUBDAfccOsmm7ATGcfkHv5KrA3Q9CHoR+YRryYGhRadOM6g/HdmQCkbbOkcygwI5gIKWyZhJS2eu8/emow0C6xXwzSmc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=tGN0snve; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="tGN0snve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785333514; x=1785592714;
	bh=iRZrXScmBt7Xn5PKV2idbmZkaUeVgRzFQGtp98fuQIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tGN0snvepjHoyjKDELlbEe8O1GEUoghn2xmz5ljBPwvx53Cn+b+F3+wbkdRyywu/T
	 aEcu5WNnBn9KZQfVmsqhFJ146kz8Wx+j32CVy3x6R33dKPDjIgorEA718f7+xEE1RC
	 W/WwpHfH5TrDabjmT8LR6844hH3G3v8mTWJ0CzGexpgg18DekLszfAN02zY8wUvxQ8
	 ATUReAotU7rPVFRZDCqSmssKQnrd2NHHoW5o5UaxcDbncU17lYOx9L7K1h6g0lG2Ou
	 M/q9i5j5GpZEby6ZXctiXW8kGlMcEMIyjRk53piATPlVF6PTlffsgpH8BK1EAXRT8a
	 MPH1Os3Mlbg2g==
X-Pm-Submission-Id: 4h9DSm0stMz1DFF2
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	boris.brezillon@collabora.com,
	samitolvanen@google.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: add runtime PM support
Date: Wed, 29 Jul 2026 16:58:28 +0300
Message-ID: <20260729135830.412048-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <amnCwIMj5dIJevfk@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com> <20260721153617.869933-2-beata.michalska@arm.com> <20260727145622.904965-1-work@onurozkan.dev> <amnCwIMj5dIJevfk@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 11:07:12 +0200=0D
Beata Michalska <beata.michalska@arm.com> wrote:=0D
=0D
> On Mon, Jul 27, 2026 at 05:56:20PM +0300, Onur =C3=96zkan wrote:=0D
> > On Tue, 21 Jul 2026 17:34:02 +0200=0D
> > Beata Michalska <beata.michalska@arm.com> wrote:=0D
> > =0D
> > > Add a Rust abstraction for Linux runtime PM, allowing Rust drivers to=
=0D
> > > register runtime PM callbacks and use scoped runtime PM requests whil=
e=0D
> > > retaining the behavior and guarantees of the underlying C PM core.=0D
> > > =0D
> > > Runtime PM is managed through a registration object tied to the devic=
e=0D
> > > lifetime. The registration stores the callback payload and 'ensures' =
that=0D
> > > the registration, its `PMContext`, and the payload do not outlive the=
=0D
> > > device. All that while `PMContext` holds a lifetime-annotated device =
reference=0D
> > > so that runtime PM requests are made only while the device remains bo=
und.=0D
> > > =0D
> > > Drivers define runtime PM callbacks through the `PMOps` trait. The=0D
> > > generated `dev_pm_ops` callbacks take the stored payload, pass owners=
hip=0D
> > > to the corresponding Rust callback, and store the returned payload fo=
r=0D
> > > the next invocation. Each callback must return a valid payload,=0D
> > > regardless of whether the power transition succeeds or not.=0D
> > > =0D
> > > `PMContext` provides scoped helpers for common runtime PM operations:=
=0D
> > > =0D
> > > - `ResumeScope` resumes the device for the lifetime of the scope.=0D
> > > - `AwakeScope`  resumes the device and holds a runtime PM usage refer=
ence.=0D
> > > - `RetainScope` increments the runtime PM usage count without resumin=
g the=0D
> > >   		device.=0D
> > > =0D
> > > Each scope performs the corresponding inverse operation when dropped,=
=0D
> > > according to the selected driver-defined profile.=0D
> > > =0D
> > > The abstraction does not change the semantics of the C runtime PM API=
.=0D
> > > Asynchronous requests may only queue work, non-waiting requests may f=
ail=0D
> > > instead of sleeping, and callbacks remain subject to the existing dri=
ver=0D
> > > core rules.=0D
> > > =0D
> > > The current implementation requires the PM registration and `PMOps`=0D
> > > implementation to use the same type because callback dispatch interpr=
ets=0D
> > > the stored registration data using that relationship. This requiremen=
t is=0D
> > > not yet fully enforced by the type system.=0D
> > > =0D
> > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>=0D
> > > ---=0D
> > >  drivers/base/base.h             |    3 +=0D
> > >  rust/bindings/bindings_helper.h |    1 +=0D
> > >  rust/helpers/helpers.c          |    1 +=0D
> > >  rust/helpers/pm_runtime.c       |   44 ++=0D
> > >  rust/kernel/lib.rs              |    1 +=0D
> > >  rust/kernel/pm.rs               | 1020 +++++++++++++++++++++++++++++=
++=0D
> > >  6 files changed, 1070 insertions(+)=0D
> > >  create mode 100644 rust/helpers/pm_runtime.c=0D
> > >  create mode 100644 rust/kernel/pm.rs=0D
> > > =0D
> > > diff --git a/drivers/base/base.h b/drivers/base/base.h=0D
> > > index a19f4cda2c83..c49303e4a86a 100644=0D
> > > --- a/drivers/base/base.h=0D
> > > +++ b/drivers/base/base.h=0D
> > > @@ -119,6 +119,9 @@ struct device_private {=0D
> > >  	const struct device_driver *async_driver;=0D
> > >  	char *deferred_probe_reason;=0D
> > >  	struct device *device;=0D
> > > +#ifdef CONFIG_RUST=0D
> > > +	void *rust_private;=0D
> > > +#endif=0D
> > >  	u8 dead:1;=0D
> > >  };=0D
> > >  #define to_device_private_parent(obj)	\=0D
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings=
_helper.h=0D
> > > index 1124785e210b..78a9153c6a01 100644=0D
> > > --- a/rust/bindings/bindings_helper.h=0D
> > > +++ b/rust/bindings/bindings_helper.h=0D
> > > @@ -77,6 +77,7 @@=0D
> > >  #include <linux/pid_namespace.h>=0D
> > >  #include <linux/platform_device.h>=0D
> > >  #include <linux/pm_opp.h>=0D
> > > +#include <linux/pm_runtime.h>=0D
> > >  #include <linux/poll.h>=0D
> > >  #include <linux/property.h>=0D
> > >  #include <linux/pwm.h>=0D
> > > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c=0D
> > > index 4488a87223b9..14d93a5d8b1f 100644=0D
> > > --- a/rust/helpers/helpers.c=0D
> > > +++ b/rust/helpers/helpers.c=0D
> > > @@ -76,6 +76,7 @@=0D
> > >  #include "pci.c"=0D
> > >  #include "pid_namespace.c"=0D
> > >  #include "platform.c"=0D
> > > +#include "pm_runtime.c"=0D
> > >  #include "poll.c"=0D
> > >  #include "processor.c"=0D
> > >  #include "property.c"=0D
> > > diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c=0D
> > > new file mode 100644=0D
> > > index 000000000000..d0d71fcb0097=0D
> > > --- /dev/null=0D
> > > +++ b/rust/helpers/pm_runtime.c=0D
> > > @@ -0,0 +1,44 @@=0D
> > > +// SPDX-License-Identifier: GPL-2.0=0D
> > > +=0D
> > > +#include <linux/pm_runtime.h>=0D
> > > +=0D
> > > +__rust_helper void rust_helper_pm_runtime_get_noresume(struct device=
 *dev)=0D
> > > +{=0D
> > > +	pm_runtime_get_noresume(dev);=0D
> > > +}=0D
> > > +=0D
> > > +__rust_helper void rust_helper_pm_runtime_put_noidle(struct device *=
dev)=0D
> > > +{=0D
> > > +	pm_runtime_put_noidle(dev);=0D
> > > +}=0D
> > > +=0D
> > > +__rust_helper void rust_helper_pm_runtime_mark_last_busy(struct devi=
ce *dev)=0D
> > > +{=0D
> > > +	pm_runtime_mark_last_busy(dev) ;=0D
> > > +}=0D
> > > +=0D
> > > +__rust_helper bool rust_helper_pm_runtime_active(struct device *dev)=
=0D
> > > +{=0D
> > > +	return pm_runtime_active(dev);=0D
=0D
[...]=0D
=0D
> > > +        // The `Device<Bound>` reference provides that guarantee.=0D
> > > +        unsafe {=0D
> > > +            bindings::pm_runtime_mark_last_busy(dev.as_raw());=0D
> > > +        }=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn suspend(dev: &device::Device<device::Bound>, mode: Mode) -> R=
esult {=0D
> > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to=0D
> > > +        // `struct device` for the duration of the call.=0D
> > > +        // The `Device<Bound>` reference provides that guarantee.=0D
> > > +        to_result(unsafe { bindings::__pm_runtime_suspend(dev.as_raw=
(), mode.into()) })=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn get_if_active(dev: &device::Device<device::Bound>) -> Result =
{=0D
> > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to=0D
> > > +        // `struct device` for the duration of the call.=0D
> > > +        // The `Device<Bound>` reference provides that guarantee.=0D
> > > +        match unsafe { bindings::pm_runtime_get_if_active(dev.as_raw=
()) } {=0D
> > > +            ret if ret < 0 =3D> Err(Error::from_errno(ret)),=0D
> > > +            0 =3D> Err(EAGAIN),=0D
> > > +            _ =3D> Ok(()),=0D
> > > +        }=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn runtime_enable(dev: &device::Device<device::Bound>) {=0D
> > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to=0D
> > > +        // `struct device` for the duration of the call.=0D
> > > +        // The `Device<Bound>` reference provides that guarantee.=0D
> > > +        unsafe { bindings::pm_runtime_enable(dev.as_raw()) }=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn runtime_disable(dev: &device::Device<device::Bound>) {=0D
> > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to=0D
> > > +        // `struct device` for the duration of the call.=0D
> > > +        // The `Device<Bound>` reference provides that guarantee.=0D
> > > +        unsafe { bindings::__pm_runtime_disable(dev.as_raw(), true) =
};=0D
> > > +    }=0D
> > =0D
> > What happens when you call these twice i.e. runtime_enable() when it's =
already=0D
> > enabled or runtime_disable() when it's already disabled?=0D
> > =0D
> For pm_runtime_enable  - this will drop a warning.=0D
> For pm_runtime_disable - the disable_depth counter will be increased. Thi=
s=0D
> implies that for every extra disable call - enable one needs to be issued=
.=0D
> All handled by PM core.=0D
=0D
I see. I was about to suggest typestate pattern here as we can easily avoid=
=0D
these issues, but if you want to rely on PM core that's also fine I guess.=
=0D
=0D
> > > +}=0D
> > > +=0D
> > > +#[cfg(not(CONFIG_PM))]=0D
> > > +impl Request {=0D
> > > +    #[inline]=0D
> > > +    fn active(dev: &device::Device<device::Bound>) -> bool {=0D
> > > +        true=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn suspended(dev: &device::Device<device::Bound>) -> bool {=0D
> > > +        false=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn resume(_dev: &device::Device<device::Bound>, _mode: Mode) -> =
Result {=0D
> > > +        Ok(())=0D
> > > +    }=0D
> > > +=0D
> > > +    #[inline]=0D
> > > +    fn idle(_dev: &device::Device<device::Bound>, _mode: Mode) -> Re=
sult {=0D
> > > +        Err(ENOSYS)=0D
> > > +    }=0D
> > > +=0D
=0D
[...]=0D
=0D
> > > +    /// Returns the runtime PM context associated with this registra=
tion.=0D
> > > +    pub fn ctx(&self) -> &PMContext<'a, T> {=0D
> > > +        &self.ctx=0D
> > > +    }=0D
> > > +}=0D
> > > +=0D
> > > +impl<'a, T: PMOps> Drop for Registration<'a, T> {=0D
> > > +    fn drop(&mut self) {=0D
> > > +        // SAFETY: `self.ctx.inner.dev` is the device this registrat=
ion was=0D
> > > +        // created for. Runtime PM is disabled first, and `pm_runtim=
e_barrier`=0D
> > > +        // waits for pending runtime PM work/callbacks before the ca=
llback data=0D
> > > +        // is removed below.=0D
> > > +=0D
> > > +        unsafe {=0D
> > > +            bindings::__pm_runtime_disable(self.ctx.inner.dev.as_raw=
(), true);=0D
> > =0D
> > Same here, is this safe to call even if it's not enabled? Registration =
can drop=0D
> > even when pm runtime is not enabled, right?=0D
> True but that again is handled by PM core.=0D
=0D
You should at least document that.=0D
=0D
> > =0D
> > > +            bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw()=
);=0D
> > > +        }=0D
> > =0D
> > You should not combine multiple unsafe calls in single unsafe block I t=
hink.=0D
> Why?=0D
=0D
To keep the scope of each unsafe block as small as possible.=0D
=0D
> Do not see much point in separating those.=0D
> =0D
> ---=0D
> BR=0D
> Beata=0D
> > =0D
> > > +        // SAFETY: The pointer, if non-null, was stored by `Registra=
tion::new`=0D
> > > +        // using `Pin<KBox<RegistrationData<T>>>::into_foreign`. Run=
time PM has=0D
> > > +        // been disabled and drained above, so generated callbacks c=
an no longer=0D
> > > +        // borrow this data. Clearing `rust_private` prevents later =
lookup, and=0D
> > > +        // `from_foreign` reconstructs the owning allocation so it i=
s dropped.=0D
> > > +        unsafe {=0D
> > > +            let ptr =3D (*(*self.ctx.inner.dev.as_raw()).p).rust_pri=
vate;=0D
> > > +=0D
> > > +            if !ptr.is_null() {=0D
> > > +                (*(*self.ctx.inner.dev.as_raw()).p).rust_private =3D=
 core::ptr::null_mut();=0D
> > > +                Pin::<KBox<RegistrationData<'_, T>>>::from_foreign(p=
tr);=0D
> > > +            }=0D
> > > +        }=0D
> > > +    }=0D
> > > +}=0D
> > > -- =0D
> > > 2.43.0=0D
> > > =0D
