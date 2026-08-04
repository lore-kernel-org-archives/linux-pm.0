Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928593F6C3A
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830772; cv=none; b=WxW106Z2oSx3gvWeONpJ8pWqY8lD9NWZRc8WLWJ+48KXL6nqWgoUJ4H9nfkBEVyCEUtAZuKf4FXlEOhagsDHLqfCoZVz2GlAvz27RCeMurvoe/axQy/3nUM3tkNLEGdCghlcPBmWUjqEDI66kgOpXvj4rNFQdXXH9bZm0L7BtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830772; c=relaxed/simple;
	bh=MVVKP78YlyvBivjm/FAklbGYYY8cS4jJQzm2/4HHWug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swVRxVm5cp9pMiVO88nXXlAju5TKnD/xvSlKDGQTWNOgBZwkYnSw+22vgr1ElnQT/rnBifgkb0EIbr5Dhpi9VHfBEd9tyJ+V25UDT4q/NkcNs+10mqyGBHG3+0KO/QFgMulrlNDvixg74XiMpQpncnQgQtq+Sc+kjCNLq8byxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoKhQ9k1; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoKhQ9k1"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so3112457f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 01:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785830769; x=1786435569; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teTYxUWmHQCyWrHWF5GYbye4/UxtKhpRLE5s5SK2UzI=;
        b=qoKhQ9k1uVHK51rlicMq5VQtWs8VXA7QSCINb0gCfOh6eVTDwViJdeHpRQZklfVXqg
         ZppDuDpILljQw4d3YQuukUP1Nj7+jnufwXQXusPapB1mETZSz61fHA88xoVfUy5ITUBE
         63J1H59Q6dx5nYnNbR1qQaa4VRGoQS+XToLBmap6DJFBeqYh2+d1abKSr0XN5wO/IlUA
         2NzM0xH2R4sdu7u085JYcX/zceVWJXM/QyeP0SCdpPMEO8QmwMfyY14GUCvgUR4l5hp4
         hcwX73E7LLbG+536Iy52DdrHsEM2zpuhW4xpU444UkEetYnPUICYAuOaY8cEW0tQLOI8
         y+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785830769; x=1786435569;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=teTYxUWmHQCyWrHWF5GYbye4/UxtKhpRLE5s5SK2UzI=;
        b=XDBhkhn+eJqsc2r3F9VNImLuGfA+nuT+L6H13pSgrxTmxoPcpQ5NTtbhs3hKrZdKfU
         3twes0tru7zn+/YAUcUFVq8u1AdpFC/OWFXPeUGpqu8IEvqX49pOyEnzxMdHRrU5trv9
         WOMIdx+5qBo4TKTuBvoXZE/A0r+QG5q2jTUsUMyAXUazwwJo/+VdOmeRpvj84WR2gHmA
         ITqiO5WOouDkiE5/lDME9V0E5UAVA//ETZpWi9AG47uftBkp9QFjfjm3IdbZdNHgCdnn
         1bMX+o12Pqzx9BrxSbb9Q+k4T3n59trm16dmg8zEd3z7n7e7wAR7N91VFaJWYkvPEBRD
         EfyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZVUJLJ/BG/rejuyKgWlP4Jgg2BCi5WKRsufPN08/ZLQrNAF+KGIESOW1tJj0HM0tD2G2ed5kBuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2sO6kL0rd6eDELp4Cigh7d3Xphrqz8sDVVG4JlB3NMfaxDCW
	KKWZiUfR+LFJrWdW8p084yDXgBtPaLE4dgIoL31BLy0f7Rh+NGg/+6BV4qDePZdgMygqWDvoRCH
	eBEvkhOBLD9fdp8j6+A==
X-Received: from wrwz3.prod.google.com ([2002:a05:6000:1103:b0:47f:2943:2f1f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2282:b0:47f:e76a:e8cc with SMTP id ffacd0b85a97d-47fe76ae95emr8683087f8f.22.1785830768095;
 Tue, 04 Aug 2026 01:06:08 -0700 (PDT)
Date: Tue, 4 Aug 2026 08:06:07 +0000
In-Reply-To: <20260721153617.869933-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721153617.869933-1-beata.michalska@arm.com> <20260721153617.869933-2-beata.michalska@arm.com>
Message-ID: <anGdb0C_j-OUsDVJ@google.com>
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
> diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
> new file mode 100644
> index 000000000000..d0d71fcb0097
> --- /dev/null
> +++ b/rust/helpers/pm_runtime.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/pm_runtime.h>
> +
> +__rust_helper void rust_helper_pm_runtime_get_noresume(struct device *dev)
> +{
> +	pm_runtime_get_noresume(dev);
> +}
> +
> +__rust_helper void rust_helper_pm_runtime_put_noidle(struct device *dev)
> +{
> +	pm_runtime_put_noidle(dev);
> +}

Should this file be wrapped in `#ifdef !CONFIG_PM` or similar?

> +/// Runtime Power Management modes that determine how a particular PM
> +/// transition is to be carried out.
> +/// Corresponds to C Runtime PM flag argument bits:
> +/// - `RPM_ASYNC`
> +/// - `RPM_NOWAIT`
> +/// - `RPM_GET_PUT`
> +/// - `RPM_AUTO`
> +#[derive(Clone, Copy, PartialEq, Eq, Debug)]
> +struct Mode(u32);

Nit: we have a macro for bit flags.

See for example:
https://lore.kernel.org/rust-for-linux/20260719-b4-rust_binder_impl_flags-v3-0-f8d0b3ea1b87@google.com/

> +#[cfg(CONFIG_PM)]
> +impl Request {
> +    ...
> +}
> +
> +#[cfg(not(CONFIG_PM))]
> +impl Request {
> +    ...
> +}

Doesn't your rust/helpers file already handle these for you? The methods
exist as stubs in the C header on not(CONFIG_PM), I think?

Alice
