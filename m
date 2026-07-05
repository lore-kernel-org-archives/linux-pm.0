Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BC360ED0
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253581; cv=pass; b=gZDlxEvbEQS710KtMWNKFHT3ztQauSTHslmAtKYIMENBVmFRrauP8MrQWQaB4t0Xu87QGW3mWM5eWg2M62uqWdpFONOXGh5ICeREnnI0D6mYrXe768D/iF2Dcc6FXsspFDDZf7l08lYx7lSGrnXlsS6+iU34d1wx6Wj4NLvq8zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253581; c=relaxed/simple;
	bh=5ISwFpI0UbPRq9FTX8wSAZ5/fVWcYX66lDYusFmfZZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pYMPBTFSXqRCbMBEgTt/FbD6Ogb1Oncw26xaZAq/2Y9U5OG0Lebrux8jbAV0FH7ZWV3/fF6GiKgvUz4CfnWStlQEG1gmPVToFrVrehgvvEZ1pSQ3eTLxAJML+frFv603QibhpwhCyTIpwZB0ziqXHQpYo+Y+fi03XA5XHaGxxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiS8dlOM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiS8dlOM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c988e16bb3so5122145ad.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 05:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783253579; cv=none;
        d=google.com; s=arc-20260327;
        b=UiFGrvyTWVqJKyVjH0dwztVfPqvV1ImC+HtiS01S60/781VAVKdoYozoMYJiennWrp
         YHvOZorAoIvVVGdL1COBpZ0yul8yNVELBbbm/0mFvE4Du2nO1Vem48R7NXj3q7efVmxF
         SQf9zbqHEFyNjS6hRnhZBrynzj3WscCXq0Wspka3ZI/tIKe7eC/l53XXutM2FqPFVFij
         S/yeCqL9NIOsl0GPoc7l2W2OPNb2DSgNLy/yLiCaRVkM5WxlrmoSUmtmwHXbY9k4yZ/W
         1S1CQxon3gyENUl4WGrG5YLZlWopgwnQpMpYfLhhb9nvMLXRqta6VPQDq1BZjDL11Pm/
         KGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        fh=pH5iLCjI9xKqvP4+QyFyLUc4KUfGrYd8prPUjudQpIA=;
        b=TnX9FgwokbGmjFF8NRrfftCnLvrPKwqfe/scU0UFlQEupRKomhp8TrLyOWZpmOsiCi
         YWuv3O2zpkSZz3kFNuutm4QEfYdUDwCJwPq+Tv8M3vSGF8qVKqjcTwOcjizi5QOcNz3S
         vm5Dt2vam+NihNKslTYRqq1tGocTJcl2XxDb+GWNsjQLIT7BZl+NTrzTehmutb2pJe9h
         vQhiKOrhaJIhXBCQC+HJ7Ex7taoALWA/7Wuw/oQx/7RU+BJU9jo1QHNxOxDazbzLLRvx
         bvO29LiDhDHnS6hUUHw3z5z+sjGeTRm1GomscP4YOLMraH6csCHhnqa3WmGLEYMK6ojy
         Lo5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783253579; x=1783858379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=EiS8dlOM4eyK6m1HpW3B/2Lk4Ke8vaKmQ1grSKFAJWT3nDgHQp9PHG6jDFJWFMvvPG
         oCku+2dl+HfLBkdKZgSuHLUA7YZqNbbMrZm2TVKZv4KZ45li1mzTsRsicFKWdCN+v+zi
         IdwL4gSU3xdcrd7mNZoZYzHVr3F5FCVUfsFcww01QxO2XIg11BR+z3vKVvWkHs0gbj5I
         2DZJKv0/WQyEQ8Ha6Xu82TGTSYANNStIKhMU5St9tH4npH0B5hAWmCb/g9/YoriaRJzj
         b431tZuxGVTTDaog+QabLoyvZpxKg8nku7BLjtK1/CPlyoToF4FA0vaITOaO05iHBIt5
         lnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783253579; x=1783858379;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=JyW18SiVL4HLUnuKbAwP0hDKkoPNOul7TVgxbldg9F8kDxAzOUvwIq3E6EELkx3RjM
         fjSCezoNCdZYJWjiOBqC9Skw8OdzjFBBxoRTayX5+nm0/BQbO8UF+K2t1yD9VFfUM643
         23rOFplQ1LBqYRcxsXvdbbvJrlDDrt0sKVc8jJvtO6ONK6oIT4JhLRUrowrBT7yq3w+r
         i4ahp2lPKHTrr8RVFVH593lvKIaXnurjdkbOM10cHW8aUXBcLPBpOw+Uun6na6OtTqC1
         uuRN74Qxdw4yQHnD9zh1uiuFGXeu9N8e+IWC25VkAHrvr1vXd49hCSPxDBjX3BbcolA5
         Mmyw==
X-Forwarded-Encrypted: i=1; AHgh+RqHoyFFbJkcXsoo2m7qDEbyQwOhdf5zKVC5+eCfTOKFMjeIQy9w5d6ANc7MGVByNEJWLKiRL5qEJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYx6799P1rwG5U7/FyAjGs+aYjc5O3krKuSXaLNDGPgybKsSM
	D5uiUpmoz6VZAAF9jRT3WO0oZXHfX5sPJ6HPFS26KxopGh/thv6SX5S6d8UcJBPfm4xNXhxqcX4
	8Ce48CRKl5FPzNr9lEXJO/Ca4EsFCPP8=
X-Gm-Gg: AfdE7cnJwXEwUomhKxs9IFBHpbYlvKNGDBVVe3DnVeMV1SStXfaldi+O/6KIVpPI7Ex
	/LPcxiwupIBUtF+0X7csZ+o7C6v0Or5MbA4ucNZNucCP0hc/RJoGMIGEdXRsWcytYVh6fNfA4B0
	R7Ya5W5VvCmK95NvgQFQgQm4fVXk+zH/9Um7PJIYTtw0GIsR2hBMUR++Oich3Uo5PNi/rxb4e2P
	wzek4g0bEvnY7TSfZXThtEni9eQ2F2lp8z71ecwoMDV2l4Mxlb7+0+56aXiYTYO1/+7+fKLb4CN
	Kc32+v10kQaZbLd8Ck8qldD3ybX3gEr67h3bbRhiymHXi+Fv7HyfG5R3B5Q6Pl2bvksF6wZBZjA
	BUO9MdHMG65fL
X-Received: by 2002:a17:90b:268f:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-382802beaa9mr4128789a91.1.1783253579563; Sun, 05 Jul 2026
 05:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com> <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
 <akmtA7EbVBdhRAOq@gurudas.dev>
In-Reply-To: <akmtA7EbVBdhRAOq@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:12:47 +0200
X-Gm-Features: AVVi8Cfl7DMeNQYuJP9tYThrU-TabLAul_khYoWVx5WCyAQG55ujZm7jKpKar4U
Message-ID: <CANiq72nESZyX95XSKC3zaog=XSQF09bYJmre0mUbtQ42-Ly6tA@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 3:02=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> But unfortunately, since `imports_layout` is an unstable option currently=
 [1], it
> cannot be used straightaway.

Yeah, we are trying to get that one stabilized -- upstream `rustfmt`
is aware and working on it. More context at:

  https://github.com/rust-lang/rustfmt/issues/6829
  https://github.com/Rust-for-Linux/linux/issues/398

> However, .rustfmt.toml already has a section of commented-out unstable op=
tions kept
> as a reference for when they stabilize. Would it make sense to add `#impo=
rts_layout =3D
> "Vertical"` there? If so, I can include it in v2.

That may be a bit confusing, because we still need to add the `//`
comments. And if you add them, then `rustfmt` will format properly,
i.e. you don't need the unstable option.

Put another way: the intended workflow is to add the `//` and then to
run `make ... rustfmt`.

I hope that clarifies!

Cheers,
Miguel
