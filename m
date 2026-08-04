Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C943CE42
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834976; cv=none; b=X9ooGeirnL++XPPOwMcUOFmLQP/43OwbP5a1Gx7sOZ1t5V4FnUJQgAFPcYaCdO91Kx7aOXZIHzB/2UI8PXNl90h4GF3oIsgzf64Etls0G84OGzZAeNKxczZD6hHK89JCSlJR9Ix0myV7wWZKYOPggM4N5B/kEKreQSVjRtrJNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834976; c=relaxed/simple;
	bh=seQi5dHm7N0iENzPndBuyLMvlINbZuNsFgRvyq8o0Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MIidTdQMCqk7A4YPIQjZgnbJS7FEzENOvTV56At4LhH9CZkmybRtYmJU+ejUeVFeqWfV8aQMfvAneoode706VKekBlQhoQc4OrQjOp7J9DrEkIOKfjPzOdL1WuWEMi/j2sLPf3dmOV7upCfywdLebvgkhtNXCGgqHg3Uns2Uoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrQBhyTc; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrQBhyTc"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so30908025e9.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785834973; x=1786439773; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7xJl7liXrGedcihtRFOy204jJIb+lTqMppbYEP+Pf0=;
        b=OrQBhyTcDRQPJ5KqhK1HKgtUqG0Jxc5xUNLRsrRPlID6T3Q0kISmeqvkGPKCXuQBOD
         m381kPvGmBBuN3cWw2YJXIBsI4rLeKqgKvlOdfFVCyFRiFcMncz+BwB0lqp8ntgKee8T
         Z797A05tpZaxroswQX243bSIqvRmKULg/dh2Tz4+RereDFpiRKMB/SrBd2jaUAV7vq9j
         whxEHQqkY3kagNHoLfRc4CkAqtih8gDd/dV7QfdcPWLuMApf7ljpxUhbk1sA9AHJ1vsv
         gypIKeItAPZ+9MZFySNGjCbOzeoRbEWvqjoQYokdznrDVSB8Ct6X2Bq6gMBCZ4tx//zq
         vTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834973; x=1786439773;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7xJl7liXrGedcihtRFOy204jJIb+lTqMppbYEP+Pf0=;
        b=mj4uuciiy+7ThnHXBQ4RmtSrI1YlGpOTEIxbLBMmraf6VEPkpB4ybtI9YOCtWf7Gw6
         zR1h2ghMBEimRkFonu5J0cicOKlZAESeRtzp/6ZXUIriZGp1pNGBco5VWGkcGcxESvk0
         g9IzKcxbaVScBqRpP2/jvNlSjo8m5niKUIJ4YC2yE1+PDG4tcvJVZabghIi3dbZ2vcfS
         7qqCslMrB3vi30etffN3XHJO2oApsPYhMSxDMWOqCpSCX/2r4zoiA2Ghsu5BUqQeKUSz
         p0eZ5yNhnOnGLO8aKkZJ9mODjkUafyExmLIgLq7nuFbUNGHFezyDIaV8dWLMfSqvHZQ1
         dNgw==
X-Forwarded-Encrypted: i=1; AHgh+RrNCTGKN4jXjYECd9AFWiP0RdmuXu8TvuWRnqntBvxo1bWIS3ul0iqxS8KMIlHE8oN9DbTHTGt7rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUhU/hTJjTdmPwj7CJkkn/M3eDx+3PMzJYDqNHu3Vung0aO00
	flVhXrYVxWlF9VQj3XfQge/DUwHSegW72eH2V7eg05vkanAanNEkO/HAEKP8zuOE3VnVr8Rk14Q
	7dJWhMv+bHsI9GXPQjg==
X-Received: from wmjl15.prod.google.com ([2002:a7b:c34f:0:b0:487:3739:c5c4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b01:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4980c66c90fmr247655025e9.7.1785834972482;
 Tue, 04 Aug 2026 02:16:12 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:16:11 +0000
In-Reply-To: <20260721153617.869933-3-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721153617.869933-1-beata.michalska@arm.com> <20260721153617.869933-3-beata.michalska@arm.com>
Message-ID: <anGt2_OAK2UWtXuO@google.com>
Subject: Re: [PATCH v2 2/3] rust: platform: wire runtime PM callbacks
From: Alice Ryhl <aliceryhl@google.com>
To: Beata Michalska <beata.michalska@arm.com>, dakr@kernel.org
Cc: ojeda@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	daniel.almeida@collabora.com, boris.brezillon@collabora.com, 
	work@onurozkan.dev, samitolvanen@google.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 21, 2026 at 05:34:03PM +0200, Beata Michalska wrote:
> Allow Rust platform drivers to expose runtime PM callbacks to the driver core.
> 
> The runtime PM abstraction builds a dev_pm_ops table for the concrete driver
> implementation, but the platform bus still needs to receive that table through
> struct platform_driver. Add an optional PM_OPS associated constant to
> platform::Driver and initialize the coresponding C device_driver struct
> accordingly during registration. The platform glue only wires the callback
> table into the C driver model; ownership of the callback payload and
> runtime PM teardown remain with the pm module.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  rust/kernel/platform.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index d8d48f60b0b9..b7e422388634 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -72,6 +72,11 @@ unsafe fn register(
>              None => core::ptr::null(),
>          };
>  
> +        let pm_ops = match T::PM_OPS {
> +            Some(ops) => ops,
> +            None => core::ptr::null(),
> +        };
> +
>          // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
>          unsafe {
>              (*pdrv.get()).driver.name = name.as_char_ptr();
> @@ -79,6 +84,7 @@ unsafe fn register(
>              (*pdrv.get()).remove = Some(Self::remove_callback);
>              (*pdrv.get()).driver.of_match_table = of_table;
>              (*pdrv.get()).driver.acpi_match_table = acpi_table;
> +            (*pdrv.get()).driver.pm = pm_ops;
>          }
>  
>          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
> @@ -222,6 +228,9 @@ pub trait Driver {
>      /// The table of ACPI device ids supported by the driver.
>      const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
>  
> +    /// Runtime PM callbacks
> +    const PM_OPS: Option<&'static bindings::dev_pm_ops> = None;
> +
>      /// Platform driver probe.
>      ///
>      /// Called when a new platform device is added or discovered.

I've been thinking more about this, and I can't help but wonder whether
we could significantly simplify it. Why not just do this:

1. Update rust/kernel/platform.rs Driver trait to include pm ops
directly in the trait:

	#[vtable]
	pub trait Driver {
	    type IdInfo: 'static;
	    type Data<'bound>: Send + 'bound;
	    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
	    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
	
	    fn probe<'bound>(
	        dev: &'bound Device<device::Core<'_>>,
	        id_info: Option<&'bound Self::IdInfo>,
	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
	
	    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
	        let _ = (dev, this);
	    }
	
	    // Add these methods.
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

By marking the trait with #[vtable], we know whether the user has
overridden runtime_suspend() and runtime_resume() and then the platform
abstraction can enable PM in that scenario:

 - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then set
   `(*pdrv.get()).driver.pm` to a table using those methods in
   register().
 - If `T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME` then invoke
   `pm_runtime_enable()` from `probe_callback()` after the
   `set_callback()` line. Note that this call is infallible.
 - Do the same from unplug to disable PM.

And then you automatically PM whenever you implement those two methods
in the `platform::Driver` trait, and that's all you need to do. Since we
invoke `pm_runtime_enable()` in `probe_callback()` after setting the
private data, there's no issue with passing the device private data to
the callbacks.

Note that we can trigger a const eval panic on `T::HAS_RUNTIME_SUSPEND
!= T::HAS_RUNTIME_RESUME` to enforce that you must implement both
methods if you implement either one.

Thoughts? I know we have gone down this route before, but I just think
it would be so so much simpler than the current approach. I know that
this diverges from IRQ and such by not having a Registration, but I
actually think that's ok. PM is already different from IRQ callbacks in
the sense that the platform abstractions need PM-specific code *anyway*
to properly set pm_ops in the `struct platform_device`.

Alice
