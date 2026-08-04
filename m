Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575C23033FB;
	Tue,  4 Aug 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846412; cv=none; b=qW/AIGBFnxsy8lLF91AVpnjhTo/TBqviOBiaMA2iGoAfT7HGCQc0ZJbl210WS+HID9o9nKIwK2w+a5VIHRHlcvTEXu4kL5oxqa1AJeduwYPx2vcBA4u8mhi2ls8FGcal+MYmMcB+Dt8t0KJhiOeDQC8reoUZ0+U1TDkffoEPnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846412; c=relaxed/simple;
	bh=CIsOcSZCewxuRWrvNu5o7YPTP1SaaWyKIrQd6nnzQGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APzauKwqWAI/E3pI2JMcsY44Gcf16eYpVEKKI3olptP1O0XsF2ilMOZzMmwO12OMsCNTFmVZkOWS0uRGVQ8dk8puyNBETVBCkS8Kgc3Hug+nCE3luNx/8XLxFWpgF3MQqR9Y3N4n2FO8zTff+8X4ut5fB7GCbs9B2irz0Zy34mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rdeXvjAL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rdeXvjAL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A831476;
	Tue,  4 Aug 2026 05:26:45 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420813F66F;
	Tue,  4 Aug 2026 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785846409; bh=CIsOcSZCewxuRWrvNu5o7YPTP1SaaWyKIrQd6nnzQGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdeXvjALc5P08CCMWdpwpyu5PRruugZhG1Xvm9uVtHOFvTMfGg+V6W6T/KiyyYlUt
	 wOQLJQbZHZMR/zuB0JteLez8DYdJLuzXMr9gl++Sdk/0aysmW+4qeZ91MXNrLBSMVO
	 enn79nzimhnI5kZq8RXFPtCb8YQ/J9mbVABirUCw=
Date: Tue, 4 Aug 2026 14:26:37 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: platform: wire runtime PM callbacks
Message-ID: <anHafc4O3bKcTeoc@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-3-beata.michalska@arm.com>
 <anGcgxwNXz5_RzD1@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGcgxwNXz5_RzD1@google.com>

On Tue, Aug 04, 2026 at 08:02:11AM +0000, Alice Ryhl wrote:
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
> 
> This value is just any user-provided &bindings::pm_ops, which I think is
> too lax. There is no guarantee that the Registration and the PM_OPS
> table agree on what the type T is, which can lead to type confusion.
> 
Indeed, as stated in the commit message
> Most likely, you must instead give `trait Driver` an associated type
> saying "the PmOps type is this particular type", and then here you can
> do `Some(T::PM_OPS)` to actually get the associated table.
> 
> And then in the registration, you can further require that the types
> also match there. E.g., maybe make the registration generic over the
> Driver type and then the inner type T is just D::PmData or similar.
> 
I do need to ponder on that one a bit.

---
BR
Beata

> Alice
> 
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
> > -- 
> > 2.43.0
> > 
