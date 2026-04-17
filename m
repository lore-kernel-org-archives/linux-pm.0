Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBD34B1A6
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412554; cv=none; b=rlmq1+ptfmo5MEhppXDvKkoKMDr0bfqhgBlgpCk58znOAAj4bHKrVvz60yMhpXFwX7R8SYpUQcj19o66Ah4Q1Xa+o1vhvcubspt5grFN347Wnon99ERdT62N187ajjfCPWrmUDbuoqEZjCAZEoFLUCiN2Ldq8TzNK3REBCD4U3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412554; c=relaxed/simple;
	bh=JNeksg9S+lB98sqZfvaiYvzh63QDCtUQjEt4efnJmzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKPr22+iqfQfba3IbWEJaO2fMiwDkEEVvW5u2+2VWLt4oLKh6NFTX4Q0WE7YBu8QatezdIDdfQH6NWrNkZ9kwZ0E7mCG9Gjcc36vW/QRujSfyrUy4hsMsgdxoeDxwmOarmZKwsK/sRYZoC26xVdvr1f5vvSdBEtQZ2V6X9cXD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d93355337so292062e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 00:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776412552; x=1777017352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYGvKR169qobRnTdQfak1Kyzy8QQtDe/iStEp2kI73Y=;
        b=cuT0YlCw91aVqMp9eyGRevujbcBjukwwMoa/8ZHy5hdMcY/PBkgJ3eeyXc/1djabg0
         Kq4iKt3bvHWztGZO5Bs6vT3XqmSWa24d25Yn+iRKaeU1/p31Z95yAXWixk2OgCD35cRE
         7LalNI8F4OTNMo1h4idV8wOwEyDbN6K01TEM8kM1VbLrjwtwLFrNbENms9M9i9dRt7qX
         3VtAJFHD+Qin6u7cJMA9znlXqihMQfmi/fLrT8BR+koACSeZTHCH8d0JPG352InDbqtu
         DMl+XMIe6Svy2O2XCZt1JF8XXs1jF9IODujWHhx3BPP/NtOLUBTZSPSXC5h5Tm1YiFuK
         nysQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QLriIb5orWFXZu07lRWoqPpoPBbFnXRO6a75Qzeb5k+tSrSug7evLcVh7Iixli5ga3dIjOoAXQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iYqwLPZkXPqFmOqoGZ+u4J0v4bVNQpqDTTr4MoRqLko8oj8D
	mMPrenvLF/oAkCCbSnzHmNiWpbHB6laQGSLQUzJjya2Kq9WnPxv4AyuUt7dGTJSo
X-Gm-Gg: AeBDiet92KGFF9rpMxebhuzquFiSkIPGkCuvgB5tLR4viFiHruWCjZRK2wjaxHz/Mj0
	8In9Sr+GCSUKStiQxTohmAL4kK2Ns/wrJz8uCq2s6msygYCNe+VFnTHvTB+aZvyPs6u1e6rVyjj
	+lgSlPOmDrLasKLmGWnoFk8lWnAZjQrtWtRayyRKi2YSxOYZjzwlyKMqsTeuwL7Ys2Bi7aByk+M
	WOuQa3bfDo3Hd6/ECTTUz/Zkf3vz/cxAu7rZsXU2rDlymleEn5xkblxmupt9fXPJfwMi1uWmbb5
	ZscCTKX0Z5WYCEUaI1xmzrRKse9CGk3HSjoqwSmNxT47F1E25vflrGKg/CNrxznnkDiTXV59t+T
	duVLPLhZhj/rngsCL45GnaCRaXP8YqrM0XPHupT86Pu1VLoLphEFLvRLmq2pkG7IeBLsHojYGno
	/f37CyLkLalxeuaEY6o5xiTIe2UJZfmtFvl7S072sXpMPhPWE1q/Y64x748fv2wdBsrei+bB4zS
	69s6anAmg==
X-Received: by 2002:a05:6122:90e:b0:56f:6b46:28be with SMTP id 71dfb90a1353d-56fa5931dc6mr767314e0c.8.1776412551598;
        Fri, 17 Apr 2026 00:55:51 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa90335e6sm488989e0c.0.2026.04.17.00.55.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 00:55:51 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9568159ee07so252189241.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 00:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/u+2+/ZWLBR/GSUVMVTDGShH+kIKgphxXeBxKs+0iMx+KyjYYyTmolG5fyQVe9wUs1OOxHeNKM7A==@vger.kernel.org
X-Received: by 2002:a05:6102:4a84:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-616f4b50373mr742219137.3.1776412551117; Fri, 17 Apr 2026
 00:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416131810.3116408-1-thierry.reding@kernel.org> <aeEm5DavehkPmSgl@darkstar.musicnaut.iki.fi>
In-Reply-To: <aeEm5DavehkPmSgl@darkstar.musicnaut.iki.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2026 09:55:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxkOeAZqPsVRecOmQV+n=+ey=nFcdduiXvs9LBj-nNQQ@mail.gmail.com>
X-Gm-Features: AQROBzAxAj1dJZMvY5l2s199UA8tSOX5OgUQyonlFdS__wBHgEBXO25Dv2sGHpo
Message-ID: <CAMuHMdVxkOeAZqPsVRecOmQV+n=+ey=nFcdduiXvs9LBj-nNQQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Peter De Schrijver to CREDITS
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 20:14, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Thu, Apr 16, 2026 at 03:18:10PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Peter sadly passed away a while back. Paul did a much better job at
> > finding the right words to mourn this loss than I ever could, so I will
> > leave this link here:
> >
> >   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
> >
> > Co-developed-by: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Thanks for doing this. I think also the m68k work should be mentioned?

Indeed: Apollo Domain workstations, and Ariadne and Hydra Amiga
Ethernet.

Also: IBM PS/2, Microchannel, and Token Ring support.

Peter is also still listed as the contact info in
Documentation/ABI/testing/sysfs-driver-tegra-fuse
and as DT bindings maintainer in
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

Thanks!

> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -3645,7 +3645,13 @@ D: Macintosh IDE Driver
> >
> >  N: Peter De Schrijver
> >  E: stud11@cc4.kuleuven.ac.be
> > +E: p2@mind.be
> > +E: peter.de-schrijver@nokia.com
> > +E: pdeschrijver@nvidia.com
> > +E: p2@psychaos.be
> >  D: Mitsumi CD-ROM driver patches March version
> > +D: OMAP power management
> > +D: NVIDIA Tegra clock and BPMP drivers, among many other things
> >  S: Molenbaan 29
> >  S: B2240 Zandhoven
> >  S: Belgium
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ef978bfca514..ffe20d770249 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26145,7 +26145,6 @@ T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
> >  N:   [^a-z]tegra
> >
> >  TEGRA CLOCK DRIVER
> > -M:   Peter De Schrijver <pdeschrijver@nvidia.com>
> >  M:   Prashant Gaikwad <pgaikwad@nvidia.com>
> >  S:   Supported
> >  F:   drivers/clk/tegra/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
