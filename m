Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193322;
	b=z3qKgD05DzaJq0hgFJStyWuDML2ggQGZ2l9w5b313bLrNiD34gTxSdIIbgJfA93bxbkU
	 epo/aY82iogksdaGPs84XLOHhniDamrxaVCCtyQYoXz5tEdFVwuOXSorL7sb+eqyK63RT
	 LRZTW0fWwfx89IPmL8CCUS85N+dpjtXqB3y24Zad1GC1ulbKyUnPuoilxv73X7RFX3bwG
	 6ihgHOcsXLyx+96Nf6Xybiul9IUdTreBNgFJUDnMMkh68pMHg9ivFMumPwIpx7LTwhnyA
	 PU5bnd9npPiwKsrWszLV4Em2h1FJcGTLCIbEzjcbzWx4UgLDtKQGsFEDVvgeBmruIjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
	b=CDQlJccveMu3Us5KLQeb4vyLjeqqk6HqxqUiFXx091SsOTAsspIPLNMglGI3zjjd0idA
	 ZgtzQfEIILyHDxRp615AMWrHYuXOJ39yrqR+r7H7faxx5tAWQ+XH09iVnoymKQmbZ6+pl
	 XomFDsF5sgvYfiwwgd1pcZKq9BdZS1VsfcL4L38JsGHNS/DMNyPvewPskvdnpNiemP/6v
	 l1jmRaelGKOhf5ZbeQ4/J8W+TWZd33oT39HL5Ecx5/1i1AQPHWgmMF5MsdB9P9fxy6y9y
	 LqzYb0pQGQ3J1rgTWhw0MlnLnAWExq8ZkapT5aBRb4JoWMnuhz9W/rEmZqhxTWIBV8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RNAMJ6sM;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234E60A2602
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8234E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RNAMJ6sM
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso628940f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795193320; x=1795798120; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
        b=RNAMJ6sMUpkWN4HrB0XYJTVcOtjWWEYhH6d3S9pj85lhBPRg5KkeaWo1USMBh8nDxJ
         w/2T2XYDMgVkyVrFeq/jl71c4n93hO/4Nc7iCIfX2OaYcsUU5pWUfNweZrU7lY4qEIxS
         4eh9dpGdnLaPp6u/BJuIaSUEM9sKLBQrNTbenH1nsZTez+0/KglhUPE3Mx537/pB4xRP
         8US4Tq4WX3HzsJOKtAtUGRlXjScW3SZXmw2uEC/7LSr2f9aIch+VfB/A7NqU30NL7hee
         0gL2JYNXK9f/Y2bCnqnXnDCx6SIjdqdoRXZ4BKvTX66tKXa7T7/hV4E9yjYAFoJPIXic
         WR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193320; x=1795798120;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
        b=Dw8CGSx4jkbFPdiXRy828Il7Zpky5C8koNQY4/G4ryoxk/uuC6lt3oGs5SBP3u97yu
         2im/0tyFVrUt0g+K0wJmvddh+tNuY0yQmxW46ZpRLx+vmNA9kmbKj5zwNQqHHu8/2uhN
         VB/gUbfMN19Miz3EIYp9CzAkjPD56oYMs0hOesPZZPnkFZ8s/cyG4NMqeqw4/4uaQsFt
         bmWYTGboMBmE60eUQ8pldfL0mHcYWsGBJ9GICmCnXphYOr5OeVCLw3Rou+nC0dHZYAeg
         ODQm4W4q4fddNNmPYE708PpOuY08DozHoKPccU80K/BgKEqXuw2FW5s6XDuguoJ+t0e7
         6Ctw==
X-Forwarded-Encrypted: i=1; AL+hErHNrTd9ZORMCYQzj5O9xGgZipiL5FDJy1yd7u+PMmiyTw+ebuNlvjGQOgZznKgVLv1ysLviHU9ejw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+Vr6k7a3CufquvF1lWJetGrbfMLqHzqfwCxx9/tEKAYS8d896
	hpv0pz5Oud35vVqVRMIMzfTOOnVIw81gIR67D6YtM5xocE/5kOJofDwBtMDdNQzHR3k=
X-Gm-Gg: AYBFou155iZ8ZVfbql02ugs89rFJ3iJ3RCLYVuq6nI+9NEKiYOCp27HyJWR1JIxo2Ph
	d6QRdhhacSCgFsVUsDLLi7kCW3M8CbROvYnsC1vmiQ8pOGvZSI1NOCt6TJfdKFzlbEsM8dcyJnc
	FHqPNoqYMV5uPRUDhul5dMyT94PZdtlC5l8lSowwtC592023iKBQ2rgaLmM2yNVX+odGY866JGe
	Yqkzj0yNCvSpIiwtWNjQlk/AFtRTInHDPksZxKA51n05QkMf/J8zgWdxyKs8+IYCpz4/F/jr7nj
	Jt0yNRBn4Tf5utJMnp2blOxY5IajRPtjwQvO2KbHIOQOaY9/mPh1jcyL8w+ZQ7Lm9BMyIsjdB1T
	blt7PPy+9BBnntIz9kxSBIFl51qry9CODaCoAnhpi/0RSZVdm6BTvoJcQ0W2u5fpYSpLomdYfs2
	Vnq6FnxtzFzo1+cBY0lqsz3/HPnbwHEJE+eYnNYHuzlrUTqwjbHq2uWMron8x1gzjbwZ1Z+hZ/N
	4KFHv7wx7lyfpJDYL5p0ee2bF9g6aORaxX3+zaYC/a+qllrTVDm9N0jzh2HfzvdF8fw1WMLa1mR
	SqIROdr+5XtT1WJZpdaX7yDPnJ8D2HrMEY1xb7NLdFzw4ahw
X-Received: by 2002:a05:600c:848d:b0:4bb:6b6b:fbaa with SMTP id 5b1f17b1804b1-4bb8880fd0amr81601005e9.16.1795193319985;
        Fri, 20 Nov 2026 08:48:39 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm102415595e9.15.2026.11.20.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:39 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 0/7] Clk improvements
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 linux-pm <linux-pm@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 linux-riscv <linux-riscv@lists.infradead.org>, 
 linux-pwm <linux-pwm@vger.kernel.org>, 
 linux-clk <linux-clk@vger.kernel.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
Date: Fri, 20 Nov 2026 17:48:38 +0100
Message-Id: <179519331840.3795820.8047048832159165355.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=4z3/sdMgR1NP7DfsDZx0tYiu2dW9UOhvaq59u1rg0JU=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlc+2Ksh+kZXIPh/3rDDW4Kn27hqR6Y15t/Vndc9nY
 JL6uuFhRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACYSOYfhf77/s+M/3jXtP6oy
 5+cRhk+hnv9r4q4aztv7e7Xt8cINxx8zMkx3PJygYGn8ecrZdJeblhwduyRv7OkO5akz19EKybu
 wlhsA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On 2026-11-11 13:54:01-03:00, Daniel Almeida wrote:
> Hi all,
> 
>  > This series contains a few improvements that simplify clock handling for
>  > drivers.
>  > 
>  > Patch 1 converts clk.rs to the kernel-vertical style for imports.
>  > 
>  > Patch 2 replaces OptionalClk with Clk::get_optional(). There is no struct
>  > optional_clk in C, and Clk already allows a NULL pointer.
>  > 
>  > Patch 3 implements the same typestate pattern that has been used
>  > successfully for Regulators. This is needed because otherwise drivers
>  > will be responsible for unpreparing and disabling clocks themselves and
>  > ultimately handling the reference counts on their own. This is
>  > undesirable. The patch automatically encodes this information using the
>  > type system so that no misuse can occur.
>  > 
>  > Patch 4 adds guards that prepare and/or enable a clock for the lifetime
>  > of the guard without consuming the Clk, so that a driver can keep a
>  > long-lived Clk<Prepared> and enable it for scoped sections.
>  > 
>  > Patch 5 makes things more convenient by offering devres-managed APIs. This
>  > lets drivers set clock parameters once and forget about lifetime
>  > management.
>  > 
>  > Patch 6 adds ExclusiveClk<T>, which holds rate exclusivity over a Clk<T>
>  > in any state until it is dropped.
>  > 
>  > Patch 7 uses it in pwm-th1520 to lock the clock rate for the lifetime of
>  > the driver data.

Hi there,

I was wondering how the rust folks expect these changes to be handled since they
touch the rust/ dir. Should the clock changes go through the clock tree or the
rust one ? it is fine with me either way.

I've added small comments on patch 3, with my understanding of what of what you
are trying to do. Please take them with a grain of salt. While I'm eager to help
rust grow in the kernel, I'm definetely very new to it. It is very likely I got
things wrong.

If there are pain points regarding clocks with Rust, please feel free to
reach me or Brian. We are happy to help if we can.

Cheers

-- 
Jerome

