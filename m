Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0342E406
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580923; cv=pass; b=tDKYcjY2ChmbypdOvBxOmVoDPuYsXRknX5cLjTGMptJKCmxtI916dB8SkNJEy1fFu2ejc8/tUIg3gRIQX1+8xmZFEMYyvnkQK5wQ+Fph10EyRz3zBfphRJfG70nvfnyouEuZEwdztjRFfVZ5zBQiTuP83JqlhW5mydsZPxOB1/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580923; c=relaxed/simple;
	bh=0kks+j63StSPlXTF3OV31d0II5QMTMM20avDv0cE8Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7cW2IePdEYLSGCYPqdUNT9whALU/pd0s2edSIgK/2lR/qTZ/XICz9Tpwg8iAuXpc8QGFrqCj0Ak1SFtyfGvKZNK1pcyuXd9QC0PJCP5WwU9j+VjUTlYMH8Sal3z2S6sRMK0kbAafSvcRJZMzPx4vxvMQQvvJ96+AqxIZvDzP8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDGJJ78F; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDGJJ78F"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2020421077so602080566b.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787580919; cv=none;
        d=google.com; s=arc-20260327;
        b=CxuO+H0yu0Up3jah/D8RrSj/pWDhV5TvEErBBDe0s2Gn3wD9a660LiWpxbcuaSNAOt
         Z+zJiA0EJAIg8SZ4/rZsJ/xC6Sx7OkKSsOh/S/Vuy6BWhn1y1YRSFCKagWPjnqjLnabS
         USYCsNa/+VaAR9/xhSftg2HzSH4qrzRVVU2IouU5WQshiCKMPgK37Pm70At8g9PWBOwA
         VOA/s/PE6flk84qq1m1cD6byAjp87isPMxm00MuvXKeGb8QWMggAvkEqR4fev7/grG2+
         q0DsXC9Ke53jxYy5WZqFZFw21kJ9l5SHEFJxkWBUiSbeaSg42n1sB1Om+Ceh08cUnteu
         W+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FrjX2y5M6BTYXuv5wkBHtI4BXsIYAL02A5EG/qzfCHQ=;
        fh=YVZK/uizOclcqOjHtzLo7pnbL2JhD+hk3ncq9G4oM8E=;
        b=ZN7gNnfSfdCEaVZBfXjmMEpdCX7yWrMpDMwzuW1UGOni1frWTuISSVL7vEXEM2suU+
         yBbn6lNQzMpfhWojCQTeso9Xb3e4j2TO8SgZxTeVYko6miva70A6SaP5M5APd18tx+na
         JCvdpfDbuYqvzLZ4UVw3cNOFCi9avr1zbgb+nrj+7W2igR3FOpOXBMCy/GgBhuVN5Thy
         t4HJDxGJXZ1ucoyMKmgnsciym2pS6dizM721zPWOobGzR61sqbngncfnZ5mgQ/slVS9W
         /X5nn9X7N516/+NmAxZ8pw2mNoqUgqSv5ywE5PWT4xVeAc1C3iirGzYEu5VS5BIYWD8R
         NXPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787580919; x=1788185719; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrjX2y5M6BTYXuv5wkBHtI4BXsIYAL02A5EG/qzfCHQ=;
        b=IDGJJ78F3Ipc9tB0nbEffHy2jfdT1CrCCk4hIeHeL02LxT0clK4aILUCWwf2BolUbr
         wxOMh2hBeW+7aJ1e9wNd3P+Hn3H1M773HuZi1a9uORkh3kauQNk66E9VImH2UnISY+du
         H/zJedVRgM0APaG+w34ig2+9rvrfyHyCf8XtBv1mh3c1umdjzmjBsmHQ/0Wq3Qama6ff
         +xhTGOqAbKhkOiWQm82qhjQqy+ls6ciwXytomojpFytyOWDJyFeSar4DdF6CyNrRxpgz
         x33NlK9pJkVxTMVNaQzeTtnAgtlawn8Wze9sSXH2KsQgydBZS2VbU7qbClJljw6MIkgM
         wNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580919; x=1788185719;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FrjX2y5M6BTYXuv5wkBHtI4BXsIYAL02A5EG/qzfCHQ=;
        b=K46oGEqN/2ioplpzNAsATkZz2793JXvdQruOPuhUgJpQYhS4MInZPWJGCKsaGRMe3N
         fELaC1uLopEkjZiaPOlPj0VCIqL2gMC9tuT2W+dl05thF2eC9GKzfn/5opJrx3cOoWw6
         svLxghoNQ0s9k/VQvQXtN/pm8sIGEI0rWgCX3uQejOnZZCAnpg0L8tBS/zZp9IkB6rrn
         oSlvhN2wCzGhNROmVuKCvsTDAnE4iSKHz+O1J0Q6fwcPTHbdVrS2k+v9tNVLWy+2q2Ni
         r+OptlyXOhHZveQzSgxr1fWER3DPctVFMve7E8ud2DAqmkA7QeTUCFkv02WGSQufLeYW
         sITw==
X-Forwarded-Encrypted: i=1; AHgh+RpEEdcNul5BRicm5WUfeyw0c31iLNZW8BqbXek9R2Dl/PhpiOT3uAbPa9Ptmlu2uU/VspqIyCXkfQ==@vger.kernel.org
X-Gm-Message-State: AFuF++leFmIn9a5+iu4ta7k/Q9Lb+HO7bBdVMyehYo1JZ/CHH7FA8fJ0
	2G1Xg3pANyPRj1wtz/qlBkgF1qCMgUWnA353YK/j9TWTQih68HCcttevsZ1KIvOj3DfjOeWtECx
	j9vt7kMDLTWLZiJW+j+8UHbTEbEWscvs=
X-Gm-Gg: AR+sD12AQ/N1Gv3aweAAaTnGoiOt9/ts6yMYL7rm48jN5LEmjC70ZIbj/qL33LJRCbQ
	q56gizOm9F54waW97eYwaUNd/0NIX1n8XdlARS1+SCXgwMFNq38fDZyTsBgfj+y3OwUF8KMWIAW
	wxTE9+RpX73BBKv3WlhnPol3KnZbOXMetc0lSl2KAilkTnEoFkT99Wn6aeYBGvSWWCBpLrDlDWm
	sME8ISPsROX+I0hURtkkAoo6gUeBhQocy0tWpfxvDJVc4rx+e78b3XEIHlOLNyGIikpDFNBtKR7
	E3NzQbKUe/DbDwtRYbMhjpggw0q7UD0lhYhwv1yH8hU5RLNKmKvpu5HDlFJ3QTih9HgRRBvlGUI
	qdA==
X-Received: by 2002:a17:907:3e9d:b0:c20:f4ee:7c97 with SMTP id
 a640c23a62f3a-c2491c2846cmr2216363566b.5.1787580918870; Mon, 24 Aug 2026
 07:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
 <20260824130437.2771-5-sreeshankar0910@gmail.com> <5ybg37jlklgrkxseu24xytbom3v3rnzbwpudg7jftr6g3oqvo5@x4sfjci7v7m3>
In-Reply-To: <5ybg37jlklgrkxseu24xytbom3v3rnzbwpudg7jftr6g3oqvo5@x4sfjci7v7m3>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 24 Aug 2026 19:45:07 +0530
X-Gm-Features: AcwNN1WcsnGQSHLRyuZJ-yHONrPiOQJH8iqD06u4L2i4WB6_vuJbh1UpdH1J-_0
Message-ID: <CAA-+ukJT1=RYfTFsRvkTsN+Yca5yhgS+1xS=Gb1HmFWaSQM2Sg@mail.gmail.com>
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

Thanks for the review.

Missed that, I apologize. I will send a v6 patchset with everything fixed.

Thanks,
Sreeshankar K

On Mon, 24 Aug 2026 at 19:21, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> On 26-08-24 13:04:28, Sreeshankar K wrote:
> > Add support for the global clock controller found on SM7250
> > based devices. This should allow most non-multimedia device
> > drivers to probe and control their clocks.
> >
> > Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> > ---
> >  drivers/clk/qcom/Kconfig      |    9 +
> >  drivers/clk/qcom/Makefile     |    1 +
> >  drivers/clk/qcom/gcc-sm7250.c | 2275 +++++++++++++++++++++++++++++++++
> >  3 files changed, 2285 insertions(+)
> >  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
>
> [...]
>
> > diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
> > new file mode 100644
> > index 000000000..bf75c8ec1
> > --- /dev/null
> > +++ b/drivers/clk/qcom/gcc-sm7250.c
> > @@ -0,0 +1,2275 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
> > + */
> > +
> > +
>
> [...]
>
> > +static struct clk_alpha_pll gpll0 = {
> > +     .offset = 0x0,
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > +     .clkr = {
> > +             .enable_reg = 0x52010,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
>
> You missed my other comment from v4.
>
> const here and everywhere else.
>
> It is always a good practice to compare to other (older) drivers from
> upstream.
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
>
> [...]
