Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFD3769F8;
	Mon,  3 Aug 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749469; cv=none; b=QZmvV3pqbCUZgDgaEwLxiwZeBOTWj5J/cZwC29UW8byiP02ihhES0LsLHFJlZi8cEDkP8mJTY4wt18iPqMjLDLiE3tR7I+TAr7Gu6tedhKJrrSciE6isupwqMXvaiWrW08cOTxfBkl3FovYT/WKdlhi3A8g3wW3Kt/Ez0KngliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749469; c=relaxed/simple;
	bh=MutnWZ70OZX6YobuvPPiKQs59LIJbeSGdq5w03ht+gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWdgMpvkaSUpsgTrco1hOoZOnroMk2cRb7Zw/rFiKvS/gwihgX3chMKIAACdmSYphYpAowXpY25ASG6SUFBqvUawSY6O9zAdV3+AgbBQjrazRsV/6YvYPnOKtgHT1mBn4D5ZC1AJJYOXD6FR5Xm2QTQbn42jIpLxoYKLQTW6jnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tXwXFlSh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tXwXFlSh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D63F1476;
	Mon,  3 Aug 2026 02:30:52 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B833D3F66F;
	Mon,  3 Aug 2026 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785749456; bh=MutnWZ70OZX6YobuvPPiKQs59LIJbeSGdq5w03ht+gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXwXFlSh9voL1WApq6ooDsyYD45CD1RmSCWOh/mh/+6SAqhmuMS8J3SrNGubs6oEE
	 YUMxxv9rhHHWrwhjECjo/uXNdMeCRwY53jBDlpJR2It8Ox1fcQ0PVM7AlM2FjwGHK3
	 Sxf042pJAxyfvjNSj6i9VGV2PYPqcLUxJo89Ux2s=
Date: Mon, 3 Aug 2026 11:30:42 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, boris.brezillon@collabora.com,
	samitolvanen@google.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: add runtime PM support
Message-ID: <anBfwkA0y6Ney850@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-2-beata.michalska@arm.com>
 <20260727145622.904965-1-work@onurozkan.dev>
 <amnCwIMj5dIJevfk@arm.com>
 <20260729135830.412048-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729135830.412048-1-work@onurozkan.dev>

On Wed, Jul 29, 2026 at 04:58:28PM +0300, Onur Özkan wrote:
> On Wed, 29 Jul 2026 11:07:12 +0200
> Beata Michalska <beata.michalska@arm.com> wrote:
> 
> > On Mon, Jul 27, 2026 at 05:56:20PM +0300, Onur Özkan wrote:
> > > On Tue, 21 Jul 2026 17:34:02 +0200
> > > Beata Michalska <beata.michalska@arm.com> wrote:
> > > 
> > > > Add a Rust abstraction for Linux runtime PM, allowing Rust drivers to
> > > > register runtime PM callbacks and use scoped runtime PM requests while
> > > > retaining the behavior and guarantees of the underlying C PM core.
> > > > 
> > > > Runtime PM is managed through a registration object tied to the device
> > > > lifetime. The registration stores the callback payload and 'ensures' that
> > > > the registration, its `PMContext`, and the payload do not outlive the
> > > > device. All that while `PMContext` holds a lifetime-annotated device reference
> > > > so that runtime PM requests are made only while the device remains bound.
> > > > 
> > > > Drivers define runtime PM callbacks through the `PMOps` trait. The
> > > > generated `dev_pm_ops` callbacks take the stored payload, pass ownership
> > > > to the corresponding Rust callback, and store the returned payload for
> > > > the next invocation. Each callback must return a valid payload,
> > > > regardless of whether the power transition succeeds or not.
> > > > 
> > > > `PMContext` provides scoped helpers for common runtime PM operations:
> > > > 
> > > > - `ResumeScope` resumes the device for the lifetime of the scope.
> > > > - `AwakeScope`  resumes the device and holds a runtime PM usage reference.
> > > > - `RetainScope` increments the runtime PM usage count without resuming the
> > > >   		device.
> > > > 
> > > > Each scope performs the corresponding inverse operation when dropped,
> > > > according to the selected driver-defined profile.
> > > > 
> > > > The abstraction does not change the semantics of the C runtime PM API.
> > > > Asynchronous requests may only queue work, non-waiting requests may fail
> > > > instead of sleeping, and callbacks remain subject to the existing driver
> > > > core rules.
> > > > 
> > > > The current implementation requires the PM registration and `PMOps`
> > > > implementation to use the same type because callback dispatch interprets
> > > > the stored registration data using that relationship. This requirement is
> > > > not yet fully enforced by the type system.
> > > > 
> > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > ---
> > > >  drivers/base/base.h             |    3 +
> > > >  rust/bindings/bindings_helper.h |    1 +
> > > >  rust/helpers/helpers.c          |    1 +
> > > >  rust/helpers/pm_runtime.c       |   44 ++
> > > >  rust/kernel/lib.rs              |    1 +
> > > >  rust/kernel/pm.rs               | 1020 +++++++++++++++++++++++++++++++
> > > >  6 files changed, 1070 insertions(+)
> > > >  create mode 100644 rust/helpers/pm_runtime.c
> > > >  create mode 100644 rust/kernel/pm.rs
> > > > 
> > > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > > index a19f4cda2c83..c49303e4a86a 100644
> > > > --- a/drivers/base/base.h
> > > > +++ b/drivers/base/base.h
> > > > @@ -119,6 +119,9 @@ struct device_private {
> > > >  	const struct device_driver *async_driver;
> > > >  	char *deferred_probe_reason;
> > > >  	struct device *device;
> > > > +#ifdef CONFIG_RUST
> > > > +	void *rust_private;
> > > > +#endif
> > > >  	u8 dead:1;
> > > >  };
> > > >  #define to_device_private_parent(obj)	\
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > > index 1124785e210b..78a9153c6a01 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -77,6 +77,7 @@
> > > >  #include <linux/pid_namespace.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_opp.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/poll.h>
> > > >  #include <linux/property.h>
> > > >  #include <linux/pwm.h>
> > > > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > > > index 4488a87223b9..14d93a5d8b1f 100644
> > > > --- a/rust/helpers/helpers.c
> > > > +++ b/rust/helpers/helpers.c
> > > > @@ -76,6 +76,7 @@
> > > >  #include "pci.c"
> > > >  #include "pid_namespace.c"
> > > >  #include "platform.c"
> > > > +#include "pm_runtime.c"
> > > >  #include "poll.c"
> > > >  #include "processor.c"
> > > >  #include "property.c"
> > > > diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
> > > > new file mode 100644
> > > > index 000000000000..d0d71fcb0097
> > > > --- /dev/null
> > > > +++ b/rust/helpers/pm_runtime.c
> > > > @@ -0,0 +1,44 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <linux/pm_runtime.h>
> > > > +
> > > > +__rust_helper void rust_helper_pm_runtime_get_noresume(struct device *dev)
> > > > +{
> > > > +	pm_runtime_get_noresume(dev);
> > > > +}
> > > > +
> > > > +__rust_helper void rust_helper_pm_runtime_put_noidle(struct device *dev)
> > > > +{
> > > > +	pm_runtime_put_noidle(dev);
> > > > +}
> > > > +
> > > > +__rust_helper void rust_helper_pm_runtime_mark_last_busy(struct device *dev)
> > > > +{
> > > > +	pm_runtime_mark_last_busy(dev) ;
> > > > +}
> > > > +
> > > > +__rust_helper bool rust_helper_pm_runtime_active(struct device *dev)
> > > > +{
> > > > +	return pm_runtime_active(dev);
> 
> [...]
> 
> > > > +        // The `Device<Bound>` reference provides that guarantee.
> > > > +        unsafe {
> > > > +            bindings::pm_runtime_mark_last_busy(dev.as_raw());
> > > > +        }
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn suspend(dev: &device::Device<device::Bound>, mode: Mode) -> Result {
> > > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to
> > > > +        // `struct device` for the duration of the call.
> > > > +        // The `Device<Bound>` reference provides that guarantee.
> > > > +        to_result(unsafe { bindings::__pm_runtime_suspend(dev.as_raw(), mode.into()) })
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn get_if_active(dev: &device::Device<device::Bound>) -> Result {
> > > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to
> > > > +        // `struct device` for the duration of the call.
> > > > +        // The `Device<Bound>` reference provides that guarantee.
> > > > +        match unsafe { bindings::pm_runtime_get_if_active(dev.as_raw()) } {
> > > > +            ret if ret < 0 => Err(Error::from_errno(ret)),
> > > > +            0 => Err(EAGAIN),
> > > > +            _ => Ok(()),
> > > > +        }
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn runtime_enable(dev: &device::Device<device::Bound>) {
> > > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to
> > > > +        // `struct device` for the duration of the call.
> > > > +        // The `Device<Bound>` reference provides that guarantee.
> > > > +        unsafe { bindings::pm_runtime_enable(dev.as_raw()) }
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn runtime_disable(dev: &device::Device<device::Bound>) {
> > > > +        // SAFETY: `dev.as_raw()` must provide a valid pointer to
> > > > +        // `struct device` for the duration of the call.
> > > > +        // The `Device<Bound>` reference provides that guarantee.
> > > > +        unsafe { bindings::__pm_runtime_disable(dev.as_raw(), true) };
> > > > +    }
> > > 
> > > What happens when you call these twice i.e. runtime_enable() when it's already
> > > enabled or runtime_disable() when it's already disabled?
> > > 
> > For pm_runtime_enable  - this will drop a warning.
> > For pm_runtime_disable - the disable_depth counter will be increased. This
> > implies that for every extra disable call - enable one needs to be issued.
> > All handled by PM core.
> 
> I see. I was about to suggest typestate pattern here as we can easily avoid
> these issues, but if you want to rely on PM core that's also fine I guess.
> 
> > > > +}
> > > > +
> > > > +#[cfg(not(CONFIG_PM))]
> > > > +impl Request {
> > > > +    #[inline]
> > > > +    fn active(dev: &device::Device<device::Bound>) -> bool {
> > > > +        true
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn suspended(dev: &device::Device<device::Bound>) -> bool {
> > > > +        false
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn resume(_dev: &device::Device<device::Bound>, _mode: Mode) -> Result {
> > > > +        Ok(())
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    fn idle(_dev: &device::Device<device::Bound>, _mode: Mode) -> Result {
> > > > +        Err(ENOSYS)
> > > > +    }
> > > > +
> 
> [...]
> 
> > > > +    /// Returns the runtime PM context associated with this registration.
> > > > +    pub fn ctx(&self) -> &PMContext<'a, T> {
> > > > +        &self.ctx
> > > > +    }
> > > > +}
> > > > +
> > > > +impl<'a, T: PMOps> Drop for Registration<'a, T> {
> > > > +    fn drop(&mut self) {
> > > > +        // SAFETY: `self.ctx.inner.dev` is the device this registration was
> > > > +        // created for. Runtime PM is disabled first, and `pm_runtime_barrier`
> > > > +        // waits for pending runtime PM work/callbacks before the callback data
> > > > +        // is removed below.
> > > > +
> > > > +        unsafe {
> > > > +            bindings::__pm_runtime_disable(self.ctx.inner.dev.as_raw(), true);
> > > 
> > > Same here, is this safe to call even if it's not enabled? Registration can drop
> > > even when pm runtime is not enabled, right?
> > True but that again is handled by PM core.
> 
> You should at least document that.
Noted,
> 
> > > 
> > > > +            bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw());
> > > > +        }
> > > 
> > > You should not combine multiple unsafe calls in single unsafe block I think.
> > Why?
> 
> To keep the scope of each unsafe block as small as possible.
Right, though I do not see much point in doing that in this case.
Both calls rely on the same safety assumptions.
Unless I am missing smth.

---
BR
Beata

> 
> > Do not see much point in separating those.
> > 
> > ---
> > BR
> > Beata
> > > 
> > > > +        // SAFETY: The pointer, if non-null, was stored by `Registration::new`
> > > > +        // using `Pin<KBox<RegistrationData<T>>>::into_foreign`. Runtime PM has
> > > > +        // been disabled and drained above, so generated callbacks can no longer
> > > > +        // borrow this data. Clearing `rust_private` prevents later lookup, and
> > > > +        // `from_foreign` reconstructs the owning allocation so it is dropped.
> > > > +        unsafe {
> > > > +            let ptr = (*(*self.ctx.inner.dev.as_raw()).p).rust_private;
> > > > +
> > > > +            if !ptr.is_null() {
> > > > +                (*(*self.ctx.inner.dev.as_raw()).p).rust_private = core::ptr::null_mut();
> > > > +                Pin::<KBox<RegistrationData<'_, T>>>::from_foreign(ptr);
> > > > +            }
> > > > +        }
> > > > +    }
> > > > +}
> > > > -- 
> > > > 2.43.0
> > > > 
