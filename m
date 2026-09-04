Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA94EE85F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534700; cv=none; b=Syf0qhePnWoYueeVShSdLeKoeSB18oFxRvWWQIKfcVPVVC3mlHJ24/ZmenKK4c3Gg404BdLEtUdmw2VpACSVaIut0JB73rmbx7oW42pfMudBqZ5lQD1WiKmsYlYaoXEwvo0ftTPwopqJPUjezMQDUcEv/jYR1HEX/4bfPGZZ1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534700; c=relaxed/simple;
	bh=d1r8YLCgRIdy4KEcRiU5xhMZDzm5Ir3G6LE/EtLImp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCIjXzUno3Bi9mjRtm0TLkaJg0QCfYRipoWBrnXea2yHzCum7a//44oNYjlS4zH2QuZElqdnH6Gbzi4GrtqcdNLL0Z0SSz5j6z+QRroitdLEcj1Mugvn75WYxOfTW9YHMH70HWO+POlDVC7rLIA7QrvDDwhtlKCzU5njkXFjnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fb8a78ad2so999528d50.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534697; x=1789139497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DBpBma5dCQR0Szv2MO2Socgh1RkSDenfZa0jgmlXBh4=;
        b=hHEa7KhamxlNp+w++osBUtVaqXCTlURf3P4Ttb6qV4BhjjwXHxJ739bnYPjfe7EpBV
         oNzTsE6fauGZEP35FO+9f7PV7AyQztL//v4a/CfpgQQaCltLz7MRsRZeKnpwNWOC3G26
         Jm134JvXRj9QWPxujCSD+RHRGvF1TlEmB/NcolCGQsRZp5ra7GZlfvQxiVTjcwsmoQGk
         v0SKWn7ZMsPtgeoELCyI/WomlPg0XJun5q5gcx7vUs/41c1HAHGuPYAsfuoV5QPKsgc+
         q2H+7qKWu/qbXW0BBmaKd4OB5rzUkhaugIH/M6wJsh0veQiUxK/xgTsMxcDIk1YZWhtY
         qENQ==
X-Forwarded-Encrypted: i=1; AKwUvBzF10h0bg9yT/dL6fcqm4RYauIt+ChEk3P6QL361oIhbZYyr7kJ0l+WWvjAH6DRzbe5xKhedquG3g==@vger.kernel.org
X-Gm-Message-State: AFuF++lB1JPtD+6i5BqcN9EaERX90ZdCsdHuEKZ0/obffQT/tUVyo07W
	yzUdgD7ka2F/zpkSo9DnKmU/g9/Va84NoyNvsTfOp9kQN5puW3phfKHArder5sDh
X-Gm-Gg: AYBFou0g9E5MfEI2GJgzkfT7cLFc+BV3MzoZvjEWZMP3zX5utrIza7A3QVw0UbCrV6h
	9MBULVM0vnjpdy326/0pn4OIJzqhbZLrAS233+VqoERcbZfvi+F6Xjv629u3kBYdcSvZ0QosHl1
	YxtfkWT7w8ojYCSSBLgnRQ/fbU/GhZHXvd+RLyEoN23RQR+Ox7ssM44n9Nonr4G6eaafjDvpzjG
	/rSbmVyFzkdCQHckRUOreKLu0vQ4w2XR+r2VihOctbDu0yOZv/kispourAlYmytTgUpNRHmICVU
	yazOiaElqZRC4jeKAA80bndM3llU6L+TqTG4dskegLkdzvMnnQMK8l7/PBs9+Vi4Y8iGuMdUPKF
	2aeJ7qZLL9WFFk6X9zTp0HbHYVzGrsgRvr4PiOqGvR5gUdEMJwqVbfFuqrO6HQENMFGHYhbz6pB
	Hw0KT1JBmaodHegkXO447EFx19QKx80SkgKCOUPixWNbmMiihI66gt+M0vShNTLiUdVANmOorky
	nGVpBhP44B7PRhf8FpbO1Tr/wNOPw==
X-Received: by 2002:a05:690e:4802:b0:66b:245f:bc5c with SMTP id 956f58d0204a3-66fb5a181dbmr1882890d50.24.1788534697402;
        Fri, 04 Sep 2026 08:11:37 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm2508547d50.2.2026.09.04.08.11.37
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:11:37 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8565d77c277so15320827b3.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:11:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUVDPbNdZlk4wRvYcYjiJdwU6cJdRN46rj5EL902mDcOwd5/cyENajhKRm8Wna7Ov8H8M0s54yDA==@vger.kernel.org
X-Received: by 2002:a05:6102:f06:b0:785:eb33:8794 with SMTP id
 ada2fe7eead31-78a4a91756dmr2264959137.10.1788534332492; Fri, 04 Sep 2026
 08:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-6-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-6-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:05:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVch5xkg3p0+9mvEk9393ZuV2TO-kcyVci+VBAMCG4RPg@mail.gmail.com>
X-Gm-Features: AcwNN1XC5gp_Xk8OzyKjoKwIynG-nLTbzWvj7aLGFiNz0LjJGn_EivdUH3_smAk
Message-ID: <CAMuHMdVch5xkg3p0+9mvEk9393ZuV2TO-kcyVci+VBAMCG4RPg@mail.gmail.com>
Subject: Re: [PATCH 05/10] soc: renesas: rcar-rst: Add support for RZ/G2M v3.0
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
> Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC to the R-Car
> RST driver.
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
