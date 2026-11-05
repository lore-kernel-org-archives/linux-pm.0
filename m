Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881661;
	b=hg6GbVDU3aFuwL1s4XQwei4iovp06OpZUpm6xKQuj8IeKRo+UaVytyMMi22dT2wmAvdi
	 V+P2scsaigEhseq1BsSxPDXh7KyIarRxck5C1m+Smp1x+XqnqZ5hcdiseHQMp269e9+t7
	 N5ZMbtxAZCZRmxADZWUZQnLTRFycs1IAARvhhee6eQLhzf1B9abhVKGQG2SJaTfi6qxxy
	 rPY8jMlxGReWM5ErUJWgfH1ZAOo1xGX1HgtFDNwpCVBK96iIT0YpE7LO2HuPHHWWNsZpD
	 U0KuEN+bqmZvnuZKBfefGWu8fKfn2WsIqyumxd9UcjV4zEB/aZAzmG7JYVE1itiMxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881661;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=4vVgWHCMlgALmSTFM5ERHxxacpufBo9envxHP7cnbIM=;
	b=JrSsx47ceK22a1Ing1IhZvYlxDlMueh8yUY7OfHcEiiLP0M89oLDxP42RB762cAtoLWL
	 RJ8h6VTMzC7JWfNcFF512xXGl6OMinFazywJTIykwkHnaihWXXuYyRjxWqxWYAM5qSLKh
	 5Ew6r2gFZJgNU7I66+Ps9VdH+V/KsELZ6a7y6p5QT84D95N3yH4O+3h9uaJ42F3ebGV3m
	 fkRFoknuKvu79/hpPA8vGV+KDgaOhstFpPcQHIC9DKLtXOO+slu7prA7IaCj4RcVsunJ8
	 LabOQ1k3htAkD5WGtRROa8xJyP2UOu8prpyYiUPxuLB15HFHsf/ERdmNJrhYij8Unuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57280606A31B
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57280606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c414e5d282eso238794466b.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 04:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881660; x=1794486460;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4vVgWHCMlgALmSTFM5ERHxxacpufBo9envxHP7cnbIM=;
        b=jW7YEWXjX2WNjyB36UM+lX8PgsA9nHCNnXVUf78AstZdXwBe9p0DggCOugrtXtPcnI
         8dNtqcWtEsGYHU670rsSyjLf5JH4Sh2rbc9IhHYhiXSEme+pJ2Vka3K1wI4xjlXxOY9p
         qVSReMggQeJOxfS7VxBg07agl5wqpF6Va6dIbw0xQ+Mn5zMvrW2d9Fd0HiHmac7YIfAJ
         2GrMxSox9kcDubmOqrbRBUFqOC0QR6rIbp6wd9DK6b7F0Tb2nxbt5hOnHBzubrOh+xql
         K9wDRTAvAeagtCW/DgNmh6cpN9ixX9T7f5qafhUshCF1uzit9zWnnn1VKxl70JIfeRZL
         EHlw==
X-Forwarded-Encrypted: i=1; AKwUvBydHt/zod6Uf3DaPnkulZG3J0ykJshBILe8se9dVsHr5n3R09V//czAiDvvKTwEs0PEH7oxRE0yZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+JLgv8KvBKdpb0cIMSyp4+gn2211tvWqJBLDytBCA0jqI8Z3KK
	kadrcYOPuXQTt+foZOcAS+JQaHQyoQK+0XAfJUEfdtJcRoSeHrME4MUG2kAhEDLRiHI=
X-Gm-Gg: AYBFou0XATsCoYbi5KOFmV/1ELczZ7CsOI7G6lrD8GFewjibROcx0VXU08rZuHeJrY6
	y0uiGaRr2HYnPySlMwwQo4EoAGqebBSLMqSwZXdgCu8+ffO2z/E+sOwaWHGn1Wr7uB0NwdaF16o
	A3qz9QURp1gPKBYGWUA0lZcrSVO03fJqF2+so/cUu8RwRaxdqkwNSqgKI5qxG0RtD7VYMOuKbHM
	rBK0LQmcXrcVn8PyTxT6CEyQc2N1hNRGT/WJL7exGJGOHrXDCvo5y7tufUV2kip40Urn24mnbuD
	5mWR7+cXe5cDeHiTl74Tx8YBjKqbx8wkacwXGO1K2uf28o8eTyBUzAEKirg+oCE9PPLt6ltM0yb
	rUo9gjIrh5KS0Du0ZqNCX3WwMH+XGguudAIXbUsBxa44xJGdZyMQo4NoEHoFNphhmkn+L6QH1m3
	j2L2ABr+mqXRD3SqQkMvdJxReurYioJ2DTPV+v1lljXG2FOsKPILgPkBuOrpK07dnLjFGqPzc3U
	+yMZ3iDMjksG6ht8MGSFBIB5bD/kUxDxkzUUMh4Fahhk+yg9ug3RQ+PZ70BnNBm5OLjR8vMPpmg
	lsZy5U/LVCW/xjyaq5MK7Ow3IYGjnX57Bj6P6rDj8dfxf7btKYt9zfv5bydV6hUYwQ==
X-Received: by 2002:a17:907:3d89:b0:c40:cee7:3918 with SMTP id a640c23a62f3a-c4ca7b62b2cmr1667179966b.44.1793881659505;
        Thu, 05 Nov 2026 04:27:39 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0ddcfa78sm170566066b.0.2026.11.05.04.27.38
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 04:27:38 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c411e139259so201273966b.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 04:27:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwDugusYDpeR/QMUmx67A1yjJcv18dSYb+fTjRiMgeTvm4ysWRHVCmujesi4NNyLgIkbaruUPL6Bw==@vger.kernel.org
X-Received: by 2002:a17:906:9f8a:b0:c3e:4f41:e2a6 with SMTP id
 a640c23a62f3a-c4ca7974a58mr1657151566b.6.1793881658157; Thu, 05 Nov 2026
 04:27:38 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-4-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-4-e052903a3832@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 13:27:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQcuuFVXXUr3qicyCJ5rrEnQdEi84Ap9BoiqimkQZVGg@mail.gmail.com>
X-Gm-Features: AclHuK8JVAxETrQV8bIOMHgsi5BiZkf3auB3ZpOshOg3R6mALyoUxmC5FD6b14U
Message-ID: <CAMuHMdUQcuuFVXXUr3qicyCJ5rrEnQdEi84Ap9BoiqimkQZVGg@mail.gmail.com>
Subject: Re: [PATCH DNI v3 04/15] arm64: renesas: r8a78000: Add FCPV[BI] nodes
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Thu, 15 Oct 2026 at 09:52, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!


> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1000,6 +1000,78 @@ mdlc_aon: system-controller@c1338000 {
>                         bootph-all;
>                 };
>
> +               fcpvi0: fcp@c5030000 {

Please preserve sort order:
  1. Sort by unit address,
  2. Keep similar nodes together.

[...]

>                 mdlc_cmnn: system-controller@ca410000 {
>                         compatible = "renesas,r8a78000-mdlc";
>                         reg = <0 0xca410000 0 0x1000>;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
