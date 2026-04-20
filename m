Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C7389DEC
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675002; cv=none; b=lgq5/dGzY0uCYBHs4O9VyGdwXL8P+TzRjfKrQ0Hj5lgYhZOg00VfWMYApGaDa8aT+D4gxPlZRVK2jFq7bLPqos0DM9Y/ntlBQNmIhTSdISCWqOMSQZ2XqmRxrTbZms005sGVHgmOvz2u+nIXtqChnVfyDDgMS7gEO0tlRJS+cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675002; c=relaxed/simple;
	bh=v5gCceeDUWWnwCSkj7MA9O4u+GB6d/18v4huwOTUL0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv41ca7oabRTrofco9QUr5mZChDDIuEEhmD/7RNa5FJypFDveawNjS6xb36E3FM5decU19OnvMAZB8ofnbnX0695bv9ddflE+82HoxqS3/tKTKSi0hIEyaIy8FMJ1FQgwGLfeF/54eEFxRIrLHbOIukp8Vqah3OAPlf3qRgcneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6058ac0ebceso1947149137.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 01:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675000; x=1777279800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk1cjRbAtp4GCcTi8WWTinbg9eeO3gY1eDEUp3GR38Q=;
        b=JaflbOYdFAh0T+Ei4P4tF5jAb1LTMM8qiOKx8DvK5goUdcJkFRZqDZDV5ImIrsaduB
         yNTULjqx6mqa3y1g/lkYO6NtDmibnjzd+65c7cfQl5Ptpynsfu8laljWlQp+YXHU9MBp
         iVAyJAs4glQxHZyjbdsb+lyKUGFx8gOYNZ6fiEwTP86BMjOS4mnJnrCV0zkNh5KThO3l
         /QimetU2T5/Xe2Mgvs1HrvpFHh2ktE/rlr4sZqRvB3eMT1L+e5AAEFSnGO50WYD2OTvi
         F4XpXQiNYOqVemeM108LA+lPPhK5pUYgh8/vkVSiSL/wvNFT4TOSXMLqHrg4VOkF7JqJ
         7aeg==
X-Forwarded-Encrypted: i=1; AFNElJ9pUMeDAIqzmDbugvQpm57dVK7RBSTsGK/QrJa+jxdv21Q2IRMNTwyWDnqVeSzreWorVmU6QFDOSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBg4m6AkcaKb2IIGJXM6agpRoH6MM1oAbF+UA0SJIRKGrZx88
	0yHxe6zlfkfnbbaUPMP5BopNfkDAlAAWBs90O+2r7HNOhkjXBi06A7b2C+OA2JrS
X-Gm-Gg: AeBDiesMU9Qikqij+GzsGncvhdh1MRQZA74qtTX57Tb7WODWHxqwuBATXSNpjUUXGhD
	na+6YS+jyvs09EFBMoauZmpTRlbwT8LMlTxtytWII464uDhFUwc3qD1Y1Ql6C0bIz0bTeJdWLKX
	bTfyKsjMGxg85MUo36CEmM9x3AHTuKhEBj40q2QoazrFrBQoMOVLopGZEZ/Zkh0rC2xFHsBNvRy
	d/0DOOSiFpkbUuBZ+otkNXRo/Qhp9xk6hjT9BlnGLJt4Ir95UP8jTUY2HSP2fJQAva1JjDS9yQ4
	cV8TASFDsfTStf8zsM6yrob+tnlEcBUwkJS6KWxcCBCf7RDA2//kBX5k7s9mLOSOD1d/iAa1qjq
	3ICrgfv+lkD+q9XdHeyYhBv7n4Fmty9zW0r/SWZgB4ZShzqkJKG6PZheQdDZCzzyrl5y6dD6wzu
	ogmFaIswKTrOv5xJyyemXSq3r3+B/R0CiwLmiFZyPiJHxPu1m80Lfla6XZ96+CFzOzvc7xTdtCW
	aU=
X-Received: by 2002:a05:6102:8095:b0:609:af4a:380 with SMTP id ada2fe7eead31-616f53abed9mr5314232137.11.1776675000090;
        Mon, 20 Apr 2026 01:50:00 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6174272f752sm4648807137.0.2026.04.20.01.49.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 01:49:58 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d9f191ae6so1844270e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 01:49:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Fbij3jcT/8bDytAXsDA3ATPAUo8K8V0FaxBHzRwpRsyAVKHs/0w0kOBCrNj4WMfTYCNutedghJA==@vger.kernel.org
X-Received: by 2002:a05:6122:90e:b0:56f:6b46:28be with SMTP id
 71dfb90a1353d-56fa5931dc6mr5255238e0c.8.1776674997727; Mon, 20 Apr 2026
 01:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org> <20260410104058.83748-5-ulf.hansson@linaro.org>
In-Reply-To: <20260410104058.83748-5-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 10:49:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzhGDjED_xaLOZnUZB4SR0KhPeWevfQvKeExEH=bCruA@mail.gmail.com>
X-Gm-Features: AQROBzCwV8ST6yM54ry_6ciPjTsOUiTBNbVImh4WgAAEBeYQh0fedrFtMJ2X8vQ
Message-ID: <CAMuHMdXzhGDjED_xaLOZnUZB4SR0KhPeWevfQvKeExEH=bCruA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] pmdomain: core: Add initial fine grained
 sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Fri, 10 Apr 2026 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> A onecell (#power-domain-cells = <1 or 2>; in DT) power domain provider
> typically provides multiple independent power domains, each with their own
> corresponding consumers. In these cases we have to wait for all consumers
> for all the provided power domains before the ->sync_state() callback gets
> called for the supplier.
>
> In a first step to improve this, let's implement support for fine grained
> sync_state support a per genpd basis by using the ->queue_sync_state()
> callback. To take step by step, let's initially limit the improvement to
> the internal genpd provider driver and to its corresponding genpd devices
> for onecell providers.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c

> +static void genpd_parse_for_consumer(struct device_node *sup,
> +                                    struct device_node *con)
> +{
> +       struct generic_pm_domain *genpd;
> +       int i;

unsigned int?

> +
> +       for (i = 0; ; i++) {

... and you could move it inside the for-statement.

> +               struct of_phandle_args pd_args;
> +
> +               if (of_parse_phandle_with_args(con, "power-domains",
> +                                              "#power-domain-cells",
> +                                               i, &pd_args))

Checkpatch reports a superfluous space before the "i".

> +                       break;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
