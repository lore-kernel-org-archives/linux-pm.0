Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C947AF56
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243011; cv=pass; b=RBvXctCdlEhdyhobWu3H1BB3qurjBbYCYuKH2sroPO3Jw9wXQb6Q5jU/9MBaMK+WcODNKP7SAV9y98E1C4DM6AzJC/gVGyxt9XTB4bPIn3Trrym9mcvNjuOA6+qyYoC9/UJ4y0xAldBlNt5KjADF4n5uNZ9ICGd+Ct91OrOEl1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243011; c=relaxed/simple;
	bh=nM7522pMTSm6ohXpjcirSMLxO2bUSl44i0fllcYRFAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoHi53YAHvmia9iICxLzsEXg+vs2XjQZr8CnQmQqS9iLk+0pk+MNosakF7PHobHBM9NoHfzvbMrxW5Ry4wMRWqfU3+k374uOv3peaYk78ETgs/os1yY6cHKeBImhBLz7ViOyHkaSKY2PUYQbsN3wKEP5Q9f2j44BjSqLHdWZDM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOlEWY0M; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOlEWY0M"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d111ca99so2764466b.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787243008; cv=none;
        d=google.com; s=arc-20260327;
        b=RLXa0FwHjL8acVteoAUcpceWwICRHgzxo10DDHAD5Q95R0nsJKQKF+qQK5DG/qM54j
         NaC3VHwUASfPrj863Z36tEH9qrUACv5g+gXFlS/6Rti6iEVhJ1YxBWhqFz7jxLK2zGOz
         UuddtLJ0/XwnjvHv8nhkNY2ysZd4afgO6n0WURZQwfmOC/8q5oA5MZj3maDS1NdzK2O9
         D8+ONnZwgiHXS/ZtjMHlPdj0BiOPFFWi0TUCSlXYxtUasPk/h98XtGA/WRBgyh5TFGKI
         pXoj0FWhI7t6E3Z4S9YoIv8QrAl56CnUj8wPSvyleCxd/Zc0fbfgn2wpYO5ZabtZAmic
         Kl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        fh=1nL4f5ijRX1wtrie5qVXqcIGHXjTPj50XS0NeJ9SQxM=;
        b=j/N1Ae8REjTpkm5n4GtB/Pg+xvAtw9lEtTstim0EDrmgok6xLJsT1jyaisqzlqswvD
         Je7l3lh8n9bx02lJuChTqpbXvd4iZ0zCYTg84GNqjadNf4IWhxQ1Dwnp84u2Sl4Z2yLl
         R8gqNQpqCJGXPR+zpe6/i+RkfkT/T2mFLduDpabGyoZu86vBReokvG/e8GvJKTJsjno+
         6MFh81I+GTVF1fe/xzwFlWQHTTHOap3as1H69GOXTwEhv9VQCcN7pgVd+4HPpiUOUsWr
         8qi1ZYTvoKXOQXYL3JPbrCNIMSnyN2eg6RuS9hjrAXl+TqGmdlp6PZcwt+dRhvg/h7I1
         hlBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787243008; x=1787847808; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        b=bOlEWY0Mb292rIMAKTE6vd/2FxvUetWzvZEY63S9Avih8hLO9+PCK5rb0GHwFLtbKH
         kk6Yyekz7v8JyRhvAMKxxrElNC5posK7Q/kEiwL2lTIIDaq9/a08fizXIo7lDyJrgqP0
         b5gdhtWHvAoPgZjSNxI+CQ4NsOydysVImcu+u/xsGrEcKrPHk5smpVKqGROCgs7aVEkv
         yFqwB/fLbbyTtVeP8L4wcLkSq/Ot1NHJjgJ8Y/wFGbCLecv3jNkvmi+gt/rtzxb6/A5F
         2a6XcFm0RVzDVbzeeb5oq8dNKe2jOt7WD5xzQ7b54KuQM0ddOntBTLtv02t+AFfyfokM
         Igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243008; x=1787847808;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        b=o4FbFk7tnr0sEP33+xqzb3yNASrIkuzy4EQ1D+yTUWzTkHicPtQBuxkpESSt3NDwRI
         dBAK9IQXpOwatf72q685lXHVACULG9Lg+soX01vbJhNki6aHzYUgsi43k3VJ9dzIotDU
         O0BWtVBRA8uzQyZYfelKF1UU6o2S5YG1S66k5j0paE+G6N4qYvmMjxiIAf3Uw9cAq6VD
         bvnmLsWLEXHGdE8NcQQ2Zf90Ikfj4i3JIgma6fhAkjFx3JHY8vmYzCJBti527qg1vg67
         FsE3QMvfRU0rCBnSJ7sOQxOSERd6IQIpFB4J+oo5A52yvy1tvVniOO2aP67D5mk0NDz9
         Y1kQ==
X-Forwarded-Encrypted: i=1; AHgh+Rprr6CFcz3R0a48FUdANGSSZ19HljUbC8IXLmOb1EWrrFAHg/Vt9k4EislrB5VXnRAcgbd9x5Y/Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJx8kW1RD3ujxha6ftpZN8EDQd/ZizHw6uHlIYaykLcIOXRYx
	62V83oj3fWK37CqQ2bhVIRIDlcLXUEwJvltuwsUkXGj12vMchmkd17xr95XUhYPrjaerdN7N85V
	OgwJQYn6+tcqphwRP9EweFtp3NFDEcLA=
X-Gm-Gg: AR+sD1037HzBJCEByfCWWUwz1eZt7CO8JhYUe9DWM0k+EzyHL41Gh67z0nu4ZZUffAg
	gVPYpgvxoiqXR3dgWMsyDUbsVfY1gC5wBAr3SnZ2jMoFHyuprN11t73J56aRtHVETwECbFsRi6M
	osCEop+UUoIdYXZOSJY8jyBi/z0mXu0gxwXQY6AERoN6TfA78x3GKbzziGHpe3fPqGE6y5JK3hI
	ejAg6ElnSZi8rnTLxgqXQYXh0jm9mbgGrfC6liSJflEwlC1OcYPUafuhsCNvit+tB6h2PuVelrr
	o3mVuYy+IpEGeHJX8xHe/rBEi7QHYpRcYusA4hopd40=
X-Received: by 2002:a17:907:a647:b0:c12:9b93:61fd with SMTP id
 a640c23a62f3a-c23e86dd23fmr1141726266b.6.1787243007488; Thu, 20 Aug 2026
 09:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820122242.120039-1-l.scorcia@gmail.com> <20260820122242.120039-2-l.scorcia@gmail.com>
In-Reply-To: <20260820122242.120039-2-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 20 Aug 2026 18:23:16 +0200
X-Gm-Features: AcwNN1WN15gIPFE-wS5GMikP40k9b6tUzSd1TSg8R6uNQUbH06o6RfXy9sJzOY8
Message-ID: <CAORyz2Lgo=teK89gxm6QBMfREY=_cAFN2TuLUFvwGcYpozkWww@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -40,6 +40,10 @@ properties:
>            - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6392
> +          - const: mediatek,mt6323
>        - items:

Please disregard this patch/series. Sashiko correctly pointed out that
it's not necessary and actually wrong to provide a fallback on
"mediatek,mt6323", which was needed on a previous iteration of the
series but not in the current one.
I will mark the series as archived on patchwork and provide a revised
v10 once completed testing on devices.
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
