Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47B42F71E
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831197; cv=none; b=MDWtbOyGTa/fuil5RxLJbky5n5wtXp1F4ANISbVCg3+rZoUWtyaz/BKi0+ObSimO/E05xYCzWOLgRdE7p6CyM4TNmphGPEPKSg7e6aVqftua7dKZ2OaBo8K9U6ZfgV3r8XEXCG6amSsBArCdYGWY+yDvZLSlnlUvwUwkbQvWwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831197; c=relaxed/simple;
	bh=LAsOEtzxkMYoh59OODdN+yuBYdhcMYsLZPgZzAuESiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKtaMGIHMphrG60m1H8841A+H4RiEmmE+Tqn97S+2z0YSmEoT493ePTqC/mdyxyhNAm/uBhtB2hJbjfgz5uHqB4v1Cj18ZeSMly3yjyF2ZPVNiCt6ncXMXap56dl8jcqXfKF3Ko+7xtkHQyEe5z1P7gwE2tdDEHY+tAHfjGQnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f89qypL6; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f89qypL6"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so17698815e9.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785831194; x=1786435994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5Xh3KzsVxqqcicEBvZF6wQ7Jh9PvamLGM+WRhr6wnk=;
        b=f89qypL6GWzc2JvNJlAo70VASaiXEbniyzCrkj67nhZ6yLfnmDL9cYnI5idUH8O1qE
         vRnh0GRsPMejFF+TwRoQ+wuqG3F1OrrKaMC+BV/TZKyGv8IB3zpFyZM6bvMM9NRGuZ7g
         3fgnFagn4Njr9OuOWZIdFiJ8Cco/c4AuemttAeMZ9DlqjPpHvHuUKfZpvvWHJOZDt5+V
         2bzRWB9nD11EunyeRAMvFlr9oAPN5Poj2ElvaHHopAMC1usVcN041XAN8ZjzTJ0Zji55
         0QYbrqkq7rDdBO8k4yvlRWy7IqKyo+eDmMasMVY+GpQJBWK+szBbYl+Enmf0R6mDA8eK
         uYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831194; x=1786435994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5Xh3KzsVxqqcicEBvZF6wQ7Jh9PvamLGM+WRhr6wnk=;
        b=rv6mnUWPB8o2LJpuMZM+MJT9SGY9MBVjtRPt3jsaBbwDvmLWbGqINpwpbhs40DOix2
         o62EDhu1LST2Y7JSFl8VJcL+3y8esqqwR7v9rF2P5uKND2CoHqXmpZZroR8hmHfxmBfm
         HDqaafeoPgOP1ZA7l7VYyJzl8APu/g5eWuKxf3yIimOUV06W0Rd13618DkLcSm1OYMMw
         yPSOdhrCm54eKXfWE6I3S2xo/gPkjy8P1Tw9OJP/gzkq7bSZIvUZyTbjZFSc30Mg0kxj
         18iUpL83JP+XOj69BCQOR9bWCyux1s5suGCaQ5jrh3iU/U4EdE4J82ALFAiRrtFsQmou
         GYww==
X-Forwarded-Encrypted: i=1; AHgh+RqtQviSBzZhDIxiydU3Qt/RdWVxX/drDA4thbq9Mu1idkBE1IvnxoQTnkBG1Z8SRZ/HgIMkC3IqgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5yfT2/ulsGnIU82Pikov7DIRaPhEqO54E742MoMWwGAbY0jN
	60ijA94KPGqQuMIwEZUb2iUS+vFxl8b7EhGVH+M1I5teSaDoaNGoAPEQU/2Qf2EPRNvrgQiL7VH
	BaT1W2Gq6HMX0j67jgg==
X-Received: from wmlu6.prod.google.com ([2002:a05:600c:2106:b0:490:b1af:78f3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350c:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4980f23180fmr233843235e9.2.1785831193972;
 Tue, 04 Aug 2026 01:13:13 -0700 (PDT)
Date: Tue, 4 Aug 2026 08:13:13 +0000
In-Reply-To: <20260721153617.869933-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721153617.869933-1-beata.michalska@arm.com> <20260721153617.869933-2-beata.michalska@arm.com>
Message-ID: <anGfGWWxiuZj4i2U@google.com>
Subject: Re: [PATCH v2 1/3] rust: add runtime PM support
From: Alice Ryhl <aliceryhl@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 21, 2026 at 05:34:02PM +0200, Beata Michalska wrote:
> +/// Runtime PM callbacks implemented by a driver.
> +///
> +/// Defines the [`PMOps`] trait and its corresponding [`bindings::dev_pm_ops`].
> +///
> +/// Each generated C callback recovers the Rust bus device from the raw
> +/// `struct device *`, borrows the registered runtime PM payload, and delegates
> +/// to the matching [`PMOps`] trait method.
> +///
> +/// # Safety
> +///
> +/// `PMContext::<T>::PM_OPS` must only be installed for devices whose concrete
> +/// bus type is `T::DeviceType`, and whose runtime PM registration data was
> +/// installed by [`Registration::new`] for the same `T`.
> +///
> +macro_rules! define_pm_ops {
> +    ($($name:ident $( : $desc:tt )? ),+ $(,)?) => {
> +        $( define_pm_callback!( @parse_desc $name $( $desc )?); )+
> +        define_pm_ops!(@common $( $name ), +);
> +    };
> +
> +    (@common $( $name:ident),+ ) => {
> +        /// Runtime PM callbacks implemented by a driver
> +        #[vtable]
> +        pub trait PMOps: Sized
> +        {
> +            /// Type of a bus device
> +            type DeviceType: AsBusDevice<device::Bound>;
> +            /// Type of the data associated with a PM transitions:
> +            type RuntimePayloadType: Send;
> +
> +            $(
> +                #[allow(missing_docs)]
> +                // Callback-specific docs are provided by the generated `dev_pm_ops`
> +                // contract on `PMOps`.
> +
> +                fn $name<'a>(
> +                    _dev:  &'a Self::DeviceType,
> +                    _payload: Option<Self::RuntimePayloadType>,
> +                ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
> +                    build_error!(VTABLE_DEFAULT_ERROR)
> +                }
> +            )+
> +        }
> +        paste!(
> +            impl<'a, T:PMOps> PMContext<'a, T> {
> +                /// Driver-provided runtime PM operations.
> +                ///
> +                /// A driver implements this trait to handle runtime PM
> +                /// transitions for its device type.
> +                ///
> +                /// Each callback receives the device and the current payload.
> +                /// On success, it returns the payload to keep for the next
> +                /// transition. On failure, it returns the payload together
> +                /// with the error so the previous, or otherwise sane state
> +                /// can be preserved.
> +                pub const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
> +                    $( [<$name>]: if T::[<HAS_ $name:upper>] {
> +                        Some([<$name _callback>]::<T>)
> +                    } else {
> +                        None
> +                    }, )+
> +                    ..PMOPS_NONE
> +                };
> +            }
> +        );
> +    }
> +}

> +
> +define_pm_ops!(
> +    // PM state change
> +    runtime_suspend,
> +    runtime_resume,
> +);

I think using a macro to define this trait is overkill. Just write it
out:

pub trait PMOps: Sized {
    /// Type of a bus device
    type DeviceType: AsBusDevice<device::Bound>;
    /// Type of the data associated with a PM transitions:
    type RuntimePayloadType: Send;

    fn runtime_suspend<'a>(
        _dev:  &'a Self::DeviceType,
        _payload: Option<Self::RuntimePayloadType>,
    ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
        build_error!(VTABLE_DEFAULT_ERROR)
    }

    fn runtime_resume<'a>(
        _dev:  &'a Self::DeviceType,
        _payload: Option<Self::RuntimePayloadType>,
    ) -> Result<Option<Self::RuntimePayloadType>, (Option<Self::RuntimePayloadType>, Error)> {
        build_error!(VTABLE_DEFAULT_ERROR)
    }
}

This is a lot easier to read.

Alice
