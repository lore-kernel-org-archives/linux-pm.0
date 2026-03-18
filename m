Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F803377022
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869142; cv=pass; b=Y/dPAmkF+KGZd1myp48Qu78ZNPvp7JNmROFQb9XunEtObcQ4JFSraklaetTr+e1ke5b+LT2A5LuQMa0pTWn5fSSxSRX6BR6Z1pPUDs5ljmT+s+ZytdwVYnxc+/gIDYq6i8od1QlXcNxrU8Js8rSaS5NMmBJVqW7RofHiWgYL2Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869142; c=relaxed/simple;
	bh=EQzldedRTpvLua9RqcprZmThFLsNIvG4JO/73zahzZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ51vlyCRV1VhRCyL1A+QVcaPx6EpeQmuYc5utJrrP/GZ1pz98uaWAoBtH46WBL9UMitg4pHMT841vT4nPlptzi+0rZ4hhjwVcmIAGRZPl4bfONUr8DkgAEy9NRlbQVhz16sJkBecu5ErwD3zZt9NvqWhigcFUR57QWRObX0OiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re2OHwjP; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re2OHwjP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97b30fa5e5so44793366b.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 14:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773869139; cv=none;
        d=google.com; s=arc-20240605;
        b=WJDh8mEK7D4+stXJqQNLJFr+4XIExqLO1vU92npUS9ty6nhkBrgqM4896JBJP4sCl8
         ZSzQwxbqXZNABsaMsG/2qGz33IxtNM+Wf4ub0AbgL7uovxcIcbWLqt0LaXWw+QAqn6+3
         oYYYiJMcONMlgCznT6pMFwLxhql7GbB+nzrodjxLjIzCXzRnOGZg+1mZF5R2Nxmf7Cdd
         0gW11AYCTIU8bvxEI53uMl48ZFEB3mzGXBXeMXDSUX5EFh9vK8uHq64V+31v++wIMhaW
         pEk7OnYkIFe9lQALk/GMXhQO2biYWjmrUfz6RdP5UAtMdTBxX3WTIFphKqz3OzKh2xHc
         Jb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        fh=1Q+9KX44BLPEzMNLbuXyjmYDxkUPWZ+dA11hTyt3yiw=;
        b=VIrEpXI2znaY5QOC6ZPTukHvW32BwDX1R4kUSKIXKjnveyqFkHRy/cq+0pHOpS0Yec
         Y0Xq+4O0AfXTZCVOvDdKI5evL3KKFO4wUP/Jom6lLk6IEJe49Httmth/p6jSDM4SonEt
         mbjwpWDeD5IJyDOC+VR/tnlovlrtXUh6rJ0eb4OF7nGo99dg6FO0ydAMqbZ/7JKFuEGD
         d8yAMgQyGAeyuZ3Xc0GAUYt9bIVEUlg50Iuvt/6/XeZfG1oLAahKQTfBdDmTlzAdx4mi
         pK6T71ABpWu7gKibcXRXfHIme1e/LM3IdE8bpVMQnYT79eFrxVDWBZCqrCuetoo7Wnta
         v6oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773869139; x=1774473939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        b=Re2OHwjPI/wDcppVPDTGr/Fitxq6TGT4tDY56to6JnJhMTzzYCnafDK2PCKKqDSUhn
         BsEOrJGmt853phtdlbowPRteBqyNBP2j/wLp2BNDngQ8Hr+WDtb0lfJTnLWr8J3xSMFv
         M6J6232/9vpMujn96uwoXZjGFD0Mvgz7BE8MN6bSibhrvytfifEJT/eGz63qWwHHuLYi
         YrUA0/dWuACmf31FnFD1Na/MNCDQ7gFYhTyFqTPVoSiNmt6c6Qpp7TClWNTea3UMaECd
         rWXoYYF793tZZfc3i3TgpUr5JwMODjualvrvBQTo5Fyfgcc+6nUn9WM3fkL17AaQ+Md5
         i19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773869139; x=1774473939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        b=bBuIaAUGTCuxeGDRkigXqvN749lJe33b4mf3CPZCZ2a4pZsFurHrNaEJuCiGWtIkt6
         EtCOu6fUMrXaHmT9iSl19/6LpXl7XcLBSBiZNl/h37easxV2uB5r0nCh5HiId7IYdn6O
         gT7jcXFv2NbulPDKIPY5V7yghAZi4zP7elVJJp8TjGsQm7+QDILjaC0pSuTUG+ex16cg
         0ZrXqcVwyreOTZ/ZL3bJZuzR5E09tmbEWZ1PfNcXYQIzWoNWuRDrhrnsUS6/auXdNQgx
         KPhlVjzIz2kkU1HBjv/5UNlNgb1if//epYvIdD5N+5V3amRAbQGNltILe/Ut/5ijI1Nw
         CcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlRkOscwAaXWpbBotzWqe/4068brWo1qn0KDlnb5yKoSYjzkveKNCUcvrk97bcHr6OcP35cvLKGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZQzu4y6ckxFEyabp1Eu/QKISKcsn5Csk5qcqhAGEKchZ+2Ao
	l1HYhlMQeZmog/aTu7hEZOweB3Ug019pjzXkEwXBpvsPC3mvFil2+SqUyjMoPhW0z6WnviwJhmY
	sF+dCwitN2txqkOZ+LYXe6J4OZu/0Dis=
X-Gm-Gg: ATEYQzzkXk3Q0ed3KHWUtL1DnaS9CPbP5GmIoHohX8Zi4FdvLQ/kDRfkPHvOcKivYf4
	/Ya/AdjVD7JkFTAbcXMqgeZGQufx+cjL2FWi9728ynwzQzJKOeRm0HhvHht5k8r8H9y5Wkr8zrK
	wFqidJy9ekbQdXSmmgr/7v1gmJsA+Wtax49lSTojaFK28KcZoQVugM8z0CSlx9YwG2Cdd0eVQ2X
	CIDc/3Lx69c6rRifSbPzQyKFdyMJQM7jWyf52i0b941CB70a0aFE5iT3Px6xQGknZvMd/PAB7lb
	jxn5HA==
X-Received: by 2002:a17:906:99c5:b0:b93:9407:ea5c with SMTP id
 a640c23a62f3a-b97f4b70e51mr342818966b.57.1773869138582; Wed, 18 Mar 2026
 14:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-4-l.scorcia@gmail.com>
 <20260318-nickel-serval-of-tolerance-621bad@quoll>
In-Reply-To: <20260318-nickel-serval-of-tolerance-621bad@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 18 Mar 2026 22:25:26 +0100
X-Gm-Features: AaiRm51yI9RGCvrRh7GVNMdJwfVjHSZ_bJ1ljw9KDUXHaZfxU7GvIWfUsRzyb80
Message-ID: <CAORyz2Laoo4EiLcHZ-ygLiFGW_h8qV7QxqNsMbueM=nov5zH0A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: regulator: Document MediaTek MT6392
 PMIC Regulators
To: Krzysztof Kozlowski <krzk@kernel.org>
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

Il giorno mer 18 mar 2026 alle ore 08:43 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:

> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> You already received this feedback from Mark.

I am sorry I missed these. I will revise all of them in the next version.

> > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
[...]
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mediatek,mt6392-regulator
>
> Drop compatible. Regulator nodes do not have compatibles.

Thanks for this comment. It took me a while to understand what you
meant as most of the MediaTek PMIC regulator drivers still require the
compatible node to probe, including MT6397 that was the template for
this patch. I compared the driver to MT6359 that does not use it and I
am now working on the driver to not rely on it.

> With this, you can also drop example as it won't be used.

Just to be sure - do you mean remove the compatible attribute from the
example, or the whole example section?

> > +
> > +patternProperties:
> > +  "^(buck_)?v(core|proc|sys)$":
>
> Nope, underscores are not allowed. Use only hyphens.

Got it. I will actually completely remove the (buck_|ldo_) prefix
altogether as suggested in another comment.

> > +  "^(ldo_)?v(adc18|camio|cn18|io18)$":
> > +    description: LDOs with fixed 1.8V output
>
> If fixed, then encode it in the schema - min/max microvolt.

If possible I'd like some clarification here. According to Chen-Yu
Tsai comment [1], dtsi shouldn't contain voltage constraints. The way
I understood this is that electrical constraints are a matter of the
actual board layout, so if adjustments are needed they have to be in
the board dts. But you also specify "If fixed", so maybe there's an
exception to this rule when the constraint is "absolute" and boards
can't actually set a different value?

[1] https://lore.kernel.org/linux-mediatek/28102417-4a2a-4e29-afbd-d0f2aa76074b@collabora.com/T/#mb1473bb5515f3e5a1bb3ff20c717b387c42373ef

Thank you for your help!
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
