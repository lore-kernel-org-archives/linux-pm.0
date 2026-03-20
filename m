Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66183375AB5
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999129; cv=none; b=nIHMtJIxtYWSnUEMNpzQs9s4kIBLZYz9GyDQnzCDEAAb+2xkDvqgqsXb8vCm41MzIdgIFrY1TmRJd8KyUqcJgtcLfJgVY0fwlTDW99T+4HUNe8hZVQ37FEUZImEKlt2Up/8tsqT8SQ2hT/Nxp0oJVMeG8+f2jiMKh8PZwrh0hWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999129; c=relaxed/simple;
	bh=Qi1GiCpIKgkbLc/3UbDM/sZ2rd9fQIHjVAU0Xb6ZNiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3WlwXMVqssBtALYtUj28vZvMe80eLdjhUZtHEh1aIYafdEEaCuJPwPpoIeckVebIRhrpFWvZg0KhnKl7AznGkEeyN0qajV+rpJcWw3f585nVQX6TYi1GUW1ml0Kwy2nur5YVZeT71MG9liAY/NbGeiYvp2n06qJiHqSVcGZZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94e9810221cso56780241.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999126; x=1774603926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15qRFIauJbZWIOHfsFfMNQAVUG61meAdvRvs8zItI0I=;
        b=YUv/Z1BDKJtKJ8OvOsfhqGzWaJ+Gi6+q9pnGhBnYdAi0ar17CxQ72+KN2GlniIHzpD
         fzZcR3Ioqg0yBxG+Dv+iJPEpkxxw6pVkS7loX/FgGnMUsH4GpZmLdYIgIESJCC3axX65
         b+Jzm8HhpXpPQeFVEauUbsdJKI2pqKwsPNs5SsJSSaWfePBwqz0IDcVlZmN9wxjLgHLE
         lyw5GSdioHmNdOrBWmQS/9V8c4SJ5koL8Hej+s7FPgxCS7LNYAuOa1rOSd+EkPDWdqPx
         xwECrGWQlVNDUYoEHslCblTtC1R/EeeW6iW493gUljYlquIEkD2mIutm7ueWa0GKtTtG
         q8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiFJTHb6SSal/aqVemCLXNmQSmRsGqoPAhq8X9+1CfV3hT1hiCTUELQcQwFIfJDIj8g8/3qeTsyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMxPzf+KQktrjHL2E7yWw0F6CK6IU0J0hDnps1/wc5tmqLqCD
	NSSDycgGsscsIUVVlkXQJXc10GaJtDZcjA0t21Zlgawayd+a7v0YFTzT+mX98srR3KU=
X-Gm-Gg: ATEYQzzEksFnhy0KlyIWC8fCw0JEXniZAzzhIlNN2X/1yHE6nwA0gCBqvXyD38CMJdb
	zX7nQukipltohaWDQ60xfBZ0BLSq68vBf/abdqzZ865K2ZlfCoec7L5PTAONSetqzYARDWJ7Lmo
	wN5BSxFaTohhgtMwmfbCCuk3bwkAYhydyN5HigpswLH5oJpuMihX5vIvGoCYqhNC0b3Tc21aK+V
	TdaHtJSWIyOVhAaFNe20VWdpIpxkQylu7Hz9xTCJmR2gcVrJ9V2y/h8dmPDorkr4uzmDdhvALWn
	13/BCMe6kv7fA/6+jRncRd/dXgwEJ6y609GYBMig3YENiUxayjDf2K5lIpYQMDMxXw3qcIJFkh9
	D4RzPgLLgdAmgyjFYSBsfBlq2dqb/IcQnj4QZnN1t/CrR++DI4lsY15n2n3XBbDHIfgfX8QpLJt
	LXcZWKesl2ShGJWNEUriS/xJbypzkIrW4ChIdgFokI+Y2GjhSajscE5F/U8idu
X-Received: by 2002:a05:6102:6b01:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-602aed07a8amr1144625137.25.1773999125837;
        Fri, 20 Mar 2026 02:32:05 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-602afb5b832sm926431137.12.2026.03.20.02.32.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:32:05 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so71368241.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0gnAK0cQphZ7Cw3mCu53HRQpF1yCrKzYWKriJEE7MoLUWAZYtIuJxG9bW6Wfe5ZWwYj+DrzFImw==@vger.kernel.org
X-Received: by 2002:a05:6102:304c:b0:602:ac40:96b3 with SMTP id
 ada2fe7eead31-602aed11942mr1079634137.26.1773999125034; Fri, 20 Mar 2026
 02:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <20260303132305.438657-9-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-9-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:31:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6-QJiLBfV6zuFndz7cFUgPCEH1VP6OCdKOgbewK8DcA@mail.gmail.com>
X-Gm-Features: AaiRm53FivaU7oSnu_R918Q1YM4DLUxcMTOVOIPw0jl1Lb0otoe9R2-7ObHqWwE
Message-ID: <CAMuHMdV6-QJiLBfV6zuFndz7cFUgPCEH1VP6OCdKOgbewK8DcA@mail.gmail.com>
Subject: Re: [PATCH 8/9] pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
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

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Due to the new fine grained sync_state support for onecell genpd provider
> drivers, we should no longer need use the legacy behaviour. Therefore,
> let's drop GENPD_FLAG_NO_STAY_ON.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
