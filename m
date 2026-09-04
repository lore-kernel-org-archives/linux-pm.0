Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C554E80DC
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534224; cv=none; b=YNEHh6RvUW6nmdDqodQrotwxftuY7qZ29h3EUvW3fE+utJkn75FooRz4Taq7a/i6IaalXRVFimN9wd9eaJfyiCRQ1S0fJdQ1D1Bv2Ad8jUH61QZaM65cn+XCAXxkcwPrtc//ZxA6Qb/R2UOlVZrrD6JP1blh5APa5N4aSU25YfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534224; c=relaxed/simple;
	bh=fzOREMKstNdN+mmlGhqGbzBVxrEgv8H1fmeOK6xcw88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVmi6wk745nE8lXzYJcgyTr7v+VUfTcmt6GLaSxNMYJLRLbpRZcSWCk7bhcKw6Hus8nH+58BWZlaNpzZY4isXom5G6aT+DfZJx01pJfM1BRcvxCUjca5YdSA/s9my9iEv8MmfKSGPogg/yW6ApjfBP02iHv/owoGkgaDE5ndj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78a220b5778so978655137.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534222; x=1789139022;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FwDxiYsshE/fUWnWj2Ruj2wFFXY+QnXdoCrsnnd25AU=;
        b=bVMzVE3OpcMWlWEJhB+wwDlPxP5D6ExQJRkirTS/U+1XCtHplODf4UcIDegWpU8+Zu
         Az8ILY4HYEgCnVnoGWAYA+PyKaCFIaiqu5WkcJCrvjhX/ujtNR2Id5nuQ6Ln1OWzpJmK
         5r9nBTTVgAAwVMlcLmQ9yv1dPpNAQe2W39pWuj8gc+PcjNvZyoFFG2v0K7muYxnEPHb6
         FhtjBOswMpqPT9FIkOUInqgHJrEInu9ONMkRF96qUTlccI9XfExGO1/ZTASs6D56zFEe
         q2ppmzfP/1SR+a+EdjRj6OREzehvj1boHOMnkqi8Qzr13zFr6UMFBjISGnab7Z4SCHyS
         Cbbg==
X-Forwarded-Encrypted: i=1; AKwUvBwT5YwDwdByAN9WQcL4nMvCos4EGP2HFhXiB0leJUIOLP8gSokxGQ8fSAL+pvUyfryei7zR1JIfqQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nY2QmLC0DR7NF4UQ09eaGvPJl+zp+5KGHzM0CpaJfbqatt/io9
	Ojl+iM3I+IWzi+avxgrv0gIlDLEVbaNpx6MDeYIPCy+mxLsYk1IucGVZ0kK3cbOZ
X-Gm-Gg: AYBFou09JOiVLdFuYUqUvcJZTgXIrMvhRPw/ULWG+fEtSxaO/hOiBUOAcS9OIEUnsv3
	qpQ72zuRXbSgja+tRp0CC6tnIlHwlbBVIKAswZsWmSYl6VS4yG2Z5KOO6gVvsrCeq3BxfvzElxd
	PGrNm97+tyAOJDx5L4n03OEczZAsJhHbYKkRJj/ZdpArAMnzY/vpt05kaiIQ0e7jtGcD3odjld+
	hZR/4QjQvFmo+N+Aj5bwCRezyQMOCJ8PWdHiYizZcw5tw2r4xBFiYMlro8NfFIXxRk4f4gUpZ0Z
	mZM4Nip53LSWCQz6P7fEyxb1NZB1rhTOw+JyTcdakTo7hCv39iSFaLi2h1+JCs0DnthWoUB7Tws
	oNDfmOf4dVtqdOCsURd0FlCsdiYkVBnp/sq7BYf9GLTyEVIcACS9Y4rGy1Bq97HS4DOSA6tmSKk
	B3mYMYe58Yc7cQbtXc1ickhAynOBnBAsX7LAta5Z7szUXnznhLSSDpsp6HQcEcJWxYQHjvsbBnL
	TpOAXNFEqBvmYgyvPJcqLzJNg==
X-Received: by 2002:a05:6102:227b:b0:78a:4dff:7b3e with SMTP id ada2fe7eead31-78a4dff7edbmr859139137.15.1788534221889;
        Fri, 04 Sep 2026 08:03:41 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ed1d832sm1787940241.4.2026.09.04.08.03.37
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:03:38 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97cc700fcf5so1504858241.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:03:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxqAl+oQe2PZsoRfzNjBCJTiA0M6cbqFXhcoaPnjo/yU59pqOY3N7KZE9FNLWhDRdV0xnvpDMfgtA==@vger.kernel.org
X-Received: by 2002:a67:ecd7:0:b0:78a:568a:616e with SMTP id
 ada2fe7eead31-78a568a7517mr457415137.5.1788534217450; Fri, 04 Sep 2026
 08:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-5-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-5-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:03:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1gcLybr06anojAeym-Y8ogRCavOOfJiiWeJRHrOePtg@mail.gmail.com>
X-Gm-Features: AcwNN1UeX_tHY_zGLACot_ynQRVuzMQ5hoKZFPwjcrfLfwgwmaAT5NZ4wqS9wQ0
Message-ID: <CAMuHMdW1gcLybr06anojAeym-Y8ogRCavOOfJiiWeJRHrOePtg@mail.gmail.com>
Subject: Re: [PATCH 04/10] soc: renesas: Enable SYSC driver for r8a774a3
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
> Select SYSC_R8A774A3 config option if ARCH_R8A774A3 is enabled
> so that System Controller driver is enabled on Renesas RZ/G2M v3.0 SoC.
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
