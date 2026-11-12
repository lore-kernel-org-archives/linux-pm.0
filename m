Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494808;
	b=TIsOoE6E0ZKumrBxnksdllhZsTJ9xbvNwPKFvUBhBcgyt1xNifh/s5IBurXiUBBK3tl2
	 pXW6n4TXNvmFAN8febYS7UCdOFNxLaIvFeR0u0oWNWk9oEZ3mB7Vk60Tt1e/bQNuc4Ukq
	 uSRcwO0gvtIErcduj9R1si2kNeA8GN94NOv+xTapwqBUifc76mLtLvzPO8hHPyOtffils
	 GqbFRCd1JkMpFFRVkd6LUISoH2MC4woFi489yNh3B0j9mq533G6YQ/7gIAZ0PpGD8OFaE
	 KRItvdL0BgXq5nx0jPTXxUjMYRqZ/Yv4HSAchtbXxqonUa5X0lu6NaTL3g+skUIuCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494808;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=DeS1JutKTfuhS5q6pNbvmoX+jSrEwDPcQETf0SHwj/c=;
	b=CtO4z49fKG5wpO0b0MIS/jkP3PABVS18hNavAohzWuCo1mk+uF3Agb/dEeSxMHqPuF2e
	 DuL6H7gxBfAQFzOUad2MOSSwq1J6j7jHCXAkY5k1htPSO2+TgnvEZOOKa0GGUFeyk1eba
	 CFjtcx/WErwolv1va1cgAuQ9zs9suCzlKZn5kBrDVqYGjV4fX4fDyzbzGXgP78qq/q2VD
	 SSGBNdvS7hEii0TJw2F+tyCgRV+8Wc5nFj2vClphbAU2E/B6sdMyVtXefZXWs8awAlpB6
	 N6Ejj9hV9yewpcYQEIvr4053NTsb1qU4b5hGqnNmoDLOQullywFtPezYHMgPH104USg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC411606A339
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC411606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ec690faf85so1410233e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494807; x=1795099607;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DeS1JutKTfuhS5q6pNbvmoX+jSrEwDPcQETf0SHwj/c=;
        b=PYgElATHtPPB4QCPR+UdsI6Ox0G3J/mv8GqoNRNHMwhOpfTiA1nwm9l5CEm0cyrSC3
         Lp4CcUDQbDG542ks0W+5a/Q4WbldAZ4pruEBW/TqwZRKrrA2fu+L5VFRyAdwTTEDtPaJ
         j0kD+UPOWQNvCI1RYo2qbPtoK7ghtQtrH5xEInOvQHG570RiTMx2dibDkruoEzb6SMr0
         5YCOUAf8vWtHL/dAT+OSgYSKJ4PyOS5JJJJQth5OhUXodOy4O8084l+BYDcOE+LY8Yy0
         Cy9zYugM5ByOxfpGe6hy0xgA0OStutM4Udp2JraygLdKOy+DGXZXFVtHQQ+HB56fyxO/
         jOAw==
X-Forwarded-Encrypted: i=1; AL+hErFnNbbXPSeg27uVB6kQ2ZLwnaOnjE4E5cH4+LTV0fVmTW/aQVtD3D8zB8HW8TRIVyMawfjjC8ryKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+AF5t07V3HXuDeGTfRAqpWSEbRouAaQcY6KRB+6cqziMdcGHNs
	QEAwLyAOV0zHDCs9fcFwQtvuJU6730ycArvbPf2lHatuK81eWSQWorDoVOU83L5/mxc=
X-Gm-Gg: AYBFou3wW96QVC+Zbd9wV8ZRlxh3gTmzqFSi4ZCac28ErblDuOPTOnIY19ZbzXZIVoL
	6T+n3uCtBky8/TCzLVt+2DTb61i6PJK7tKE3Z45KKq+6kxYkIZa8Ipp8drLY9dVqG6ZwEMIv+P6
	oukAf/jZ0YHpOo7y8rPLORvf7RTZIbd36fY5A1sTG8MowVymH8GT3jKG+fwDj5OvDsrx7W88arq
	Px5ydquVyDt/dLMs3dagl5mGhBi9bq5u/+RUBu0WEIUQTiISQgDjJifeWo/qhT07r4tGi94FUH4
	LyxkkPhH3h0dp0VOlD6azokw1BVXnK+pQ/a6EGduDSM2HlPTypay/TCw6bykPnJ9LwfIoP+dkFr
	KWz5VPP/EFqWJ9DK1u5a0BTcET4FYKggUFB6SNM8Xpt4fpIbL5rvJldbNJmKPR5U2ctUffHjOKa
	Zgs5TMBQvQBO8sAK98XKkd3F47KuGwb05+tuHn4Ivth6vnj3vA1HEIwhQJLNEa1JEXqz8dUA1PV
	2qY3qu/WDyt47oZARHnzMdYg9H/A+g5HY8Lu8xVk+8mn30qDgn0U7sVXtSddNv+igl09qkrHO1H
	GOjYdeOY14TXqdYioinOPP0Yy4wjGjMyTH4jhlDLTSqWNZ+RNntaTDbsf8n4oFJgK7cE9KWO7hv
	kFoVbf0VNWoLhtpTj
X-Received: by 2002:a05:6122:1797:b0:5ea:d32a:16de with SMTP id 71dfb90a1353d-5ee1c44ac5dmr2135184e0c.15.1794494806858;
        Thu, 12 Nov 2026 06:46:46 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee3240b829sm66193e0c.5.2026.11.12.06.46.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:46:45 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ec690faf85so1410198e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:46:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH82bWvuoyt7rL0gMrme2ss/SRgc6gkAr/z48eEQ/qkM2F6O1I52QkZRMbxKsq274pwIZNyeSryJw==@vger.kernel.org
X-Received: by 2002:a05:6122:398e:b0:5ce:d56f:efac with SMTP id
 71dfb90a1353d-5ee1c4995fdmr2096272e0c.21.1794494805148; Thu, 12 Nov 2026
 06:46:45 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-3-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-3-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 15:46:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKr2fGN3k0LYHhoFp3Rp7_=KfTB6tQkGYDof0Em0HVtA@mail.gmail.com>
X-Gm-Features: AclHuK-vYdrIZUHe9zqdC5qY90reiPN1Oa4nwuum4GsEnnZB7I1s1LzmhCydy1o
Message-ID: <CAMuHMdVKr2fGN3k0LYHhoFp3Rp7_=KfTB6tQkGYDof0Em0HVtA@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] arm64: renesas: r8a78000: Add FCPV[BI] nodes
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

On Mon, 9 Nov 2026 at 14:35, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.
>
> Use the SGD1 clock as it is likely to be the clock used for data flow.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1574,6 +1574,78 @@ mdlc_aon: system-controller@c1338000 {
>                         bootph-all;
>                 };
>
> +               fcpvi0: fcp@c5030000 {

Please preserve sort order:
  1. Sort by unit address,
  2. Keep similar nodes together.

> +               fcpvb0: fcp@c5038000 {

Do you want to sort the FCPs within the FCP group by unit address,
or by label?

For the contents of the nodes:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
