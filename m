Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221F4C4F41
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331524; cv=none; b=tR+y0hhj3550aPRkTtd6zujyeY/i3o2L1tItSOBKUoyhRklOKXx9h+KvcsUoVtDYRG4Oj6dkF8qx1nDFgA+CaRYSonKaEvgbiGkhYwXulA3yC01bjRLVUW6DIxLjY+KoZAlF+T78/QPE6NLNKQhwo6BpBXL+7NyyEkjmonQ6dCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331524; c=relaxed/simple;
	bh=rCFulCS196Fw/DBDyF9OMjFHIxiu7hy/WMzgUHoLoLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhbVjv5NplMN1izrxe3fUvtkewKYo/mQAFKuUaCxdvApbnJAsYut30RYslYn+2KNBz2yKSPtPBeuW7RMZjNojhZ5aqQ7QUgM4c9oRKo3UmuTcXOSKb5i+XqWshbwyhGyIoOsQNKU2+JGXnwjkIBYt7TeoD0xTKH4lXsYNHgBkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5d4d307fab6so652525e0c.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331520; x=1792936320;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fhGyumamsbJwvfAtfGydBWyfBrT9VHxtfq0yzwmUVgA=;
        b=NxEFBtHSQHbOsxWpQyIco4zem/bLUvJ/B48kuv6nlpO5zRXftVeMslasWM2VZS0scR
         qgrtfMp9BFnrmbcPmu0rmDQtSCCTfmafQ8TE2nVRt2jfDVzdSHeEPRK8kunpB9WEBquy
         ZbDoNcr17JaceLC4/RcERS5CXPQGHUhwEqljgZ1vZuGwPUQPF7QpFbNVFIIq2zFZhoq1
         JXUqldvywVCVs2NbTd7eUBSE4jFXFJRgavbY10I25qeHWr96bAXLtOatqOq6lgF3hNO6
         exq5U9jnCSmH9X3TVZrNiQj9ed+OmDj/kukrLqLwv9WscJBN1REXG4z9cBrTVUrwHkrh
         3IbA==
X-Forwarded-Encrypted: i=1; AKwUvBwiI4kmjIARMHEjr8HNxpl79IF5uhDi+3HvfBfSQyYJ1LIlk871JIbn43DiueR6PIV+txFxM7mI3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrVDiWgrHv6yvtbtuJfkLfw8TH14yPF0p6ZQhHTdaP1tpNZWzq
	jPvGjVGZbu7LCD1eFJYM8XjN+isULOwr3UgmJGUmNjSXBnREgTCOvWix3UQQY9xC
X-Gm-Gg: AYBFou2LhzpxKBqfWw8iJTg88/M0IONWMekSnBx2OwAR9kHIWqSYfvpWKQAsOo1+YMi
	ts7lqCK6iIcXmGdkfCAXqx2jtbBuOi9T6pQfyXjfWA8nKeIrq/c9ga7roApfptuDdISSeaqiyR2
	vD41tX5BLfK8dP8d//nIVRMEBJ/NaXIaYHYhNAAlVQxQdUyJjUiqZZ5UG+YM2MPJ6+8Yek1IFts
	/27E7XU0EmWRguHEFnoXuFiIPYFH5Jaq/khh5M4UsCl/pOlDZIJAtQGlXxWLuEQfIcr8av9BuK2
	T9xG1ksfJdZiMFHHnaH25OHNxIsvzEjKMOgukaSZfb0jHwVt0hMRG9PmmziK9lzaMZFyEkIqmMl
	kO/CuqZqEll+8yBeJ60njgxpLcRMbKZ/+9k1uy/+hxaQanZqSSPttwo7k1bvxJchpqlxYAcWsOF
	DEky3Epzb6aVspHssGiAPI8A6Epws3bigFPCwYX7hlIgAHSKqnaWtZTf3ZEHfrUbUXHuuzR1ala
	Ceo2NYmJXoDcWXfOIeeGdafMyzzqUrQpMKr
X-Received: by 2002:a05:6122:32c6:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5eabfbaf8efmr479914e0c.1.1792331519929;
        Sun, 18 Oct 2026 06:51:59 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b518bc8sm7057374e0c.11.2026.10.18.06.51.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 06:51:58 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so172290137.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 06:51:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwKik6gtfIKV4JPwLC6rsxHDXJURxoUU/fr8zaRcSi4n39WPVZxQQRFsPg8uJTS4pp3hKK+Wcx15A==@vger.kernel.org
X-Received: by 2002:a05:6102:5249:b0:7cc:2a3c:9a33 with SMTP id
 ada2fe7eead31-7cc36b49079mr1291606137.34.1792331517781; Sun, 18 Oct 2026
 06:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
 <51d8ba05-76e5-45ab-91da-3c6cb02505d7@mailbox.org>
In-Reply-To: <51d8ba05-76e5-45ab-91da-3c6cb02505d7@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Oct 2026 15:51:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzX8fd4NDQi8ow0m+48g8p-LBHMysFi+fOqp1oDtT8LQ@mail.gmail.com>
X-Gm-Features: AclHuK8HjL2MgNJEhgQ8UPYzZV_qfVLea-QA-Rw_khapKdsDEf1HaCakMPT5y5o
Message-ID: <CAMuHMdVzX8fd4NDQi8ow0m+48g8p-LBHMysFi+fOqp1oDtT8LQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sat, 17 Oct 2026 at 19:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 10/16/26 5:55 PM, Geert Uytterhoeven wrote:
>
> [...]
>
> >   static int r8a78000_cpg_probe(struct platform_device *pdev)
> >   {
> >       struct device *dev = &pdev->dev;
> >       struct r8a78000_cpg_priv *priv;
> > -     const struct clk_map *map;
> > -     int ret;
> > +     const struct clk_map_in *map;
>
> Super-nitpick, use reverse xmas tree ordering here if there will be V5.

I believe that's already the case. What am I missing?

>
> >       map = of_device_get_match_data(dev);
> >       if (!map)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
