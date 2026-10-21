Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792564549;
	b=SVyMHKpiDt/xpL9A7SpCrUbjKGigFyZZP4bDixEh4PqVGYsPn3HM52H+bfNv9jTY3rq+
	 yo0UQzZbcCWQJrRDjq5Z4QxnxinXRew/HHu0ZBpL8gKLAKg1Jf08WvNmLQf4fWORp8UuF
	 8Z9+Nigk6c+Tu6098sELwRJG2rJ4IZgJadW3vC4P5YZJRYnfxV0Up+sVdMzEmSoE98wrM
	 BiihJOESsGvZ7IOQHQDsi8qjRRhC4zbYDRV89mWIqGTBEcMuvpjJ7TMpS+gSAZmkDiaVT
	 3zsDysLknqVd6MXQv0rL5ULECFG2KbLmjoZXuOj2kyzmF8O8kJEtJaWvk38+pK8fpeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
	b=VPmcdBeU6bOPIJ6DRW4Yo29AlS57dEL84+cAEEb+CrLW3J3m2cHA8TTCiVCxFLfgJy3l
	 YdKn8ltnGKJ9X7HpzMEg24bbqjJHyegXeB8J8e6sWmgSCss0FXlduDBQ/JfBJvb8Nuliz
	 PIgMiUWAmaFspvXHZwpYpgm4A7VW6+VYhT8zi9QUPn5J+SFjqZqV0Eb3VuOY+jOiVBCg/
	 1269rEBGjAfiN+vOQ+KoBOTFsRkZHpYUyLB7ETbWVj3H6o0B+gqp8wBaTcjY1v1oBX15R
	 y0ZgcZSDRCTqABwud6FU2oKoDhyRXfNoBdvt/X5bItPNTyTrNp2KrosAdtKCzp56qiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SQsO8Joy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BE606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SQsO8Joy
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so381715a12.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 23:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792564542; cv=none;
        d=google.com; s=arc-20260327;
        b=rFf2yke3QHqR9wcaj4XEUPniO6YL2BULChE+gwPXMgZIdSic22OHvGdluwAIHclnFS
         cz6WpSS2yiE3wuwPXkwQxvcuZBsrqHpdyGRbYcvAmwSuU21OUPFIOQ48DOAt5etwlnEY
         WB09gsT6ovqcDYhLJlaOTd4GvLX/0Y3tFUt8IKCjSU+RjYnycL96i0T+e2nsMTNOMLiQ
         yva9Yvb3y0XVAE4PQF0BGOqC4lr9VUogJlb01u+vsdVdSfnZfdKvBA5eOuQdBcY7R5pS
         6yDdh0uaZiEbwFZ2BwhUbI9H2b7djxW1WQS9DQHJIgY2rqyAO3mNHbE6pRIgyn52ykEo
         hOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        fh=VJ6VKiOxIefndd+loPQe0Nanoxnll4OluBg2HsZDWuA=;
        b=e962kyK/DrC8Xw0P/JtHyy51INsFKHjMTE2Y1khvgq9QzJK+qSZEp3GYgUVlZalfKT
         21zpJTgk4FGs/2IqfBizlZWKZWG9QHNU69aZRmc/Og5/5fRFv92rLqCoAC1hAS5u7XdJ
         /bCkH3IJHAeqzQ2+eeY6JXgaRo6/JBLxSZGfn5r5CO+aDi5JhDKUCZwlSTDHY/jjV7zs
         5sKdxyatKKxqzjAQ8hu/vKzpv4kJS7ZVfsjMtDQRZl4EFDRN3bif2TCWNezB9uhZERgq
         INPU/aK7RS8VQl1+vwXotTOTBiHd0HSn/SiI3T6YQeYVBUCZJBswg6Y5zUxKUtpFJZuz
         T8DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564542; x=1793169342; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        b=SQsO8Joyz7VS+7gfUvSNluNI65EhcKIFQMPJULqGN5UfjLP9MzbUUAM2GeJ3hqkllf
         uQTdBDyQbPPjRYGai0WfdeDnW3WO4+t42Z2mxWWGm4pmVnVlCQHe6qlpBR9vaZ+vllGx
         h2xGVBgEQCFKH11r+9q5QdY65sS295/+Tq2DS5ZXmmh/j1ULBCd9h7KS+U9B5Cl0c3Fo
         X3iBdo5tlBejOn37rvZjodYCVcBnhpW++UlRUA6F09Pri2F5ZzW1B1p7sy6bKVbEkrHz
         Wb8LUZX233PjNaT0LiBwXYPf0Yyg5Q1S+TRvn1by6+Fz8GSTOQ4X1R586y6DHikxclnf
         NB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564542; x=1793169342;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        b=HGEFytiwa/QujbErqIyMW4sGrEovwZFricDExaMMV8EQKgsmCyJj627SpHpWO+jYuw
         dkd1tNDTbVd+EfhZF+RoHpMaATSl1VKKQ3asbymTsGvgfuHKD84rcEiJ6dddpcWIV1Ux
         b2SGQHtOZ23/HGjIBytuFfjS+QwgEorLlMcvcmKFWtmp+t8UJSAY5zttcAYHY8A59YYT
         bOQ3J6d5zqyn8/mPhpdidnYp7U0KkSFItqdm8wz1mLKRJQ2S+StH2bkyX5I3LeJVXcQe
         8SNctvHiW2il7qI4g3z19D+PnnnLYBe0pQ8urt9SIgYvAFLLdo225rV0zVmVSHcrAnfu
         RyyA==
X-Forwarded-Encrypted: i=1; AKwUvBwrQnFNhRF96tmdNQcXEMgcJUyjkSasXQrCdDqLDgX4zXKW0B+UqVlS6uOEgPjweXtD1pJnN9lI/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVssWtOihQXbu8kbGV1hqVKJpt4orzWWQYfZrY9nMH0izMVfU+
	jOFerUC60c0XX8XJfeRRMW+CgMN7gedugsv2GdPPkaRDBccMIYa4/b2uS1HErERBtuT2OW0F9uK
	pTuYYHifNgvmfgKmeFhc2nGO0Tdi1YQs=
X-Gm-Gg: AYBFou2L5UDPOjwNR0oIkcr4DoXlYaiPrQP0AxpW6qYxXXM/xMkt/W1OTw0sFRou+Xl
	T24rL9m7li+StWP5mV9L7qh8g6Jx0wmdKC2nrrnBChvtS7IT8wmDAgJgM6DjmyqcT3Tm6YF6qEL
	Iel0uwgYsXMaY86KzBFoCq1i+ko0Cn2mvjuNYBeXOE2lV6LOYBrYigHyiBJx0XJKXrc6hskedRV
	i6/sG27wF5FoZ2w+W25egSfF8XkmzXRRuq1i76POgYE49wzms7H3r/RG+mKn5cGNu8sDBTtFM+X
	ioYHEwRoUBCvYPDl6gyC/TRfB6giN+AyyvUBnMG6IFAziBdW3O9Oaw1wgpRD5NSj/tlmGYrS451
	1cPHFqN4GHHjen5vH3d0j3wKuvxqktW6iLbaoLw/bj6ldiuW7P8zYml5j
X-Received: by 2002:a05:6402:2105:b0:6ac:5de8:ab5c with SMTP id
 4fb4d7f45d1cf-6b408ea04f0mr627314a12.10.1792564542175; Tue, 20 Oct 2026
 23:35:42 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020173556.632798-1-l.scorcia@gmail.com> <20261020173556.632798-2-l.scorcia@gmail.com>
 <20261021023245.GA3650393-robh@kernel.org>
In-Reply-To: <20261021023245.GA3650393-robh@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 08:35:30 +0200
X-Gm-Features: AclHuK-lIJk49lXRNa98GE7gi3l_Bk4TgNu432VwdO696lfchFDIYtZnsg1U3Dw
Message-ID: <CAORyz2JS1vf7P2cQkzYse_WheB4xYMmywWi6v2pNbeFSkCO9ZA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Or drop the example. Is this one really different enough from the
> existing example(s)?

I am so sorry, there actually was a previous email by Krzystof
Kozlowski where he already asked me to do that and I thought I had
done it!
I'll send out v11 without the example.
