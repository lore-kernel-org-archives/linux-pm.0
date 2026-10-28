Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198637;
	b=b0ZKxq8rfDzPylT2XgCZsOvDlsrLL+CBTv65jpW3E42XZWO6bH002UAhiSMpWqzSkmKC
	 ZCN9A5AbY22at1cIuulf9mXYx8Q/DVSuFczGSUtc0OqQLhfBPxQC9MqyVxxCN1VvbEdC3
	 l4L0rKB1K+wWfZKzJ4YKG8SnoLBqKLKdD50zq6nVlyu+AXwdPEpcdxwDJfIRIl1MNR4fU
	 6J3t11BKFJGR4c0pPFoFPntTgszspzPZgs0s+OeM0+G7qnD0gJRcSzboMTXGxpu53hahY
	 vzpSIZuQkZO1wmaGYFyO02aULtHP46i2G5JlW5fWZF5wuyEMdJg+kdBeM7wGpeJpntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198637;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gvbpjObWezyuObEIw7vWCioNUAtttLKw08sbbnbJ9pw=;
	b=Oj/CJBK8YDxF69IR7X482rgHOVgSHTfBSXA7MrNcQWjlxM15wM0anFG5tmNqEJpDMF35
	 Kl8PEOQrimGyqTCUP5paY+sb6Qk94ynifXo3il4zgCg8ISTD4nCRef0ILp/6an/6S45id
	 k8Ektp/wSh3KkO6a9TCui3CZKva9Yi7eU2kvCRmB6Ms+v7gPIE4im6AydAwirLd38FPFC
	 yqsbsu1VMQoQoREspevf0IjKzZgtL7szFyodGmcQcobgqTF0qMlF3Zg3wVhu9HLxDTM00
	 uqYhxfqyhn5UWmUWxDfSBLB+FZ2sT3JJ9cz/+hr7Uf3mAMSNaTU+3KBBkgBD0qBmY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8D606A31E
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 14:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD8D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eafa528803so393062e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 07:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198636; x=1793803436;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gvbpjObWezyuObEIw7vWCioNUAtttLKw08sbbnbJ9pw=;
        b=uxmluhvT8sFqmuKe/AFXK87rx4lEBTVOQldu1rReXUl2QsUdufjisZBF2JB2tD0eJP
         UGj8pucvVlcdP2dllXXbGMS+3t1m5GUa4ox5MbAxWqPTM8UsqhbcU598do2Fpk3YlQ0z
         TJ83SEYTYcditCR+MDPBHFB/+RRd/Ti1+i0TUQuiBlS/i4SF2848IugdgYavnieOR9n2
         1YA5rG/v2VlYJRV0q3J1pnqst/Lf8DtDF3xJG/wtxBXqi0cD2/2zEgwxJ3SR/+rqNirs
         sG7T4aNVL0Y2QmYMMeRvtPiO/8mw2lIlbkf8YLADbk9fcWXHAV8676v/kHjTxbNfN8f7
         9C/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzUr/+nZgZCqn2/eYpQnY8OL6VtOYI33tZ156SUQmzOFiv3gpR3Fohy3zOpWmiEiqfFZFxzSbiwsA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJbtuNN+a/g544IFT8mF0sGgrMJfivWlOFoAX39Nbm+oi8pZc7
	q3y73o+fu1ZetpQ0hOBaCV7XdCrWozGxzyhrzfk8i4As1/P/uJuBn6F9WS4pqqM0
X-Gm-Gg: AYBFou1bdC/2T+YUDzBARWyQkIvlQw1Wfc4tRIb7I2F5Gh+dPzHD3706YjmzPDBOzXy
	x6tjt7fxqGPGB10mnGLU8GWFdorAfQ/gbb2+KNeBSbC56y7CZmo902YaCJhoozsxojSz5PY+3Z2
	CJHnvoeKbQhNn3vICyFNeTlkaZWKLsXsfdDNxfjtIei6l9y0lMPMPZ2AXrn+77cNVX8EgxErc65
	LBoP1mxUCxxpm3OlJfMCUoI3NzMOuCLN76+pBNIfyTYnLfKOfjskH4Dy6RbLobch0KWAERo2L9V
	ukQZuFRBesJ4TXxbeFFAiFuCwiLHSREFyGPCp77rcIkjin2F6eZUymfdu+fEo4+lcwcNb0Vx1k7
	jcqVDH9hC6RqFXCdI8SA+ODSaJliZOYqWkaCK8W1+NNsaLN5awBlMUWBGUfY/spKjMZpSm5jHvg
	+CzDels83g9qiynbVHQd0/O3mP8W6BEVeNyZKsqyZCbY2mm+Il0MzXN3Adnh/LJdgN9k3FI9QGY
	OCCfSmaYqBCr25JogGcprr/q1cfHQ//OLdQyvsJZ7d1M8f7jEpLrjLLHu874LtNsrvekOgsrvCt
	jktcPvuSy4k95tPGgtUkyCHucGdOWN9/0Y7AvX5vlavBPSEXkmKWSQABzuSmYenU71U=
X-Received: by 2002:a05:6122:e26f:b0:5ea:d1c4:7cbe with SMTP id 71dfb90a1353d-5ec4ccf6e8emr1336195e0c.23.1793198635962;
        Wed, 28 Oct 2026 07:43:55 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f6ffce4sm1953951e0c.1.2026.10.28.07.43.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:43:54 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c03744ef27so315579137.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 07:43:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwiVJ634LviCTeQBzKUre0cKpN8YETpUg9KX6ftlOsZHEmcC/IexbGBwRGW69TeBD+Uiif5sBCDjQ==@vger.kernel.org
X-Received: by 2002:a05:6102:6f07:b0:7c3:1d7:f234 with SMTP id
 ada2fe7eead31-7d03a294a6dmr903761137.2.1793198633657; Wed, 28 Oct 2026
 07:43:53 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793026273.git.geert+renesas@glider.be> <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com>
In-Reply-To: <20261028132937.GL15441@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Oct 2026 15:43:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
X-Gm-Features: AclHuK8gWV6NxtQKAEUrEm-e_rgKbr7fNh5k6QXPge3G8NVSao5SAOErcvAPoSI
Message-ID: <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > @@ -28,5 +28,8 @@
> >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
>
> Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> R8A78000_CPG_SGD16_PERW_BUS, as well as
> R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.

I could add them, but do you have any need to refer to them from DT?
So far I only added clocks that are listed as clock supplies of on-SoC
modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
Timer Unit (TMU)).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
