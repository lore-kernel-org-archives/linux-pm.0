Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D923D2A4;
	Sun, 28 Jun 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677724; cv=none; b=fsL0EDnS1ELTsYvnzULdrXw4p+MRSGKdq9AX9sRfvCrkb+OE8j9uu8RP75EED8ATRITB97I5jst7YnZqIGaXlNkVIcaS8r7WemnIOcT+9tD94/6ynXqPeKq5uT8ay6iuOViHJB4MRY2rI9xI22erOc4sxkFNVKSCNDDgBUOkjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677724; c=relaxed/simple;
	bh=rwi/xxYcnjT0eZvitp0xflBm+rWniJkt6hIaZwXneh4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=q6fZIgzLU9dBm5YP6kck86G21EV6FBo+BJJ5l8g+u90KVnAmyRXldgzuwwYn+Yk1dLz8mQenqT8qQgPCQgoXwT12yW1hKAsVe75dgQCjjqdKEMDkbZ8SD7EFpvVnMH0NLucQzOEAf8ExxNVCtfWu0pCII0U7myWqQPhycQoOop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ual3UC4J; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ual3UC4J"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gpLHj4Yd2z9tG4;
	Sun, 28 Jun 2026 22:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/88b3Etn343+GIDtpFPjDNRJuj4pU0CEfjCs57vTBs=;
	b=Ual3UC4Js0TCa/WK4fHeOAYPBx+3AzL6AtrRcYPBb+6XjddRjnDz2dHARDHaa0A8usrgWq
	UlqkzZkfaT9Te/6iu3TyoDuJ36VK1RC4wu0Mii4rV7OqJGe3cxda+cihess5EnOfaqwnPa
	S4N6nfD2wjX5Isca7xkkldkvCkVNqK+V6ST8PTIr3w++mV8OOARDHQ/Cu0+SkWC9xVJu71
	N40tErCU/7FLeY28rPFgBMeDz3iTcf7juQFZIc2+KIp5vRfT8d9GUAmedu71E7WD/UyzaU
	vxfNE4OxjVD7uIpe9z42f9ukFQ+ksqoP5rfmnrP+Dn81cLo43+AfIE0V6Pti/g==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 22:15:02 +0200
Message-Id: <DJKYI6S4MUVP.3RZTF8FDRILYV@mailbox.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boris Brezillon"
 <boris.brezillon@collabora.com>
Subject: Re: [PATCH v4 1/3] rust: clk: use the type-state pattern
From: "Maurice" <mhi@mailbox.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Brian Masney"
 <bmasney@redhat.com>, "Boqun Feng" <boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
 <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
X-MBO-RS-META: 3u353mzh5e8kn59xdxsaheg4i3j17fjp
X-MBO-RS-ID: ebde9567693c9bedc44

On Thu Jun 18, 2026 at 5:46 AM CEST, Daniel Almeida wrote:

> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns
> +        /// a dummy [`Clk`].
> +        #[inline]
> +        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) ->=
 Result<Clk<Prepared>> {
> +            Clk::<Unprepared>::get_optional(dev, name)?
> +                .prepare()
> +                .map_err(|error| error.error)
> +        }
> +
> +        /// Attempts to convert the [`Clk`] to an [`Unprepared`] state.
>          ///
> -        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api=
.html#c.clk_disable
> +        /// Equivalent to the kernel's [`clk_unprepare`] API.
Missing definition of `clk_unprepare`.

Best,

Maurice
