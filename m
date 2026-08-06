Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EE3DAAB4
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998706; cv=none; b=SHni6xhCqC+LkNVVGi1kipQRojMIr8U2DBanSJ1EStJMHk4FjGx1TFEWgllCSBwsGdN6zz1Ro9f5CciYMAu6SoqZJPyuHQ/yz6rg9gIRYvKzuNMM4WyfUUYDQmu5gcCyg+N+q2uUpfzXLiVIt6XCTa57luqNXcw3OZqQ8i1YTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998706; c=relaxed/simple;
	bh=fRTJ1SJFWkaeN99T099jlMEWWDBrUQRgB6IQGkMC//0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6rRLNSmbovI0aB6gLySQl3v/128FcqAbk42YZofxFTEx0xUYQBB97HO/20HizO4csipOC/vjK4D8jPN81AQnJwo9DHEe8IH6zlgPMiRMf+Ewd1QDMOlep1IhE2PBFCUwFOIH/RDGhSuLdbsYhFbmKt4x5yCcfFA96CuPuwdjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHqtjjYy; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHqtjjYy"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b6f97676so17924345e9.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785998703; x=1786603503; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRICwH8NrYFqbtAQ5CUI1CBNEXWJgmDrqZQyPRGCMDg=;
        b=LHqtjjYyc7p50lFWb++MNoxu50vjQThWRpPfuzM7kf7LQYMt1cM3xK5/PfrBKQSqxQ
         bG2yMsusCOHYOEzmhVCabWqj+Hl36iTDCk5BevenidVqwWG3J45DDbY8LJgQSfqRWzLk
         I+cbUu+3YXivb8ey4ekr4dnk7s1IaCNxrbDka7RWBJ8FRs1aAraZsBqXIHaLOj+/3BnD
         cuSWJM2FpZixERUjr9eipUd+nG3Aomh/C46SKB7HE6x+KL96il+QyLO4OjomF2dvSGdE
         p6WjYJd2SUpNJ5JGP2ZhKFwk1EAyPFCYgVfpQ4H8+37YZsgCTGErjOm75x9mYBOT28yO
         /HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998703; x=1786603503;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRICwH8NrYFqbtAQ5CUI1CBNEXWJgmDrqZQyPRGCMDg=;
        b=hdjeY8tt9aAnoal6CegKzulIv97ApzdP2kLEPFGJJ9Qjrv6uSOE4OJhybzMSGVayE+
         U6e0NHFLYXAYPWiresHcIPFTlxrJIY1u9Kw8iNh1Fzu4L3Jfa6M0rccYHEcxbaQKEEa8
         94SnJTbzhQy7Rgy2D9idylQYHvfjB9j4jNLQ7Vn/IadZ9Tz92Icsys4Ljb+lgPV2JApJ
         28M9RVjJIuWlTCKAgCI4PdqbcVT2aeEMZtjK312KqbyqSYTirIiKdzgCq/HjPpez47KV
         WLHd57xlXecysOjGXfQIj8aKc+IW6/brrpHzoVSw+N/Us/bVr46P6jxya+gXKddAUzoA
         Rupw==
X-Forwarded-Encrypted: i=1; AHgh+RrskwH+DHCWNfssBgOrY2CD5pn5Dpaj63EAlpR9fFqSoT27XQkwgpef0an3qbuihksq2B6wv4BOiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yG6w0ARmuXLYgYrw5I9kjuJl/wsQh6HXN3tCuwPgtm/XLET7
	gINYeTGJ1/OR+uh0clbLYpbXQSG5XJno1KreaasTR4yRkaVMnvnsOqDR42bX9Gb4vGnGpcRH1kc
	CnjcaPtthPXW2vWLjFg==
X-Received: from wmbjo7.prod.google.com ([2002:a05:600c:6b47:b0:493:c2c9:129b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr58567965e9.1.1785998702236;
 Wed, 05 Aug 2026 23:45:02 -0700 (PDT)
Date: Thu, 6 Aug 2026 06:45:01 +0000
In-Reply-To: <anHa43G9-aln8wik@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-3-beata.michalska@arm.com> <anGt2_OAK2UWtXuO@google.com>
 <anHa43G9-aln8wik@arm.com>
Message-ID: <anQtbRH9SB5H1zRe@google.com>
Subject: Re: [PATCH v2 2/3] rust: platform: wire runtime PM callbacks
From: Alice Ryhl <aliceryhl@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: dakr@kernel.org, ojeda@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 04, 2026 at 02:28:19PM +0200, Beata Michalska wrote:
> On Tue, Aug 04, 2026 at 09:16:11AM +0000, Alice Ryhl wrote:
> > On Tue, Jul 21, 2026 at 05:34:03PM +0200, Beata Michalska wrote:
> > > Allow Rust platform drivers to expose runtime PM callbacks to the driver core.
> > > 
> > > The runtime PM abstraction builds a dev_pm_ops table for the concrete driver
> > > implementation, but the platform bus still needs to receive that table through
> > > struct platform_driver. Add an optional PM_OPS associated constant to
> > > platform::Driver and initialize the coresponding C device_driver struct
> > > accordingly during registration. The platform glue only wires the callback
> > > table into the C driver model; ownership of the callback payload and
> > > runtime PM teardown remain with the pm module.
> > > 
> > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > ---
> > >  rust/kernel/platform.rs | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > > index d8d48f60b0b9..b7e422388634 100644
> > > --- a/rust/kernel/platform.rs
> > > +++ b/rust/kernel/platform.rs
> > > @@ -72,6 +72,11 @@ unsafe fn register(
> > >              None => core::ptr::null(),
> > >          };
> > >  
> > > +        let pm_ops = match T::PM_OPS {
> > > +            Some(ops) => ops,
> > > +            None => core::ptr::null(),
> > > +        };
> > > +
> > >          // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
> > >          unsafe {
> > >              (*pdrv.get()).driver.name = name.as_char_ptr();
> > > @@ -79,6 +84,7 @@ unsafe fn register(
> > >              (*pdrv.get()).remove = Some(Self::remove_callback);
> > >              (*pdrv.get()).driver.of_match_table = of_table;
> > >              (*pdrv.get()).driver.acpi_match_table = acpi_table;
> > > +            (*pdrv.get()).driver.pm = pm_ops;
> > >          }
> > >  
> > >          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
> > > @@ -222,6 +228,9 @@ pub trait Driver {
> > >      /// The table of ACPI device ids supported by the driver.
> > >      const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> > >  
> > > +    /// Runtime PM callbacks
> > > +    const PM_OPS: Option<&'static bindings::dev_pm_ops> = None;
> > > +
> > >      /// Platform driver probe.
> > >      ///
> > >      /// Called when a new platform device is added or discovered.
> > 
> > I've been thinking more about this, and I can't help but wonder whether
> > we could significantly simplify it. Why not just do this:
> > 
> > 1. Update rust/kernel/platform.rs Driver trait to include pm ops
> > directly in the trait:
> > 
> > 	#[vtable]
> > 	pub trait Driver {
> > 	    type IdInfo: 'static;
> > 	    type Data<'bound>: Send + 'bound;
> > 	    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> > 	    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> > 	
> > 	    fn probe<'bound>(
> > 	        dev: &'bound Device<device::Core<'_>>,
> > 	        id_info: Option<&'bound Self::IdInfo>,
> > 	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> > 	
> > 	    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
> > 	        let _ = (dev, this);
> > 	    }
> > 	
> > 	    // Add these methods.
> > 	    fn runtime_suspend<'bound>(
> > 	        dev: &'bound Device<device::Bound>,
> > 	        data: &Self::Data<'bound>,
> > 	    ) -> Result
> > 	    {
> > 	        build_error!(VTABLE_DEFAULT_ERROR)
> > 	    }
> > 	
> > 	    fn runtime_resume<'bound>(
> > 	        dev: &'bound Device<device::Bound>,
> > 	        data: &Self::Data<'bound>,
> > 	    ) -> Result
> > 	    {
> > 	        build_error!(VTABLE_DEFAULT_ERROR)
> > 	    }
> > 	}
> > 
> > By marking the trait with #[vtable], we know whether the user has
> > overridden runtime_suspend() and runtime_resume() and then the platform
> > abstraction can enable PM in that scenario:
> > 
> >  - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then set
> >    `(*pdrv.get()).driver.pm` to a table using those methods in
> >    register().
> >  - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then invoke
> >    `pm_runtime_enable()` from `probe_callback()` after the
> >    `set_callback()` line. Note that this call is infallible.
> >  - Do the same from unplug to disable PM.
> > 
> > And then you automatically PM whenever you implement those two methods
> > in the `platform::Driver` trait, and that's all you need to do. Since we
> > invoke `pm_runtime_enable()` in `probe_callback()` after setting the
> > private data, there's no issue with passing the device private data to
> > the callbacks.
> > 
> > Note that we can trigger a const eval panic on `T::HAS_RUNTIME_SUSPEND
> > != T::HAS_RUNTIME_RESUME` to enforce that you must implement both
> > methods if you implement either one.
> > 
> > Thoughts? I know we have gone down this route before, but I just think
> > it would be so so much simpler than the current approach. I know that
> > this diverges from IRQ and such by not having a Registration, but I
> > actually think that's ok. PM is already different from IRQ callbacks in
> > the sense that the platform abstractions need PM-specific code *anyway*
> > to properly set pm_ops in the `struct platform_device`.
> > 
> 
> This is a sound idea, though there are few caveats.
> This patchset only introduces runtime_resume and runtime_suspend, though the
> range of pm ops is wider than that. So if we go the way you suggest, we need to
> accept that all of those would finally end up in that trait's implementation.
> Further more this would need to be replicated for other bus devices.
> Which makes the implementation pretty noisy.

You can potentially do this:

	#[vtable]
	pub trait Driver {
	    type IdInfo: 'static;
	    type Data<'bound>: Send + 'bound;
	    type PMOps: PMOps; // set to Self or () for no PM
	    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
	    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
	
	    fn probe<'bound>(
	        dev: &'bound Device<device::Core<'_>>,
	        id_info: Option<&'bound Self::IdInfo>,
	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
	
	    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
	        let _ = (dev, this);
	    }
	}
	
	trait PMOps {
	    fn runtime_suspend<'bound>(
	        dev: &'bound Device<device::Bound>,
	        data: &Self::Data<'bound>,
	    ) -> Result
	    {
	        build_error!(VTABLE_DEFAULT_ERROR)
	    }
	
	    fn runtime_resume<'bound>(
	        dev: &'bound Device<device::Bound>,
	        data: &Self::Data<'bound>,
	    ) -> Result
	    {
	        build_error!(VTABLE_DEFAULT_ERROR)
	    }
	}

To avoid that duplication.

> Offloading enabling runtime PM to bus driver might not be suitable for all
> potential users of runtime PM either. Some drivers might want to enable it
> while in probe, call device resume and do some early setup. With this approach,
> using drvdata is still an issue.
> The sample implementation for Tyr is just one way of doing things.

Ok, it of course depends on how these things are actually used, but it
was not clear to me that this does not fit all actual use-cases in
practice.

Alice
