Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAD3655DD
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124727; cv=none; b=iKTZ9oTyOhMgvLBYwWiGNGSzVr8xU2g33U9f/555MVf0OP8I89LF/ybexJ6ycOgTr5CnHx7erpTHFHEiLZsKUOAPq6+lnDNFULZ5LqH8a3hTCt/TM9mMdN8OWhgxUg85ToW5oigQEdaawljA6FytkPAGNmBjEiV2FVFEVuioBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124727; c=relaxed/simple;
	bh=CTQXMUV+/UBVnNjzgtkJO88wjy6FOPIwK3y5DrpmBBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjJquyoYQ+vpLiU3p5Iqo4Et6DCFH01dSD9Dq4330Skviz85hHhl5sb+xbl+sLjfv5pBB08Jx2WN9SVXNPYz79/ruEJZ5WzNmWhTWjdjOuGMpm5nSSM8gmyyquMcjhzjfsKSEYMvzC8sZFmlaIP11nTRg3i8Cx4/r8r+/enn6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c379e8ffso34552765ad.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124725; x=1782729525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sEwup8vrGtzg0eQ+zIA6Kd2oTy+XBY9jxS2BNcFzC0=;
        b=sJXdlFgBOKSjn9i5A4T8ql2cko0/gPxhvAxQNabdFA2fqTinWEN6Cz4eamAsgn5Cpm
         Ph2dYpO1p1skPxD+N0dLhGRm23TlbraVdJGiKYcqhTYmrxFhgVsuMT6IFVe0hKv3qU5Q
         84t+zZgLWkHgz0s86v6zgdLpxsO3kytB2aG/YsHiCvU1PV2563LHIvypHvHvKQ1kbcJP
         tRkEzJWFvVM/f+XX3x2fal7LUEB18swp7q/fCdb0McZVZeAAxbQEoih1BYuqA5FpIysB
         mzOo5MTw5dovUD/GnOo3yuCzQ3tPd0gF12NA3EMh8FcUkyR/t3kmj/XcCidCgvuxPhDL
         7qrg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2s1zT49jz5bnnDQ+vBxkrVRpfWJ9miXb9lRKQlgrSnTo+rc0RUOiQW11iUBB3PDEc7l1W0OJDjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7b0PO/USGmX/LEO6AGtbr9lrfqU1wBHh+BYwDdTFAuRvtW2L
	6FHrVpoEn6TDtfYc50jUiiLSr1FCuk2h/aTT1g59idC+4/RbE5GAjFNDuccBfMAJ
X-Gm-Gg: AfdE7cnx+GsQEGSJhLWACnG8P3xEyXrnsDBU/jH+698JKrt9w/THidw08gXQhROYzM8
	NntRkGGkf4WfF2iWRaPsZ/BbdCmRzk3rsD27hgEMnKM8t75dtDrtIOyD7lDbSdMpcSI6UG+OR11
	OSbQkjSoC+2PuvSM0NmZJvKa9hPyQ+ZC4uOSbW+SloCf0oDCQcRAFXwY6VmUictyD+qtuVnBgVQ
	lRikcmUPFgCUwlNVaF1srN0Y3fJuah+JuAZXrxxuB869r1J/g2B9CieEKjJUSK/DNbuxCLb59yW
	bTep8wB+SXDmAmmOUjPlzejb9q3JmSn4VOYgOclL0k6KYLCFHzC4jJu1dxJG0r6U9V621eG2YY/
	a4w2UMh2apnG8Bncu+YUrUp4ecZwDCXTtMZbXxqoI/MjI2zhEp3wmI7K/g5TrM4x6O4tlqgXLvv
	vljPyxuiwGsO6pEkcypILpMN5786RFdwPwkI5QbxKP5aP/XX2kYeBR
X-Received: by 2002:a17:902:e947:b0:2c0:e7bb:9081 with SMTP id d9443c01a7336-2c71904bfdfmr143635925ad.33.1782124725169;
        Mon, 22 Jun 2026 03:38:45 -0700 (PDT)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com. [74.125.82.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436de1fasm75713425ad.25.2026.06.22.03.38.44
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:38:44 -0700 (PDT)
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf854d5feso8261803eec.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 03:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpjkG8LFWGh7Z9HUxQn7x73AluLpD0qRzt6umwHMsYeJDMe1ji4Jw+mPyCGIpBP6yEdKRfhs6A2Jw==@vger.kernel.org
X-Received: by 2002:a05:6102:3314:b0:6ef:f6cf:1b32 with SMTP id
 ada2fe7eead31-72a043c9af3mr8022945137.27.1782124344043; Mon, 22 Jun 2026
 03:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com> <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2026 12:32:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
X-Gm-Features: AVVi8CeRh5uGKoGdWXUVe0e4sYYTgs7H91cw7cP665l5Rz_E8v79r8eSiiAY4SE
Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Linus Walleij <linusw@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Javier Martinez Canillas <javier@dowhile0.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jonathan Marek <jonathan@marek.ca>, 
	Taniya Das <quic_tdas@quicinc.com>, Robert Marko <robimarko@gmail.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Adam Skladowski <a_skl39@protonmail.com>, Sireesh Kodali <sireeshkodali@protonmail.com>, 
	Barnabas Czeman <barnabas.czeman@mainlining.org>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Anusha Rao <quic_anusha@quicinc.com>, 
	Luo Jie <quic_luoj@quicinc.com>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Chanho Park <chanho61.park@samsung.com>, Sunyeal Hong <sunyeal.hong@samsung.com>, 
	Shin Son <shin.son@samsung.com>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alina Yu <alina_yu@richtek.com>, 
	Andy Gross <agross@kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 12:16, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
>
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
>
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> Intention for this patch is to go via Rob's tree.

>  .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>  .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
