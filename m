Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF82C028F
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254157; cv=pass; b=HHY/EAJRYYjHhCSGFX2JHbNpyPuBFXpaxN0ndjhp0oKugytviXdQ4D19JI7UenuPIaiKOk9UyZOUUSlKlwCkhGeTZG60csAN0U7Up83zGTorzwM+xH0e0cFPjLGBCJTVmCCB2tbrJl9ax9pXHpp4X8jc6nhDbi+dZKOGeKIqFSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254157; c=relaxed/simple;
	bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r+08txl4wHThMi4rUEsKZ6aYA5qSqi54i3fvxQcm5V8CWzhvDm/DxrWDTJlCTkaP4I4G9TyZB5zOO89Sqdx5FxzL7opQuu4payeAMlyi8h0Bpjp/bOUJXOJ/Xp/CDbzjn4RAAS7TCasanX7Lfz0+m1hs/4Rp7ykiJ4VR8u0Yrqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhyjfxyA; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhyjfxyA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-384caf7b168so145365a91.1
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 05:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783254156; cv=none;
        d=google.com; s=arc-20260327;
        b=Jqamz6LrSgJybdLl67zp7dbEiR+dJxfucIdxj4mfyrxV7VvCNsYNYryJZHF6KdGgIu
         6e9a/3CVDhGHWDrYiTBVdpXvgj0raIxKntEVhaygeOuym9hZHaSmjrbogHrPnmhmpp4S
         SU1nstkoAyJDh7H4nEeAdbmeWnEzL7G3Ldm0Ddnbg11YiLWNXbjmv1JTFD7PHtzIIgR8
         vRXDhVgLr/9wnGVq9AX41YiHuxrxnJswBoEMUKeEQkyWkcdObA35CRbTMlA48AKr0kEf
         c4eKxEZsCcH2FO3+upmtdrGITcaucT07MSpjD4v59QmYqNJESnDlPMLvrcXMmvm5IIdn
         mXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        fh=yvtoeSCJLkCrC8QRXXg2h9Pl/jysY1Zz/2MPOZlIAT4=;
        b=rd9MHQ7n/ncVM2ZhcW/IfShlkCe95ZRoG8kRhhpWJEkCvYPGRpfsjpoOqTspOs57L6
         cImaId9/L0o0zLkmxKLZ9hZ75e4Nn/0KrcqUSydygKw3ziTIglI5JR3yjI+cTKszfcth
         WZ0WiQ498xzOscpuXWTG7pMqrUGEi26Vs0+SnJ7QXDhVAZFdVsXG343swCftVodLUbHI
         HOEAFI/qtKPVPiCov/sUpC4e0Of1XsQL+0FMAoVXXxlFVU9cR0w2gzORxAgizGmVsicV
         CNYWvxObytsm7yudhcRsOfrPPH8GVoy9G8PTrj+vDEM4ZZ9tYczQgd3JoOi3FizMeHGH
         L/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254156; x=1783858956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=QhyjfxyATsOCVoQS1jHI7Mibm0pDUoc6hvz2g2DThUIjMUZJYAjaB/pjXj01gPkIvn
         PfUDF6VcZ+4vAS7mRO+8Tu3Lek9RvxtWQm6vEWu+ZDOW5AK4Z2AeTmPW7czcovGoyDq+
         ZVfrkt65J2lj7P8VTHHGIiyLDSOzsCql4fpQd+xA3DHo+FO0qg5BnVIv89TaShPzevFS
         Feej2fjYBtwo/K6so4aFuH7GfGlzqB/U/o8s3WKhvQfbIC106TCgOzeeVrhGV6CfgDRS
         fMD5LzSJzRbtv+Zn8VTyus83i47Pak+MLGzJSR5JcGngV0B0yK2vCcDoH0cgBqVjL5KU
         +I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254156; x=1783858956;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=mdvMr9xvndPGtwvIuaFKNpA3f+goqmFlqLzKkmcjI34phKP2x9SBIwB539Nde5HEzh
         4+fQuOqhqFW6fr0A1WOt39vJbgS6/ZrocqFc//Qb4AS0cW3fPPowumDjTLUlrcBbmeJs
         w76GGMardA2MnlnbY/M8Ncufk0XmedWDYZMyvE/+x+Se54TOWsdo0y8dS0R8RPJJveKz
         p68EYjeyWbQStSUH4q68XnG1ThuECGTjqpT7ww5lmzfsFke0B9F3YB3KBEu6/Ct3TpPA
         W4FbWIpFmv1UJav3/oV/12KrHSja2byMIl/Xx+wtYKrHOCjKb22XRGlX4CC9KSWdmiE7
         0Q1g==
X-Forwarded-Encrypted: i=1; AHgh+Rpao9VGUsz2nm//oywxq/QCzfh7JUdchlnjznKaI2ZSdzOesxGZ8MvVznCifJP0J3/ifR8mAucPHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJCPMh0FcxyA92edx8isyp4OoBuea6yLKk57kfZYXlL1Y31kd
	bCEHPJN41DvfZwuT0ftYdJy3qHKQ2zVtZfFxC0ho1QQGDHFzPYn6zIjYR/jt7X8+F0Sxk2h9SdC
	9d5N8GG946tv7kmTOeQk7aObxVRNizYA=
X-Gm-Gg: AfdE7cm2CX9ttONjLVzxTSGBFACwepgws+EFTuaf9Gs7ZeGlKRVdUr0Qk1w8nkBC0kK
	fSkslyP2JGeC1HmEfp9QlBlX81gpGsRFV+Deh3RH2uCaAmeVnVLRAGdlxT6My1S+uMpoUuXE2E7
	vAyFAXjawKGdxN+be9ZMQa4OG9HTIPtLL9COdHcv0huI+b0mJDtL/GxBkIaOKAh4TDM8XtiDlzI
	IeiFbwZjofEriRuJxDmlkU6tHoohcTvRalLKCuJh1xqGLSlCdTT9UL5gCOSY91plMemV1MeoKz3
	Wv+tuQPKL+wUcmZKd1W4wqJ2dw9pIMKDMkxaMPuOEp56k1S9zw/PsHBKMyGeKxYy5f5Ihab4ILl
	aBM/3uo50Hicv
X-Received: by 2002:a17:90a:a416:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3835a16bddcmr2702118a91.4.1783254156186; Sun, 05 Jul 2026
 05:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:22:20 +0200
X-Gm-Features: AVVi8CdKZk1uQg3RyoO9gWWnGdg1D5rtqZ5BcTTqS2w4TtsLqn1TqMImL9QufHY
Message-ID: <CANiq72k0zokLC_L2wPJRDb_CyvnJznOSKUgTaiHo87GT6Pwyag@mail.gmail.com>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various drivers
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 2:38=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> Miguel, could you please indicate if you have a preference here?

Gary is right -- it depends.

Generally speaking, it is best to do changes through each tree;
especially so if it is the kind of thing that may be prone to
conflicts.

In certain cases, yes, I may take treewide changes, with Acked-by's
from maintainers (and very exceptionally I have done it without that
if e.g. it is trivial enough and enough time has passed -- trusting
that people trust me to do so).

It is part of why the Rust tree exists, i.e. as a fallback and also
for convenience in certain cases.

I hope that clarifies.

Cheers,
Miguel
