Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009681;
	b=Mk3NdtKu2f3vx3dGRyN+45vBDFEl0QJ8jt+RlFyo/0miQEYCSIEswNO0W24WZo16Xj3b
	 1KOc1Ci77MS32lf2aCW4E8sZF6MLJgdDErk05IHOh7ujdFgTvuRh2lDkuPC+KrMkr84si
	 OF2T5iu2vZN2zV/NcOfwWcpZo/w3Zm+EMomdyrUg47DjVAS9kLUfX3tfqV1LDQAztjm4o
	 IeNpMqRQ0kBuLGrljtWgBDXHtHBVjVpLAyqlMZoXYligsQykYk0+GcI70WpWxBlGoejpK
	 UcOksGBDcC4k1jm3u8o//N3gwhv9w4d5WJNdX+9TzT1cd3jBenOCRXwZvZdE8Aj6Jww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YBVvUekf13M+I2J4OXSpne5JBm6BNzst3m7Bc2T2IGo=;
	b=ZRo8ZqNgCIG+nC9W6gxvGtUUWVH79YQOAxcvb19h0riCyPUXEQIe5DGaKnqzCfZmtT43
	 bx2wS9bYosTczuQmBw0GQudKAk3M4ldSprS2AQ1QW4vd/Fm4eK3k7efa0XjJGIjq5ml26
	 EUPwHf3sszvrvEJ+ORUdNTk0MtdcRT44Kqn8zSiwDGCDpAHDprWwDCIIl7tdQJ/hxiAo4
	 mXORo09oodNsfGwo9aaC+8Z7fLN52BtPWYUO9NHG2p1PNwBSi6Dv44PdP/wgM9weBxgLZ
	 FhSESo783MNHNO4b45iIuNsNZ00D8QEYIZEddZ1hPc9H6o4S3hYW4b/bW9WKEts6fjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yy21S5I2;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9160A2630
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D9160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yy21S5I2
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df02b91f9so1210172f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009680; x=1795614480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBVvUekf13M+I2J4OXSpne5JBm6BNzst3m7Bc2T2IGo=;
        b=Yy21S5I2XLIJsEjcJfnwiafnIj6tQpwVdezBaC/tKTofNpSoYeCUC8Eqddrb0Q+Ida
         42tnkukBTfvYFjB5yTqBCnuYhMhBjy7nNUAq0rOBgyHA7smTq+DK0gthUc2+MV513e+Y
         fBKWifCkWg9CbSuph2Zu4cfmZ9HHU+ZPXkMs8m1p096BNJ/4PS5aS8TUfb/AlyuKXVPl
         q5uXgvrgGofr5dAglr5srIa/JwsbgyhPhqKy7eSMEJBCCe//vjXyJwvqV7DtiJe2sERU
         ZSrJURmnfhZH81d5iLycCXCcH3RROk6TTob8tBBscrTol/e8n5X9GQZ+SEFDR/zWjjx2
         c0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009680; x=1795614480;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBVvUekf13M+I2J4OXSpne5JBm6BNzst3m7Bc2T2IGo=;
        b=NDzoaes4BpdH0aKZCS8sgv+FYO5Lx7syEczLvk9Su+vZYCTu6mwnKByXoCpzeGw64L
         7BThHkJJ3FUWlz3XzkRmfTXMphK8tirxSj+0/331nG0xpMxiEijOQzMMwHP372NOsBja
         UfVHFpCdgdLL3LW9dFLa6735oMhljsEnY/5wab+3MTnC6pnnB2WOsicDXBrVae4SFo9F
         dQhWRgny76AN/eWKnFpJAegr+cLbuz+kP+I7TOKc6ZejUh5cqC/lCJbsCZZYMS1Z3fUc
         GFWqtIDMvLAXIOOAmb+pbcUOrp8VB8MabMMIOoLFGCFv3AtlaWxrhNKvfcH59ZDgIOyd
         t+Bw==
X-Forwarded-Encrypted: i=1; AL+hErGwZSe4G1cGWqHGe6N2HgSPY5KWPQ+eBl55gbfFtdM859slRfwx9VOORPkPP2nff+JafpBK1RRHqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8XsQdSEwEh+iZja+zBHzW9OfU1W70L+unSo4u7cYmWWLu8kDF9
	gA6YsQ/FQogw/5SGbkQVGW0UuKpBOwhYyGTDto3eydW9I6atM0WOarKCX02AH8xWl6GBabeYypl
	vuujcdEaQv55hgdtf7w==
X-Received: from wrvt10.prod.google.com ([2002:a5d:534a:0:b0:49d:572:f312])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f91:0:b0:49b:b94c:e8e8 with SMTP id ffacd0b85a97d-4a37294840dmr12837911f8f.8.1795009679054;
 Wed, 18 Nov 2026 05:47:59 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:58 +0000
In-Reply-To: <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134758.658847-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 6/7] rust: clk: add `ExclusiveClk`
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2026 at 02:07:45PM -0300, Daniel Almeida wrote:
> +    impl<T: ClkState> ExclusiveClk<T> {
> +        /// Takes exclusive control over the rate of `clk`.
> +        ///
> +        /// No other consumer of the clock may change its rate until the
> +        /// returned [`ExclusiveClk`] is dropped or [`ExclusiveClk::into_inner`]
> +        /// is called. This may sleep.
> +        ///
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API.
> +        ///
> +        /// [`clk_rate_exclusive_get`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
> +        #[inline]
> +        pub fn new(clk: Clk<T>) -> Result<Self> {
> +            // SAFETY: By the type invariants of `Clk`, `clk.as_raw()` is a valid
> +            // argument for `clk_rate_exclusive_get()`.
> +            to_result(unsafe { bindings::clk_rate_exclusive_get(clk.as_raw()) })?;
> +
> +            // INVARIANT: `clk_rate_exclusive_get()` succeeded, and the matching
> +            // `clk_rate_exclusive_put()` is called when the `ExclusiveClk` is
> +            // dropped or consumed by `into_inner()`.
> +            Ok(Self(clk))
> +        }
> +
> +        /// Releases the exclusive control over the rate and returns the [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_put`] API.
> +        ///
> +        /// [`clk_rate_exclusive_put`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_put
> +        #[inline]
> +        pub fn into_inner(self) -> Clk<T> {
> +            let this = ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
> +            // called on `this.0` and not yet balanced, so this balances it.
> +            unsafe { bindings::clk_rate_exclusive_put(this.0.as_raw()) };
> +
> +            // SAFETY: `this` is wrapped in `ManuallyDrop`, so the `Clk` is moved
> +            // out exactly once and the `Drop` of `ExclusiveClk` does not run.
> +            unsafe { ptr::read(&this.0) }
> +        }
> +    }
> +
> +    impl<T: ClkState> Deref for ExclusiveClk<T> {
> +        type Target = Clk<T>;
> +
> +        #[inline]
> +        fn deref(&self) -> &Clk<T> {
> +            &self.0
> +        }
> +    }
> +
> +    impl<T: ClkState> Drop for ExclusiveClk<T> {
> +        #[inline]
> +        fn drop(&mut self) {
> +            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
> +            // called on `self.0` and not yet balanced, so this balances it.
> +            unsafe { bindings::clk_rate_exclusive_put(self.0.as_raw()) };
> +        }
> +    }
>  }

Only new() states that it may sleep, but into_inner() and drop() may also
sleep. This may be worth stating.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
