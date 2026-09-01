Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3824734C6
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253041; cv=pass; b=XUdI/I2+O8IvfW+vzuw3OogScgVhCgpBjWQ4ITGHZk9ascDozE3OAm1FvTtDmKdX2/Qi4GHDpHnqrke1raNu4PRq63GbnjLJ7j+4rLZDXciXzzTgAVJDzb60lXzNUd/+/XGBGokTJYKBWZzjfOra9CEk3/7zudl7NEeNEZajmlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253041; c=relaxed/simple;
	bh=Pbz07IOx7uWzunVKVHlwzF5t9F6b7iAgHltccdPflGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/SHZQNEXgLnVqN5ZM9pToMyZMz6zP6gtVb2oqUc3MsLHgtF+izenSZvnVtj7pbl6CZQN3jI4RwSnHB5fdk4QWhMxziu3h+cSpLC8WPpyW8CBC9NktlYH/7iLzR4ByYaCjoTcPoDw+Rbwt1fNLGo5yiIETMLu0Pcle21PcNEyNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrGMohtJ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrGMohtJ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso5629941a12.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 01:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788253038; cv=none;
        d=google.com; s=arc-20260327;
        b=cn81ahvyl62csbXScOqzecEC1BNxlKoyFTF01TkA5ffvjm/llEaTxmDJzh06f7NTnU
         X/5ORgykAYKHwCDyaypOy0eouFX/C5bbQBqLSuwKf7xh15tH3u/BLtlXylslZ+qf3Duj
         AvJgv2Fpv60c36PVOR1V5peFGSYXRsWtn2rlf2tXRUzYQ149m5KASWQgVtUDOFbPlO86
         OHJvLK+r+0Kj2xJq7bYsABlTWUSybvqH6pQ09KzOuzW8bWQ5QQbNQAxPCwWWgtz4K2bw
         XdaxGzugndKbQg2vFxh8P9g/plCKIzCXkcdIj7gmP0Qaod4hnoXZ3QEZsV0ar9jbZhuO
         xGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bPhwsI1urk840eFQFOhdbzxIWtm9TMM1qXVbyg+SFZE=;
        fh=BUfnVkcn6QseezD8Ib8qb0L74m751MWmJeB/n2ygXwo=;
        b=DAuSptOwNrhTMG/Ykf2LcITYwCYexp+DJSczPW82/C7w6lejMv4e0/ZO+h8iJIFgg+
         Io0o7mM8PVDxJToHpJsffGHzkS0k0qlVpv8F/Nny29cXjXwiYlvsW9VkEx/T2jHfLc1V
         yp6VFAAW8QyXKg0gxr3cX202tMYax5O6ulrh0D4wBOcqo4O4uVXyee4aC70XtahEEE5S
         tNVPDB1cf8IYNHsHwGvOs4KxJennAhH25f/3+v2/nmuL4obPo+gLy2tQ11qPEKQBcGkT
         P9XksGbm1fPZS6cHpdIlpZb8yKrKSzKyBLNxap1AI5QEs2qDS1CAKRjo3jnIo9OTnhdg
         CUCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788253038; x=1788857838; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPhwsI1urk840eFQFOhdbzxIWtm9TMM1qXVbyg+SFZE=;
        b=hrGMohtJ+5Mbb6KN9lsAGC4MBEth86CGQhNW6qnIu2z3Zcf1iMFQaDusVtu0Dnjwoi
         sMv15QY31d9w9B3kY1Z07kGX82ajGGzRXTr1EVhnALzLmldnybzD2idTPPRaldfldA6L
         GC384aMxypXyMAWBWMYvI2rc+14mY78pFwPnUUH41XRYhIz4kSpt1tsutqf/hjG5YfCa
         sH+z7xRINBHzdokYS5mbePOEU9gaDlDn9SvPF1HTKMMFDh2ynzKVLYYMoc2uycgj7sFL
         S0CST3iTiuCAC4WUmq8OvxrSVATlG3u24B/CxuhnGcMZc7LY+xeKVDia5bf3AkahM0jc
         GnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253038; x=1788857838;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bPhwsI1urk840eFQFOhdbzxIWtm9TMM1qXVbyg+SFZE=;
        b=Noj02WHzTSa17f/sKr77UOpO2n4K7LfuqRdhfndV15JiMPqQ8ukg6OBv1+XFUbeEr9
         ReZH1Wjp80ureoicmy8FR/oMVoYrcscs5oNMpl3UYdioj/RztqCkABKrv0DCtEzw48Sg
         vUwnK1L+tqPcaicqxiHmGZvPkM5uZHBcWtUesejp4G3xBTwtYxiMsRZyg7Q9ReN9gXyA
         VuGleBXUBFHNwnYKFNU5iBg+YnF542VT4HrqDJvmPV36FWE+qUQ46tD/aU8t2DRF7AAl
         MNzR/8Xx5TDVeTM5uFJKP9Pn99rZdtuK/IzDy7h7Q+0EL63CIFmgO+rz+QmchrZ6NKdj
         +9lA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8b6TJ2SvyYM4LNhbDWJcp2fLcLb4fw6E9bAYxEmXBerCZNGFvKy5V9S1eZQuPltcjt1lCVeDpUg==@vger.kernel.org
X-Gm-Message-State: AFuF++msWT9GTsggGZTaAAYmb2DIpq1QymHXJ6Z6E4ttqhDYwjmuo/gE
	WvVw4lESOIVljgetzbypcfw0CukYqkpeWWZnhjG8672gdasFjuACL+g/3jC4LER9MjWWinFn2/F
	pKEJJsUW9xyMZ4xuKBmVEpjPNIkqzWWA=
X-Gm-Gg: AR+sD13pDxoPJrCbn2ByyLOqKVX0/4z2OtHMkFi0O6ihXJtUElPRO/gOSR3Rb5zKMbY
	n/NNqwe9rUsRsDufFyW0mPgyH8CA34OHHO7MjxK+BByhWDGvHbTklZduLi9cfQ05OI7QZsxwnPT
	9LESh8hnlTVQmEVQWzfd7BqXltOxToHmPSp791SdgRhlAwMT0ngx6FmV3IkBlzhSVx1O571x6ma
	RnNbOco1qKYmGcwGnKTZyBPWEdH+5v/kKLtCovbTAKzG5L8hc8tUHnL+43oS+MXF5x3rgwmpB6A
	N4ZH0bC4Df7IEQOOT8Sy4fd9ZazVVSaCFToWcJNE7jPao/KEB0WhWrxC6vb2tQk0Gi+vzgbwL5O
	mXMU=
X-Received: by 2002:a17:906:6a17:b0:c25:c67d:53cc with SMTP id
 a640c23a62f3a-c25c67d5cd2mr18684866b.8.1788253037879; Tue, 01 Sep 2026
 01:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
 <20260901070717.20513-5-sreeshankar0910@gmail.com> <fyzo7furxfsreajgefuimfdpkkulxvwxf76plc5o6kjv7bgdym@2pah3t7yfiw7>
In-Reply-To: <fyzo7furxfsreajgefuimfdpkkulxvwxf76plc5o6kjv7bgdym@2pah3t7yfiw7>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 14:27:10 +0530
X-Gm-Features: AcwNN1XGMvHREpeWhXMnhL-AR_TL9aR4BW-G9PMQ7EyQU1HF166WiwXPkNVsQPA
Message-ID: <CAA-+ukJOPKGL3iS15uWAc7iXviRe-xgVf61dcd_gP6p9zLrByw@mail.gmail.com>
Subject: Re: [PATCH v8 04/12] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, radu@rendec.net, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 12:51, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> On 26-09-01 07:07:09, Sreeshankar K wrote:
> > Add support for the global clock controller found on SM7250
> > based devices.
> >
> > Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> > ---
> >  drivers/clk/qcom/Kconfig      |    9 +
> >  drivers/clk/qcom/Makefile     |    1 +
> >  drivers/clk/qcom/gcc-sm7250.c | 2275 +++++++++++++++++++++++++++++++++
> >  3 files changed, 2285 insertions(+)
> >  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
> >
>
> [...]
>
> > diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
> > new file mode 100644
> > index 000000000..0d548fe4a
> > --- /dev/null
> > +++ b/drivers/clk/qcom/gcc-sm7250.c
> > @@ -0,0 +1,2275 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
> > + */
>
> [...]
>
> > +
> > +static struct clk_alpha_pll gpll0 = {
> > +     .offset = 0x0,
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > +     .clkr = {
> > +             .enable_reg = 0x52010,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
>
> const
>
> I think I already mentioned this for v4.
>
> > +                     .name = "gpll0",
> > +                     .parent_data = &(const struct clk_parent_data){
> > +                             .index = DT_BI_TCXO,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .ops = &clk_alpha_pll_fixed_lucid_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static const struct clk_div_table post_div_table_gpll0_out_even[] = {
> > +     { 0x1, 2 },
> > +     { }
> > +};
> > +
> > +static struct clk_alpha_pll_postdiv gpll0_out_even = {
> > +     .offset = 0x0,
> > +     .post_div_shift = 8,
> > +     .post_div_table = post_div_table_gpll0_out_even,
> > +     .num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_even),
> > +     .width = 4,
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > +     .clkr.hw.init = &(struct clk_init_data){
>
> Same here and everywhere else.
>
> > +             .name = "gpll0_out_even",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &gpll0.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_alpha_pll_postdiv_lucid_ops,
> > +     },
> > +};
>
> [...]

I apologize for my carelessness. I edited the source as per the
instruction and sent the patch in v6 patchset.
Link: https://lore.kernel.org/linux-arm-msm/20260824150156.1310-5-sreeshankar0910@gmail.com
I accidently applied the old patch from v5 patchset to v8 patchset. I
will send a completely fixed patchset as v9.

Regards,
Sreeshankar K
