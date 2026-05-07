Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD533F1662
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158263; cv=none; b=JqPGQK6x4r9C/Mcp+NI7izG8ttkTEIl8efc2/HlDznHrFit0BsKBVvzpkkB9T2U//mMSkj1YgQNLW3gaCfSQRJItgbH1zHwWliiPz1ObZd6jjZxXXhfAsoD7qP1JJmVlj4hcgkosUS4Hs6Zv2Oc3GYSc6hdu8QZ1d6rWQrgG6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158263; c=relaxed/simple;
	bh=h3Vlkbk5sdnGg13yM94cBpckZTupKbTqjZZ6gANaolw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iPJ4kf1WHobHB6KB3pztFBj3Dxj8cxFDHZ/r8LtJ0fy09cKYTK+NL8luI4YuPmCssOH1LQJx7ggPfbuWfZJqOolDfqwHUUcKqjemaRZC1lV0Y9wmtOTfOFxZ7Tx2p7dfX7eHyVQJvAVgFdkIoYvawQ2S/d7GcKIQL0avPFMwxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRhZ5EgY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRhZ5EgY"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso5891335e9.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778158256; x=1778763056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
        b=NRhZ5EgYtpSzRPVKw3l4G+F0UKuwmoEJ5Cqd01cStGdfNg3xeNHV/Dt5UTswLPUXpK
         zkYls8UXWRP2uerd6G/MUIy6SvkquIO8r+Uakn1NTHvPDTj4/jQrhauhauWffyahmveA
         RC+5V9qIfE71z8J88pcokSzUHd71kmfH9umxOV4wv+8asM7gIUJ38foCb/E8yc6sv3Ol
         Yy4+IR8a7y3Uku9o10iwSRKy4FcAI57m4BZg3Jq7jWvjw0RSuAmP5ko8+6X1x1qOYO93
         L1hirrbNxq2cisiIPqONHljKPXjb1uL0y9CLakiJA6R/0SuS5gq3Ss+h2nJJ74C5A48D
         1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158256; x=1778763056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
        b=tTDZqNNE2WK1ZkswRPbRbButvyI/x6Ljm6eXT1eLiU5X/Jml+4dIzBjR23MLwKAm9a
         H/TrB1YkPycFuX4FHvMeQzxSlj/+eiGdPzHQ1sVgfWaBdjhucXtalDrIcUhOk/zjxhbr
         YgfRIJWUHQxkz3D4zF+JcJsVAeiDkTAd41IVjTuj6vSUELZQY/kyTBZKXW8YWzQ6ZuQa
         OMzCMvdaHckNLU+sWXPuIhtXcbI5pA45MQc1xV9rSzTkiJUVU4gpQ+9fRBPj/0RsGOl6
         3pMWqO+UiiBW2yZ+fzY5hAUUGHmqO6q7TLbVgB0ysx5nY0XM4nK1PJ68MXEc661WZevy
         U+RA==
X-Forwarded-Encrypted: i=1; AFNElJ9UCKCNa8xyw+gc9SDPpwW9tjsn9vZeal5X/XdWo4daFFhuZf30o47W6OftkXh5Kw39zI8mOryBaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbL+OIuM9GRa4bmajrInnzvJcqP+MWPR8cusgysYmKV7IKZmnf
	06QmPHZgr01XzRQUHNR9B4RyhTIXZ7wsuMJANlh0DfU1pIB0gbUE+j6n7jjHcJYz8Wq7W52M+Cd
	W3OYJapheJTNo2fVALQ==
X-Received: from wrpu17.prod.google.com ([2002:adf:f891:0:b0:43d:70b2:d297])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48e51e19668mr127556795e9.8.1778158255465;
 Thu, 07 May 2026 05:50:55 -0700 (PDT)
Date: Thu, 7 May 2026 12:50:51 +0000
In-Reply-To: <20260506215113.851360-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506215113.851360-1-dakr@kernel.org> <20260506215113.851360-4-dakr@kernel.org>
Message-ID: <afyKqwxDxu3cT7U9@google.com>
Subject: Re: [PATCH v2 03/25] rust: device: generalize drvdata methods over ForLt
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, May 06, 2026 at 11:50:39PM +0200, Danilo Krummrich wrote:
> -    /// The type of the driver's device private data.
> -    type DriverData;
> +    /// The [`ForLt`](trait@ForLt) encoding of the driver's device private data type.
> +    type DriverData: ForLt;

Associated types support ForLt natively.

    type DriverData<'bound>;

Alice
