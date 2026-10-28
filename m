Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180837;
	b=k60JgUe1DkEinr64c52HR0r7LFZrc9d9iIvROeQLmQN5o0YxRG4LEgw6ez5c8Jad8tjU
	 sTvJiDTWjsJUUpFEvTx+/DYQFVxPe88/RpPZW7xdFNfRn0jVbylZ2e7Es/nuD6W6umV7O
	 sNffyZIcsnwJAulY9OhF4N2Nn+hjAShzdPKAH6dnv5kxo2qn5y8EfjCRbynAGmSpN3ivo
	 JiBxGbhHP+N66J0DxrZu0CPltG84roilqjuHlk79evQcHEUV8NveN+LouwoGZagB4D10j
	 kFv7rwjALVs4kq8IViYO8oadqFe3tFrSEoOSh4h7eNSsv6As1RcnA5Vy6QAgwywepxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180837;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=WusbLHVsIxfQC7Yt912VgHXMTR66ioRkw44xspu0Cqw=;
	b=wEZSm/NgLf2jjWFQFLHEnXc6uPuiAgE2APgAs3AnNlCp/STqEmio+xQ8amZa3f1Qzymy
	 X+6lHQDkRsOIsfzoCGXp4iDFrQYOUYWQioP0YVTcnvczS44PQohzzQsPvJUGjO+t6QOPy
	 +iHe/QE0gWd3aRWAm5qn+Jx/6MSJiMoy8vhm0mBWXYynd6YuUDhPw7E8qSBZGXVgSC0Qg
	 GETwsbyeBXkKcNB/iDHVH+8aWPodzpe6bcSS9EGyJOhioKPxLNMREedjiU/tCml7o06TR
	 o7CZSivbVtHf7vF6geEzFEjNlt01THSlHCKSYp2ZBBR4BXsmCLEJNOJRrqgCXkPCMjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EaQ/uJCb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B08606A31C
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaQ/uJCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52251F031E3
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180836;
	bh=WusbLHVsIxfQC7Yt912VgHXMTR66ioRkw44xspu0Cqw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=EaQ/uJCbnWPXlHtr5OchiT406Hq3ckTH12cvHcaO0eg76LUu6zZYqp2I+ZblwuK4G
	 2y9GB87LiAGcjLyDz+TAXxojKPvNn5cDnX7AX2KtBg/52nk5plIi3MZbZSNZaqzdgl
	 hwDgZtycuoKdchx4iyzhEccJvEpOXakE/BG6yAH/P160raDXwi35gICZofQ12jklux
	 DvT3GhUW2o4PI8rImduLewy47S8RuBZJRK2O9JWLVli3KMV1c+64q9bhsc0pP0NxSs
	 S2SL6kIjUXCPkKwg6yLinabNr0PR4vgOsQ/eyT/5tVkecqDyEe559M1V/3/3l2W8PD
	 IOZ3Lk20BwfNQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab3dd9667dso4934601fa.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:47:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwibK+M17o7bVTPpkP1GalkAbkeP/oNPxx5LxUcevVc8sR+LTZd6YaT9aeSALC7Wzdkt9PRnlwp8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYI8FsTuC4I+/W5WC2tXRiceTRAowfO5jmmewXGPT1Uh0HX33Crd
	tnwKHRSJNH4yBVU3yJ9AaL2+Xfmt5hBDhUJogHxhIwUq5fZc7olXFSYqpKv8qK8F0zNA4h177Ys
	mrcx5uhETAoDhoUebI+7xQoYZiYrfMl22NvxqJveL7w==
X-Received: by 2002:a05:651c:210e:b0:3a7:69bd:80ad with SMTP id
 38308e7fff4ca-3ac9cf74f2bmr4236611fa.6.1793180835578; Wed, 28 Oct 2026
 02:47:15 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:47:13 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:47:13 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <528b079a19bd4043754bfb56db8e5950bdda62f6.1792776697.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792776697.git.geert+renesas@glider.be> <528b079a19bd4043754bfb56db8e5950bdda62f6.1792776697.git.geert+renesas@glider.be>
Date: Wed, 28 Oct 2026 02:47:13 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdH37DhKMtagN3Ua1doY7ZgD3f+ok3V+h86kb4J8-dtQQ@mail.gmail.com>
X-Gm-Features: AclHuK_iGosVAQO6GwGuzhCeB4_YYSDAdlMHAhkY-OLVFYNCMrxDS4lJ3KzFIGQ
Message-ID: <CAMRc=MdH37DhKMtagN3Ua1doY7ZgD3f+ok3V+h86kb4J8-dtQQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] gpio: rcar: Convert to gpiochip_generic_{request,free}()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 19:50:39 +0200, Geert Uytterhoeven
<geert+renesas@glider.be> said:
> When a gpio device node has no gpio-ranges property,
> pinctrl_gpio_request() returns -EPROBE_DEFER and its GPIOs are unusable.
>
> Restore the ability to use GPIOs before pin control support is added by
> using the gpiolib helpers instead, which cater for this use case.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

This sound like a fix? Can you add the Fixes tag? Is this patch independent
from the rest?

Bart
