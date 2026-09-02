Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE53B42CB
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333060; cv=none; b=tHEri4K4BO6SHpEvLJQUvqcXN7nLsreu2iH/EUkYkgQe8px07cd7/TWWS3yFKVsg7IwZg9GfXqDe1lSay4C+cDTns+OiBpmaTOUBYn03jpzP9TIWbpZ9FSgxv5So0feXeBsNn5os93iUYSlriy6Vn9rFXlfV+UMnAMAS563pGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333060; c=relaxed/simple;
	bh=fzWNt8m6dV7XJ26M3vj5sYnnsx+91P3uMd2jJYIJ1HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV3xNnbpRH2nAv+cx+sZQhJN+BWt6FNq4G2/PSPth7jpmQRe4BWD9Kiyd2uIHM/2wyHs9I64VPBljK4MzPin8H91RztlK1hdV8IYYYXYFqpgTadiVKgfTLqy8V0qAc35p0Uo8Z26eh0mlABFd6WBUrKBk4bnkqSdEXMFg5GglQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c67175d176so379266e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 00:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788333057; x=1788937857;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S6z6L7vVC/89R/jl0HvM4yW8bp8VIuMDT6yh78Uqavs=;
        b=LwgNmMJ1JfxX9GITK3NVoCwby7+mBzqTFXQVLeuKIv2T+WjfKNyD7s4eN0TYbs1h5/
         xHwnqok+lrt/pCK018cxcC7EDQ5axMx/69vVm2UyS7IQhpne4JKASUcPgHpB7X6ceLC4
         el5f0IgYJwzs6iyp+foGPCRiUN5t+Tlt+lkFEbKZoY8FaKjxMp1kXPw8ywJ3lzYW3+Oj
         Qkj+5VBl+ld4HRN9tJVMFLx1kjUZ5NPhDCCJFzaWN7D1IU79WEc1h5ellSZVsUx/dk6l
         yFaooMDO483IUki78x45dmrju5QFgxwIEBqNqWMckW7kFuK2n/cXYDmsMxE8sGOle01c
         bZHw==
X-Forwarded-Encrypted: i=1; AKwUvBzuN7yxQwHb1rXgvo3kVNOvPrAdaJ4edYip0vOOiyI1dnVB0Ys3lwj1zsnPNx4W6SlQerzUdkzJNA==@vger.kernel.org
X-Gm-Message-State: AFuF++nnr7OzDHV4vf7s9LkJR8CjFH1rYlTDOUb6fT1P/rx63IzKlf8O
	uAU57L9wnH6ZZ7/5yJWIiu1u8Y/DSa1j5M0eRZ5uiwh/IkIKm1Q+DnoTjx8fdSom
X-Gm-Gg: AYBFou12GMrjYu2aDTNV4HO+oHdf6Xqquz/81PqfZFdNRH2AkzqOJ6uk47F2bkSuOp3
	ix1NlJH/OILMDc19AwuOfjw7NqGun3ly2jMwbfLpoPE8Bkj9Ytqm/DGb+JpxQEITvDbbnEaW1ai
	RMglD+kOSP9Gn5Uf+7DUBkFb6ryunsDI0Wm8B1rV5S6qdvUsnovMihNUo3CQxoh/iXd/ub/lw6F
	4VKteA9dtyPA0Bfat8IrslILxdY8vcSvQ+1U4r/bYA92zEnwstWIZeCjlar/T7KRcaaTpAVOnTi
	6APW5CEe3JLp4uBrXA0Mq4f/iyDEeVp6eNSqyJgWqRr7IJvzm9B+EcL16VPTK5s7mo1jA0/Fb1N
	RKwEZwA1n3KpgYeWrcajzP6a3pris6dXqRa4aBBTPX0X2eCUe211QisDPkwDvvWu5fzSFRYr1iA
	nQGlYLgrNz+S/vpAswZN+m1jYV/y6Pvd7Czh6Bfb9lUu7UYBYliTvErLjsiR4yx0TPLFLxBDHjX
	24MqP+rGNTJSVli7QY4mQgV4Q==
X-Received: by 2002:a05:6102:14a5:b0:784:94dd:5389 with SMTP id ada2fe7eead31-78a1f3954bfmr783010137.13.1788333057603;
        Wed, 02 Sep 2026 00:10:57 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a20782asm1484603137.1.2026.09.02.00.10.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:10:56 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-782e0fc1e55so319124137.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 00:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxanWFJ9eDHH6o4U8ZiLrtkzMxpzkKZmsTz3vpJsiMohu8Asd8Vq7TImnWEhJYIHk6sF13RoGzoLQ==@vger.kernel.org
X-Received: by 2002:a05:6102:38c6:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78a1f1c3849mr970255137.4.1788333056097; Wed, 02 Sep 2026
 00:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
 <20260826122742.153643-4-biju.das.jz@bp.renesas.com> <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 09:10:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmn7B_UOb8f2j0_BOx3d55nA0-0Auay-HLFYWtziS+6Q@mail.gmail.com>
X-Gm-Features: AcwNN1Wg6VVOr5E8CpOD13jdheZdgLtuCw94APvhRsqrd_GzRtCymguaJxx7oSs
Message-ID: <CAMuHMdXmn7B_UOb8f2j0_BOx3d55nA0-0Auay-HLFYWtziS+6Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Tue, 1 Sept 2026 at 18:15, Bartosz Golaszewski <brgl@kernel.org> wrote:
> On Wed, 26 Aug 2026 14:27:25 +0200, Biju <biju.das.au@gmail.com> said:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> > which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> > SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> > using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> > {usb,dsi,csi}-pwrrdy pwrseq targets.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> What is the merge strategy here? Are patches 2 and 3 independent from 1 and 4
> at build time?

I think so: one can safely select a non-existing symbol in Kconfig.

So once you're happy with this patch, I can take patches 1 and 4
through renesas-devel.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
