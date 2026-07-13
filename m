Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32839DBFA
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930759; cv=none; b=cN+io9qJqMDowuq5v5cNP02zXB/ou6yJYstcuLnXVPwb2DiuxWxkOfAaIauwe86z36ORm+GLsRwT6jpD6UjT2Bufe+pma91m6Z9n7SwF7UMkuD1s4EwpVaMumTEAPIRdFPRL3sgGOiHQdaPmRN5kl9DOSIJz21G822/f0awY0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930759; c=relaxed/simple;
	bh=Psfrc3G7bXxsl7ECubdBiSlZDy7VaNL3f7/IvFNPlmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cs1XnLtvk9Qb165+zZm+nG+U6OnWYBsXw4wo/971UGgaepxYk5xeXkdu3B5XKKqu+x8z8plqoiY5RIblT68I3ON6N4shH+wX+PvvhQ0Zo8yyhHORBfKaOc2ROpFjXVAhacB9OVOTazwBY5iY/lRWcRYjAuZXAao2B4NQqzx0Exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-737de525d2eso3006722137.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 01:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930757; x=1784535557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cK7IMBHRP2FdUnWCkfnYLPOObmzv4mtZRa495nyVkt0=;
        b=WFRnNHZPraOEpJgw88EndFyIrIBPmeUQfY6kyn7iD1KhD5udkJbvhLUutFfyuXQ2iU
         qtKbeaquaqgrkKHs0STmTQ346AODxFH+aT2BrhxtDjDJyYAjI9GOhroBZsLegWITiZCh
         LJJtmh+677wNlgHhBMGzn29XV0qWlZRxxkVQ11e1Gu7z4lG/a+HtDHoVmkI28xhb5x4x
         emjhgLws75d7luhmC/OOyhzqRpUcWkACjW8Z4JCjbW8A4FMvSejwSUXvvlWKE7OgrcJI
         oQVVP2dkUn/MSonpuP+DojlGgf7rjhRp3FLMllIhf7jDFsf9b43Kwu3RzDyYMEuBtMEB
         5Rbg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/hyZ7Imn666IJtsRGWPahIGFEeiylcCT+7js8qIYP9NXnbitlP6dk6hMGclosT3DltkgnlbnbSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY4CzcGM1xjcRNSFmeQys687W6oRoZGiI+s9F4P3rYpUz4m8L
	dELi5B/1SJ2coJgdtMlj197b0QPOJzK0V4qW+pBj8BQoCOyFA7Z+WdN6FmBIFHUq
X-Gm-Gg: AfdE7clS6dnCg8Riig5ppEnNcLEkZAs1CEBT9DAWha0ZDJTZfQhe1/Cr2kpv57/Gf9x
	cVJnL1gnTSLofVsFa4f4hda1efcSnv02cZ+fjE1R0S8J1vieUppJGem2kNoLFjiP5xKgg+BM4Vr
	bj0hdZVrRs9Anb1A5SI87w+e00oo791hxXtAtENjgwAAQIUsoF24YRyuaET97FvYdBr/oBViQTf
	EywkbZatj2APaen9XFpXvBNyfnNU2mZvxPXVcQuA0Evly1l+tjs2Boa/Z2Qkovo75Rj1opse5pD
	Oiq9xzJHWiQYDU6pO+GBFeCWareslh7QutaS6v5PpGwf2V9GqG2nm6aJngiCaNkpMvP1aFWjTrI
	PqTB/YBUfA1W0+uhSi1FOO6lOQcRRE6CLKj6hcn3wxdKlK7MWIWO/swMGocaR1Crl/PrRq4i1XU
	p/Z98MvWrg8NAYk1WlwnDzlEfVVv+d9eovlQfBqS6oaziKEWTORw==
X-Received: by 2002:a05:6102:f83:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-74533d7c9f8mr5298203137.17.1783930757391;
        Mon, 13 Jul 2026 01:19:17 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed5d4cb01sm7052575241.10.2026.07.13.01.19.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:19:15 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-725cf9a923aso2241989137.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 01:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpuDfSCvVvGWxzyfrT724DA40lIEwunGoVTf66Okbt5QtZt05v2HYseDdyzHjbMAngfy299x7d4xQ==@vger.kernel.org
X-Received: by 2002:a05:6102:f83:b0:6f0:3c5b:ce7a with SMTP id
 ada2fe7eead31-74533d7c9f8mr5298165137.17.1783930755575; Mon, 13 Jul 2026
 01:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <50f5804f00c55cd60604d00da1bf1f1dc912ba8d.1783505142.git.geert+renesas@glider.be>
 <alQTnZwVRwpVTVUf@monoceros>
In-Reply-To: <alQTnZwVRwpVTVUf@monoceros>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 10:19:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMS0ymenXwSasZ7f5aTcK30kTxq8U2W3Dhj43y1UAcTQ@mail.gmail.com>
X-Gm-Features: AUfX_mzM4sxy25iOR9jBU-xAME53IzNcexx6a8MgetXZ4RYeb2wzLaySAOrHbao
Message-ID: <CAMuHMdWMS0ymenXwSasZ7f5aTcK30kTxq8U2W3Dhj43y1UAcTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: renesas: Add R-Car X5H CPG driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, 13 Jul 2026 at 00:22, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Wed, Jul 08, 2026 at 12:15:08PM +0200, Geert Uytterhoeven wrote:
> > +#include <linux/mod_devicetable.h>
>
> Please don't add new users for this header file. Only use those
> <linux/device-id/*.h> that you actually need (if any).
>
> Ditto for patch 4.

Thanks, will do after the rebase to v7.2-rc3 ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
