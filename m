Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255733BFAF5
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821371; cv=pass; b=GG4Bw5eG8XMhaQpbbUA8RnDaOt1KyxSNnxs9CS9A9aG4ilSNn/BLqLCAi8n8tRkGfKaRzRi4mra2rpypOqM2N+c5wQAWfLpxTBKgNUU++RcYb+QxdYpkW4LSw/E61jD6WyrnDybVbHA40T68bqqMATdy4g3E1Jc1rYJ45m8lcFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821371; c=relaxed/simple;
	bh=Ee8xVylefUxsgAC7/wUPXBUGosnDj2MjwQFydFBfjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnwCRN21063yz9Un9SxLabouVcuoWQtYfVzcqzDJH4D7wkhIRPL7P8v9FIZADhmfxFFRIGIGDkxZo1JQ6JjGMpdaZzTptkTVxr1auDFjgck8KbC3EyHDG/9XQMsYQi1ulHIirg3Qna2N2dCdjhTnaH7mHIN60xxk9VRiqakvclY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/gtWsTx; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/gtWsTx"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30436e8f582so595454eec.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821368; cv=none;
        d=google.com; s=arc-20240605;
        b=TYyNuv4NPmSyxzg+NtNSEZDeM1wUmH5eN+7R+FS3x2NotHok0VuQvoUomf8x5/lbt3
         s7P2p0dI1j58x4JdbeikXYQsIbsxgTT/OfiPbp9JFSog8yK8kti1pMPR/AfFwb1gBWcs
         e5cR6Rjz33tx0PKOfNYbVSHVOvXw17NJWkdhxMNX3L1pnJ8Mjjpk9JHakNqyDWZEWIzN
         /Dt2wzxh1Vhw+JZ9J8xbvxtGR9e0/bVTEtSy7hoRgzlkPST3kQFCUg+XX/DOuDkjHO+Q
         9+xDsFBBCvdtuNt5mMhdNIh0K3RPEsiCLNrLYxnEamweGX/uMmUTo/xZR0QUbqiJQCRb
         mqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        fh=9RhKKXCgZlc7DdOVV6rNIxN1nehVLELYwwmI70mQ9zg=;
        b=jPOWX9lsDrhgZ8+xjihlLm5GmNeGLwFmlRD06WplHMKOr0Ip5HsxglHFkgzzAkCeUJ
         CbQS9B9VNQ/6adrWkFeCcWnbl6Keile9YP9xpXRyNFn3q4RjmLiirRniEO4vENREzcyN
         W/6gZWZIAlagwYocbkTCCrZD0+tgJi87wlyizuUIHsr6lXlrr07nofJTQq3ohr8vJwI2
         8h8Fig3QRpxSpQ08kwutsDo7mhefWtj6qdYojW190xmSWm9i2JLdvd4E3bdWL0svEXzi
         Eq0SrNG0Qsf5JT0EEeCpszye+iCknKPy9GT+CkYn5wu9lbcl0SyiO5XZVWn05tOnV61F
         KUUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821368; x=1780426168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=H/gtWsTxLU0K+b4gFr28hm1M2IqFsQtp4OhQbOtWzR54nA/ZWN3No/6X/dzvj2sjCI
         tI1SGQ/6hvbxgGEa4S4DaMWZ2UZx2QHLMa/SddknnO4shgZFUzr1qjKX5H6YqO/YltR1
         R2KyKjtM5f1mOQxdlutG4DMBrlXHvM61XCxRtqLq7Z41pZjXRwrc1fhoC5JoDq7Lzme9
         XfmcQrhbEUshzeGkdyJRCHqfeuxp6qaxRBJ1PTfswoFhRD8OiVJSjIDm3ZWlwJ4SzMkp
         i0Zy4SaYI+HOJ/7EgzgfiDlPLcjU0bM7xMZv50tVSH2f9hM00/tvYeQscvP7+VM9a4II
         nHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821368; x=1780426168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=Mb0992alsGHeURKd9OXczv+3bdMPROjjkeIPZoQ/y/04JImM55VoBZisLNZ514sg9Q
         S9+VwZoWZFUSBOMdkBXCV6tyKVKEcs2q4E+Waafc4KqNp3fovFOr1JhF3rs/V6wArmix
         biFU2fuGowBxgng0PJH49+0dCcVFDNxrOGbYee+294gGVR4LkVrgUTYIlK+XW4LQgP0J
         LonEkWLaZuTNZ4+9Y3/MFr+O7rNso73NnFnZk8D5GT+olwq4qx9IL+uCMmjOhZPT96GF
         VOnErqdzTLwZVkZojE965qWhQ+X9vfeeo9uvUDRJRAVV2GJB7zevmiP1sIvur8N/IJUA
         bTpQ==
X-Forwarded-Encrypted: i=1; AFNElJ89jTU4Hc84A8elHX7L0BLKqCb20ZDO5nTExU+uOzsFjJ/NWAmkIHovBrmEBaw2CamoXtXHPaXSvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfbZvQIwLuyn0ykXaByRPbhemJ9Elmo6NIgdNb7Guu70xCbSN
	3c44HU/IH3RdvTZNrNHUM6T4OxzPCoFhi2mwsAzxOH/D3EaPVQm24Z0saXh0+cPVrc1nGF7ttVb
	m/yUju8Bq7NUN42vBkuIOeMh+DBT3/O0=
X-Gm-Gg: Acq92OHvBF05a5GjZkNfRqNfW+s0ZHMGnkqHzhO+ZRUTk0xIcokOpKaSjvt9Pk6Ld5W
	dHZpuOOtT2IiMJVeWeiSl5xGRlsd/hL+7TpKCI2PRSYz52z2tfq3fDmbijpuS5zuGO9b25haeXj
	2KzwTvYd14kbuWtc2iFdC6FD42OzeVEPGGYSUKTiHBCKwvlUjBzm/6hQdkK698qmXDtkI7EoQ/c
	sEkvoDKYp/uaULrsoJadMQ6KJr1m+/edBjqSUYSdV55toKk2ApfYjPAlUFX6wVt4hxzLTBPtaIB
	BOltWp3IO3fHiYhSyL1SKgtcCrnI3GBw2dHbeb7ywsx6P2NRua1o+7xtf+HWKIBAygRAsZ98GBW
	mRwN+xqgyEF2arYi8vsVIj98=
X-Received: by 2002:a05:7300:5711:b0:2dc:e799:934f with SMTP id
 5a478bee46e88-30449099a11mr4340063eec.3.1779821368216; Tue, 26 May 2026
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-23-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:49:15 +0200
X-Gm-Features: AVHnY4LynmVmerdJFsxXUCWY1urLy48wQB7u14V2mO2sDmYd9U9x9x1s6x7Cz50
Message-ID: <CANiq72=iLUncNw35tpRinUt15W0aqsEiNn+rMcjC3VGq0gx0Rg@mail.gmail.com>
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +/// Representation of types generic over a lifetime.
> +///
> +/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> +/// can be soundly shortened.

I wonder if we could keep some of the commit message around here -- it
was a well-written one!

> +/// The full syntax is
> +/// ```

Nit: we are not fully consistent treewide about this, but please add a
newline before (and after) examples/code blocks.

> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`

Nit: please end comments with a period (most in the patch are already OK).

> +        // https://github.com/rust-lang/rust/issues/152489

Linked to:

  https://github.com/Rust-for-Linux/linux/issues/355

and tagged the issue with our label upstream.

> +    // Currently the Rust compiler doesn't check this, see the above Pro=
veWf documentation.

Nit: `ProveWf`

> +/// Obtain a type that implements `ForLt` for the given higher-ranked ty=
pe.

Nit: [`ForLt`] like below.

> +/// Please refer to the documentation of [`ForLt`] trait.

"of the"?

> +#[allow(non_snake_case)] // The macro shares the name with the trait.

We normally put comments on top of attributes, but if somehow that
messes up the formatting or similar, please ignore it.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
