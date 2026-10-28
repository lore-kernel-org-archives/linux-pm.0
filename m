Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192806;
	b=HPsBCR4IDBhPIoz2ubEkTbqHyGmqIrUn7Gs2b+kWiY9wCBRR9ax7JkdH0irZids+SH8D
	 vlFlP33QmE70FL693odD+pnryZ3tKpymWDjVf6tKQYktGprfk6nxxE6H+EuJB7WbDZAf6
	 EpRaA14Pjbld8/g1feNCj4Vp9JfhlVqLm9M1w0t3jFbOemmVK0JjiRBzPkOJR3hUUWMNW
	 dRZrwB7jl+daKhoEOc94t2aADW05DQIJj3mKnp7XKyWTvOQZ116yH/FvgJDPWEXZ2+ihV
	 ANw3NGoeQr5Fkig8RdE/yV6ckLW/RCXhuxwjFvGRm4HdFLTSVFI8ZpziZPR3FW5/TfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192806;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qDzV/BSCBAxOgkyeUgwhABAV8Xciygx/josgC+QLyV0=;
	b=MkcD2qhGnqQGYMCG/vSNlKw6nQFgQCV+OKJNTGlqyIJS9kYW1qbV1ELhU1coVJpmJemm
	 VaLAfcw+fDHZGG+evoTGAa2O2ln3T6PNGNTVQMo2BM18x8CcKXzvZkCFT2Xrf76dyS51Q
	 S2EZ5ttz1BpZNvnVmlvGlHMyWPu9UcRyk07ycQZwfn6dqM+HLZatAJfGzY2+3nsAOO6JN
	 yJOzyZJ31p1b0j8cGgUX5gpNrTER8SW3nhti/J+FeHNtw/JCRWvVpC5T6yIahYg+sAZ9X
	 LtpinlWvKGms5d7VKChUNn4eiajWNrKXD5tInwX8cJa5ZaDMftTgWAMkrqI5Aik7zwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdnBz1db;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AA606A31A;
	Wed, 28 Oct 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdnBz1db
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F191F01828;
	Wed, 28 Oct 2026 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192806;
	bh=qDzV/BSCBAxOgkyeUgwhABAV8Xciygx/josgC+QLyV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RdnBz1dbtXIeb3HyA7QqqOJ302Jd+NkhIn8zrh+yGXspbul4+HP4qUcZg7SvMRyeN
	 ksTnfg3zMNnB6WNBV73M/sAaYcpWVYuM7RoTGnS2DJVKmxQO/jTzecXmsXW48Ymdjq
	 6VKWbhzz3pLQQHIUDgcnRmzeDYGdFA7lJpHW7BwCqGBMisL7y50McuyciglcrV5km7
	 IIclv+4fgj3p6ecCStDcv5+gqxZmEBMMUZuJ60UT2mqy5Zy4V02t9vPwKJc/CcUF8p
	 Fku9mH/mWu5cICCnYkIkWFOWL8dNDDPGQ4UJkzuRb5wFUtHSN/xCrNrmUfPWgb6gAq
	 Y0olpsYneKHmw==
Date: Wed, 28 Oct 2026 14:06:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: pwm: renesas,pwm-rcar: Add support
 for R-Car X5H
Message-ID: <20261028-snobbish-deft-saiga-1cb2aa@quoll>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <388ee68e120ba73e675ad78fe0b1cbd89b061831.1793026273.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <388ee68e120ba73e675ad78fe0b1cbd89b061831.1793026273.git.geert+renesas@glider.be>

On Mon, Oct 26, 2026 at 03:55:18PM +0100, Geert Uytterhoeven wrote:
> Document support for the Pulse Width Modulation (PWM) module in the
> Renesas R-Car X5H (R8A78000) SoC.
> 
> R-Car Gen5 enlarged the PWM output cycle and high-level period fields
> from 10 to 24 bits.  While the added register bits have initial states
> of all-zeroes, and thus look compatible with previous generations, the
> register bits may have been modified before Linux boots.  Hence no
> fallback to renesas,pwm-rcar is included.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/pwm/renesas,pwm-rcar.yaml        | 61 ++++++++++---------
>  1 file changed, 33 insertions(+), 28 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

