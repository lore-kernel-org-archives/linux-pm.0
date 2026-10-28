Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181214;
	b=U4zsG4wUcJY31jivEpkhhwZ64jmoS/E13ocarepZgj1HoN67ESm2BktIgFT352l7nmL6
	 Q2BBDuqabMIYMN3Gfxx9Dn5zEdLRLhBYfrSFFiUdUlJP6MAu8/eJQF1tdS1MZcL1JdkN9
	 UapHbF8hpWfCD71P6TBnD3CIBaas3yVY2+/nWBZ8CHk5Wpajy6kQ89sgOBuMaRUunTDCc
	 Pg538/5aeJ29oX/8bblNSpQ7xJH5tdx2Fd3PrTYZbz9sTTCkCkZPjebWzCK78Oq2d8V1n
	 Rt4DPOSYLLJBFLJzC4kp00UOmLckE2aSR+HKNg+0vMfl9tRQTwTnf8cfELqhKj9kJzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181214;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LaKKgg7JsBllMMsQkIPVI3Ax0Bcgu+KbcncA6nhcHSA=;
	b=2EwpBT6elKUBH9R/pLK/MMu2cfZ99RQ8XBdtrLFPh1atZMTsBa2tlb7C++1+gqdLcBO5
	 yF9i2Ec6mQRvCmWZHAVPKLNby4gwMw7S4vG2XxaLhQFu47OzG690zv3SbCdSSw1XBNqcy
	 BhwvcRCw6wo0KAeESVAgCZFS0NOwOm37b3QoYnRVr4DVenkmWd9mHCAnPhD7mVz0yvwMF
	 1IHWwdrH23GSeQgfLaQ0cEVy8ePVSZNUpw95Qpp7PF76iE00hcy6q09OL4Ihjyf26qu4d
	 r9oIxirqTlGUKvtRtdLmifBL37ROH2Lj4wps+mdHRW04Rkz/gdYZ26QoPXaYmoAVOCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACC606A327
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ACC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9912c61b8b8so440417241.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181213; x=1793786013;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LaKKgg7JsBllMMsQkIPVI3Ax0Bcgu+KbcncA6nhcHSA=;
        b=xwnEYcU2hDGhUz4KMKcbTj2r7MJ9hO3P9dt1W5y22KArOhMFREXTW6rFjE7XiukURd
         vkpJYtfRLzpdmuGijvc1ati+i6cXAc9jm6f/AdwvrcLVYy0p2LnFXCD6FsxS4DVnsEqk
         AeUqOB2YDWr9RqGZgXJ2m8NqPmhaccKS+i3koHy1opJFHGIa3VZkBWLvF5KpJRbBarUc
         MzuVNcc3UMmrhCTyBgU+Y3RtlEh5WeEOIkJJK7IFREqX4YqLNEKRKFbaipDvMHQK7Eeg
         yOvPk/dXEc0qx3xe/NGLli70KnkP2XVQWPQb1TnnPqpMuukp5Bo8JXeBkE2ptOKeO2U/
         DMGg==
X-Forwarded-Encrypted: i=1; AKwUvByGdSk/q5ixiJhsSAfwml/qAhiCj+M+FWSizrDSfGHE/PsgkzZX93Knm9KP01sEcuZGCvYiizhVNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJNwDh99ZLUcqhLxP9f0+vvc7uyP/m/naeLZWx0s29tftBxkFMd
	rWSCSjVB9sy/0JN2wrX07DtCukJEPB5aCJdLCytbK/Dqjmn/8EMtpE2jlKadx9lM
X-Gm-Gg: AYBFou0Lnl2z1D8V/Agq5/Ka1hH2c/LKePSlp5n1M6jVd5uSaJpezAqrlrAawzIH47D
	BbqocSVu0r6WoCAkcDZr4mIY8VC/6GG54AT3vKEnaVhO55hdYIXZbjauX6EOhqrhd28YpkrMLa+
	0widAbqfzBl77ebLZlrfLvuRdKrrwS4paeEE92gomKKTSvFW5bukOsjax9QzO/cuAqi75Kwzh3a
	nFeN+qm0cIVWPIbEscVt27R9SURaEq6Kk369G3xsYGJNlbZFJowRHGu12Zxq7rBEtCfyisXl1Ks
	3D4rI3tSmyXaABYhcMwrAtNbQFnyohilgn7ML1fDuY2iTfhs6ncYFuDZp9NE0LzB+bSiZpHxNGS
	bxKyKAtgs660mhUOURNtt2dA3r44RUfO8p8QA/SozuQ/4DAUNHWSYCTwp8t5KbegvA/JwDgUkqx
	4zBn3uD/YU1sLOjoX5fVLpzbEIuXPvvWo9PihsmVto98lX5kIKepEXr47f9oxFSE2Ik6KNpFx+J
	j9BhZCL96R5Lfqo29RCGI8Cin2mzSiQkLsuYVE2kp41oJyQrQcGMA2t7EAh+Ca838ICHK3Ml/OS
	Vm1Yt3xZxxxnwYszaI5Az5KL1padOuumE9Mh+9UoY1RsgKMIu/nVqKnCI13VskFKC0Y=
X-Received: by 2002:a05:6102:3c83:b0:7c3:7286:c291 with SMTP id ada2fe7eead31-7d03a4846c0mr741350137.19.1793181212957;
        Wed, 28 Oct 2026 02:53:32 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259c5b23sm5473330241.4.2026.10.28.02.53.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:53:32 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99075306daaso423835241.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:53:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuWav0gJW4i6lnoRxUEuGPNo+D3FQHQg7jeYW9JF5rGxon/KOAV7OUhT0WlZDBrtYNGiqpVYf/rw==@vger.kernel.org
X-Received: by 2002:a05:6102:5244:b0:7cc:2fd1:7122 with SMTP id
 ada2fe7eead31-7d03a47e768mr803872137.18.1793181210633; Wed, 28 Oct 2026
 02:53:30 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792776697.git.geert+renesas@glider.be> <528b079a19bd4043754bfb56db8e5950bdda62f6.1792776697.git.geert+renesas@glider.be>
 <CAMRc=MdH37DhKMtagN3Ua1doY7ZgD3f+ok3V+h86kb4J8-dtQQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdH37DhKMtagN3Ua1doY7ZgD3f+ok3V+h86kb4J8-dtQQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Oct 2026 10:53:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=ZkOsjG_FF-raMJWEUtj0VkD=9Gs0SsWKWLwyhG5H_A@mail.gmail.com>
X-Gm-Features: AclHuK9BGkRKGrsUq56mu96OMIK1DMZBGsGDXPyfwPmkMrcZVroZETBYHJfP3k4
Message-ID: <CAMuHMdU=ZkOsjG_FF-raMJWEUtj0VkD=9Gs0SsWKWLwyhG5H_A@mail.gmail.com>
Subject: Re: [PATCH 1/7] gpio: rcar: Convert to gpiochip_generic_{request,free}()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Wed, 28 Oct 2026 at 10:47, Bartosz Golaszewski <brgl@kernel.org> wrote:
> On Fri, 23 Oct 2026 19:50:39 +0200, Geert Uytterhoeven
> <geert+renesas@glider.be> said:
> > When a gpio device node has no gpio-ranges property,
> > pinctrl_gpio_request() returns -EPROBE_DEFER and its GPIOs are unusable.
> >
> > Restore the ability to use GPIOs before pin control support is added by
> > using the gpiolib helpers instead, which cater for this use case.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This sound like a fix? Can you add the Fixes tag? Is this patch independent

Sort of, but no upstream system needs it, so I don't think it is worth
adding a Fixes tag.
ISTR we used to have GPIO nodes without gpio-ranges on other R-Car
platforms before, when pin control was not yet available, but DTS
history doesn't provide any evidence of that...

> from the rest?

Yes, it can be applied independently.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
