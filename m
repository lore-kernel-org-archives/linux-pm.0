Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692861EB5CE
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068996; cv=none; b=TINtTMho8hmmM0LrY3ygC/3PXKMYi+sAeB3MsRR5viNQLcshEiMkE5rWaFqSUOmFeyZ5LFtcYGayHI5CymzdhsoI/sCeJBEYTvw64RqTlnKcXS89qAUkp7T93sd6UA127TeWM9RwCC80s1AbNCVK8lDV7ASQvxMOxa841rS1WKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068996; c=relaxed/simple;
	bh=zQAGAJqK01u1hsgk9tM79y+qHgIMow8bJd7VCIfEqak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu9STeC7UyYUehxTJpqSSKOde6ZNJHXsfiLtRczrBLkvjsgtVp3C3LPqMi79wxgOOr+9gdgoEB956VJIX5vpqxWGAQLoAGXC7plohMXkNOBeJh6JPDk4kefR0ysTP5nZMFfPCrYco6EmmFuXJD4uAET2r2U2YQMEBY53ZWTRfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c82bb05ddaso2779639e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068994; x=1790673794;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gxG2KWqjG9DQXNsqNUjR1bwSMAhv13VrmESGniF7QY0=;
        b=1byre7rkSH4yQhf67KdJ09/932S+v5Zi6gON5wW3bKLquEz0E6YYiPdjWWEHD1Z+rQ
         hbtBAjaJpsXOSJduIqV2m7BESyTwO/9R3dH+0nIp1jJRiCFxqh3JOYgKR2b6jICFK0vb
         yjN9fvGREZFdGJeOTtd8vEzJsB8D7VQLbY1a0htq4K8ydi8yiaMdV2xOUDIdIXkk2Bv9
         aJOc2qUfSr6fu9lXOMnkktNaa8zk/FVcihJKf0YKQ225VAm6Ydj6mD4BhhSuPEgTCuvh
         YmLUOcN1Tdysw0CyYJDE172ub+O6jKZb15MVS0QkYYFI6RpLU7U8oIApZwyeP+UWlmau
         0Jxg==
X-Forwarded-Encrypted: i=1; AKwUvByUWnKSW4B8JL4NWiQFYXS6ZlDMMOI1LIazPRIqbiAHu0JKtleS/V0r2QgjNnK+QkqwD2H8+RF+wA==@vger.kernel.org
X-Gm-Message-State: AFuF++kXiaMSK+N7KSPVvbgG7fKCaxorBzTQDylYGOrE0jcJH2MnsbQy
	opVrRz3+KdzQYBhE2KOXg/UiKsPlqvSGn3/Nz7ERYIrgAXne9ZElOP+cG4BXu356ijE=
X-Gm-Gg: AYBFou3EngjGmiBjYWy7uZgteXG72cn/ILF2Br4CsErZW5m4AlCul+ulR9LX0Pt/bCL
	4F6LdPFdrhL7k7FAIZhDGanNTxaOb02AVFvmK+aKGV1Y5eaywEmPoIEIPD4IpZwj7laFZ/9U77T
	efJyfXZG6khWbsB+o5FEaa4EDqV1JwvgaRyFwYD0/fgu36wSBcLsNFqYgFMReqHEck3gD0oVA8L
	dyqH5KH8chi/xqDjnsApQvR5m1Uo6Yx4ThXOheo6aKiz7DnqLqUW2JkHJs1GcxKGTu2uqYVovs+
	shqwn/qSCXXjPDlIkqKJq5hzD3mSeu5OTLdBYTG69VOl6/Q+ATQroLzO2rpOyShahDnWj22oUtO
	LKVZuRif26xhChF/aio36t/xqPx9+1sXU05QYaGDysgL2GW8iJD3Rvk6ObZ737KMxv7Oj5Yufit
	9ceaDmLhk3Mrd0V/qznz8EfGBJn4P9szyrlQvw3g0uJed3h0++1q7uChTlWi+8YIve7h7JnQjps
	jSmAYEgZvBnCc+MSp4Mfcoxt6fWvgRs/fOv
X-Received: by 2002:a05:6122:f05:b0:5c9:ae70:e784 with SMTP id 71dfb90a1353d-5c9b58b3dafmr8231399e0c.3.1790068994130;
        Tue, 22 Sep 2026 02:23:14 -0700 (PDT)
Received: from mail-vs2-f24.google.com (mail-vs2-f24.google.com. [74.125.227.24])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9e7d76809sm997862e0c.16.2026.09.22.02.23.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:23:13 -0700 (PDT)
Received: by mail-vs2-f24.google.com with SMTP id 71dfb90a1353d-5c97b28165bso3837123e0c.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:23:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+N/KTaalulsUGz2jbbqReBqhr2w6wBz1Uv8ooJWplY9m780adIhXhah5GsI+BhCCcHHM161CBMQ==@vger.kernel.org
X-Received: by 2002:a05:6102:e10:b0:7a8:1817:276f with SMTP id
 ada2fe7eead31-7a8181729a3mr5004222137.37.1790068993345; Tue, 22 Sep 2026
 02:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-mb-rcar-sysc-v1-1-fb25996bb2f4@vt.edu>
In-Reply-To: <20260921-mb-rcar-sysc-v1-1-fb25996bb2f4@vt.edu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 11:23:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSA=firVaQ8HQ-ztKd+Em16Xj3LTfcLLk9SHBw2gCE=w@mail.gmail.com>
X-Gm-Features: AclHuK-dqoaxKnjPGxgLEKwBtvJRMWUy2-_GWvI3MviqiUfHAePyiKA8wtVLn60
Message-ID: <CAMuHMdUSA=firVaQ8HQ-ztKd+Em16Xj3LTfcLLk9SHBw2gCE=w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar-sysc: publish the external
 request mask
To: jaidevshastri@vt.edu
Cc: Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jaidev,

On Tue, 22 Sept 2026 at 03:18, Jaidev Shastri via B4 Relay
<devnull+jaidevshastri.vt.edu@kernel.org> wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
>
> rcar_sysc_pd_init() maps the SYSC registers and stores rcar_sysc_base,
> rcar_sysc_extmask_offs and rcar_sysc_extmask_val with plain stores,
> before it registers the power domains. rcar_sysc_power() tests
> rcar_sysc_extmask_val and then writes through rcar_sysc_base at that
> offset, from genpd on any CPU.
>
> Publish the mask value last with smp_store_release() and read it once
> with smp_load_acquire() in rcar_sysc_power().
>
> Found with MBCheck, a static herd7-based memory consistency checker.
>
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Thanks for your patch!

Have you tested it?

> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -106,15 +106,19 @@ static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)
>         unsigned int chan_mask = BIT(pd->chan_bit);
>         unsigned int status, k;
>         unsigned long flags;
> +       u32 extmask_val;
>         int ret;
>
>         spin_lock_irqsave(&rcar_sysc_lock, flags);

Isn't the spin_lock acquisition a sufficient barrier?

>
> +       /* Pairs with the smp_store_release() in rcar_sysc_pd_init(). */
> +       extmask_val = smp_load_acquire(&rcar_sysc_extmask_val);
> +
>         /*
>          * Mask external power requests for CPU or 3DG domains
>          */
> -       if (rcar_sysc_extmask_val) {
> -               iowrite32(rcar_sysc_extmask_val,
> +       if (extmask_val) {
> +               iowrite32(extmask_val,
>                           rcar_sysc_base + rcar_sysc_extmask_offs);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
