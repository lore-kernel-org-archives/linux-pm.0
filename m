Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FD1DE8BB
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808516; cv=pass; b=lMWkYiNalk/UeWorO3LOw1aCIZRuC2VDzEbUwpZI5bgALx868wDiFtTWFrSPISDNJdIzvXfb5OEkbAPAPhMaJTUc31hN5j6YueDQjG3hx/O5pZc5XIhOa0UFngeTdVSBnTJ+/I3jXUcAyzcHgh57yJYJ/yKORAxDnx5K3PHL51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808516; c=relaxed/simple;
	bh=12uAIaSCl7tiswRNJqqBaN64Jz/2PQBPhlMgm7mCoFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpp0HmRgEYupNqGoeO9JFwF1Z+sSeIRZh7hxQpQnLlKZMiOjl/wGJOJtFFegLTiyTH+QWxTp7NKHNyU0e6uKrCsYzsMRpiTuNRluJTFb/T5hGhniOa3uYOQJEiK3nJWhWWoXqJJW1wYIzrXokMNb9mISz+NTetDTM6/ZS8Jgalc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4QDKeSM; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4QDKeSM"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c5912314fso555343eec.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 01:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808514; cv=none;
        d=google.com; s=arc-20260327;
        b=STyKiMvxZMm7dDEqIWbxy6xsqNzMJRMxY4rdaIM4u26dfyLd5FBxocyAYZmioUPbn3
         KWBOmqeGqJXa7xcY140tpAtRIwsk6OzUOG7ME03l5Erf0pxE87s1el4nlGzocVQV0eYT
         7Z+2m9PKUI0PdeB/vw3b7N5OO0nY1RqHefuVYcmEIpOGmygqav/AKms8RuLR9OZmZRuY
         J6Dpj6VvVEAuVhiFVBUdPdDLrCLNhxAVNMWzi6N0MgiYs5VIFw+O9pDSIDIFn5RXUjMW
         FMd2ORiGrIaR9DeJ7oHAESZ63B4gY8yUGxhwTGcmaZ5126liaZKreRZwtQotxIig0pHB
         UKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        fh=ZoFKXkL6q9UjkBYGcWV6vx/09fZRKI+MV+zMLkyaE2g=;
        b=WtI3dYCX9cF4NgCDIcfu7RQv7gtPF5lRfgI/aBB4RDayYMupBBi93aaJhfUJ2uvJxJ
         MoKlqi0WlUzru5YHbJGoK87BqLyRNwv62G4Owwzvlb1pFEie9Pzi2KnHQhoIHalYqfhV
         HEuZn021y0dA6Gg3cEKuegwYeZwQCm5zw9PBirF4273FhMP4RudFpsGNIotsE9dvg5gp
         KoWM28r2oEepDeWCqE21hudeLTvHxih18LociBdmFeXAy3HfwjstzWevzYzo5bSu9wzu
         lW8JuEq7+GOAPSra5XL12dJEcz3WZjdVij4Rvmb+0LbHeVbfS6BL196jUnfKOTMGmAw3
         KUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782808514; x=1783413314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=P4QDKeSMKLnfVsDrpWCuEmR+fde0eSYT8JQqFhe7xLiugA+IX+ZEepZDsU6I5Ie6jm
         EtCDCgp7ZUpLvZdZ9CeeHs1gUu0FxMROHIvFtqAoQDLzY4WLKVd+sF0mn1+zSJcaOOg7
         ivbtAQ3UbteWlBQOZntGY9QsskxDj5hlMxFvEVEvo4HBZvZsK14n0N8BCitTpGtn20mb
         QA2/hDVc2OLBIH9W3JVORw9oy7kYaxNwQxRz/mq6Pak487EKo1e1i7J5CyPThcjxMTpL
         uBwhyWHKVQUOpS4s/mkDiT5cs0YZI553d1UZiED4mLQC2v3AAQ2O+HmyAr+DDIx3cXgg
         pdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808514; x=1783413314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=Ui+kTlSP4llUZj+W9MNlDmQ424Ji0jBR+v+D9XeJDIgNQ1XRIzt+3tSfS07oVPSi2h
         1iOYyYH78SKnFLMttACvEjEadXutTT94M89OOLXSGZb5LzVByRDJU4s523l644baMct8
         wPpRJaMwoxWH2zw8I5ZI5eFJ8Icr/mFbwj6UPegHeFFzny+1Tx8KieZPWs73uuIAtVqH
         CgUtcq9tBZNQaNhPGorAJrHV0glNRY7PRb3A0n6QbPG4xDX2TkZ5iO9NQcJOI8ixp3Wu
         2DTd0cP6HW0H06TSgvOKYqGZg4afrhS0EfEI7buFJapJ0q7dDGChachnHuWHfh8CpHzW
         xpxg==
X-Forwarded-Encrypted: i=1; AHgh+RodzQiTwz6s9nbl+miTFWS24QTTWZ3oNhfkXMp77VVfBMYuQ2JqdPk3+BCRCgYibcBid6YhOKuDMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweW596momLJ5w5Qz7RK/jrPAwjUaO/986owAUTXo+6t4zqZbKu
	ipY4pP+RMOzfgDq52+l12vjSO06BywgZt6qW2VcosmEEDc0Xt8y68ssDbTelUox2mNODICu2WJ7
	leS/xAR2Gbi8vzGq1QZKKUd1YYVtnK8M=
X-Gm-Gg: AfdE7clQGKirv1Dkr6S2R5ovWyMuLl2DEr0SrzMtfoyiJNX/AsiGL/bR83a22qF9OP9
	3LM4TtUawh1XCUsiHCviB0xAolYsz/6U1DzoRcN8M7gfuBh9FByayRCMPOlPMwgSzsWhhRkZiPM
	cSBxeOmkmuYUYfCxjqTCFU16kZtCQzSmIIdKIfC4m5SFRCTyIIDilTQO1F9uqExD1tLtiInM2Yx
	5NU0liFhWPkYhhTimeSwp+1HVpcVpDIipgD8tAeBBOlpdjC7o6uJ0QZFvKM4cN8cYSsyAohuPJy
	9OIRxfbNEHDDH25h5KPRM4WUPgByBbychLge+7JPlydvouasb9kzTyw5o/mwP/zWNq97V9yCBjt
	BqkyNOZe0z44Y
X-Received: by 2002:a05:7300:6ca1:b0:30e:dda8:e0ba with SMTP id
 5a478bee46e88-30ee150954cmr1003565eec.6.1782808513710; Tue, 30 Jun 2026
 01:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev> <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
In-Reply-To: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 10:35:00 +0200
X-Gm-Features: AVVi8CdhtqV-BYuDJ7-_rhOqSdDxdGUExu9BuuQ1x0bjmiH_24JXcG_HI6rxurs
Message-ID: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
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
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:43=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> If the preferred style is to place each imported item on its own line,
> shouldn't imports such as
>
>      cpu, cpufreq,
>
> be formatted similarly as well?

Indeed, good eyes.

To do what we want, `rustfmt` needs the `//` at the end of that level
too (in the future, it will be without the `//`), i.e. the patch
probably passes `rustfmtcheck`, but it still needs to split that line
and add the other `//`.

Cheers,
Miguel
