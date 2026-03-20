Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96235C180
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998974; cv=none; b=vFOXZFOfuuXxMSj/N42GtwlFwA/Pb0Qq325tozTQoUbx7+B3RuyxuDa39QPWGlGiGZ+YjVAf82qjvh/6jLNTMlJT7h0Ufw3C2E6lsGxkTW1dHhoKFSktrIxAYOfhm/Vjt0FJEdlFhbZFr2IJN+aheMhWCtVET5hp0PPNCEtX6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998974; c=relaxed/simple;
	bh=fN++xRCdyIMPlCDHvWsWKTJTDrSq9xVVqybE1248o8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWNWzFjBtRDVQB95nyP+NMlc2Luq1Idqgyoy2hHZpWnZvf3DQKfdF86FZpo3q1q26K8h8eURxWyv2tZSCEmsKofxqSkrl5v/7aZmFKvfOGvhXolJXzAmcbdwQ1nrkhpqw9ha+zaGda30BZDwmU0o/f8KSedt58ztwVdTt635iu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-950c26b6b05so1011764241.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998971; x=1774603771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OWvbRFWeHVUH+eQg7QXHsou4B24BwJGm6d8wGsTrzY=;
        b=rx8dLxitXoFPG/CehNb8cj7Zp2vcj4XLjXiSXprepJQRb/2yUVmLwMjyay5uAWRGgG
         KD+IzBt8DtxFHJ7DFueu3OoiVVhqlqSzFTVo3OGsAqepzaT1Y+QWrBnM3JM+rSjGAK9E
         PFnTfq7dCJMJpK6jpPE3fmbtiA1yFaRW23TlH5/pcHRNAP0+CD/gu9QxT/h4SPrz7Fnk
         YJbrMmaZeEyj0Dok0f29mFth2uHxGUwSePrKC/TbAt6IdpCm1HDhkszvmJNVdL5U0lTK
         5Nc10W7N+41kMEmbmTQ9n9vNiU2wQ1nLwfl9hNh4Fh92vrCoqKgv7FTKICFy4zyuUtsk
         46tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfOtgh9yfLW41aPg1CblvJmVGukuLRIw1cUiRO2Rg2R8S/XrOHwRNa7A0MvQ4XBfl892lbRPVwNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01YkjqXxa9r51cEzDsdMEyAq0R6G0nr8/ZWD+1mxgbh1O0VOh
	n1F70JKSmlmpqISXwYDlIspAGt7Krw3i/bVLLoS0GE8YCdyrX1aqmZltj5eGmtKP63Q=
X-Gm-Gg: ATEYQzx++i/NNg7T+khLElEvTdJtWuWQvwK1AxgHOUU5gtWyOHY6mAJBaTAQKiyn04E
	/kGyMuK3wuYGUc5rn9ucUtKj9GWEcH4tE6Om9mmt2yjZmfRGk+nLgBHFYh33aAVhZ94tftO5BQe
	KPTZCqG3cvuOQEVa0bZ5BSXyhulw3l0eHbf6MTKV2b5f9D99J67xfPyLfzUDLLjJzVR6isBu7bN
	KqYNnWByVZ44e5L70w9ol+d+C2/R8z5qSkv8DtxTZDVaPfYaKjvzWyrz7GtcDPFWhL0C//pv7Wn
	fglSMKfhJewxh/5HAU58qxcauX+rkGqibtGl4OZNLIh5t6GYwvzTEYRrk4mTBYQalW1DV5TMAB1
	vLGPXpjCCAEhoGabG0zemmeNdPMDLKP9MupzD8F95mvECZNA7HWCTp0JK9Am78xHx9cVYvAvXq6
	dMSCCaJfoOHHz8VqZupCnAaAYre+z+BPOAmnZUgqGyxDLWkF/x+2m95uThV2dZ
X-Received: by 2002:a05:6102:504a:b0:5f1:4fc3:855c with SMTP id ada2fe7eead31-602af5ca30amr1145417137.7.1773998971553;
        Fri, 20 Mar 2026 02:29:31 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddb6d333sm1391309e0c.2.2026.03.20.02.29.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:29:31 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ffdd9a6155so2167274137.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:29:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXwzmLMuSqJ3OIgBBKrhlyKadlbjONiUUUXrti/LZ7YqCliLfvDIx/rPnc6IZ6qTXToyS4elTBEQ==@vger.kernel.org
X-Received: by 2002:a67:f0d6:0:b0:602:afbc:ae78 with SMTP id
 ada2fe7eead31-602afbcd937mr731164137.2.1773998971174; Fri, 20 Mar 2026
 02:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <20260303132305.438657-5-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-5-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:29:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZknduohmhed4dFBtXuSEowmfCJ=C8HeuCGXsCsvFyWQ@mail.gmail.com>
X-Gm-Features: AaiRm523IC3GrIsAhOOqBmX4iY-88KJFmptpIGAiC68dOGH9suDr0hQOLTqaLuU
Message-ID: <CAMuHMdVZknduohmhed4dFBtXuSEowmfCJ=C8HeuCGXsCsvFyWQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] pmdomain: core: Add initial fine grained sync_state support
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

Hi Ulf,

Thanks for your patch!

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> A onecell (#power-domain-cells = <1 or 2>; in DT) power domain provider
> typically provides multiple independent power domains, each with their own
> corresponding consumers. In these cases we have to wait for all consumers
> for all the provided power domains before the ->sync_state() callback gets
> called for the supplier.
>
> In a first step to improve this, let's implement support for fine grained
> sync_state support a per genpd basis by using the ->queue_sync_state()

... support on a ...

> callback. To take step by step, let's initially limit the improvement to
> the internal genpd provider driver and to its corresponding genpd devices
> for onecell providers.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c

> +static void genpd_queue_sync_state(struct device *dev)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct device_link *link;
> +
> +       if (!genpd_should_wait_for_consumer(np))
> +               return;
> +
> +       list_for_each_entry(link, &dev->links.consumers, s_node) {
> +               struct device *consumer = link->consumer;
> +
> +               pr_info("%s:%s con=%s\n", __func__, dev_name(dev),
> +                       dev_name(consumer));

pr_debug? Or better, dev_dbg(), so you don't have to add dev_name(dev)
explicitly.

However, the printed provider name is again the name of the first
domain.  This is incorrect for all but the first domain of a onecell
genpd provider, and thus confusing.

> +
> +               if (!device_link_test(link, DL_FLAG_MANAGED))
> +                       continue;
> +
> +               if (link->status == DL_STATE_ACTIVE)
> +                       continue;
> +
> +               if (!consumer->of_node)
> +                       continue;
> +
> +               /*
> +                * A consumer device has not been probed yet. Let's parse its
> +                * device node for the power-domains property, to find out the
> +                * genpds it may belong to and then prevent sync state for them.
> +                */
> +               genpd_parse_for_consumer(np, consumer->of_node);
> +       }
> +
> +       _genpd_queue_sync_state(np);
> +}
> +
>  static void genpd_sync_state(struct device *dev)
>  {
>         return of_genpd_sync_state(dev->of_node);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
