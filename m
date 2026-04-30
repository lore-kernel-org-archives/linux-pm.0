Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006343939AF
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540366; cv=none; b=mZKfS4UR0b0Al1q/Wdu5ceZ+5GFO5DimGNqthZQfubS1aCL7Oy1W6XWBwAj0BEk0KX9A7dPXoZ4ADB7EB7f8GuULJ+fbsASe1fpsRmnTqmXs9ZGjg/W0tQ1ycXC6OhpiOMEZNINmwc1YJ+pqHdU1MgSjvY84UJOka4EkmQxHTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540366; c=relaxed/simple;
	bh=o3bO4FAjuxVK0962UiL8rrguCj8OrcINAutnD/Afj4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qLaNW1UT8MEeXda9YtGGOBJN96M9kguhl1yB7QLYe1tTlpwjK+f1BTCgeOqJLEgRIiPcESrf1ydzGSXUKAjcm9IuXhtpH3HNzhh8iLt223Xban6WuWiy/pkp518HLXGQKFSsxntBe2SuNj6HPVR+0kF1SB6b2gK0nWSrWMWqB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEqJL9dh; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEqJL9dh"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-44696b11265so794304f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777540362; x=1778145162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
        b=oEqJL9dh943pzVc0XpvcL2nBYCSHeF8oC0berfukxf8qxE2wcsal2baoKmcWYugL4x
         GhCRu4H2vjafUhWXCZ7YQ8T7ZruK19P0gMPVNCTSGrzCHB8ylOnGamcs5qcf/P+E/Zak
         bmLU0sSvZQLSlhkO4pZMdDv03xaUYwBCsUUKVeEiuE+bmHV25ivK4gWjyzaD4B5Wm7hQ
         cKWS/vqVhIcITd4OIEe4LYB4AAbzP4tHmDKQTqaaFACHldYef7whDmKYpct7IdVIHggA
         BtFkcmsxWJjaBnvDIxeADKtw3zvgi1i5qVRr4oM2+GPuaYlwb/9VXs8e7imfr5aQUIlo
         dhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540362; x=1778145162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
        b=aWz2gdcuJqt4SfQDK7052+JCcvSqGcVyoT4daU+2jBOy2tmWl9vPR+Bu3aTRMqZVgG
         sNGCBUMgAQEqWCRpe6bHTeQ0Q4PvIhgGPTcM8gAPfSeUKDCzgB2p8hU/EmlOKOXE/G3f
         NVU7QPUhd/7qhwYyhb0ay/hpSzOI1Q2lWIKIWyt5soRd37jn6x5aZL0100eo8AISWtqf
         6aMpAK5OXN5LcH/yJfpLjSx2MxZJ9QHhw4ZGbYXbZYl639k09w5WBDdR6XFE8+K33yzQ
         w8F64wHy/J0JRZIUPTV0zXNB+VBWgp1x5koVLrKbWnPxXxQaJPRJpQxSaIjHMfYixAnq
         RG3A==
X-Forwarded-Encrypted: i=1; AFNElJ9gjWuai37i869PxcEodD3jVuGB73weNdYxqFqKcpjnrBlXYTt+pVN6qyW6Moo06uvOpXiMAPz12A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/W4gjUn8mGiBufBrLn++mGxpPMGZhlyXFXI0/xYO87H8BjOP
	V2szmW/e7lqoD0P840cAyNzQmNLyGuZtCtGwQUHuhYGU4cy76yWEHMuMU9wBWg9f60f9aBUF9gu
	5afE3Y3pQEAvjEozrRA==
X-Received: from wrtw10.prod.google.com ([2002:a5d:608a:0:b0:439:d5c9:3b63])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f89:0:b0:43f:e22e:e8da with SMTP id ffacd0b85a97d-4493d7fa1b5mr3355911f8f.5.1777540362054;
 Thu, 30 Apr 2026 02:12:42 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:12:41 +0000
In-Reply-To: <20260427221155.2144848-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org> <20260427221155.2144848-2-dakr@kernel.org>
Message-ID: <afMdCU06-Y2d_LXh@google.com>
Subject: Re: [PATCH 01/24] rust: driver core: drop drvdata before devres release
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Apr 28, 2026 at 12:10:59AM +0200, Danilo Krummrich wrote:
> Move the post_unbind_rust callback before devres_release_all() in
> device_unbind_cleanup().
> 
> With drvdata() removed, the driver's bus device private data is only
> accessible by the owning driver itself. It is hence safe to drop the
> driver's bus device private data before devres actions are released.
> 
> This reordering is the key enabler for Higher-Ranked Lifetime Types
> (HRT) in Rust device drivers -- it allows driver structs to hold direct
> references to devres-managed resources, because the bus device private
> data (and with it all such references) is guaranteed to be dropped while
> the underlying devres resources are still alive.
> 
> Without this change, devres resources would be freed first, leaving the
> driver's bus device private data with dangling references during its
> destructor.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/base/dd.c             | 2 +-
>  include/linux/device/driver.h | 4 ++--
>  rust/kernel/driver.rs         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5799a60fd058..be59d2e13a15 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
>  
>  static void device_unbind_cleanup(struct device *dev)
>  {
> -	devres_release_all(dev);
>  	if (dev->driver->p_cb.post_unbind_rust)
>  		dev->driver->p_cb.post_unbind_rust(dev);
> +	devres_release_all(dev);
>  	arch_teardown_dma_ops(dev);
>  	kfree(dev->dma_range_map);
>  	dev->dma_range_map = NULL;

I seem to recall that we discussed a plan to have two classes of devres
callbacks where device unbind proceeds as follows:

1. Run first class of devres callbacks.
2. Device is now considered unbound.
3. Run second class of devres callbacks.

Is that still the plan?

Alice
