Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355433AD9C
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226810; cv=none; b=R0nFv7X0KLClLVY4ji2l2VEEFbJg5k+eRG1aOjyHySTwhIJCrhjPhnzaZiltj+xdSM9Q75LdpqMrbV0AF5HlwggaDM2dk3pA13rEI0skLkvC8P5SlB6k7FKjbFptBr0EIS/0bXzHcdqrDKBF8gUwLhaVwwyqDEA9LiaKxlsEtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226810; c=relaxed/simple;
	bh=pk3moMq1FKy0fl1HwB0CJkZy44+CQqnu0oNoBum5fLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEQFnxVrfmCj/+o8FIXj6Ia7LfW662RFweAyG3ctaYMyu8p2OeUYtZO+fFZxCC1AsVn9xLDX/g4NubMmvRTnQQr2OGaOmsBBTGrcIG6bjRsjqMKDW3NlxB2tDERcr2siPblZM9gnDTr5873HU7SCL7FJMSoiMpSNJr2eL0uQDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-835c98b659eso1200683b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 00:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778226808; x=1778831608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FZfZV6lWdmpc+MfoLFhi38NvgPEcuF56xNXrAqxNBA=;
        b=Gi4KrgfSWPRaXn7E2lxYdjHFJxS5DCMe1983LJ8Umr04rEecMov6yZeut3aCWLSH3f
         Xomzwd2cVJEFNqMEVx5xhP8/Osc7mGwX1RC5nfA6SvhQjmuY3fhwlROUQkRlJrNrhqm/
         +St/9yEag3RSrfMbwKSGKqgeUawUDoxzFQ8h33ymE/so7Nn7huhFFMyvGQz76GEDYvO2
         gBSAp4Muajqe6LKvYQv8ULtnyPAHEQXH4S78i257rHsXYtLc0dL0fOp7vUMP7Fc7Y4WQ
         VVio/CJieYyZoCCX2yANX1lVberHvbE670mFOBWEJ5CV7Zey1neEhQrUGXDuu9IheP4H
         Y1Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/CrkDlLTN0QuG4B3jqh1nIOMvK87EAzq5AriWDg1nO2XM3q/u895A+D5swVN7cn45vZqc3y5Hw8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzng03DVVbpN0Bg38pGaw2Sork/nvM8/sBBh5aeYhf3OpYJqEeM
	YAIPZsHhUXE6MjI6bX3UycCEfMBNubUaIbtpm5K4NgUafAdeJCeE4PAPSM0ufX92azE=
X-Gm-Gg: AeBDiesRscHTUzjkyRv4SJsaKYtvzpwH3ugCvEeNrMGObQ3URLQD/vpqTrJ/dIBNBmi
	uPXYu5aJBch/8ebiRb4lzImZsQRtqUMMY6zhLS9Io5JN6+BHya/UUVBoGsBEjcBgZ68/9B9NLYZ
	LiAN2+cREfPNwTm/QlCJzqdTEOtvXrp3NRsL70EWt4+ZArEvm3+2+pdSEi1wgOC7AB3/WD7JGDK
	SCBvedr2RMaugYcHlapoQQp26cQzVJ6vHXqr9y2DtzzUxMbhK31wPbFZmfCJ/ZaCfH2k9Cr6f44
	yw4hfz2/gJOOWGMVZtoaOIMYQHBSnB4/WFNS3SEk/zWyFoAtbmeALWCXqbmdhPP2mkw2csDkmzP
	n8DFPODU+EOBkRiDupxWO4jou1CFwBjes1OzzilYcSto8jkUhQix3DiZhNzQIJBkvJP7YBx5qhA
	kD3pdo7TVlar+ELnmYaBy1JhBxv99/M7BE6A7PltcZ7kocEcHpgMmtXDUDiQRRNzMGZkxdSUFp3
	Y4=
X-Received: by 2002:a05:6a00:4195:b0:824:374a:1407 with SMTP id d2e1a72fcca58-83a5c4bd711mr12017510b3a.16.1778226808393;
        Fri, 08 May 2026 00:53:28 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c861esm14243496b3a.30.2026.05.08.00.53.27
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 00:53:28 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso1231150b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 00:53:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/J2GKKirc5Dmi2pDIvIG1WQJljuj5kwqQ9mtemE3T6UlyVd9S1jtd8a5/vz+s7CIDzazVs92YSDg==@vger.kernel.org
X-Received: by 2002:a05:6102:8499:10b0:631:28c1:155c with SMTP id
 ada2fe7eead31-63128c11e98mr2184841137.7.1778226445710; Fri, 08 May 2026
 00:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <053c312d07445517d8f9c84bfe3cc8fb72d4cd9a.1776793163.git.geert+renesas@glider.be>
 <39879eae-39dd-4b4d-9469-d238cd7d120a@mailbox.org>
In-Reply-To: <39879eae-39dd-4b4d-9469-d238cd7d120a@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 May 2026 09:47:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVumfXkBtxzVBY27SRngHG2eOoWP+cgbkWQDNDkAW1mOg@mail.gmail.com>
X-Gm-Features: AVHnY4Jrjqq6M3ZL6uO54VIlKGFRT3YU3BSC7jZzhSUGnVnDGxRcagGSeBzeNKo
Message-ID: <CAMuHMdVumfXkBtxzVBY27SRngHG2eOoWP+cgbkWQDNDkAW1mOg@mail.gmail.com>
Subject: Re: [PATCH/RFC 10/14] dt-bindings: power: Document Renesas R-Car X5H
 Module Controller
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Thu, 7 May 2026 at 23:53, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 4/21/26 8:11 PM, Geert Uytterhoeven wrote:
> > +  '#power-domain-cells':
> > +    description: |
> > +      - The first power domain specifier cell must be either the Module
> > +        Power Domain Gating (MPDG) register index (0x00-0x3f) from the
> > +        datasheet, or a Power Domain number, as defined in
> > +        <dt-bindings/power/renesas,r8a78000-mdlc.h>,
> > +      - The second power domain specifier cell must be the module number
> > +        (0x00-0xff), composed of the Module System Reset (MSRES) register index
> > +        in the high nibble, and the Module Reset Destination bitfield index in
> > +        the low nibble.
> > +    const: 2
> > +
> > +  '#reset-cells':
> > +    description:
> > +      The single reset specifier cell must be the module number (0x00-0xff).
> > +    const: 1
> Just one more question -- the power-domain-cells second cell and
> reset-cells are always going to be identical values, correct ? If so, it

Yes they are.

> would be nice to keep the description: aligned, and maybe even indicate
> in the description that those two values have to be the same.

I thought that was obvious (but apparently it is not)? The descriptions
are identical, except for the latter not explaining again what a module
number is composed of...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
