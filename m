Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FA2E8B64
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999559; cv=none; b=AjbedC1BLy0dSZvHeO9cMvgIQnxRmb2Zk8rLtZYx9To1IuhFXR+bV4NyshRBCtvqKDZx6bFMGyqgYvUuVApuHXxn2VbenzUTaeuAzcxbrxEXYfAONqVjiJAvGCCVXDZFthkNAZ/hRnp/4Rbysla/M0YseIM6uoZNUk+uuPbOek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999559; c=relaxed/simple;
	bh=osFaQ1MKQQQDJVAXjPfwmMeev9LJHqW9jkw8l3zouec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvr/vCNThxe1MHXB0DzeDn2LG1RF3HFF1RFMvATKuModDHG3Ca7uqpfGjLqybq2dy9TPbUK5EYJWX5SUVfi6QJpceJYKGuNry911yEyqSHuxL/6mwqiLhK2sJrxHevSTpY/DivbAekdu2O46wdR1yQD67EEtkP3vv5Ams3/biaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so854850241.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999557; x=1774604357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAm2bmEp+JAg2qfDtNL07kuDx1TZE+b0/OOYKhnw49U=;
        b=f8ORB4bjdFQ+6Q7qED87j+TEDlZKvUAKdcWFrKlJ3mJbIcj699O0/aUz/KWWG1ub6u
         dRukS1VddRj5UF4KwKRM9km4G2PzGjyFh7KoQby/en9z4DVUgqwqogch8Md+SDuV0qLI
         F5c9QBwNbgCC7VNg2KMpsfzjgESX+j2oazDZ6vOwdxuq2EFjp1aDBl0t/uT5cBDgUCY9
         oz8b2wxqS6lfEaDuTMHZYHRYdsQ6R5BMSdZYUa3mGQMRcmffACzvWenkho/rJhnQ/UqX
         nHsGvDeVOFtCsJSppoi6KWVN1Hp8qJwUWgnr/wD0KKtfc6A+aishJBHh95Nb1sT4ylhL
         jd5w==
X-Forwarded-Encrypted: i=1; AJvYcCWkH5BUD67Q1k1lX4gaFuoNP65y5TkJWMU5alItKAWH8ui5DOoU0zHT2tkF9PnOo4O14lggnLEylw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmxrrTEHcFOtjcmdV96vsPWHPppiU6oJ/Dc38jYoIy+5OQeOd
	63/cP0NSwdkK1kRzhvDf2aShFqWEj3vRW/nJlme0wWxiZzkERBqLFMGqRpOxPZVWaVw=
X-Gm-Gg: ATEYQzzijuCs4Vw9PWPuyxs86Y6BAc/+O/RH2hVX+648BTd647V7sSUnzcXUNXhDPET
	dPBr8XTSdP0oQSA5fz19TlJpVD+e1tBGIop2M9f4H6+cVX8YmDzCIJRZfWt0w6Fck7oZA+tcqTJ
	XCbba4/Ay7EZEFKm0S0+r1uFOHSbrA31EBuVG9RCZouQ0tpxzldCatnlU/led6pq5rIWQD9fUlp
	yYsFIcroVKMnivf0HzXR2BD/d2YAnGI/gc7UMRIrFaOW/lhYd5LdDNlgPT38ArWYBgrepHrForg
	shROrdLWMqLONT35OhOuX/5C5fy82Nv5b8v7Bqr98o0oC0SfK1JYWEVkBpWmfnWxDWSha5Flg87
	1V6hqEyArUfRLiupxMpnTaZX80qXEsZPUBGnzsoN6LJMaC17y0M1tL1GbY2dvUXfIlO3iUfFMl7
	XBRWHfA3tP2oatopcSGufI55OOHqo8OxvDUbl0j1HBTZbY3toujZMSSXbzqluS8N+x97o7yzg=
X-Received: by 2002:a05:6102:579a:b0:5ff:dabc:db3c with SMTP id ada2fe7eead31-602aed9a2e6mr1253539137.33.1773999557235;
        Fri, 20 Mar 2026 02:39:17 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-602af853b1dsm936500137.2.2026.03.20.02.39.16
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:39:16 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so854839241.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTFkqAXUehSD6jii1QMIjTJk1dScxQlMX7wVj1f3Qy26QsJVVupkxmD0cLdMIPvoga8Cs8rzvzGw==@vger.kernel.org
X-Received: by 2002:a05:6102:508d:b0:5fe:af0c:79f5 with SMTP id
 ada2fe7eead31-602aea8c68dmr1453044137.5.1773999556502; Fri, 20 Mar 2026
 02:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:39:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJEHU9aBO-b7LAPbpiQA01uqj1s_cqTD8WVg+n+tWQJg@mail.gmail.com>
X-Gm-Features: AaiRm51rurRvs8htKwZeARKRHyof35mEZc1epCRF91aoxz-Fdur6_Mz5Vy-LZAw
Message-ID: <CAMuHMdXJEHU9aBO-b7LAPbpiQA01uqj1s_cqTD8WVg+n+tWQJg@mail.gmail.com>
Subject: Re: [PATCH 0/9] driver core / pmdomain: Add support for fined grained sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Since the introduction [1] of the common sync_state support for pmdomains
> (genpd), we have encountered a lot of various interesting problems. In most
> cases the new behaviour of genpd triggered some weird platform specific bugs.
>
> That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
> remaining limitations that we have found for genpd's sync state support. In
> particular, we discussed the problems we have for the so-called onecell power
> domain providers, where a single provider typically provides multiple
> independent power domains, all with their own set of consumers.
>
> In these cases, the generic sync_state mechanism with fw_devlink isn't fine
> grained enough, as we end up waiting for all consumers for all power domains
> before the ->sync_callback gets called for the supplier/provider. In other
> words, we may end up keeping unused power domains powered-on, for no good
> reasons.
>
> The series intends to fix this problem. Please have a look at the commit
> messages for more details.

Thanks for your series!

I gave it a try on various R-Car and R/SH-Mobile platforms, and all
PM Domains are handled fine.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
