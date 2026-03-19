Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158DB2652B7
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896226; cv=pass; b=EAB9OTfcJNi8WXHwSZi1dAyNxYomThrW1m8RqgNuvaG9BpJQkBLpZfFqkA9zxTVmmN2TH7gC5WolTJQq+jgX5Y2MFXCfrTY/dORgSp90HO6fhr9RqpN2d7zmQQF2O9ucpNmrjAjROW2jxWHLjcLr6YhH3Guj/8Zypkm3VwqvI0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896226; c=relaxed/simple;
	bh=RJ3zkOU7L58sRoFvbytTBsvFQBnd1tM3hTUu3UJnWbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AydWX1HFHfQs1kFOwExeAmxSv9knbBZ+UauIIT9uAYzAMfcxh50qF66wYJoe4WZ756ngBtYYrTjdllVxY2zSqWNPLGfuuhjkS7s3g0PydZQoIA6cQIR2Mo1Jrvv6vlXRDeW9w9jp6HaYvH/ewXFuKzJIt53dcRitRpXTq+QuW7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c5cW3sJa; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c5cW3sJa"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so527754e87.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 21:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773896223; cv=none;
        d=google.com; s=arc-20240605;
        b=i+U13kWrBE0M+4Xn/ExDZSL2vR4C8HWTgNKYLlScwbiqPnvGiOcw37xaUcbVvUw+Kq
         EBNcSY29rpdOEYiB/B1d5WGowNP14iC4ICerox7SrBG6u06UC5mInv6mpTrcb7tMr1gh
         ZSukLlHDKNIQHs2BYTGmDdGXfXEZalFf0iDToOkhI5zIISrZp/flLve5UZca82QqLNYi
         JbA6thl4rIqIobblzaS/Z7NbSif21zVM1uL+TC9ejF3ki+ruJnSXw73I/j/4kyIonkEE
         3SFf4AlpfOja3vy7V4he8z8A+ZxP5qYDFQng9/KPu3JJOsMa248Wxzk09oQ5d8zl4D+k
         hmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        fh=7UoOHGGqBQ+mgx2LJeu5s4m8GFN6XCqGZNnMtNbAVYA=;
        b=Dws0G7zU3K73bvZiSR2FjkvOtKldNiT4nVII6n5MmlKqLSegtjfKBDEDkf82+MT+Mr
         ziflqm4lnwJHBXFDDV+mBT4GYnrOQQGwys9zoL7j5IGSGV8VuaTC6+9kI4mcVqOLAWl9
         SNqm28ng7kpNFO8bu2fkOxzxnCdTO4iKUKgEqqUPvpWf4dKxShGvw00DdD+Dg+Ab5Wne
         K0KOGxgg1O9V1n9ohRWHTX2zVfBJPw6vrVDOUIL/ol2OjQhT8N9PUvpz30wV+0Zw5RRU
         XERsWkbElpKx0MUqp4Wljm8KPiLogdiH7ckSsLRns+oiQltgh8rgUqLHdKSGgvvNexP6
         kJIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773896223; x=1774501023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        b=c5cW3sJap+sGtxnrhL3MefVSVt+9F1u6gmHQ7cPndo0veI049W9uS4/57N0ivvWF+M
         OlIh1AyxOkI50DGrbjl28V7X+2kaxXSaAuwpZL+46FIwvRdLOzvs6f1yEiL98ZE84jiJ
         UN4ceoFLzm8NvOP2yD0hwEKGqQngNx6q2b5sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896223; x=1774501023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zufBE/wG0H/dPy5NtwxW5QdocP2uRSfDHkfDw+3Fq4=;
        b=TVPQHWnzCsnR+/VFbcqJKKVmgQi1MFQoEYasHNbEJQxJdN8uArc5fNcu/1sPnd1o4i
         KVrl/1THRLfoiEJ8LZmx3BlaBYWOR5avAEHE/fLIEC53izNsZJXQ9H7el7AeuGq9CWk/
         5YD4uW0UWl2zgS2Y5h256wefmqld5Z2CiAm1ftOlcby8LDY8NvhurQ2mAGGPIH7NBBbe
         nCBmyLWdSCx2ql2DwzaqQK4fD8e7I3wLvXVKs6y6JWTp+jXAMWuiRxFL7RmaVvu+t9MQ
         dVCxHxkCWodIZF0fLr8ZF6GtXzw0MRP2t5vvO601AdME+W00dvslcX4DzkpHRPjslG+j
         4t2w==
X-Forwarded-Encrypted: i=1; AJvYcCX9duwa9UA6QPnAa69eLo+MuqTj73jtu//UZIL3Vn4P9YJcUJ6Ki97YkP/xot/552G1QUnMson0KA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+CBZx135Z98nxmJMo2x+peRgMjgTvNjH87q05i0xWWjKLS+4
	P28X6ZMBPjlUyLuIXhTjVasy/R/BFSroLTb7IgqS9BE2QBL2UwlmwaAKpwfklpATjFMltcnPXLr
	VWCxrLBNqv96+YJHWzcV3cSGpt/doHC15evqul3P6
X-Gm-Gg: ATEYQzzS9Ff9OmY9OuYR3uOgvv+TUdLmCKl1m7gQ+hPNWk2NCGEh9Et7gTIzyCpM/to
	nytqSVQGaR8kV/gyQmm9BISNoUpD+E5SpOZdofiZZAiyoa5JhwhpofAGD9r6J0beN+g7946ib35
	QRSd6DpS7nIzsT4w2VPjluPyhKauDerhbu4Cm9oqBFE+Yw5qWnfnrxLQD7K6Ww3WHt88/Jil+Dl
	xvCD6JmTvp6L8XRB3VgDTYpFdtiKUWrD1X+HAPzELLpafR66ktOlB/pQMa78php8YA6EsAU0ehZ
	Fn6z+rSQ49YmGoALLIhitnQIyGKNwcvk7v17cA==
X-Received: by 2002:a05:6512:1598:b0:5a1:3561:de7d with SMTP id
 2adb3069b0e04-5a2796bae61mr2319165e87.41.1773896223417; Wed, 18 Mar 2026
 21:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-4-l.scorcia@gmail.com>
In-Reply-To: <20260317184507.523060-4-l.scorcia@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Mar 2026 12:56:52 +0800
X-Gm-Features: AaiRm53ZcC1_5GBB68m3xy0r3oGl-8GEHHuCoUTvKM9klv1nQiqkqQTd8EeYleI
Message-ID: <CAGXv+5Hz6JHBTX1ftxRuD0pJuhxGJnAkGUO7=kUh3fErOLtXTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: regulator: Document MediaTek MT6392
 PMIC Regulators
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:46=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> Add bindings for the regulators found in the MediaTek MT6392 PMIC,
> usually found in board designs using the MediaTek MT8516/MT8167 SoCs.
>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../regulator/mediatek,mt6392-regulator.yaml  | 318 ++++++++++++++++++
>  .../regulator/mediatek,mt6392-regulator.h     |  24 ++
>  2 files changed, 342 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6392-regulator.yaml
>  create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulat=
or.h
>
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 000000000000..fa4aad2dcbe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml
> @@ -0,0 +1,318 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6392-regulator.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6392 Regulator
> +
> +description:
> +  Regulator node of the PMIC. This node should under the PMIC's device n=
ode.
> +  All voltage regulators provided by the PMIC are described as sub-nodes=
 of
> +  this node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt6392-regulator

Please add the various supply rails. This allows you to properly describe
regulator dependencies and have a complete power supply tree.

They can be found in the datasheet.


ChenYu
