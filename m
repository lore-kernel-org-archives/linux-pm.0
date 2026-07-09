Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7983FC5BE
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587845; cv=none; b=Sps5RBrkh1lYdcobk33/MWD1z7YAO8IaJ/qpyMvQmli4RN21YA/bLkrwASycjBIi8U8wJl+JvS6jPW8eIKaKmBfqqGYLDutNv3sRWR5Gq2KRFl3W8ROQNc9OBfENPxLt/gNz2cZA6vwPC1z6uQ3kRYE3Bju+/7AZ/VIpQ5HK0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587845; c=relaxed/simple;
	bh=8p1SlX4Y/tAMtxoktfOY4hYUbJ5KdrvxJ/hf35CLJIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vGmgmdtepw7S7Sid42CQ46oLz+97xMJbpAsm39Ar3K+6zwKMWRiiKEg84LmbkkfAzLmiwVyZ1uacW8edTRRH6TgXxgdA0gUrBQ0We04/d3DDLPrYwEweUmYqBSaW7Lo1cWE0nahIakw0gOpcLzSJEWo2BOwVL5Yw1MC+/YuRk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NML6nO88; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NML6nO88"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493e94719e7so4081175e9.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783587842; x=1784192642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHb/QYDUeRjEZWmoAxhxicuHQ83r8Iogoxy5g/5DRs8=;
        b=NML6nO88IooRB6zrk3xKGhZwKnJ2AnNs7VSnEjk4j0l4a5/A595GCIvC3E6KCYyJTJ
         SNzOeGM2s+gaNuISy4xSzvvn/eRPAxtyPQxXVBFU7U3n9UkFQ0SBFvG8Tr8y5OjYZCsb
         0G6Y2Ruub4sMK6iGkvJwtt1HB8RbLWZvZEEzYsyHr9+rvRytUaISRDp2sgDJKFvnfaS1
         adUXvPN4/V+uOg6AjfMgvDAnUMEgYXoX7v5HN08WX6DyH8WkDWDiJ3Q6BecSeP+00Zki
         him7Mu8z1lKNCiejO12YnuQGgVUjo9WSqe7PJD3uPQbVZQ5tdL2TE194NqtWwdlIupR3
         yZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587842; x=1784192642;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHb/QYDUeRjEZWmoAxhxicuHQ83r8Iogoxy5g/5DRs8=;
        b=AQvdVW0/+L4THrcX3MAPdZJ2AjBRC7At+sm/Z5FEk0ztKxhFNbVnieTiW2SgdgOj0W
         zFjr2snAvSBksxdUIV1PVHxiDYPwJ05vyepmqvnXIg/PlfHT5/FLrzArDDca8l8j1KB3
         YFgzpo4PVho+6s/2UjbbANfIw7wgNodaCFI4s7R8qnV1ghGhdfk9kMuwWwY/o6eJhU/Q
         5GhMJ+FUewxH2iYgqQXTNQqGXp99rzluo7wctHIL4wUCSiESDExON1Vli3DaAiHIrXgQ
         pr9ojJxmYRrGTxrgC5P5cL5xwt1/fu46EK0JMm++LGXtCJM9ww/T0iondnFwB7FtW7J5
         xqkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnxkbQyg7zWkJQhkSaYqWfnFWNHoElhQNcKipxEFbFNwFM2Brv07+L/nF80SXXgKNaZaYvxI9q3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8jPyJKnHqLk4ErABPI/Bkz9gOVY1oEFljDPTtWtvIv1G/5lO
	tTeKtaVU5PXQmWm8ClABOTw2x1KCjLmrTpf3oAm8EnkAZCmLOpWVLuNPBAbzrTrBGKbSgPQB55r
	ZJbqo3imQKpaBymWKeA==
X-Received: from wmer22.prod.google.com ([2002:a05:600c:4356:b0:493:bea4:1b1f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8e:b0:493:d26b:1575 with SMTP id 5b1f17b1804b1-493e69b0dbdmr59666475e9.27.1783587841386;
 Thu, 09 Jul 2026 02:04:01 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:04:00 +0000
In-Reply-To: <20260708214738.25008-3-brucer42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708214738.25008-1-brucer42@gmail.com> <20260708214738.25008-3-brucer42@gmail.com>
Message-ID: <ak9kAP1SZF8AchQT@google.com>
Subject: Re: [RFC PATCH 2/3] rust: power_supply: add power supply class abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Bruce Robertson <brucer42@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Gary Guo <gary@garyguo.net>, Tamir Duberstein <tamird@kernel.org>, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 08, 2026 at 09:47:37PM +0000, Bruce Robertson wrote:
> There is no Rust abstraction for the power supply class in mainline or
> rust-next. Add a minimal one:
> 
>   - a Driver trait carrying the supply's name, type and property list,
>     plus a get_property() method;
>   - a generic extern "C" trampoline the power supply core calls back
>     into, recovering the driver's private data via the parent device and
>     dispatching to get_property();
>   - a Registration that owns the power_supply_desc and unregisters the
>     supply on drop, freeing the descriptor in the correct order.
> 
> Property, type and status constants are re-exported so drivers need not
> reach into the generated bindings directly.
> 
> Signed-off-by: Bruce Robertson <brucer42@gmail.com>

> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        // SAFETY: `psy` came from a successful `power_supply_register` and has not been
> +        // unregistered. `power_supply_unregister` blocks until no callback is running;
> +        // `_desc` (dropped immediately after) is then no longer referenced by the core.
> +        unsafe { bindings::power_supply_unregister(self.psy) };
> +    }
> +}
> +
> +/// Register a power supply backed by driver `T` against `dev`.
> +pub fn register<T: Driver + 'static>(dev: &Device) -> Result<Registration> {

Should this be &Device<Bound>?

> +    let mut desc = KBox::new(bindings::power_supply_desc::default(), GFP_KERNEL)?;
> +    desc.name = T::NAME.as_char_ptr();
> +    desc.type_ = T::TYPE;
> +    desc.properties = T::PROPERTIES.as_ptr();
> +    desc.num_properties = T::PROPERTIES.len();
> +    desc.get_property = Some(get_property_trampoline::<T>);
> +
> +    // Stable heap address; moving the KBox into `Registration` keeps this valid
> +    // (moving a KBox moves the pointer, not the heap allocation).
> +    let desc_ptr: *const bindings::power_supply_desc = &*desc;
> +
> +    let cfg = bindings::power_supply_config {
> +        drv_data: dev.as_raw().cast::<kernel::ffi::c_void>(),
> +        ..Default::default()
> +    };
> +
> +    // SAFETY: `dev` valid; `desc_ptr` points into `desc`, kept alive in the returned
> +    // `Registration` and freed only after `power_supply_unregister`; `cfg` valid for the call.
> +    let psy = unsafe { bindings::power_supply_register(dev.as_raw(), desc_ptr, &cfg) };
> +    let psy = from_err_ptr(psy)?;
> +
> +    Ok(Registration { psy, _desc: desc })
> +}

This looks like it should be a ::new() method on Registration instead?

I would compare with existing Registration abstractions and mirror how
they do it.

Alice
