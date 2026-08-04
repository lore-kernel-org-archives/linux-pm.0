Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9136A36C;
	Tue,  4 Aug 2026 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846455; cv=none; b=aVXohxc1VBxhOMLJ6JNyDnWA8wpVSW4OSQw1kJigFK08cfB/oxvfeXGIo0+i8T0Yuhr3kjuS+OB3h8T+m6eRsV2Abhzxlp1mN2LThSWmh7HhqpPGMjhfxD0j30RocB2FDLDk/2IPPrsWaVsNyPcWFfBU+kIAA19Gcm1PgruWyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846455; c=relaxed/simple;
	bh=73jS5FUxJ1g2RZc1a9KT7m1w3UaW3hDzaU+e1jIHSOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBC3GkEyTdXMQtl/ZgeiIAWMwHO2sGgx5jz1dyvb9DxrG5rXdILnsiIYcBzRFJBTJ2g4QxzUhFamWmXJQGtRPUZIgN/cmP5/KQtjsCcxZmHdT2zZXx4Xx/1rQnVU/C3oR54EzD4kdVdVb5CsqGK/HmMKZRwXr5RedKToxZn9d10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sLeta+dn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sLeta+dn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CF81476;
	Tue,  4 Aug 2026 05:27:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B0CB3F66F;
	Tue,  4 Aug 2026 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785846452; bh=73jS5FUxJ1g2RZc1a9KT7m1w3UaW3hDzaU+e1jIHSOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLeta+dnlBbU8WMnJGq1Y97rZPfJ8wk3Y104pMkI8g/vfNhtofdG+A7gwUQBy1LRA
	 444lH6Y2ebx4EU3u8qLik9/jEswOTONGL8cgtfmrGWtli1AJGMslO9dETOfSi4iTp4
	 afNVEQoebi+2mwg8+yITKbR6pVaP/HpbLEWvLp88=
Date: Tue, 4 Aug 2026 14:27:25 +0200
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
Subject: Re: [PATCH v2 1/3] rust: add runtime PM support
Message-ID: <anHarTAFv-c4qx4h@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-2-beata.michalska@arm.com>
 <anGfGWWxiuZj4i2U@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGfGWWxiuZj4i2U@google.com>

On Tue, Aug 04, 2026 at 08:13:13AM +0000, Alice Ryhl wrote:
> On Tue, Jul 21, 2026 at 05:34:02PM +0200, Beata Michalska wrote:
> > +/// Runtime PM callbacks implemented by a driver.
> > +///
> > +/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm_ops`].
> > +///
> > +/// Each generated C callback recovers the Rust bus device from the raw
> > +/// `struct device *`, borrows the registered runtime PM payload, and delegates
> > +/// to the matching [`PMOps`] trait method.
> > +///
> > +/// # Safety
> > +///
> > +/// `PMContext::<T>::PM_OPS` must only be installed for devices whose concrete
> > +/// bus type is `T::DeviceType`, and whose runtime PM registration data was
> > +/// installed by [`Registration::new`] for the same `T`.
> > +///
> > +macro_rules! define_pm_ops {
> > +    ($($name:ident $( : $desc:tt )? ),+ $(,)?) => {
> > +        $( define_pm_callback!( @parse_desc $name $( $desc )?); )+
> > +        define_pm_ops!(@common $( $name ), +);
> > +    };
> > +
> > +    (@common $( $name:ident),+ ) => {
> > +        /// Runtime PM callbacks implemented by a driver
> > +        #[vtable]
> > +        pub trait PMOps: Sized
> > +        {
> > +            /// Type of a bus device
> > +            type DeviceType: AsBusDevice<device::Bound>;
> > +            /// Type of the data associated with a PM transitions:
> > +            type RuntimePayloadType: Send;
> > +
> > +            $(
> > +                #[allow(missing_docs)]
> > +                // Callback-specific docs are provided by the generated `dev_pm_ops`
> > +                // contract on `PMOps`.
> > +
> > +                fn $name<'a>(
> > +                    _dev:  &'a Self::DeviceType,
> > +                    _payload: Option<Self::RuntimePayloadType>,
> > +                ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
> > +                    build_error!(VTABLE_DEFAULT_ERROR)
> > +                }
> > +            )+
> > +        }
> > +        paste!(
> > +            impl<'a, T:PMOps> PMContext<'a, T> {
> > +                /// Driver-provided runtime PM operations.
> > +                ///
> > +                /// A driver implements this trait to handle runtime PM
> > +                /// transitions for its device type.
> > +                ///
> > +                /// Each callback receives the device and the current payload.
> > +                /// On success, it returns the payload to keep for the next
> > +                /// transition. On failure, it returns the payload together
> > +                /// with the error so the previous, or otherwise sane state
> > +                /// can be preserved.
> > +                pub const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
> > +                    $( [<$name>]: if T::[<HAS_ $name:upper>] {
> > +                        Some([<$name _callback>]::<T>)
> > +                    } else {
> > +                        None
> > +                    }, )+
> > +                    ..PMOPS_NONE
> > +                };
> > +            }
> > +        );
> > +    }
> > +}
> 
> > +
> > +define_pm_ops!(
> > +    // PM state change
> > +    runtime_suspend,
> > +    runtime_resume,
> > +);
> 
> I think using a macro to define this trait is overkill. Just write it
> out:
> 
> pub trait PMOps: Sized {
>     /// Type of a bus device
>     type DeviceType: AsBusDevice<device::Bound>;
>     /// Type of the data associated with a PM transitions:
>     type RuntimePayloadType: Send;
> 
>     fn runtime_suspend<'a>(
>         _dev:  &'a Self::DeviceType,
>         _payload: Option<Self::RuntimePayloadType>,
>     ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
>         build_error!(VTABLE_DEFAULT_ERROR)
>     }
> 
>     fn runtime_resume<'a>(
>         _dev:  &'a Self::DeviceType,
>         _payload: Option<Self::RuntimePayloadType>,
>     ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
>         build_error!(VTABLE_DEFAULT_ERROR)
>     }
> }
> 
> This is a lot easier to read.
It is, though there are more collbacks, that I would expect to be added at some
point, so macro is just to avoid several code blocks that would only differ in
function name.
But I do see your point.
Happy to change that if you still believe there is no much point to it.

---
BR
Beata
> 
> Alice
