Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358927;
	b=fCv1mbSh5Dsh/ctTzf4ygHcSYKsL2h7ufgIkXMc7pYSM6ylicEXFJ6Rao/2fSo0y+UIY
	 sk+uV1bs0bMk/9Zflel+nxBEcXhrM8MeaWFxQTPvNW7hveSTxs5lbK6Mh5a8grZvnA4zg
	 5gDy60cwrEY70ZF2T0F9agKaoNNx2+hk6zl1JYaReMkAoQA0G6ozqnDchel1M0P0ZduLX
	 Qi3WQf8XH5ECluJNlcEHSELn4y1OAIi8o0EUFnEjmS3VduRVePTHdUhSLsYLfT2MoNtMU
	 iQLoF0w4+8UFzULf75//k55DNMOhc3RYQ0I8TStVgddb3o0PNjNFCz7A5LhHwZJHUBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358927;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4LuX6viShIi0dZkWLBzFB0AnGUBKUuhfZQE4sOsfOL8=;
	b=dUW+hHM2l5HOd7ICiiE7FxZY/Kviqh2L03Fs5WWP/KDPDzlDnEq51AtbskQyM70uAstX
	 VR/BFo8LIiYzhZxhKIx2+w8G/ptB3+h4NPicQkvjLUqVS6h6/RZ8oH7ZoT1oTkOthiITG
	 /YBEgaKCxBN5axgbMcw2oD0EQOkmhmj4JGZqdsTGFxrFgnxwG8OzKX6oE4uddL/rsU7DA
	 dwW67TH2p8Co5UjpgSGKnwj3HZiXauVwO+W2dvAC5JGpjzB2mUbOaGv/D1weTS5zbokcY
	 gk89Qsk8ZufEmzs69yFXS6did4V9w67garw513OwO4nEl218VJBAbIViFg8F8wtgTog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koSobmDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5F606A31A;
	Fri, 30 Oct 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koSobmDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1B21F0093A;
	Fri, 30 Oct 2026 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358926;
	bh=4LuX6viShIi0dZkWLBzFB0AnGUBKUuhfZQE4sOsfOL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=koSobmDNsosyI2zvhAxvlL4srpRmz79RPyy0cykC6V3p6prMwP/y7DC7uMuTszGTv
	 BG3mNdgEf1FC44ikXoPJbiNxlVCiFi9VANl5UdM4qnkOyfhplcZOw5GRd9U1yzgYul
	 uNRd2okYdwVh0oc6CcUD/FA8tmDpo9fzGM1goXjPB7VZiE1sfh49/Q+MZf+ajtP82Z
	 AaPKFoWq3teCVundpmSTf2m8qoyVYWGoXKmjAqm8Rj1c6CQQzvSpx33CBiq+d5GbLP
	 3VCUfX9Eit+2ST8x6xksGoNm/8ySFDGK62SFdvDKW1yVbaJmaV7l5nrQH0fy/Cea8Z
	 ZBCvcFKVk1Gdg==
Date: Fri, 30 Oct 2026 12:15:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org, 
	bmasney+clk@redhat.com, khilman@baylibre.com, martin.blumenstingl@googlemail.com, 
	rafael@kernel.org, viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 1/4] dt-bindings: clock: amlogic,s4-pll-clkc: add the CPU
 clock
Message-ID: <20261030-rustling-expensive-lyrebird-aeb880@quoll>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-2-christian.koever-draxl@student.uibk.ac.at>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025192219.209137-2-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:22:16PM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>=20
> Add an identifier for the S4 CPU clock so that the CPU nodes can
> reference it for frequency scaling.
>=20
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> ---
>  include/dt-bindings/clock/amlogic,s4-pll-clkc.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

