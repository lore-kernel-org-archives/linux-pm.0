Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095739A056
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534173; cv=none; b=X/9CvxAPEmZXqGKTXGRAH8Ezm7W8IMCkS8AHv2IU6qEjLMZKUrMYDog/eVK0SnL6c6bP9t2Yer5F7EA7zUKne0mun3PH+EWlUaMXOGmROw/Iasz0U5gbbqKZsL7HN9534VSwvae7WbYC9MdLYBmIohup9R3qURYSfwv4mIRRGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534173; c=relaxed/simple;
	bh=OVpDaLi1lD+Takpp4uvA66C8HI92i7f0cSJulK2KE6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB30yVnPrLIRT5+tE8WTPKZyiYvVOCBnl9Gg8cjaJLMp1+YBeNbjETUowvZFP+YhDRO0ueoGX21Qml1s3q0lb/1KqCPshLI94Bl7Yuozdqw6UJnO7x65o6tJcAMfyO9VUEcxaKNTU24lQsitE8ApEXIuJbtRfN/Dsx6JfB1Rfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9808f46d89eso508586241.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534170; x=1789138970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qjft24L+Kray3Ujvp0X5j4rTQSYixQ6JGAbX73Xi0TU=;
        b=pU+NkwYDqcf+FcUs+9anPrbysM1PGvdUkE/UagOI03cNd7KrcrxkdukLBix5J/UN6b
         sYwdsDxvIxi8yirGYBpyfitKWvxj3dov8n3zmbjqCzowpgTDjJfDGF/urn+XXS1xO6o/
         W0yikb5Efu8KulmyAckxYCWYrw9e+0iCfrmUeLC1xBPaIktpZ51heNDBSrTH2Pojr0GV
         HpagZg26Tte25Mm8asVzw7/APxNaolSmOVHDNf7MHUoTWd49csAxKGgS8s5OK2yGH3Jn
         DX1zbDbIET+Bbk+A4QUnL3Kz2wmUmGurT6Vzcd/WMbPYuUwv8i2NgtFhmMLT3CcJjKFJ
         ltww==
X-Forwarded-Encrypted: i=1; AKwUvBxNexiT4/1bzfz3vAqGPwBchwu9JhatjbIkZuPWHY483iYVq9iJ+WUYWmuDe64+hz1LB81LSVsJmg==@vger.kernel.org
X-Gm-Message-State: AFuF++m7ARwKTLQtpYjaRApHudiE9OqVlBpO5F5p2VXlRi7H3+4cxuSa
	/Z+Fznog6FTcm9/60KzoVUFC1140xQTV17TjvvrSI2G3t/boKF2iDRZH0l1cl7DM
X-Gm-Gg: AYBFou0kI1ToSFU6WlIYTnDQp/12QNt3WdrIj32sHylru+vNLW4oajSFvrV1aE/wF9d
	m+I3Lo6rLRNuK1UJtf8iu5yA7WoxEKk1Dfb4qVqsm6L34Hk56544UhEvX60IhZOvF/dsUNgn7bm
	QdX1+6BtE7V8Vd+bQEN/d3iH5gPvPdN6mDZ3VxZaNUV+/FjtiGZCtUCg+KBJp6Wtve8n7fsXTXt
	QgjzHXbD+Wam5YL3PIOrMq6xaZtfqn255cf2n0KafOtEGdphAxTdsxAXt9rFNNhR5WEKv0JlZJg
	EnEp02nuIcPGkGDcFWLNZQFWyFAKo+IAUFimKdgRecYlPU0pCTD7J2fFY2mvEBMeW7t8eXaPxxg
	pTgT4zU4saMRXspO+qLepi1v2D+fluObSxklbaU446Hli3bui2l9oDGr6+3I1+icEzGCFklmvzC
	IqYpLHrWSjvr3eDHZxXrlbHxNtKawjdI8G8/JlyjfOQTUIIII8tjc7mXFVUU9Gx4YzC6Fkhk6By
	4FROKLtRMnGy8U3gTPltGntMg==
X-Received: by 2002:ac5:c7a4:0:b0:5c1:47db:cfcb with SMTP id 71dfb90a1353d-5c7ed7960ffmr2345752e0c.4.1788534170156;
        Fri, 04 Sep 2026 08:02:50 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ed1dc86sm1717677241.5.2026.09.04.08.02.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:02:48 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97bf8e907b0so712936241.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:02:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwIuWyH6XNj/lZcjwGqD+hDahRUp+BZ+VPeTwIqFERqsiKzf92Ks4MToH8LA6ToE5+aq7ypfQg7rQ==@vger.kernel.org
X-Received: by 2002:a05:6122:8f8b:b0:5c2:b01f:e503 with SMTP id
 71dfb90a1353d-5c7ed81a4femr3374662e0c.7.1788534167484; Fri, 04 Sep 2026
 08:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-4-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-4-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:02:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWH2ojjcpKK4vDWQWw7buj67H4y9=Mpf9L-xn-qD_4U6Q@mail.gmail.com>
X-Gm-Features: AcwNN1XqgKT4w_HXWtn4Y9fm8kvbc5sNYhBHCQ08jgA0R_r3KSaIYmzU-ZXgbgE
Message-ID: <CAMuHMdWH2ojjcpKK4vDWQWw7buj67H4y9=Mpf9L-xn-qD_4U6Q@mail.gmail.com>
Subject: Re: [PATCH 03/10] pmdomain: renesas: rcar-sys: Add r8a774a3 support
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
> Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
> to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G2M
> v1.3 SYSC, however it lacks the A2VC0 power area.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pmdomain/renesas/r8a774a3-sysc.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2M v3.0 System Controller
> + * Copyright (C) 2026 Renesas Electronics Corp.
> + *
> + * Based on Renesas R-Car M3-W System Controller
> + * Copyright (C) 2016 Glider bvba
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <dt-bindings/power/r8a774a3-sysc.h>
> +
> +#include "rcar-sysc.h"
> +
> +static const struct rcar_sysc_area r8a774a3_areas[] __initconst = {
> +       { "always-on",     0, 0, R8A774A3_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
> +       { "ca57-scu",  0x1c0, 0, R8A774A3_PD_CA57_SCU, R8A774A3_PD_ALWAYS_ON,
> +         PD_SCU },
> +       { "ca57-cpu0",  0x80, 0, R8A774A3_PD_CA57_CPU0, R8A774A3_PD_CA57_SCU,
> +         PD_CPU_NOCR },
> +       { "ca57-cpu1",  0x80, 1, R8A774A3_PD_CA57_CPU1, R8A774A3_PD_CA57_SCU,
> +         PD_CPU_NOCR},

Please add a space before the closing curly brace.

> +       { "ca53-scu",  0x140, 0, R8A774A3_PD_CA53_SCU, R8A774A3_PD_ALWAYS_ON,
> +         PD_SCU },
> +       { "ca53-cpu0", 0x200, 0, R8A774A3_PD_CA53_CPU0, R8A774A3_PD_CA53_SCU,
> +         PD_CPU_NOCR },
> +       { "ca53-cpu1", 0x200, 1, R8A774A3_PD_CA53_CPU1, R8A774A3_PD_CA53_SCU,
> +         PD_CPU_NOCR },
> +       { "ca53-cpu2", 0x200, 2, R8A774A3_PD_CA53_CPU2, R8A774A3_PD_CA53_SCU,
> +         PD_CPU_NOCR },
> +       { "ca53-cpu3", 0x200, 3, R8A774A3_PD_CA53_CPU3, R8A774A3_PD_CA53_SCU,
> +         PD_CPU_NOCR },
> +       { "a3vc",      0x380, 0, R8A774A3_PD_A3VC, R8A774A3_PD_ALWAYS_ON },
> +       { "a2vc1",     0x3c0, 1, R8A774A3_PD_A2VC1, R8A774A3_PD_A3VC },
> +       { "3dg-a",     0x100, 0, R8A774A3_PD_3DG_A, R8A774A3_PD_ALWAYS_ON },
> +       { "3dg-b",     0x100, 1, R8A774A3_PD_3DG_B, R8A774A3_PD_3DG_A },
> +};

For the content:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
