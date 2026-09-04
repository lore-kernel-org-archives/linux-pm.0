Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1997446067
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534991; cv=none; b=EsZVzX55hLojKVvneyH7DV4XnXezFec5WMNO5HiIKjMmwr2cEaZBTNrlKa6wgMDRnM24FMjhDIPer6HXupSapArYU/C/jiZ5Z597qdDjKuJq90EzxoXjIL2HURZXR4Cbux6V/HfqRLAK4ULSAbDdY5BTa45KhDK/Y+GDZb4cygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534991; c=relaxed/simple;
	bh=3zmx8Z2M3ZeRzOKqpOgR2P10M5x7/5/EKeh+dHIiZJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxmIjdkhF4YVY5+wo6M1EF+0AkV+tcHVHErWnk/RBhsoAd8XxOPzKgRe1FwR8qthVPz8nzuu6ljmT1jN7Kp3kgC1ZVpqH+1pAvOdr9g5WXuo8lu4rctVRId2xfnu4NHd0PtfuuEpEYd0MlOTzq8MT4LYBzo+tB6IKloOYWu3ziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c7c25d9f6fso1068084e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534989; x=1789139789;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VtnOZM9WfbSwC1inxRe0geJOr1JfkMHDy+62es74nYc=;
        b=a9CddmCs1dnMt601fCrC9XlzPj6mo3PD4jRdaDzdi8kBymsJ4RS4JUmKPlksTXl3Hm
         kmsskBQWap6U76+G2SC0TbgSa5L0KInAvOa99N8Xyux7WUiRBd7gednKgZqyoRoBMStz
         McY16B3Ol2bs3cvMJuOw6JSpIJ0w13wbEsa1gBmV5/RiDsAQDgbjzmOhirlaigtMD8Tf
         scZRNmHTo2VRVrkZx0bgHMuG6Z5RbR9JKVRO6vKo98NhanZq5BIpNl3YcRN/JeY0ZFG6
         jjXBRV/V/7yrEk5vcp8eGlCXLO66hahDkqlyGOEvBLwCbIGZBYwn9OXze04HEJmNwcXL
         SR/w==
X-Forwarded-Encrypted: i=1; AKwUvBzz+vDSwWbowBqNQnQaHz45iVPeaZIAWObCVyZFJwPMFAkk3YHojfKbaJcdHnw2AmOIf+y72iUCjA==@vger.kernel.org
X-Gm-Message-State: AFuF++mNXMTBz+iIQsrW31xN0RytmMpyVvL7E3IgyaDzHx1YS6kdEwqw
	cPJwVaTGCzO6aWG4XZK6Qd0oVKiaCIginXiwAjHPiy9QVkgjQFaPA1f+8NtIHgvy
X-Gm-Gg: AYBFou3YP6DM9mbWDgFNTuKMrrfp8eMRwD3FYCousizL9m8l7lBBoabivM7/+i1bRr5
	Smpd0viwyAqkO+pzGO0aJr2v23IIiPL+SkHODjJGKYa5nKDLkLHC3GBtlPGosqSSJx/RfrwJyQ4
	72Awmxlc5FOezT/+82AKfZ2Ykxxa8BAznOTl+hngUdtr4xTVLdvBrxPwZJOW10kZXgOPwp0m7og
	gjy8OY56MhbJq42iTyzhWjH9U7BL/B02FRMm6LkjbA3ENsO3o5+fVo/xeHogBtPQqDhQ7tXMByC
	iYa6BfaS8N+fLFS1J3Zd/Zps+XkpdKa08mXUUhaCAPnRHVXdv7XlwQbxXCB6Gk+CiuYoxYfSyGn
	4fNVGtcmVp0XgxZtNhp08l7CGCu3ILFSvUCamIfZNeIry9uCdkoE92OOClWGj68saHATtBNZvMX
	quevBOXSLL+RILLUA0ANedwbAHlgJB4MpYy7IZDDNIayrB+KlURA8BlHDdF14ra5p/A07D5PXA1
	YmTEOEboY2NlRwFMNvv+VzeahQJhw==
X-Received: by 2002:a05:6122:e189:b0:5bb:eebe:7ffd with SMTP id 71dfb90a1353d-5c7ed846723mr3534038e0c.8.1788534989307;
        Fri, 04 Sep 2026 08:16:29 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ebf559cbsm2373306e0c.0.2026.09.04.08.16.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:16:29 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c7c25d9f6fso1068065e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxyKIu+3OvRs1hiJaQSIiy2Hws8LUjbtF5V6UkRGElucVAdAK5XiA+Us/QOKk3P7n2cXDECEi9U3g==@vger.kernel.org
X-Received: by 2002:a05:6122:e189:b0:5bb:eebe:7ffd with SMTP id
 71dfb90a1353d-5c7ed846723mr3533958e0c.8.1788534988918; Fri, 04 Sep 2026
 08:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-8-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-8-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:16:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6GACqU4VTEk0hUO2A74RDmO3twMhEvkFAp2xiP=PN8g@mail.gmail.com>
X-Gm-Features: AcwNN1XsJHROGLoqiw2JCifUELiKV7YahAKrRzR2A5vM8Z-pkJl7ddzQiPC7x18
Message-ID: <CAMuHMdX6GACqU4VTEk0hUO2A74RDmO3twMhEvkFAp2xiP=PN8g@mail.gmail.com>
Subject: Re: [PATCH 07/10] clk: renesas: Add support for RZ/G2M v3.0
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
> Add initial support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC,
> including basic core clocks, and SCIF2 (serial console) and INTC-AP
> (GIC) module clocks. The RZ/G2M v3.0 CPG is similar to the RZ/G2M v1.3,
> however it lacks some modules such as the FCPCI.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
