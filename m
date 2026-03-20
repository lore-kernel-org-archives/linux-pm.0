Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B02E266C
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999439; cv=none; b=QegQzgj37G+KUtDQ4Ku9Z2u8b3WtHC0dRrhhn+hzqDWu9AOoZrkpHpgIBSgsvUMjzYJHzzx81bGZTUC4PF8rTpITr/xXhSw0H43203ryQWfXNs4CwjmgQyunki1CONQ7gTLXWMGlEYD3ab0nP3JTulm90OqULFvajLG5SqZdsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999439; c=relaxed/simple;
	bh=OnWjqKpMxVfnZWeaFobxoRZpf7uh+VJc9UOJGP0nSMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbTE8XpKgRkJrIVEHcVLdfk2h86E3x024eK8jKB/8It8tHELgDKrPwjiu4hS5AhYLEpDm6NZrk+Y67xcw9ohJVS8PhQGB3cD4o6X197tq+okOyuq2mmGzG5G+M/xCC51+aDCQaHzh+ghdOJcPZ+qbxy9XcUsk1WiEBJjfNfpLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so1265208e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999438; x=1774604238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=043aRu80oNzZpDNLQsr22bQjNBOCbJEW+dvHRdFYP0s=;
        b=DagtbdBDPh7pSMB3nIrubLgoqkZ1GcFWo9ULFhaz1TVZKl6+oi6HGeOeCFXSpZxm5Q
         QwbqY8zqMrV3kQ4KzP2aV2VjWWOzHj/rGjIRlv4osiPeiQoIe0gAn1ojNQD4fPZ+FVSp
         lRgaivENe9ktt6ISzZWi67xoWYOZz6gLhWXDNoBlCufZEfOxYvghmZs7z52wHXbfzYFG
         48Vt1CK3qa+7Nlk22HrwslINXlzYpYYga7KOXwyptax91JgbZQDjDW67g5lM+XxDERHJ
         ybbIJckJOkiPR9ufbcWrk5Ykf1UzpTocQmDmvxOQx0kEAnBqc3jgWm97A5JHcc3MbW3h
         aoww==
X-Forwarded-Encrypted: i=1; AJvYcCWEifgEPbvWsAkoQ3fCOt8ZZnr2jrod/bsnvQJWeaksMynpTnxwZLBlZvK25ukMwBAmwHGV10Jteg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75GTK7Bhmq7LeiK80H1vnuzPhUTA1YP5g+YfF/fNcRJXXFqHa
	KTQl5Cp/lGoosIY8WV7knyiZki5pDrBBWVPqmhFB5XHSBGHfwl+awqlZI5rigaG/TAs=
X-Gm-Gg: ATEYQzybVSZ05oXGgUXstV8jHFEWI4CzT7RaW6EVFDuOQWa899akIx+hsgrwAbtkz2n
	mhGkU+4udgw5N5P0RfRS2a2pNoDOeSig+3Sv94VeWCSZIbQmesBy4mYklh9e5Mr1lyS0aHpJ3OP
	KEyJE6rO9ESMNBqln9l//9O7ATjgAdNiaChFkEVN4ni8jXd0Nn8IFGw5FBUQ+/ecOcrnzfRCO9H
	kcfUkN1ONcVjAYq/bbf+kwM/wumpPDgTwhN+D2CgxoO0f/6Jf97LVHMcy/Op2Nk6Qs7bN4maBMW
	Qontq/aCNj3vBtROAXmoTT2LDnBveavV9iCpowXSwDyKTdZoKbVNjazni5/2sF75TBURdA82IGx
	QxfvMFqwyvjWGHdgshkGujg6rDJbZk6pfVvQphKpPzs1roU/BV5MNnJmAq0mkOkRniqgn7Smw5S
	MANl6ja6UZVh5G+FD6zXjl7qMec4+pj/SvgLyuQJD+hYQXlZ2+UC4hDcjWrS5TZQLx
X-Received: by 2002:a05:6122:45a3:b0:56b:75cd:ec27 with SMTP id 71dfb90a1353d-56cddda1e24mr1241730e0c.0.1773999437619;
        Fri, 20 Mar 2026 02:37:17 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcb1179sm1225174e0c.14.2026.03.20.02.37.16
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:37:16 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56ccdd0044dso1325245e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUReH8B4X0aWj9aSsJbkWN69Ir5ft0ePo8mmah3FqfjobWrkuisOGdh/XhAmkLWM/dyDLZmqU8Rvw==@vger.kernel.org
X-Received: by 2002:a05:6102:e08:b0:5ff:ecd0:1d1f with SMTP id
 ada2fe7eead31-60295fbd13emr3475496137.19.1773999436473; Fri, 20 Mar 2026
 02:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <20260303132305.438657-10-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-10-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:37:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK+xePxZc-OXRfDmvQ1v4q5d=HQ9c9aNqUg7gPAMxUAA@mail.gmail.com>
X-Gm-Features: AaiRm53dJdS28UgcJSslHTg92ZueMj8wSzmPzodj_bB6ak0ZjTNGpHHyRikIKcw
Message-ID: <CAMuHMdUK+xePxZc-OXRfDmvQ1v4q5d=HQ9c9aNqUg7gPAMxUAA@mail.gmail.com>
Subject: Re: [PATCH 9/9] pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
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

Thanks for your patch!

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Due to the new fine grained sync_state support for onecell genpd provider
> drivers, we should no longer need use the legacy behaviour. Therefore,
> let's drop GENPD_FLAG_NO_STAY_ON.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Rmobile-sysc is not a onecell provider, and thus never needed this flag.
Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
