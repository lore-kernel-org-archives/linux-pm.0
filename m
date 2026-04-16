Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E29397694
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330941; cv=none; b=r0t56UJjw0eU+jmwWEnO/fSp/3b50I1WLDmJKcnMVprz3FiJiV4yBCM6B87y7r/t3izIOVcmjCpx19dR449g2TUUPCni/z8yeMIYigXSrt26VhiqS87AlRGBzgck4D9EZA6Lek7ckMwMljLSYDmS+66rQXhsDOwAGfgDwlbiXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330941; c=relaxed/simple;
	bh=rLJXeK4hRWaarrm83nX7ulLtTkTvA5gC+mp8lnG07Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMEw4FOVFVKikGsr1yafPUgk7nX/LV0gEAbnju1KEoCrpna7KBD36odFTQRO7EJiGIQQspToQlpV+m4DhmeYSnk5t4LEMGa5GWWVryjUrOJ7oBcNpxThbV1ik+lP/eavNAfBTHJ8bNR+I50vv7tzKdtWzqOwFQlmf8bIgTJmu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-953c5738c03so4561258241.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 02:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330939; x=1776935739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMhoE3dWcYEYFYLFrnzKFs+t80wEaMgHVRqoVG2blDE=;
        b=BSjKqvaRoelhlK3jBwLRD4BSAw3DERX1B40I3b18s9fY1yVSX4SrlMoQYAp1af/1jE
         j3E7oEeYNrzrxwDqr/reZIFj9ihJrgMEuUw4j5t5UkOIrkupAi3Kj4mDs1VDzK9MmxSA
         FTrV2/OR5iKbZ0ILP3GxNiPsSaS71MydnXBcL6JvQ6CImoh3bo6H9BWXN5s2+bXfBjvi
         Ih4JNEBW8hDQIT7xWV0KymXMMvEI2z/ANmSXUXfeEm5YXzBHPMauGUFdiXb4ktqudx6W
         pSBKtyeaYsHs8I3K+QEiz2GAgs7vzRiuzm4EQKQdTU/gr6vHQXJi6hFVri/4tAsqfOgD
         XpEw==
X-Forwarded-Encrypted: i=1; AFNElJ8PPNABSs0Bow7BNTM7pZDQzQaBtWwbISKIxYj462l5BRtjhn5bT2B4fz6ieLq0B16G8+WRjKRvYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BvKVDA7Z6F69aTWZrppeEOE+GgrvzeUO+PixrOO3UOL7TgZf
	dwMwPEAHxLtcK6xoBcXnw3K3MZgsN5Sa2wh+OK0BgibYmMhsfczmumjpSc3f2pxV
X-Gm-Gg: AeBDietk9RmYf5NzHyKscEX4aNU+Ocr2z9ap48f1BB2a+tMSt+W3CeZ6fCvIgYCkDaC
	FWIWEYV80U3OSPQnYXHyj1RZUhwagkV5eO/mPZnZDGa8Dbd+29It5UJrq4lk0+vhz1Cpz5iJuIy
	xkGLrmeEgsXoW5gKSOPHZXrWqaj0pzYURy4EVobe+FWenDoIssLhbKxdNYcRSJXm0riQwr12E6o
	CpyL1qaiNfsPldK4IDFG60hFMGQhWor9YAp9PQOcxiDYcFpIlStdALQR14gIglEsca+4rHmK+uZ
	6JgvoVQtbgGQQtgztbcDSA/8AepXDg5rWa5Kl1uo24QYkHLRiKwsCYhZBH+RjeAo7qJib4blrGp
	w0ZYEZvnrEnIMDSG+9r6wqfHKm1ZQn3iFk5sA0k+hBI8wUlk3BsTL1iW1F5TiCGaRyP4DM84H8m
	Ojq8QcBetwcOPiJfbdXrgaq36Z0pzn/T4IePG3oa+qtPN3AM9SOcnXJ1NCu1iLzjdhl/1/a0I=
X-Received: by 2002:a05:6102:2c87:b0:605:42a8:940f with SMTP id ada2fe7eead31-60a01ea7a65mr13364490137.31.1776330938785;
        Thu, 16 Apr 2026 02:15:38 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-612ccb25056sm2103369137.2.2026.04.16.02.15.37
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 02:15:37 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-953c5738c03so4561234241.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 02:15:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dJpEwf1i/xw5kVXp0Lr16IBpd0ezc+vREgvgZNsveNn/G94navayM1+y5XEpEl5uNseZ7utK0Vg==@vger.kernel.org
X-Received: by 2002:a05:6102:b14:b0:605:6b10:f70b with SMTP id
 ada2fe7eead31-60a01e98c5fmr13021637137.30.1776330936790; Thu, 16 Apr 2026
 02:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 11:15:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWHnANr4R+AW5-xHrm=D4SJLuKVF5mq3PFkbevcTz5qWw@mail.gmail.com>
X-Gm-Features: AQROBzCpQ5QUMxJI8AYAFk1dpzk_2cq3BgCM8ShBxNDhV532ikSOHTjzfwIiEo4
Message-ID: <CAMuHMdWHnANr4R+AW5-xHrm=D4SJLuKVF5mq3PFkbevcTz5qWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core / pmdomain: Add support for fined
 grained sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
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

On Fri, 10 Apr 2026 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
> Note that, onecell power domain providers are very common. It's being used by
> many SoCs/platforms/technologies. To name a few:
> SCMI, Qualcomm, NXP, Mediatek, Renesas, TI, etc.
>
> Anyway, in these cases, the generic sync_state mechanism with fw_devlink isn't
> fine grained enough, as we end up waiting for all consumers for all power
> domains before the ->sync_callback gets called for the supplier/provider. In
> other words, we may end up keeping unused power domains powered-on, for no good
> reasons.
>
> The series intends to fix this problem. Please have a look at the commit
> messages for more details and help review/test!

Thanks for the update!

At first glance, the only real change compared to v1 seems to be
the removal of printing

    pr_info("%s:%s con=%s\n", __func__, dev_name(dev),
            dev_name(consumer));

Right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
