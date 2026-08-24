Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C543E068
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581581; cv=pass; b=DJ9rgQ4H6x5Ul4/x6Tckwqc5kmL5ajqDh0HIP4h3YQtorY8Fd4Yz9E2EkS7Nt3uljWV+iOZMjrdQW5WJ7MdBW10khwpocURKuZWSGyQvH1y+XkVEFPdba9BCI8Oh2lZsBjwqmK1Looqz9vZd1BgfqYdyt0y23rmRMdOMd5fWArI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581581; c=relaxed/simple;
	bh=g6YG7ebYQXB3bRpGj/OB4nhiGkj6yamYDPhaSzTu1Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1tey7S+wZkJLxM2BfMbTVRfJje30MEAtt5g5pOcIupHFfL7cgMhWOpWTTQ0usCnr5mNRP4aDUgBq6abwS0Ivt4LiAmj6hUk7bM7mt2FD+IplY4DkbxI+FRXfmFGVJzgxBmCyYZI60x3RRps7O1meEAgGLjybTmwG3WH99wng8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1oYoH4d; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1oYoH4d"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso541781766b.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787581578; cv=none;
        d=google.com; s=arc-20260327;
        b=DPCJb4fIhNp4ZcVUq3Wux2OPjVcTj4T57EIBiFinwm8K2GrwEBd04VKNmhDAscwi7z
         cyB3NfIn2vIAzcW/34/byXkrJvIb8IoOlfEdx7V9p73QqtxF6mm41HLQXMKFCxRTtgWE
         PUtoXPzl9uprTkjIuIrOKFICPrKdQd+cYsOGUwTqBvGzvr8yCxzFTS889x1ZH6ya9JmD
         X1vopJ7ohhnjKI7AHqzDdKYbeKgeuxyX/DRus/dCf9W0apyDre+noZG8KvYhKJ2pDXVx
         eMKia2lSP0/G2NGK+Y4NFo1k7CpS5s/fzmRdVAgqo3q2d6GbEclawMC1rp81/YVZ4E10
         Q3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xKq0tTixvb6fNGgIvXcGGKjXYqHTulwy/M2vtC3qFIk=;
        fh=hG3CTWWKIltmiXCebwodkmuDLmsVLFejPuelfr9CH64=;
        b=s6Iiyy7hNkMhTxZt4/z8V/AZP9sgFDN2XjtYn+rqzgQH2aXkvS31bWkz9RP4WPCHBo
         6vfV0jyGpqRExYbNUKAL5wRD1dir1rBXFFbMb7cZCULdx8hTsL1Qy7EptYywMHRYzoLh
         YyOKA9KuKdj8LiyT210DjItGI7yrW8pntkI+jaGbBznZ16sAZGq3w3OWQFKQdgyZEjJr
         0wgenYHn1I4AHw2CwArS1fKEJoSWI1vLHO8JKCPf7MbUAZ3yKdy39rVwJlv7UpKAJ7Nw
         jWv6RrfwtN9moX+4XCWC59UkmkzxlAXafhAPJtZ41VdasG5kTHOdoj2ojUVfFomvSFaM
         cfxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787581578; x=1788186378; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKq0tTixvb6fNGgIvXcGGKjXYqHTulwy/M2vtC3qFIk=;
        b=n1oYoH4dUCRj3F9ZgC3yBwfZexnJT8/KJhMCduQEU1+cJaA9tU+5SvkjfbWSTe6a+U
         +fFySSiAmkV+2cbe0eknWQ2nmqO71qEFOlZ/JEPOAq/jT4NLmdPnGTSPZuD5EGwliEHq
         o6w95odqn4McNp/DtoWDr4tLSS9/0VZWgLUq4YFzx50XPKsr9QNIDCNlYlwvHtK55Fjx
         TMkdcmJfxBqdqX+0ZxWdOXBOMUk49a4nEYpQmG7BE1YjncK/En3+JBapAukgCV/7zE1R
         GLRpOmMG61umcPPFDrePpyN/sKrMg2Fv93hBC8d2ll106GksjIdZvW86EM0bfXqfE13+
         QMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581578; x=1788186378;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKq0tTixvb6fNGgIvXcGGKjXYqHTulwy/M2vtC3qFIk=;
        b=ql8H5pCvb/0l02B7NnTp3x/XCc8LxhVstRXWx3q+iiTNSHEg34DGQHHsm4ARhin4B/
         6x6O2TFR/hWoZV++EgfeDJ77DqnYXohrBz3eCgXeIIT6pcjrLy1ouzR2zPhJ/ck3PzXd
         sME5T8gPDSz2htCDXjCpLW1Ggra+IKM8hLAT1N/ZjBNnXDcDASDA2x8xN2HGjucm/C/j
         v6F2B3UIX9vL+GGntQ1RQgIfPij0M3UN/sJFlErdUn8fT6MJaLQ/gwxmRk5sTtv34/ob
         VjpiG3lMOJoz3ATbKv91NAqkGHCMEoJFR0t1tSP1wafE+uW0q0C8COeia2LAgTVePMBb
         e6NA==
X-Forwarded-Encrypted: i=1; AHgh+RrREisCNe1R6BBf1D5qWmOllLAQqnubyZ4vHC3EKSdClhmB3E2TpC+vIoh7C8gS1HymGHq3LiCOqw==@vger.kernel.org
X-Gm-Message-State: AFuF++lYYWcceXALdjwufQvnpZJ/dIet0gms7XIXzrsUjcuIaOZLu7AI
	CVoTgC31VrKpTuoOv1bugrAy7qyBdLRey7rQklB9nPouBE8SZZXzTntlyzYT1gDUU56+xr5trav
	IoN9DLMO0wzByf4ovCNmCR6uKW74x41jpYmj59cJ6QQ==
X-Gm-Gg: AR+sD11YDl9CgNMiQdEbF2tBxxoRnRMDDRck0kcUwANZ4Gx5burOJ2fGaH0arWQi6oz
	3OFs+b8PfTItT7/HYkyl1l9iQB9PIsSBrq8Fe5zZK+LDdQkBHbuVSbvSM/2/rM3Cv/HfCl2Kl6i
	7UdFMNVv5TfBhlqak4geiTGOQ9Amwy5liXZ3+bo+SZJDNcStacz1L8eEZUEtHNd/xw6+jvTUcof
	0tgGppogCgpl2Ot1N1Mk4Lvm4DKKY6VLkGU3dYW4t0rWVJjv4Y0fQFK+imIy7Ze4UNG0DnYamRS
	8Rj0hi9Gnk32xvuZQ6Cgmr1HUQYYr5q7dOnf/74W2T75/pl4mtPTqC0LZNx9E0IxtGitVFoOEty
	ibS4HZn0J2i4X
X-Received: by 2002:a17:907:97c1:b0:c1c:64d4:5ba3 with SMTP id
 a640c23a62f3a-c246a651d39mr3008695466b.20.1787581577574; Mon, 24 Aug 2026
 07:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
 <20260824130437.2771-5-sreeshankar0910@gmail.com> <5ybg37jlklgrkxseu24xytbom3v3rnzbwpudg7jftr6g3oqvo5@x4sfjci7v7m3>
 <CAA-+ukJT1=RYfTFsRvkTsN+Yca5yhgS+1xS=Gb1HmFWaSQM2Sg@mail.gmail.com>
In-Reply-To: <CAA-+ukJT1=RYfTFsRvkTsN+Yca5yhgS+1xS=Gb1HmFWaSQM2Sg@mail.gmail.com>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 24 Aug 2026 19:56:06 +0530
X-Gm-Features: AcwNN1WD7-RHPqzMcCh82DKazoZZTBj7FvE-P3djUsyLE_onjNfXG89rO_KrT4Y
Message-ID: <CAA-+uk++=6z0Ri1drTEKT-geGDU5ZFv2aQusC7ZLs-Pwf87B1Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org, 
	tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, 
	linux@gurudas.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 19:45, Sreeshankar K <sreeshankar0910@gmail.com> wrote:
>
> Thanks for the review.
>
> Missed that, I apologize. I will send a v6 patchset with everything fixed.
>
> Thanks,
> Sreeshankar K
>
> On Mon, 24 Aug 2026 at 19:21, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > On 26-08-24 13:04:28, Sreeshankar K wrote:
> > > Add support for the global clock controller found on SM7250
> > > based devices. This should allow most non-multimedia device
> > > drivers to probe and control their clocks.
> > >
> > > Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> > > ---
> > >  drivers/clk/qcom/Kconfig      |    9 +
> > >  drivers/clk/qcom/Makefile     |    1 +
> > >  drivers/clk/qcom/gcc-sm7250.c | 2275 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 2285 insertions(+)
> > >  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
> >
> > [...]
> >
> > > diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
> > > new file mode 100644
> > > index 000000000..bf75c8ec1
> > > --- /dev/null
> > > +++ b/drivers/clk/qcom/gcc-sm7250.c
> > > @@ -0,0 +1,2275 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
> > > + */
> > > +
> > > +
> >
> > [...]
> >
> > > +static struct clk_alpha_pll gpll0 = {
> > > +     .offset = 0x0,
> > > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > > +     .clkr = {
> > > +             .enable_reg = 0x52010,
> > > +             .enable_mask = BIT(0),
> > > +             .hw.init = &(struct clk_init_data){
> >
> > You missed my other comment from v4.
> >
> > const here and everywhere else.
> >
> > It is always a good practice to compare to other (older) drivers from
> > upstream.
> >
> > > +                     .name = "gpll0",
> > > +                     .parent_data = &(const struct clk_parent_data){
> > > +                             .index = DT_BI_TCXO,
> > > +                     },
> > > +                     .num_parents = 1,
> > > +                     .ops = &clk_alpha_pll_fixed_lucid_ops,
> > > +             },
> > > +     },
> > > +};
> > > +
> >
> > [...]

Thanks for the review.

Missed that, I apologize. I will send a v6 patchset with everything fixed.

Thanks,
Sreeshankar K
