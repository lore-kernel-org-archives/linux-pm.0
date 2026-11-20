Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161417;
	b=l7b9XexW/iBDR25HtXFgFOriStiYZZDlduzU8Exx41gFWYmpgdiUUUw4WzU4xQhdV8iB
	 hqMgfW4PHG6cA6BzF7MynpEwaK8A1AOR635Zv+Z3TntTECuCqGn8CUbGtmID0mboJcq38
	 3/27L5sA2m1TNB5YizgC9tZ3llbd/6Gch976NbbrtaXN4ofxtmbCf6wWkz+/MGv5YjHL1
	 con1n6Mw7a6q+gp5+EYKZ7WnC1/K0hxmi5MUnUFlsFFgEVmBQsr+vj1gNZJCIBmL+iVpi
	 q1obTnQsi3XPRaXCKYv5s+3vku0+6oWAxZ0Uu1dbu/XkDj90btv4Tb+Egh+Tda6FP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161417;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=VaLwNIkn55D7JevqcpHCVmOWA4zFnE98rOcR5xGlqds=;
	b=WNADFFPcUPAvQ3cwXDSjJNFzsnYCyJjpytzq0BNWUXiyH4eQzBV+4T/3JItxUjKTNdmj
	 grza2MsmTQxhEd5eMj+mOgd70klhgdKrf4bc7AzEqRIfbqaBWEnagjpDIC3iX+CsnMJ/H
	 Ma1hol04WcQqgpOgM2z8oHcbu6guE7znSA5LzsDL/M8nidgdYgat8RERjTekaoimYeKtE
	 vSikn/djEEYZ+ZpnFMlM3WZW34kNfLiZnYFqlk8LrdFaGpWW4i9AD3TshIG5uhCcZ2/vG
	 YiqfF0cC5Gn+Mv/cE3J+znrizRTkMK7RChf1s9lS43O5T9B/zuTXTKtLvTJALhin6hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB1606A320
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CB1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ec6f271883so385468e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161416; x=1795766216;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VaLwNIkn55D7JevqcpHCVmOWA4zFnE98rOcR5xGlqds=;
        b=p9R2BkCczUvDRYhImIlxOdWzqkOQSySCQnlH13WgC6pV9RdSYczi0/pbyxO2uR/BuM
         uNQGBm2fDoVTV1dBQg9PsR8QaecIB8W138y3idpdqCvfEWLkrl79nf9O9Q6fBuasBb4F
         q/03D7fqZuy9vR/pYSSi8elQ1YM5+B0+S8tT5y/8uE3J7eAIyGjRnLO6o1HRuV3X6Pag
         54nrouaO8ej8mZnW+3qSjjTrAe4qLOYNwAp+ggJs3Yw5DoroPHx6j9/GxIAGrsy85Hck
         zB53D8+WBa8gbwpGlTBoFCUJhBoQbvSmDX0lLhnj7N+JBIfk3ncWLjlOKWEhhRT9paGQ
         lLMQ==
X-Forwarded-Encrypted: i=1; AL+hErE3wIDCd9sWDR4N73tD7yvdnl9uZauNt8nPMVv88qYaJhx7XsNfz+VX8itwwrDaml/Q9qwSLvLLRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9HF3wOWLfnaWM9Ai4CUTh3Zrejr0Dq3imQVhNAITGtFyMPEyRu
	IosaTd2eEAv8s7BQBeugNt5PvvR6O5+hdEGHDdInDWKpGDdZ+kW1fYFkEsHK/B84
X-Gm-Gg: AZFdTZdr/TbpLIqBEKTmhAgBgZDFxIQOyWsXnzf3M1SrnDH4G0jzrbWMwqDdxJwYyme
	RpY9SXPiL3X2CoixrS2D8bkKqy+R/ingMbIlJjwyMRXO1jSg/Y9sKaliaf0mOA0kFv92TioLuLI
	xgvIuPp291l3sEVmGiCFWfBo0zFDVuTAQBx3LgFlt0Oqdf+QZdixKirm3LC7TGzc91wI36v+E09
	mCCfuyrJ9wwQEtbAdo2vRTLGNev3qSyMtHBslc9h/R3HMmvSxzQg5DFLXFL/W8tnxl5EpFpck2s
	ms+GTI/meNl/IbwIUx4L1N88qyk8VGxPbrHBRqNu+VCVOmpoSqLDGokJEYBNw7AEA74aMMSPbaD
	/q6wif/CHkmRu/pg6GQmATdXAhCUyh9UM39d36DLgF1PtJPxAf0qHFSiq0PPOp9NRCl7NiLhZQX
	uj61t6/bHptvs099CgQPvqM0aoBxqR8LpC+6jvmN+MMnz0+71T3vrVz9HoNnMxY/rmESgT51VqW
	B8Dtku3sj7lwlw/lC0mptGu01lsLJ2uC0bWuSLXO06mrEeITypDWbuPrHjoc+5C8IoCGEjd195a
	00q/hNiEtHpFKIWSq2ztn+ZaTDJeqSoS41UM7Lf99wcRQqDvCCupTsePRRLlsxB9FFU=
X-Received: by 2002:a05:6122:1d4a:b0:5e8:c908:d60a with SMTP id 71dfb90a1353d-5ee8aeca3f4mr1219556e0c.9.1795161416368;
        Thu, 19 Nov 2026 23:56:56 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b6641d6sm1852343e0c.17.2026.11.19.23.56.55
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 23:56:55 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so424805241.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:56:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH76Zy2UJCghw5LNz67GypPqu8SjcTUoCiIOA1u+hq2O22Ry+dZch09y/QEVcoYtBw9pk/HNNIW3g==@vger.kernel.org
X-Received: by 2002:a05:6102:448b:b0:7cc:26a8:e726 with SMTP id
 ada2fe7eead31-7d739567d98mr1003780137.26.1795161415051; Thu, 19 Nov 2026
 23:56:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <cee843b319c9eceba2339f14a134e305a2b05d7e.1795029012.git.geert+renesas@glider.be>
 <57d2cc58-15ac-434e-ab40-7a8a54d93a1f@mailbox.org>
In-Reply-To: <57d2cc58-15ac-434e-ab40-7a8a54d93a1f@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:56:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXS4ZTxLBrZoNycHUzdUp9QsisfA7CcBPyAGw7zTuSoA@mail.gmail.com>
X-Gm-Features: Aa3M54pzvZjiNE5ltwUGvGnHop8D2bVYiqyWJcr5J_J0ppW6-NxZAErFEYs73QQ
Message-ID: <CAMuHMdXXS4ZTxLBrZoNycHUzdUp9QsisfA7CcBPyAGw7zTuSoA@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] clk: renesas: r8a78000: Merge debug prints in r8a78000_clk_get()
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
	Paul Elder <paul.elder+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Fri, 20 Nov 2026 at 06:28, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> > The two debug prints in r8a78000_clk_get() are very similar.
> > Merge them into a single debug print.
> >
> > While at it, unwrap the (wrongly-indented) continuation of the
> > r8a78000_clk_get() function header, as it fits on a single line.
>
> It might be worth mentioning, that this now also uses
> clk_hw_get_name(hw) instead of map->fw_id .

clk_hw_get_name(hw) was printed before; fw_id will still be printed
in get_hws() after PATCH 04/15.

>
> [...]
>
> > -     dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
> > -
> >       hw = priv->fixed_hws[map->fw_id];
> >
> > -     dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
> > -             clk_hw_get_rate(hw));
> > +     dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
> > +             clk_hw_get_name(hw), clk_hw_get_rate(hw));
> [...]


Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
