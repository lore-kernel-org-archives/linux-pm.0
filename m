Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85D446067
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534064; cv=none; b=Zk/OdFGt/yLehkejaz67CkywhQJQj0DY2AwELCfQvHsFNFuFvixURCpE9heRdkMzKZ3zWAfz9fU2DOZsIfsCOs4nVPRoztix5xq/aEoVKVNp2WejvsMlCZCgpsY4ReUMufB4jeNu7UKbtrAc+gdYyfGwvqaUSkwg1VHXSAmXFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534064; c=relaxed/simple;
	bh=dxuiJN3F+W/TTKG8/DBhxTqg4U9X29/XkWqF1QF1YkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3D4iT7RV00zaNV7qm5ZISlCaj6ohKr7f/tFJzNh25y+pTDY8y4kEFL7+0YiUHXCy87aqpoBGmYzUuAlwex5KS5CR6AP254li5iWSrJf+gi02ibtuD+qmuRGfHLPkjUFydEA6oCFSlrMY80vwPHJUOj/LPAmk02OuKt+Wv1Yagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso512553e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534062; x=1789138862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bIoiHSllQkJNgmmben61gMxsX8BWtDH0S9evEzpoUUA=;
        b=h8T8hFO0GJwAx6eW2SA3gQGxXVoCwNI6KCsrH4Q0u2dplCrs7JPVH1EiJHF7Q1D0v8
         BZA5Cg/lQRpaXc4Jl2oPSR6YGzPKFPjztwnF39eQBqcti/hmoY1d8PG1J9dnIR/z6Qxy
         aZVdMnk1SYLFQyho09H4qIiYzLy6wm+bGFhBzPCnMjfKplFfb9Wc2mFPXoc6KfhY7yJk
         iW9gvziA2NOaEzk1wU7rKzmp3S+Dywm59BWl1VdO92oPuJPc9Z7oGqOsuStXNIVFcECW
         B4IFM5dSaCQbJd8vZzBh4CLEkxAFy2YgV/6oIT4GggBfvFgLXnH10GDLMTZwsa2TF0ve
         D2FA==
X-Forwarded-Encrypted: i=1; AKwUvByBcjAJVEuoxrCfzukPMG6HKx4iueE87ItGgbsm7yvqzzBO1lYuqrle0ZQ+7AwzHshS5nPZpdAMrg==@vger.kernel.org
X-Gm-Message-State: AFuF++k6J0OeyggIvAfcTfobAUJVg9oM0Ffc9rAFycLv6/ZqcY80PIiz
	Zp1/o5+bTLYafBzGM6caTgga8U38UTo1v1tZ5yJQrmoD9IHQcEhRw2LfEC52x1pH
X-Gm-Gg: AYBFou3wfe7HLkUfvH2oEzlOydTnDeesPXJ/7VBpbdaemrVXZS5JYewwmLdGNQImZe6
	sr06JpW4vTAZ5B3thKuYdRwxyffu1780gqh9jFVeGF0iFB3lmlr3cQN21OS/cgLDcyTPYUpmtsa
	peJMJsHCCQU0jwbG7Eeo8hamDXw3FZkJkqoA0gXN63iXgxZ0WSaAstt+tS2wO47VfrZ+Ja3st/t
	lnKhoDQ61DWbA3l+QErpoLO6qQQiyGKHSivAsdFDxIEURE4zHtw9ZGdXqqnTcGI5BKr3lbnwBf6
	h/ORInIPUD2xQkhJQLSzlQtAl8H2a9ZY+IbfAfV7i5it/0sYXbXTGDGNOqir+ZOdcX0FzDrlBy6
	A6i9WUI+6Ami0kIJEtCTG68SEuB7PxEIOoW5ojeH2w5laVITS0qp/esXoZVePqZRS3d55jk3ckU
	kFbNyUs7BPWy1ekZTJvPr1jBvKkRrTb6Cmj3I171bXEcLhkLswgMCWDYAnCxf9aCB8lMn8a2xnK
	wG6t2JMHCNlm2JgsJL7maXsfJkU6Q==
X-Received: by 2002:a05:6122:da0:b0:5c7:ae9a:a056 with SMTP id 71dfb90a1353d-5c7ed457809mr2515629e0c.8.1788534056732;
        Fri, 04 Sep 2026 08:00:56 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec23d459sm2225155e0c.9.2026.09.04.08.00.55
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:00:55 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c65d654c23so470845e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:00:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKiXWqyukRWFt9O1C4ZE679JbzWT7jnHFHEm1BSLW6n+ITR5R/NktLVd7zdGGeaiiByf/IhRAEEQ==@vger.kernel.org
X-Received: by 2002:a05:6122:8f8d:b0:5c3:61c2:9ec6 with SMTP id
 71dfb90a1353d-5c7ed456d8bmr2814332e0c.7.1788534054755; Fri, 04 Sep 2026
 08:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:00:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkkKnEsCKTcNMyr-WMvp7o5++Yg3rPR2f4wao=-weRoQ@mail.gmail.com>
X-Gm-Features: AcwNN1XGMcfTKgzVCocL_OQ77Hbdu56w54bgvUPYdeBOHMixmFG2F9qVHqoWoGg
Message-ID: <CAMuHMdWkkKnEsCKTcNMyr-WMvp7o5++Yg3rPR2f4wao=-weRoQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain definitions
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

Hi Ayman,

On Fri, 21 Aug 2026 at 17:05, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> This patch adds power domain indices for the Renesas RZ/G2M v3.0
> (a.k.a. R8A774A3) SoC.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/power/r8a774a3-sysc.h

renesas,r8a774a3-sysc.h

> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2026 Renesas Electronics Corp.
> + */
> +#ifndef __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
> +#define __DT_BINDINGS_POWER_R8A774A3_SYSC_H__

[...]

> +#endif /* __DT_BINDINGS_POWER_R8A774A3_SYSC_H__ */

__DT_BINDINGS_POWER_RENESAS_R8A774A3_SYSC_H__

With the vendor prefixes added:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
