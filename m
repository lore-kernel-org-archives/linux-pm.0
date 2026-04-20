Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1A382F16
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667823; cv=none; b=kjpAbyRqFSUUXygaXVHwxIamys72g8U/8mRd00//ivouTOkLRX9iN4NyjpYNwm6ldLjD/TcCIsaa8pcRQfqpTNAJQGpPKmF5gld21FQ/ZAeUbc2IbegVN6nzIUUQPuSR6+dCAOxx4Vosz5IhVKVEUeRaATdS2Oi35s9cAdHmFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667823; c=relaxed/simple;
	bh=66683rtKBPWrf7C4XTuvMiaBte65Hl+xhzNuAjnDIic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRyom08IdSNH99maXW4/TgqYRuDO4GTmvxpB9piOXvoy72yV5RHvPen6TXrcTG8ANY4TBKecDmCcGq+c6fl4wvCwZQLO1/D0QpkR/yTfWWTh8Kv+OsFP6BfRUrq+eBVQEhMCJEN08pE/9jXl+7FvlW5w59GCAOou5W4ssr4tE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-613207140bfso868692137.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 23:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776667821; x=1777272621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev7Q2PR+MzeC42yfPBg+fufDGNaPf4avnQMcEXwV9q4=;
        b=QqwwtXkGx/ae9XEQ3H974Hqq0f6/FrtP+ehgTImnBJSzrPhuVuiGQu3sTiPCQHwho/
         8s26IEx7KqHYq1Vohz4qQZtDdWp/oZ8gk47JmtTspI4sCKI5uvzOVu0SMPPK33k8VOHz
         uo38DrUyI+tG2T+35ZrJVR9Zu8spXjc67M4z6u75h6ZJ3OM8tgoLCUlJaEo+TZlc4oV6
         xrO3hGWrhr0MjOIe3S+qwMdczXBswsitDj1jL0kNdpe2YOKaiSlZswCUSbojXKNN2Pw1
         h8BfoJWFb7RaPCT91rB+2K/m5bzgtcGfptopwvncV52z7U9oGS2vlF6jTeaCeVZK/U0u
         fo1w==
X-Forwarded-Encrypted: i=1; AFNElJ+4m5r+R/nNvIvImekYGGaMRyuqIW30GSDo4S+ZZtahd8qyjt17KKHQevQDXcuV9H8c28wBpd+NLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0CmPQPNAE02EWG8lakNzuKDZBCVQ4vy6HFCuCiY4Tggxx6Px
	UrHtV7kmEP32c8GvB0bpr3iZmS5T68WKXiPRrd1cWthdk2qfsaua552DRfmvLHvZ
X-Gm-Gg: AeBDieuSQzKsixt/MrSEZ0BOfjOg7ZPtyO9vjCv2fXBjaM1D076004YGdhUciqOdHHn
	NQ8vM7pRl4YtYwatfBPw6zlFJ3nmBzchl7gggHBfYsLWyAlgDgpf2wNw/h/RoLE2vpz6FCQSMob
	jZe6EcRhlD1MdYxGzie/spYmrGW7BdalryPE2gzZqP7zeGVhjVnxnrOtemldGxlPQkKWygPLDXK
	yLKDCFuZvS+rK87XGhqeahGGy6rCuh9Um7U+TdYNpB5w+XCT8jttFWkF/J5nngWBaKrUs0rCzYa
	8JfoABvzG8qEpyxQ2brbHoSdTA3qKPNXQejse1i6lSbxKx9jocuZrNhGTUltNm3XELdrEhBzZJw
	DZqT7OmaBaC33ZVDdBpCWciEjxWZdtxTaRxsc0WIGJNooDMYpLwiyOV5sOXBacKw2B2YtoGlP9V
	ECnkEo+LkLKC15PMGuoOOkJN6Eer6NzIouV4v8qoV/cZ4Ut6KWrilJL/oo6E/iow358NQbBtg=
X-Received: by 2002:a05:6102:a4c:b0:5ff:e769:44bb with SMTP id ada2fe7eead31-616f84983c0mr4300365137.30.1776667820776;
        Sun, 19 Apr 2026 23:50:20 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589097ec5csm4357925241.4.2026.04.19.23.50.18
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 23:50:19 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-613207140bfso868683137.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 23:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/wJihqXbw25voJnyiaFwT4o0+t4wvahVMP87GCzK1+HEETFNeAtlq8ycANbwtaBEFjl/KdCl+JMg==@vger.kernel.org
X-Received: by 2002:a05:6102:6051:b0:60f:7499:9b6b with SMTP id
 ada2fe7eead31-616f859752fmr3673069137.29.1776667818181; Sun, 19 Apr 2026
 23:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
In-Reply-To: <20260417131549.3154534-1-thierry.reding@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 08:50:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
X-Gm-Features: AQROBzDvJRShLyy63Y8y4xm5mUkGqHiHZxGK82_lU0-LEkdWIcvZD7MEx0w1d6U
Message-ID: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thierry,

On Fri, 17 Apr 2026 at 15:15, Thierry Reding <thierry.reding@kernel.org> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Peter sadly passed away a while back. Paul did a much better job at
> finding the right words to mourn this loss than I ever could, so I will
> leave this link here:
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
>
> Co-developed-by: Paul Walmsley <pjw@kernel.org>
> Co-developed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>

   "every Co-developed-by: must be immediately
    followed by a Signed-off-by: of the associated co-author."

https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/submitting-patches.rst#L506

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add more missing entries

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
