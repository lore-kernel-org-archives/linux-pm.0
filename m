Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7E386C2A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691336; cv=pass; b=ILoBO8SMIzcZbnZDNqfClWQD5xCyxlvQntIOtG2lWtZL1QD7zGTGBy65VPcpuo5s9yrjJppbiDNiMbNkThubUj1LRCSnrHQML8/uamKSyAPbclIr1RMh5ku+esXb7QtjmI04uCUfG8dlMfxBP21hmxEb7nNxQWKOSTXy9uCHlSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691336; c=relaxed/simple;
	bh=3Sf/Ef5H800PXwQhDeBagKsip9d4VoWdZ9+JzkHv958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqi9ht9Nl/hL1C/J7jC3UFsDmbDNQXGBrdxTgh7Mbqyafq+bN4noAY1YXMNRU3MJMWUzgY7zOARMhI/VC1QPCNbH5l3VhjAQjS5DpijAsIs+wbZ7JVDUjR0K3Ue/M50v9d5tHoB9sS7yGsGcuzCTEYBxlQL2hd68tM7ZetfmrS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QIkv1PXa; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIkv1PXa"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81062fdeaf5so51592517b3.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 20:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784691334; cv=none;
        d=google.com; s=arc-20260327;
        b=k60RieUJIqZ+iCFjsGg7ASmedHMlNHBRoZisJcgcEQ4m3+LjuqZ5xY+Rxb2xASS0nY
         iinXgMecP+tr5lRj/Z/9qcWfcZ/xi+RiQK3voCm7VXiUaxZP8jPkTiLMNY9d9h6yvP4F
         wnyP4f5jMKXdGcZTYysvDg05yX+S4tR11eJzStw92eA/mYS2lv9qEeM4TP6RragL+K34
         mqTTKh+lMm7qxp1lXWr/b2dGUzikDYTkgAZKasW2FKAcV4JiUZ01y6tKxOmhMppY/Z2p
         u54e2dOUyiBxU0fg1WhZNsXZZjUkasR6EOPgbArQ8WbTpdFxjMiG0mtgaRTET9Yjgi82
         8m2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fwHOybM5kh7M76hGR48ziCvoLZNoVKPyP3zXf5iOrYY=;
        fh=XFTzAk/yrkaF54P9cLBXn5jvxar9h+ojUmI97rSKKb0=;
        b=HjXyY8sog3yKBtbaPEg8dI+jvcF5jb2Y5CS1O4NTSdoSeLmrsUEhdvD6+s8/Lxqg6k
         APZt2GH/0fgZ6ExE+8zwkgHEVZ/8DhM03P31RH1SvbdncdZvYm8bhAsl+aX5H3AF0wII
         vabGGXAiuIE2EqXkIBA86q54JdALwWYE/smcqQLL22wa3pEkaONQI/U4Jvar52ksrf3G
         Tr2PgIhCNLm0nq82NRaR0sfjS5dV8Lcqp7z6r18qWs4TMCbMdj7ONhfronbkCEAGYASm
         KFMlFCHTHuRiApUttrsvCRyNurTVmzT3xmProVCmyD3H0OmhVfEa0A1ibcILqvpCVow0
         B8tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784691334; x=1785296134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwHOybM5kh7M76hGR48ziCvoLZNoVKPyP3zXf5iOrYY=;
        b=QIkv1PXazdL0tcEScqFAbVsKqZhIuurWbZoixozFgj3YAy7oLvIWwd6VgazXxE+nbU
         DYIeFCGkJN6xQ69OciJZOT5oZgtoJ9jlqngF7COpIJd0nqoFqX4jtbkKP1vSfY3BLfxs
         yWMBhj/mGltnfykA9olAPKl8VxFbGVPORWLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691334; x=1785296134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwHOybM5kh7M76hGR48ziCvoLZNoVKPyP3zXf5iOrYY=;
        b=gK17vcjnb6MWCDH38xvCGyzQ2CyqEWeBE3WBtnPSaNqPFZnjxZMyRklDWbx55Hgi+J
         APusKp58WU34X6mz2el8R0iReaFEG1tU4TeyW4jz3If3BKkoh1AK3/gLplPYP9DddmZ6
         n2s0/JtKmpA4vzcRK3M1hYyyXCbJQOJ2x9byWIM27vxzDfJzK5ibT0nMekfUtAofkVhh
         3rzBGDOJjYpQCv/h6wP0LFTc0qSyTlIkIOv2mgFY+0mkuQU2m6dwxuiuQA0Snz/MN8P9
         8/cU+PAiVN5EAFvATz0rjxJPHK75Xkl2ZELjh2XzL3JLe54zwxQeMXnA66smUAUuysxc
         VmvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXtDkYr3pTN8pduPjIAIqrro5vyXWyEB+ERiada9y1IAEyZJAk6WFFm0oGD71xdMQ30QRESy3Pyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBW9tqG/m0J7UBitzZCAYZAzhWlWP6EUCP8i+oMwNZ1WKndJd
	93O9oCjB3Z7tlCNOE1PD4TNHkKHoTolp/3mWnKiYlam26EKNrJEDzZ9eqMDVO5dlNgYdqAJMaBa
	VVlVa1gVmGAtc2/kihtpL5z0qvi47b/zWhpPoCvVL
X-Gm-Gg: AR+sD11NIq+A/38iShQF9T4hUAKuN1wYH8/B8+38R1sRkpR9LEHxemkm0bITp4nn0QP
	TCZX0KZnJP+XYnTDPxZLq0g8snweGRbfPJCVizb1b20YQb5krF9lIZsUbA7nupzyMjFy8Dh/UvF
	WTRbVQRvC1vG6E6Rb6axoC8YOUoemdmuerw5xrx7kwG+5xHhMQyI37keKzB8hnB+kCS029E2gFA
	AyoMA122dGaetFuxTHcHZEqz3Pwqy1IN/+Y4Ehiq+LgscZDsMP3DDnpyjxoyicSIsuNXsFiG3a9
	pg1SKpHyskSGCao=
X-Received: by 2002:a05:690c:c4c5:b0:81e:f308:cfa3 with SMTP id
 00721157ae682-81f33bfed62mr7716127b3.14.1784691334267; Tue, 21 Jul 2026
 20:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com> <20260721105230.101906-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260721105230.101906-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 11:35:22 +0800
X-Gm-Features: AUfX_mwF5azxEMhr_2WNLIrQ4cJxk5YI9R_dQgFYT_P0qpGKSy3wJnLrxRQxP90
Message-ID: <CAGXv+5G-mVf3b7ygb8h4sTtYkACjc9B-VenTqOvbBQO9Pasgug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Make resets
 optional for MT8196
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, laura.nao@collabora.com, 
	fshao@chromium.org, jiapeng.chong@linux.alibaba.com, frank-w@public-files.de, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:52=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Both LVTS-AP and LVTS-MCU may be shared with SoC-internal MCUs
> running some sort of firmware that checks thermals in order to
> scale frequency, or to take action for critical SoC thermal
> protection - and this is seen on most MT8196 boards.

Yes the number of MCUs on this SoC is a bit crazy, and the OS
has almost no control over them. :D

> Make resets optional, as doing a HW reset on such boards will
> result in either an immediate thermal protect shutdown or in
> a rather important and usually permanent system slowdown.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  .../bindings/thermal/mediatek,lvts-thermal.yaml     | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.=
yaml
> index 975235130670..29f431fcdcd5 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
> @@ -94,12 +94,23 @@ allOf:
>          nvmem-cell-names:
>            minItems: 2
>
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - mediatek,mt8196-lvts-ap
> +                - mediatek,mt8196-lvts-mcu
> +    then:
> +      required:
> +        - resets
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
> -  - resets
>    - nvmem-cells
>    - nvmem-cell-names
>
> --
> 2.55.0
>
