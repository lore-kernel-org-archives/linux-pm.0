Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612936B913;
	Tue,  4 Aug 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846508; cv=none; b=bExhg5//Hdrt2GeMJeKpgpTo2VemizIvRc1MJvRHMnTJP/COL5iVdfFSp4MAoz42WfPbfuRS/2mVuSBG2+ZwDzyoriT74vOjSdy+OOukXUh8Gl+Xg304v6tGfa1JVaZaAvWBznfVGnSVZbHgR93lgn1iDM4FqAGAEoowIGiZbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846508; c=relaxed/simple;
	bh=O6MGaayfqKbwMTZ8rRJxQ6cRb2muhGjQiCHzQ7H4mmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8/5gKCU7yiThzshO98XvA/j12QtZtvAXYU6CKGd41lxsElmoRERyTkdech4NQ3fJm93YqtWtqgc09zwnWmrS7mt9kaAbUxwWsEzhGSm+3aa5J83SCQY97xhWSBY5sE732RYzqlnVkeL27VXbdmV2AvqDzEbqnnNvfWX7T77xF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a8wogyMN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a8wogyMN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D5BF1476;
	Tue,  4 Aug 2026 05:28:22 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8603F66F;
	Tue,  4 Aug 2026 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785846506; bh=O6MGaayfqKbwMTZ8rRJxQ6cRb2muhGjQiCHzQ7H4mmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8wogyMNeg7UTwUcdUptjw7WYbB3APC17qU87uA9otovh8QHxD4g+DrqE41VYqe4T
	 iTaQDKBZXnJeFl8zSesylKmzFaE9hvUtoaweETmBHL1jea0F26KDhlyD6QB7BUTUb7
	 n7BAQQkYU90x6twYhezN+NUOL6F8mknM/9+P9LZs=
Date: Tue, 4 Aug 2026 14:28:19 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: dakr@kernel.org, ojeda@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: platform: wire runtime PM callbacks
Message-ID: <anHa43G9-aln8wik@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-3-beata.michalska@arm.com>
 <anGt2_OAK2UWtXuO@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGt2_OAK2UWtXuO@google.com>

On Tue, Aug 04, 2026 at 09:16:11AM +0000, Alice Ryhl wrote:
> On Tue, Jul 21, 2026 at 05:34:03PM +0200, Beata Michalska wrote:
> > Allow Rust platform drivers to expose runtime PM callbacks to the driver core.
> > 
> > The runtime PM abstraction builds a dev_pm_ops table for the concrete driver
> > implementation, but the platform bus still needs to receive that table through
> > struct platform_driver. Add an optional PM_OPS associated constant to
> > platform::Driver and initialize the coresponding C device_driver struct
> > accordingly during registration. The platform glue only wires the callback
> > table into the C driver model; ownership of the callback payload and
> > runtime PM teardown remain with the pm module.
> > 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  rust/kernel/platform.rs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > index d8d48f60b0b9..b7e422388634 100644
> > --- a/rust/kernel/platform.rs
> > +++ b/rust/kernel/platform.rs
> > @@ -72,6 +72,11 @@ unsafe fn register(
> >              None => core::ptr::null(),
> >          };
> >  
> > +        let pm_ops = match T::PM_OPS {
> > +            Some(ops) => ops,
> > +            None => core::ptr::null(),
> > +        };
> > +
> >          // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
> >          unsafe {
> >              (*pdrv.get()).driver.name = name.as_char_ptr();
> > @@ -79,6 +84,7 @@ unsafe fn register(
> >              (*pdrv.get()).remove = Some(Self::remove_callback);
> >              (*pdrv.get()).driver.of_match_table = of_table;
> >              (*pdrv.get()).driver.acpi_match_table = acpi_table;
> > +            (*pdrv.get()).driver.pm = pm_ops;
> >          }
> >  
> >          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
> > @@ -222,6 +228,9 @@ pub trait Driver {
> >      /// The table of ACPI device ids supported by the driver.
> >      const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> >  
> > +    /// Runtime PM callbacks
> > +    const PM_OPS: Option<&'static bindings::dev_pm_ops> = None;
> > +
> >      /// Platform driver probe.
> >      ///
> >      /// Called when a new platform device is added or discovered.
> 
> I've been thinking more about this, and I can't help but wonder whether
> we could significantly simplify it. Why not just do this:
> 
> 1. Update rust/kernel/platform.rs Driver trait to include pm ops
> directly in the trait:
> 
> 	#[vtable]
> 	pub trait Driver {
> 	    type IdInfo: 'static;
> 	    type Data<'bound>: Send + 'bound;
> 	    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> 	    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> 	
> 	    fn probe<'bound>(
> 	        dev: &'bound Device<device::Core<'_>>,
> 	        id_info: Option<&'bound Self::IdInfo>,
> 	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> 	
> 	    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
> 	        let _ = (dev, this);
> 	    }
> 	
> 	    // Add these methods.
> 	    fn runtime_suspend<'bound>(
> 	        dev: &'bound Device<device::Bound>,
> 	        data: &Self::Data<'bound>,
> 	    ) -> Result
> 	    {
> 	        build_error!(VTABLE_DEFAULT_ERROR)
> 	    }
> 	
> 	    fn runtime_resume<'bound>(
> 	        dev: &'bound Device<device::Bound>,
> 	        data: &Self::Data<'bound>,
> 	    ) -> Result
> 	    {
> 	        build_error!(VTABLE_DEFAULT_ERROR)
> 	    }
> 	}
> 
> By marking the trait with #[vtable], we know whether the user has
> overridden runtime_suspend() and runtime_resume() and then the platform
> abstraction can enable PM in that scenario:
> 
>  - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then set
>    `(*pdrv.get()).driver.pm` to a table using those methods in
>    register().
>  - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then invoke
>    `pm_runtime_enable()` from `probe_callback()` after the
>    `set_callback()` line. Note that this call is infallible.
>  - Do the same from unplug to disable PM.
> 
> And then you automatically PM whenever you implement those two methods
> in the `platform::Driver` trait, and that's all you need to do. Since we
> invoke `pm_runtime_enable()` in `probe_callback()` after setting the
> private data, there's no issue with passing the device private data to
> the callbacks.
> 
> Note that we can trigger a const eval panic on `T::HAS_RUNTIME_SUSPEND
> != T::HAS_RUNTIME_RESUME` to enforce that you must implement both
> methods if you implement either one.
> 
> Thoughts? I know we have gone down this route before, but I just think
> it would be so so much simpler than the current approach. I know that
> this diverges from IRQ and such by not having a Registration, but I
> actually think that's ok. PM is already different from IRQ callbacks in
> the sense that the platform abstractions need PM-specific code *anyway*
> to properly set pm_ops in the `struct platform_device`.
> 

This is a sound idea, though there are few caveats.
This patchset only introduces runtime_resume and runtime_suspend, though the
range of pm ops is wider than that. So if we go the way you suggest, we need to
accept that all of those would finally end up in that trait's implementation.
Further more this would need to be replicated for other bus devices.
Which makes the implementation pretty noisy.
Offloading enabling runtime PM to bus driver might not be suitable for all
potential users of runtime PM either. Some drivers might want to enable it
while in probe, call device resume and do some early setup. With this approach,
using drvdata is still an issue.
The sample implementation for Tyr is just one way of doing things.

---
BR
Beata
> Alice
