Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618056;
	b=3kL36R7522xpDGeBWU7xJV2V44EKCjKhvw+RE8HkgH0symgWcCVqdoMJpJKkmIlQh8cw
	 25HBhU3FjvC1wxaLLPs0yG8vqAejsBkHC5CZq25B7gYia7yh5Etja5OHN20pBIFXgluGO
	 gez8YoMvHfFZqXKQcwK8YOBix8zo6P47J/MP19q6MrNYyZz2GYGNqOov94+gv4DzOEvVG
	 9lnpEOD1Ea9ySSFceYnrrL+dANGomBvo/MyIDDAH/IrxuW3DKNUklJSluva4HSZ//UvyM
	 X2RBdQbD/BaF7+b2GNFihzsIVJg+y1rYVsmHRUwy20as8WwWoBmraMyuAH82M0uec2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618056;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=jyTslH/h8L0C8HCIteQbCN/1sF3Ppecw+tHudhxEPjo=;
	b=kMwTXYaCJSjKn/T6DEikvS547U5BE1YH5EOOsFgM5Cl1VC1s1qofy46j7peFE8bqFWZ1
	 hetOeRIn+xoJSl5wI0mmYPwtZ6LssOMBX4bB7dzYghYsAN0EtQjsdMM0zGeNk3sIJW/ZV
	 cQqJL38OqimTPnjCvhQxnEUQ2677uhFvhGNGcZ1U3TVYXlW5nbqJrDfBvSN/5e3nSkHR1
	 7+g4RL9SJ4hyByKB17HI69JLSf/uaz4a+qycNGTXNmMOdUg312GOJMjHIEjxZfjOpODnJ
	 vPFUUW3Cjrt3I9u0GmPoLVoKbHStqKGfmRINg7eDQaPUTu+iuTiIWHnI8+2y1MMTcfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0C606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-921318b2eb8so74196256d6.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618055; x=1796222855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jyTslH/h8L0C8HCIteQbCN/1sF3Ppecw+tHudhxEPjo=;
        b=YPtPQSkbYAL9VCMm/QMEVZwaohuQUDtUQqiCzcZ+Dp8jrFy1JIReELF7P4xtx9nyYn
         2lha3mnxBKqybZJmEIeM/7GaMIlsW40GukHUb5UdQ6Rg1ie2pVbsbH8FzbgovnPMBVFW
         18zFpsVqxOHgc9YUOIMvBfmhqq5t30Ti+J8CGleL7PDwhozcbQvd3xkbOvKzASfsU1sB
         dETpgke5o987+DbhOb6bAnxDXBVY2qMc3bc8v5aXoUG7JHGKOW3KXAGujn3TzkzzrhYY
         DVBNtFRX2RaAQVoRlz+b6aXyTBgfnsIMkVi3zUgLqPJvEwkHajmedEskZIQenW4h05/Z
         cZIw==
X-Forwarded-Encrypted: i=1; AL+hErEkMMIuV133IYxHo7RJd1CDYe4Ziqk/FcBdCWwaPLqxtGvfr8VfPcooQbGj66U2frEVAR71GVgstg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9YauF7WYTmwRl6B+/epvmCAu4ock9EW1lcgFhXz3vxDGc6+fHE
	XXtCRIkLCZ1DqG3Xk8Sh2BvyL0oLSJgNCXtW+4hoyzXCjg8W+EllLJuY81UzEDlI
X-Gm-Gg: AZFdTZeplvnDlyq9EQ1rkJiCvHZVBfVCqZcJq5HGW0dDfcCyOAcet34nqWDmJt8xPi3
	OfhoXswdABh76zWQ0f/w0lumRgb7B97+1I9WPsf1jnvn6UixvIseF40jxfXXyHGf/cvkAI35ckT
	+hqBu8xxZqjez3GXqBiGD83dyKyYLP46rYDo8l1EKHwZuOCY/2Zwk5qPIqub1eau8sgTPKFLsMf
	Ujf+Joa/BXaeR2UL2Ild++3UFOyIeoro/dwKfG8HATAqN1KL6aMk4/zcoN6NFtoXY9DiJH+/xus
	7nfDLfqS9rMJIhpKTsuq6Vn9HgQgPqL+ZlvDvEKeMcEZm+JeZz8usOX7jJn9N/0cssV46HS+GLn
	LJ+TKXo0anDwCBKU3X5qXyjr02x6MAGyQoS6LoPy48lSwl7s+Bsz+u/FNKS7tgeldqKK1COTM/N
	5tQSIVDFZzb72LIc3AGDf3jY9ssYmcXaldPV/pLWXSyiMKH9BVNIsh2aMN/6bolY+AUMLXIIyuF
	mnM8YRMm7ISzVjPPwR/eHznmliKU6rtUeUqXQ8hakC2VtvAMDtrBeoG37sCS+3VXprQFYvO9Y5Q
	FYEh1j+cBGrYXzffxAWTiOMFliWRLkKJmiiix1V4slROJ44bhb6ZD79DF1fzd5saAW8=
X-Received: by 2002:a05:6214:458b:b0:921:334c:59df with SMTP id 6a1803df08f44-92134a9957fmr310603366d6.41.1795618054903;
        Wed, 25 Nov 2026 06:47:34 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm161117636d6.1.2026.11.25.06.47.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:47:34 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99e740a7131so2632694241.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:47:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFhtnw8/wCxi8WutB71yakByqZTYUQNoh/WsWSroZS1vddvlIZWjVT+eCLjQxEWxdhCP/DhwBWWOw==@vger.kernel.org
X-Received: by 2002:a05:6122:1daa:b0:5ea:389c:520b with SMTP id
 71dfb90a1353d-5ee8af0b136mr10546236e0c.8.1795618054600; Wed, 25 Nov 2026
 06:47:34 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com> <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
In-Reply-To: <awAqqg6F2Z1t55x2@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2026 15:47:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLn444XFOUV75J22dNSnMkcjefusMomnp1dqRe3tsggg@mail.gmail.com>
X-Gm-Features: Aa3M54pxTFdlXtNPAY9vlRQdDdU5I_xDDti_PqZ4BrybSMWjBRbxoSvFUUiO_NA
Message-ID: <CAMuHMdWLn444XFOUV75J22dNSnMkcjefusMomnp1dqRe3tsggg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Paul Elder <paul.elder+renesas@ideasonboard.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Fri, 20 Nov 2026 at 12:10, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > I don't think SCMI itself introduce instability.
> > It only defines the protocol, and each firmware choose its ids.
> > Could you tell me what you mean by instability?
>
> Let me try to reword:
>
> In the past, we wanted to support all kinds of firmware. Sadly, each new
> firmware introduced different IDs here and there. So, we came up with
> some stable IDs ourselves and mapped them to the IDs per firmware. This

For core clocks, we came up with our own IDs, just like in other DT
bindings where there is no simple mapping to hardware.
For power domains and resets, the IDs are derived from the hardware
documentation (register and bitfield indices) (augmented with a few
power domain IDs that have no simple mapping to hardware).

> is a n:1-mapping of firmware IDs to our stable IDs.

Unfortunately this is not 100% true:
  - There may be multiple SCMI IDs corresponding to a single physical
    resource,
  - We are still discovering missing SCMI IDs for some resource.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
