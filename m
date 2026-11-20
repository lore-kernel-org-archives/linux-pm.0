Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795210300;
	b=2Udx79eGSPFxk4fl1Xf6PAfPsxgI9eHa+h5lLBp2Cv6Y4qDN3uhWdyzsmRoxHFoqhokW
	 MPNw/7miiSnLU3Gjv2lGPmmyjc8+uKV7l1W8dyTQlzvFe6hOwjeOFmLYQ+8lOCqUJY7A9
	 QK3A6die4NcTIo49RuJtyM0dR4mmsNnhuPUCekZfI+n2um6zTP6pp1WmuLP87Fl8I30Y5
	 iwi0bFYT7UsiLGWFklzyAWLZYxSLNmPC2XWfJWfYvBjtXIRTnTlsB2FRmBTLXzEFgXKzZ
	 TAlPWhBja53VsOPIAqACSs0wu+SvT0yXyPrdZcfo8T6cImJ1m/R3PfRzDCD8XJHN1Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
	b=ZUBho6+ii7wAzbwdujGUBZj2ECfBAB/v2y6sS2qRW0P41l4PMjHKB4SmBBAT2uzMrCni
	 HJKPpD2AaloiwqFKPpxliuhAwJUVD/cschTrnnJT8rMpcxrZ0xGLKBA3jKga6STF7ZZrl
	 iwVAEH7wNCTtGtHfjR8hGCUmwaupujSO8teiOvnGrGlQB3JGmrfLqsRqQf0MxU4S4mE9u
	 ILAGg2Jpnht0wGY2O2NNVPmyNwachgK4t+IB1cs7wPiqkUiCfNCV35NbYrlqTXGcy1YZt
	 fR3IVE+Id5SNfuN4lercopMJCmMS7n7EY24PxJNKBIQsE+1n5V6we8ajhliED/9yVww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owhm7wLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68060A260D
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF68060A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owhm7wLl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3adfe7a31dfso1047791fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795210297; cv=none;
        d=google.com; s=arc-20260327;
        b=EHT7nihBYS1LoaosrJyoKM/ck3sS3ud1BMW3MAfba31w6V2Rks/QsSrnekG7rzN1L1
         u6ks42NzB4UbsA5/K0x9xX+Qou2rJH2UWLcJ1XoZ9oHWGfYRZ2A/sGhjkkCc+RdsGUaM
         bcim50w+Ld+jCe/v4qbgTbVpkq8KmQIxqAinGP38w8hSleX8zHqbCvqx8N9hVgLFrMIz
         9dXYRC0N4A5FUdcduip+uIu9okjKwmd+t9ht4h7x3odjLHTDWzSSDUK3ikh83rJ+q6+5
         BdrfbdwoDHTdf15Ths5JZvQR3jVCfj4puj/cSehAdEwHNTWd6iqQi0JikBPCbvDDEzA+
         bbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        fh=G0z6l8mc14+OS0cJnsSRuo4l3Gvgih6U/B76vIFPwaY=;
        b=oO3JURgmshMzzrw6J2eAG/bRFJldAs3tYXlcOFGKe6QuCBEzPuJl0Cz4eUX00K7TAQ
         qod18d4r7w9TUbJVdDMs7OaQbPpYDru1hMRas4tBXlwVQmLLa7PiQu1uczFXdGHxGMoK
         SW7zWRFT1B9dvi6f1s7RLRFSrZeko33TCLWDSvruXkoJjdQTiv9J5O8fSrLE1ckjUeeO
         vRR37/PWf+UVutXJb0/TbiGmR4eD3PtjfNlFpyCpFNZh+qaoPULvfuGKxlpA1Jzkvu1X
         /UEBFQDQ/vYd/V3sVtBbYpHdalRwTsrvxGVcG8n5W8NjmCIDRZzrVXWhQcxnnvBMdpg2
         sJoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210297; x=1795815097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        b=owhm7wLllg3l9s3Ng9CV1HrjwLj04k4mew4+Il/Z8w5k0GXizWUecYujWL4XpHDtMa
         eS9MRCtEBZwwC8OdUWFwKPDTIlDgdFLHLZUfue/yq/USkW8/TiW1ko9/CoxPtSxP1A9D
         D8MSFcWmlq6iHfxe/N4v0YRGxj23N85NQtLSVROCDnIzR4Uv318mpVWcVMo7jrrlABYt
         YjadBn6OUuNuIFRnWiaLZ5X/eKMo7W3sxO+bCCWoKuFkljemHmv/yxy6hv/IR4N1kz5O
         L3UPxcjApzNrfzj6wR8qTA9djgxz/M4AodemmINAcWB3TwhsliP53LE71qSquskMkxGi
         21ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210297; x=1795815097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        b=sEmpYItSQXKCHavzVOrGUMrWloX9hci7p9/xm+j+T+z0hsicVZsT4PLYGTCDK+7r8P
         S+1clFoCtEaNKC9lamNLnkSDhjbK1R2aZQNv3ejtx45Qkwh4wz55zuj4ki7PD8tCqYW2
         X0ZtiF/P3TLaAiVRYHbtdFgXREMiBavqskO0R3+0BpGcKgJEhYF4MoM9yM/is3p+lXDT
         vZrcqFQKZ80MoMWjckq0z91441hW48Ph7Xs6/n+EKTnmj9QkDF3exGM/9P2ldjooEVZD
         wvsP3gKQXXe6CGN5BSULGnf7aiQOExGApPZxFLChXiWdWV2JWsQqw9DEE2CY4gxXfu2o
         QSfQ==
X-Forwarded-Encrypted: i=1; AL+hErEDgEpFUzyIfSrlaMphCffZAstwtdsKQ3Z6dUzAlNbqfTopXF+Ipuzns59XOKu/dFP4baVosfbaYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+RBGECML86Rke1RqVB/OR5NK/GdVpGfOXbAkFMcsF9nBnq6U1w
	6VPAeUgAT+Oq7R6v5hg2BzsRQgaUBgL7kO1uEGnipXVplepnFr/rhfTp2ALbbau25nWCFYvwtZJ
	n0TLlaxMMOusiKLmIYrnZ7INtYt/4jYc=
X-Gm-Gg: AZFdTZfHRm5vL1+AoBnr+D6lEIMMEcBmULlrkEJrcy9RvQ4jP2KZQY4UvGyuuC8hyG3
	qdwJA7euoNJL7QuX7kshS/Fc+mm/SQz6QXQMSlLySSgDXYyqhawmnGQ+uSAbKbAAykeF9r2B+4a
	0PqLe7myWVa6Al4l4WZo+t/EADFhgC6zWxpZEcSlra8/zLjxiIkgkxABa3Aj1mzvAZR1G0HWIne
	flI+fb0a7k2P9OvrYFfuUK0idJeQH7nD9r3sxbbh3mavPflXvfCOI2oSICVwhoKn498Zggjabgb
	0EutOpjwY/utC0eGyXJvc5ATdpw8wzuDfUXwxGL87NzXRn2oh40iTK534zitXxOK90oVzBSlPYb
	ZGNUcsPzKJBuxV9ME2p1jcxwv6NGoh8PWIJqGL6fqrE+s2sSZIG0vpRgaE8ZR0Lx5UmMOnBqRAi
	fcV1fHxNOLetmh1sFw+XcHKeYe/WNkHkKRemuJL7ZwfPwxODIzrnuLKl4AFISokhHn0Bz+SB5c0
	LvzEot4KLIRUQmBlP/99Z0lUaz3tBbwNsk8xbMkKaSRo6PRURZxRkhOn6kde+I9ohY153OT
X-Received: by 2002:a05:6512:1320:b0:5bf:cf6d:ef1 with SMTP id
 2adb3069b0e04-5c1bc5767fdmr1687437e87.0.1795210296624; Fri, 20 Nov 2026
 13:31:36 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com> <179519331840.3795820.8047048832159165355.b4-reply@b4>
In-Reply-To: <179519331840.3795820.8047048832159165355.b4-reply@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 22:31:25 +0100
X-Gm-Features: Aa3M54o4i_zALBjbkgtOxZes0dCWZ4jiHPCTwn8GOTMZ7mrp5N06gIycRXOv0PA
Message-ID: <CANiq72nOKrAtct_eb7tjc9JFFpOQrN0=5bOyOZo1p4C+4U5bsw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Clk improvements
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-pm <linux-pm@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-pwm <linux-pwm@vger.kernel.org>, 
	linux-clk <linux-clk@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 5:49=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> I was wondering how the rust folks expect these changes to be handled sin=
ce they
> touch the rust/ dir. Should the clock changes go through the clock tree o=
r the
> rust one ? it is fine with me either way.

The clock tree would be ideal, i.e. a lot of subfolders of `rust/`
belong to different subsystems (the file is already under "COMMON CLK
FRAMEWORK" in `MAINTAINERS`). The "treewide" Rust tree can act as a
fallback tree for files tracked elsewhere if needed, but it is meant
to be exceptional.

(The files will be able to move to e.g. `drivers/clk/` eventually,
when we lift the limitations of the build system regarding that.)

I hope that clarifies!

Cheers,
Miguel
