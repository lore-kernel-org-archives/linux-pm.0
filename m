Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD3404BDD
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592965; cv=none; b=qIGlcjoZ98N7fAUNmm+rTCpfVqjVS+UJY17qMNtiP30y8c7atiem5ccYtQ8c3hWCLchKRKAFG9cUxYFGdYV9SWZ2HiNUpod12Fxq8G96uO1d5AF6m535mupPXuYc2idSubMw6R/uC+J75TL08DRTufGynY60wcF0iW2La5iipco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592965; c=relaxed/simple;
	bh=SGuHeYTcGstwO5n9DDhvCGTcKVnams+042+BkbBAGTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKFmX/2UCsufdlJ+P0lnen9w/RukMJGKgy6tB3X4mqqsOOeVOJmAHlbR0SjZzqsjvDkOsawCPXPlNh2ANNgfahK8Flf3pR7Ti+kkwb29f+7nBbTA50o21nMX3vUv0JfYNrnQLwycpKtXbbVBniLwNUsaFRviDL15JWo4VOqpU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-738bd0b7960so1531899137.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592963; x=1784197763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZamOEqvf20g5QpO72EPkaDRuNkZPExK+6Unu2WZF2DI=;
        b=VFkNwi9EyjFpSNysJuN99dIZ+bDfmyNezkjE3IDl2Gm6jJcfBTUsmEUB5c/JTUsKnB
         GKtGgoPyqTHWU4BCKlU0y9+zyeOG+9xKrebTXpT62IMnSUDOf/WVt3hTSipqRVJ5tgwE
         hdjo/wPCruVUPX3vQcMIZ1sQ32XhyhiLPFS2m8YpDnJ85BQzbI5awkG0A3DoDXPcD7U6
         cBDe/ws1i8RLz4eB1WG6gt5SUGV3td9qPuvZE6HhYAUk/5sKf/y0hl9jug5LBVZoFPtS
         tOHcH00Fqg5vp75PfhyOHJ9vqez7mPdC0ys2WmwCt7IHtDxV8sSbOEGWYqe9jarTMI2B
         eRZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rraw5vrbZsmnLUkCDjiUx5y/ULQokHrK6dC/PhK46BoD2ipaERMjtE9HZFCx048/+0Xufe7iN3pIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhhbIGxqa9EQosiaffP+hhu3omHpgpjju8L19o+wV+CEiZFZ4
	xqk7dvjcsnVi79jxOTvEfIFTSFjdbcCZA+H59k/yNI5MrRy1oJMwGEiPuCydi7vM/jU=
X-Gm-Gg: AfdE7ckPUjuxKv2iWmIlBgtWh4CUdpMDQ49t9iMjIYNLVnqXq/TGKjm81SzdcxmhTVf
	bmMQCqnD7Rnu2K/kIP9QxT5FNe5uQDe1mklcjKa5Fqf2C390sSskcEWBcFCI8wrJSHHCdcATcLQ
	tXjDlGOtTK8AcB8d4iC3CD+4jWzlvuNKtMKpKDRJ0WicpWXm2vS3/69gYCdCHlEn6rro5EsMA/O
	uLk1VTLqCSTRjs5jJMF0sRjnsU2tuag+rjtOIm0toTPeTfgq4dG31GN+nJ1Wlb+f1bmcvRdCq0X
	u+dK4MQT55miSo+N1jXhQMZxy4kHOAtnnuh5vKbcZJ6sRJqq+QWv2g5VnMZrbauU/sD0T14z18U
	PoK8OV0XhYMZLvENUHbmXSxAkk/gPHP2ZKy4buF8lRHMrOV2P/COBP0ArfbXxJ/pv9YZvscwky0
	iWucV8l7B6A4OboWD8ZTzqJYFdfqeD5B2c/fO2KV/iWoqTx22qE3dhfA==
X-Received: by 2002:a05:6102:5814:b0:73e:9fae:583c with SMTP id ada2fe7eead31-744e01be793mr3791438137.18.1783592963246;
        Thu, 09 Jul 2026 03:29:23 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed3186d3esm2772164241.6.2026.07.09.03.29.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:29:21 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bdb162ee53so1192015e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrpNGwRk34hAR7t8PzOWNnqpeAFICt5l10B+YLI/9Q/e2GKt7aTUXJz+kSOADCFSfly7zlf2ZyGsw==@vger.kernel.org
X-Received: by 2002:a05:6122:16a2:b0:5bd:9d27:1ded with SMTP id
 71dfb90a1353d-5bf75d09a7dmr3522535e0c.3.1783592960849; Thu, 09 Jul 2026
 03:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
 <a069d50d-030d-4189-ae9d-37f989829da4@mailbox.org>
In-Reply-To: <a069d50d-030d-4189-ae9d-37f989829da4@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 12:29:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCXVYtN+jykp3Uz4tBHpWwW488=NguxSpWkYkO63BB3w@mail.gmail.com>
X-Gm-Features: AUfX_mxryCBg0UJms9GxmXbM4sVe50wH12jLcYc8l3gBc8Xa9jNslCUWm3ZIyfc
Message-ID: <CAMuHMdWCXVYtN+jykp3Uz4tBHpWwW488=NguxSpWkYkO63BB3w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 8 Jul 2026 at 23:55, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -358,6 +358,7 @@ config ARCH_R8A78000
> >       default y if ARCH_RENESAS
> >       default ARCH_RENESAS
>
> I know this ^ is not related to this patch, but is the "default y" and
> "default ARCH_RENESAS" above valid ? I can find exactly one such use of
> Kconfig in the tree.

Thanks, both are valid, but sort of duplicates.
I will send a patch to drop the latter, and restore consistency.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
