Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0ED33E374
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714348; cv=none; b=FRh1F6wcWTvqZURGUvmpmTuQwfH64WplrpSX7WthFX+d4qsWgN0l11DLvEAb9N3dUJsgPaWH9pb70wFnGbmnYrX95FONxAds7Z33ujm1CSymYFdXumzGg0E13MYmzFrgwj1oNChuqpuMbDEVdZYKMfMi2gJyBAmtceSIx3S6Dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714348; c=relaxed/simple;
	bh=SDYHbKXHfX9Y2pe1dgvuoInQbKO/zXiJtMq7qwolnww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GivubBW+/22CK8dIhthgpDgHCVKa88wGFpR9bklR8HpAik0g+1YibaRKxzM1S691jY3JcOJWRlr5ada7OGLav1jtG0gjrQsCBFT95MTUCvRPvys3h3/e5SD3FgU2nFJou4THrEUKYbaslLiz24B2AsEYvUazpkMYvSj5WtST4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUWven3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUWven3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E73C2BCB5
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774714347;
	bh=SDYHbKXHfX9Y2pe1dgvuoInQbKO/zXiJtMq7qwolnww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BUWven3tTY39LHzZKvDQ5YFSR7pWGb6ZZYXckmR9WiLzGf+QxzV0ZpeM+SvCz0OSh
	 M9jVnx7iRO0cfBf0D82j9N5gY4ClIG3DpTGybw/4NTiWUK9edgYZoUfISvVM7RVxud
	 qIfsGGLad/hWnrqKyYu7NbRWkYNTLx/J0j8ZrSqtU38AfN36olkuCCJLNLEl3q+NvP
	 4fiwYbk07NZ4uosNwP5Qc4diVl2elWRMpL4dgXNiAj8X0ml3wKyWo6aIWYUbJiGjm+
	 nLCnKLR9848mWc0tjd/TJb2WVehYzPPjRUahvmwmXL6/Gm9ygtioZqljNddiTaPcPQ
	 uPUul/6i6un6w==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6500eae6d2fso502564d50.1
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 09:12:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkOpz0i0VVu221Le3SeAJgOmjo/7AEt6hx1X1TwBreEVfrRQSpzm2WPKv1tIXcLooE80VEew1voQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlPprz/zP8WsAq8tFzgQJdhPcwImDB90n0NNFSkcXUZipWOwR
	Ise3ayV7NzSpWR7cWBuYjYgVEkOXZ0ioDK2irtGP1W1oedjcka42AZcDR30iWNRU7BMdQyZmYuj
	dKQ3h1bQdSP7QQmi85a8ZX4G5UU0OoQE=
X-Received: by 2002:a05:690c:c509:b0:79a:d0a0:a883 with SMTP id
 00721157ae682-79bdda0e935mr68324137b3.0.1774714347027; Sat, 28 Mar 2026
 09:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328124707.141209-1-khushalchitturi@gmail.com> <177470797266.1536342.6967120656934552033.robh@kernel.org>
In-Reply-To: <177470797266.1536342.6967120656934552033.robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 28 Mar 2026 17:12:15 +0100
X-Gmail-Original-Message-ID: <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
X-Gm-Features: AQROBzBmxlgNPR4lwnOObl4JeVoYuUZVuS6Wk8AtiSoqbvygkl-i3j0IOlp_ErY
Message-ID: <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: reset: cortina,gemini-power-controller:
 convert to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Khushal Chitturi <khushalchitturi@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 3:26=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ower/reset/cortina,gemini-power-controller.example.dtb: power-controller@4b=
000000 (cortina,gemini-power-controller): '#power-domain-cells' is a requir=
ed property
>         from schema $id: http://devicetree.org/schemas/power/power-domain=
.yaml

Weird, this power controller does not handle power domains whatsoever,
it handles the mains power. So it should not have any power domain
cells.

Is this the result of some regexp gone stray?

Yours,
Linus Walleij
