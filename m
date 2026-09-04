Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BC4F55C0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535769; cv=none; b=a7xkfMKfFhimk/fYcnM1spabaH/Ph1Yj/YHmwu6EmGPcGy4o9UBGveNtOtFGhQNABVK9wFtQK4n2nqI8OkM4B9hpv3PRBGYMb5vXNYHio2RpjJwkJvXRJdj71+0kkWP5A15lmMFDjm6X1NR7gcRb/QePgiCR5Q2mwQXfHKA4XTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535769; c=relaxed/simple;
	bh=nCrntIDhyuwP8BQpdMv2tSN81fhquB9QOVe0SeizZYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpLyQjTZ7hZBdgulc3zLUeTuWEnDNDnTgln4ZX3Q0nfXQczyAA/QkJE2U6a1TLpquqSRP18v9K9f7FNzupKVjYQ4+3G490LGysfqTIngJoeIkOtaqDvao6py7S5RhaCM3k94FYv/96LPvQ8GrRsjnmHKY/A1ZigziBxFgvy8NLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66ce4a63e17so1286363d50.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535767; x=1789140567;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mr7nrVkZKYZ/vaRmGYmX7E824Q9vDG1RqRG5Sn6gSeM=;
        b=e3fGBUHN6pnYi43xDSArp6ZOs/3iBuqsKCL91iJ3FxGyNAVlJKKI4ntviLrHEDV3P6
         Kz9nxot7TtA2SYeRv3fxZFB+tfLigUp0z5xFVWaF1uNB1KOuepS2BFE8G2PBAA7OmWh4
         vSQNm7gj3Q46bPWvNK4YgFQrNaie9PZyyfstSWhyOZjUrDJ4JTWP0rdBrQVoiaMlncr3
         xwUlyXPFA9E+SQbnxeP6axTU4Az99rf/LMhX8KluuODXaLut0ijWDSbI5ZrVWBJvifTn
         40J5F1lS3muqU4t+z79dw50Pnz8jnZsWy0RDAPusRovS+QYWURszxGXKUnNlJeINhvWt
         BLug==
X-Forwarded-Encrypted: i=1; AKwUvBxNjNRq/aywjN8acLKPnv9htb2MWGA+2NblBCttio9MhduXc1EsVZOn2w0VIW/yF6NiRs7CcYQQqQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k4NNFBJzxWF0DZRfrTflPsAc3wX2mKDxlK/bnfuNSSiqYC7AuG
	dnXFAQRRJ5V7kRllYmnwPvUTfhA60fc09+Mz4wLRWoAiR5M3C/mArA//hBSivPF+
X-Gm-Gg: AYBFou3N/BTT5/uSwVhN0NF2Mim2PedzSQjm6Z5+hNvD513FW3KwtAyreGKpxgEgHL2
	a7N/3xmUD6AIPC3KSCyw8poKSi6KIrcGOUSNpEx2i0etbtArx+KogQj/Ax9HMkK9r8al/cWljPb
	WQubeo+Kwz+KDe2z2YX0RxQbRU5m4c6KCfn9a/sAVLENMPh4AOS253wm8F4dSU1Nhu/9w1QBYGT
	lTx6v8rOcPx04gl0Rn/Tg9hNQwSCO0juJYQlrum77CtjmIH4WJ3bAw/3iXZtoDaX2j51/Gz31d9
	nc1bgUXvapYlayHfGYCzxc+57wjtV5SPB1v8bHdgDEucPHTfCmV0kGPopeUbwbfRodxu8D1VgJy
	Ntkmf+BnraglRgIxAEexKBvchFHz7hAS6zrekywElnBQnW56Ed12/BU74+DqznhxmvXyBzfCpcU
	m5wJx0lcxt+y65je0sPsCJYFQgj4s384t9LgcQJBwTMSYKXIu2UpGu172yFPaYG1JDMLQ/ZULF4
	PYR5IUdOmCys98jr0Xf6eMCyg==
X-Received: by 2002:a53:be03:0:b0:66e:4aab:407e with SMTP id 956f58d0204a3-66fb5ad6cedmr2251155d50.48.1788535766863;
        Fri, 04 Sep 2026 08:29:26 -0700 (PDT)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com. [74.125.224.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4914af4sm2472499d50.13.2026.09.04.08.29.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:29:26 -0700 (PDT)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66fb2fa79f2so924069d50.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:29:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByC/R/ipqPClCHMPip5eTrzbrQEjyZE+MGjrLKr5EOX1dYoe/CoUhwXJOZTnajHcC+Fsle3BNyV2A==@vger.kernel.org
X-Received: by 2002:a05:6122:32d6:b0:5c7:a3a3:a4bd with SMTP id
 71dfb90a1353d-5c7ed3a528fmr2695851e0c.4.1788535415032; Fri, 04 Sep 2026
 08:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:23:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyPbUEy1sPZWmosVtL9GQviEB+d8RW8Xus9wpxZREgRA@mail.gmail.com>
X-Gm-Features: AcwNN1VarzxavclKk9EMuPnWIySi6CxTEUYbBFaUC14MO-nuKk5tEQAZbU7dyfM
Message-ID: <CAMuHMdWyPbUEy1sPZWmosVtL9GQviEB+d8RW8Xus9wpxZREgRA@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for
 RZ/G2M v3.0
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

Hi Ayman,

On Fri, 21 Aug 2026 at 17:06, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> Add initial Device Tree Source Include (DTSI) file for the Renesas
> RZ/G2M v3.0 (a.k.a. R8A774A3) SoC with basic support.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

With the cosmetics pointed out by Krzysztof fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
