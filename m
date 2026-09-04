Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79784CC288
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534075; cv=none; b=i/QYtDbY+Ho6raWewfYpeJKZlwvMxVPxnww0BZWMfqfgVlL1SEvE5CID8VrMGaPmRSXer/DmW2boBMWbaa7dCg1DRb3ZTfZyKyXrlCDFL/pl669GqpXt1JR1lb1F449Rau7pPCd7M9/de+ddYWVjdPkUFmwDCbHrNirYmEnRS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534075; c=relaxed/simple;
	bh=90rHthjt/yGjs8ruJ73s4ajxZDBI6dnx8TaoyliYuBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ5iUAPsck/xVBBhsif8uZaUgJRmPTHZQNwVKqyyuumQHUc/Zw9N+KypDrT6bFGPgQ5woBV+SUbC4mO9/vcMc5xsPae2VBe47mlciC83mdZgr8PqNdtlJ8SQvVL8BjVz/C0mV0u+9QaPIYuMG91iXfeKN26ncsNNRg7P5B67M+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-784a1696a21so817409137.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534069; x=1789138869;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hlQwu8m1wQp2ta11biuk/tG/NCV6kSdttoO7IfG7LVw=;
        b=RLTJ4lXb7APcaStAMNoD7O9gjVIFMnWsbRTYuLMhorIa0tFOC/gaQMHgwEgQyzghmr
         eHJ8kVfziH4hXaDSbOQW/aSI3QSnZxadjNrSNYzHKMBTjmBaZSuY80UDCFOblpT0oiT8
         ncYFwiU6IuduVP8KoWb+s4FOL5xv4SbNc9FlQeGP9eRVMhanRvBAdOKBFCW4hdRv/zmq
         DyayClcMigCqLqbeyLmb712MRH2xqP+/Gge6sLRFihscMtpUM+A4zVbtIp5AUo6Txw6S
         TatOKsdX0eyyA+2ElHiZcd4DAaatKfxV62k/VBMyoWhMCOe8jALbdS8g0ga06ELE/k8N
         hZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8lPQ3j/QMmBlMZzZVxfpUpGm+UEIIkoWkYUjNOjaLAse4b9ScvYRwbsUPjVFd9C6gBnKR61/0LQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n1OQC7DIGCZghDNbr4VU7ToMJpqxxNJHxmSkghjfkdBAvJwKZO
	uVBjnusGsGwry8FXVFDSFd+NK/YK/2iZibHGfRBrRNHoz6EhG2Cb1a+3me4AAXQC
X-Gm-Gg: AYBFou1DFolAJ1XFQrJlfZ30ezE+BG9Dea7/8pYSSjftjZolI1h7JC453oeeIPhFiqt
	7MumtezR7ZEntzlOpjrJ4UPH8gvWiVtEPASltcgYwq4q+hUwO8gwvoMguXr8/FrZIBztjVg/uN5
	mhAwi5mgdkjTSZGKK5tSGk5dUL4jUYXXvSkIx6bGEvJDr47BIbh99IwuiJh56Sk7nitR2jOgJYA
	mXFR9rK1c0VTYnkLB9UtWiaO3E0R+CBUhzqrs+1xDfDFR8ybSggjbfAhFLoN4jCurXtU1fokWS1
	9Yssrze1luiUOz0fdVo8fzS71nh6ThADj25YJUdeRmeoNscBae3kmH2N6lb4ErvQykqQysOt2ZC
	pv3FP4bJFAfk+yia6xFzgPa/sU5lpz5MjX4kDqpFrZowfm/Y88i5ZG9h7HgcBqXWuFM1JETGqI6
	mmqf4opFVTsl3abHcr6bBL9W68Pmq3HmkysGL6QiqfvJZfRSX+nAGXr40OVtHzTDmMOyD+llw+e
	cWzypBbh4iW5bQovHr1H2dhJw==
X-Received: by 2002:a05:6102:50a1:b0:785:8f76:654d with SMTP id ada2fe7eead31-78a4aafe94dmr2259241137.13.1788534069178;
        Fri, 04 Sep 2026 08:01:09 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808edd3d81sm1724223241.7.2026.09.04.08.01.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:01:08 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97e9c0da212so732600241.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:01:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxlExxtw8WA1H0pF9oUXs+c1KwjqpcqixNufk+YxHrOdtl5punJID18jN8u6X5sBFnkgJreaXqLdQ==@vger.kernel.org
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id
 ada2fe7eead31-78a4a8b86c6mr2573960137.6.1788534062781; Fri, 04 Sep 2026
 08:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-2-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-2-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:00:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuyEXPJpCaE+MGwWN1qJVyzePA5--wsRTZRtFP8woCZw@mail.gmail.com>
X-Gm-Features: AcwNN1We_3fExHm_K1_nUZIVYeTkuFzPE8r5pnBYIyrcPLEEf_cM8LoiXO9Ji0A
Message-ID: <CAMuHMdVuyEXPJpCaE+MGwWN1qJVyzePA5--wsRTZRtFP8woCZw@mail.gmail.com>
Subject: Re: [PATCH 01/10] soc: renesas: Identify RZ/G2M v3.0 SoC
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 17:05, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> Add support to identify the Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC.
> The RZ/G2M v3.0 is assigned the same Product ID Number in the Product
> Register as the Renesas RZ/G2M v1.3 (a.k.a. R8A774A1), so use the same
> SoC data.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
