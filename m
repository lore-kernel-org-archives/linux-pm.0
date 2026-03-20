Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DA359A7B
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999111; cv=none; b=Gl2vmnDKaI2qDbJjPEcs6MYuPhpnB7WZ+bvamV/iKOECBjK9JOMNQVNfjWCoNgjMJctIptIDvUMA80PQ3xdo6uoB7hInEAxoSSeP3/eakGXlBeSN2FQsKyCAWvR7y/7iA90PrqUzqPQuBT2byrgcTnlhV4wfcl5WF1U12R+ivh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999111; c=relaxed/simple;
	bh=Qi1GiCpIKgkbLc/3UbDM/sZ2rd9fQIHjVAU0Xb6ZNiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQsOcX/qU79azYJ6zRFAHjAGd3pczYz1xM2v5r1ZebkH0nNcvWtB++N/QA0hjG+vJspYvzov9OBsS1uWFEJvXwDwqmuOLPUh+/k8+X+huPUlDFdsYcjak+hBml0VdrWO2LMRpU318m4iwUturmKCNN9fAtB+hFrQ5h0k0X9bPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94acd026e45so326251241.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999109; x=1774603909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15qRFIauJbZWIOHfsFfMNQAVUG61meAdvRvs8zItI0I=;
        b=dIyLpeC9RU0iQhfsLthjQA7vJ1N3wdoTJb6Q9FX+Rure59aC/8JbFvtjr64Cowep/1
         9s3Fuy57qg7taI0BCKsEc5OI1iM1EvYEbIf/FPJaHP0HiIanR2qSOxfVXqXLAcDqr0kq
         JM5B5cy7bTR7a8DARRlgW3CO69bLT/lwwds7wCiDSpECg3b1ROP3ZpucF1q3cZ5Swbyp
         uQQBq6NEFogOLrFzpBro3cAJj1hj08qSexOiA+ws6s8u4u+E+zqtLvFKVaQ/S81e7Nje
         TAhnSQBw458KvfsrKeLwGFI8fv19ko7R7m1JiMz2Jz7eYMa6qu+IkLgYdgig1MkFhN/J
         B+pA==
X-Forwarded-Encrypted: i=1; AJvYcCUIu78XNTK72mf7Vr/Vyu2s82roVhGqLRIN2jYtK5LF8OKTAG9ZbZmBU7oUyxlzbs3UKyz3f11MwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaA9wsx7uGMmGET2bM+F/gf1r4qYoevqMBnXuh3mUW4gEVScR
	hYdAKOAvc6/WqMZG/+Rifvdsk4Yaq9AXgLo0cbXD8xWojO/LhffnbciGxykMBLyAcBI=
X-Gm-Gg: ATEYQzxnGFBUyhuJIn72T9RjSe2XmWJGIW1+EhsJl5DAJfhxbRdLclPK8lJCzkKI//x
	Z7Igi6fEdaI6WnfWoOJeu3rX1TOzXuenxXB2ZnlxRIvoh2XM3z1hxsXN5sFsVrUdzbh7P16AyZI
	mZjhGZlC74CK+0jd2XptqH4sczf+j3VuVNo7UhhqSoHl9P5OrdYVbp7TVZ8N4NsJzzyXFyuZ89Y
	MqMsFhXdySQKoeH7wqHqjjYLzgtgGr8d6MTnAHHOUw9s+pF5Rio0/HzosDFRSckt5tkiFb5OZmj
	LO9cZI5L0VT1op+dfJFxJzE0O5qDRrUJb52eX/FMaOBqdrCwer9JwFuJKRQEDPQtholsmqd4f8D
	qnNZQX/LZm42UpdH44WiC3yilXnLfv+Mtau5Php6eVVxaTLJ6Gbhka2AqgEF6VEldlrDjMPI73C
	F7hfA4f0SNLD7xschSyFC39yQ4nZ26h2/IZ7oBXiALo3i7rYM/q/OLEpD5/BEN
X-Received: by 2002:a05:6102:4492:b0:5ff:1e61:b303 with SMTP id ada2fe7eead31-602aecd0dd5mr920567137.17.1773999109197;
        Fri, 20 Mar 2026 02:31:49 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136bd79c0sm686641241.6.2026.03.20.02.31.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:31:48 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-950bcf4df06so369555241.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:31:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDujpUaYvMBI4vrY8HFn0vHHibRueJI+wpAgTDby03d38gJgsjCcH9KWYYiExDbF8NaVOCJkRfTw==@vger.kernel.org
X-Received: by 2002:a05:6102:4a8f:b0:5fd:ff75:f41d with SMTP id
 ada2fe7eead31-602aecd1c9fmr854127137.24.1773999108162; Fri, 20 Mar 2026
 02:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <20260303132305.438657-8-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-8-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:31:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGOchmxq6yiZva43wSzptagKd2Wz0uvAJqq6D2hj=6oA@mail.gmail.com>
X-Gm-Features: AaiRm50bikNxwG5d8QdeS3goOaCSfEY-riZXXOejz7Kn4PitUZ0fSrDHTZqCkTk
Message-ID: <CAMuHMdUGOchmxq6yiZva43wSzptagKd2Wz0uvAJqq6D2hj=6oA@mail.gmail.com>
Subject: Re: [PATCH 7/9] pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
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
