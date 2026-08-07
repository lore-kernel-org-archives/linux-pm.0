Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB342433E93
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105179; cv=none; b=HrF4zAkc8kDwGsS4mIJ8TjqKq+Ui7ATL5Gr2fn6yTYGSz6ogzwoH05j/mv/+juKcpgb5JeYJrHtka8SK5ZGvFhFq7XJ7AUshf/lgmMWutSX5dvCyUAersrrscgl+BTImjpxHukSSOnxOs0V68/R3+aJc6azAjokvVnZozFEZceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105179; c=relaxed/simple;
	bh=5pGKnmoICNLpXe4M7LHt8EGcgiSmeRq0818OzQw8gG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qscD04j+JyMjxfSvQUWAjEk8BYr9NkPfzASEH9uhBdpSytrWm1Dzdw7d8szxDAMHebVTUDZHfk5evgJTLKYEbUeF8XI+A4yP0kf0BQKGfJvjPeY/7BUA+4s4C4HOOBQ72rsXSyZIhI/kQL8PbIRyWQEuki8Ag3iJGxhaDlNlin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9770e900464so1526924241.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105167; x=1786709967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DYxpa8lmyse0NqXbYFiTDGZv5gvprqKNCKipSvH+Cko=;
        b=lWFWbHj9d3WpRiRIowuMABTMjHCIICS+CuJ4hWeoVO4awFjjxPHHkw5CXo7Cm2HwjH
         FvK46kmVsLXjQE+vXgfy5KVrmJy2j/3UVXzplpb7HwmNk7L3pBE6j2GF8ZuyeOH+eBFp
         G02fSbYIHJyBBlbJ9x1/r8a9EcXxkWLCIYpvbYqUNc3/IP5oDRGL0sDfO4uM0DxgIV0+
         b7kULGw/fpDVgLdq21ZpPpHN2Uyl9gp+o8f9/DLTxeEiux0zyYx5BsJ9jed5DF9bAodc
         3bSKJmdrHKmq+n6NFYc2VBaIrjGwFbuWuP6P4S5cqzv7omfiwtc461H7nbmrZBPEYvh6
         tFHA==
X-Forwarded-Encrypted: i=1; AHgh+RoCN0ZlhHaoE4kkgNOl5oEddE65orUAlWv3gEnmQsamY+H7WeauelXPKbQeSwnl+pc81XtyQFoAbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoIAt4wpG3TTUee/1W5cQUw4jmbXmLZkyfZSWyriaNDA8gmXK
	Dt7Eifn1dw3X9uVMmXcRiMyxcDu8ZjtXWMXmHcqG+FhMEP7R9UBnTFD3q5xNVabL
X-Gm-Gg: AR+sD13VFCpJPRRKtZtyJ44rlsU5OijoTrsOBjhLQSkYhbhVhnyyq8RIVJa24MOCV4Z
	ZlNsRJnXwb3XywN9t4KSAZoll8sUBlXMpswFNeUhvAdQ621QtYIusdCYW0wWlw9ACCjqeTFUisH
	fvdHoPLmTjIkbht2Iv8rhT+VKVqomv9i5gtCZnjG7PRwieb7Qurw1jdiszCQjMi+SDX4+Lif2sP
	SpMPAgCVB0LtqaZCOTS4SiFF4RdR2CoUHLcA3Y0vf9v4ku6whh5TWpmCmQ+Om/wm5spvMroMlW+
	Ks0+z/TQtcQp9Y/896f/obaMEQLIOgggmhL3ZOSIrd+4QQtbBHjYBh8cThsUEZrakTHfS0IJaQp
	U5Uv80mMVOyWHhvmjRzC50FYcWBv0Z6MxyGI4dM+2OASqPmnxMNZ9eIh6Z+CP728WDMjvPxowFr
	x0r5Y7H1s12pEylEUiqMnc3tQCumAlzI3hTp3fXsWjC3jFucdzEhLv+9Mrt22oXiRjQThRYRTeh
	m+B7o7z1JVW//NSxXAO6+8p1w==
X-Received: by 2002:a05:6102:84db:10b0:745:4670:42fd with SMTP id ada2fe7eead31-7623ef2ac76mr1528176137.20.1786105167340;
        Fri, 07 Aug 2026 05:19:27 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76400dfe036sm743735137.8.2026.08.07.05.19.25
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:19:25 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7377dde7bc6so1215348137.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp2TKa+NJaRbaZSIdMi36feWWzcMxSOKMdUMnpyuZXVSrx0UW3bSvPov6Dd/qPsHwVOiILVkJbzYQ==@vger.kernel.org
X-Received: by 2002:a05:6102:36c8:b0:744:e685:d7b0 with SMTP id
 ada2fe7eead31-7623c68ece0mr1223701137.8.1786105165460; Fri, 07 Aug 2026
 05:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807100320.121108-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260807100320.121108-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 14:19:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGfR58UodRRjr1=vzsxLBiNsNkiwu8A7FNi-dXVSMH+Q@mail.gmail.com>
X-Gm-Features: AUfX_mw1-JjmSggQSkFoEu3CKaZTE6znw8ZDrIHmcv8xsq03LStv5_YQM6l8QUg
Message-ID: <CAMuHMdVGfR58UodRRjr1=vzsxLBiNsNkiwu8A7FNi-dXVSMH+Q@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Convert to seq_buf
To: Biju <biju.das.au@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 7 Aug 2026 at 12:03, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The devfreq transition table sysfs attribute (trans_stat_show()) builds
> its output using manual sysfs_emit_at() calls with hand-rolled length
> tracking and PAGE_SIZE bounds checks scattered throughout the loops.
>
> On SoCs with large frequency tables, such as Renesas RZ/G3L, the
> resulting table can exceed PAGE_SIZE. In that case the function bails
> out entirely and returns -EFBIG, logging:
>
>   devfreq transition table exceeds PAGE_SIZE. Disabling
>
> which makes the attribute completely unusable on affected platforms.
>
> Convert trans_stat_show() to use struct seq_buf instead. seq_buf_printf()
> tracks the buffer position and handles overflow internally, removing the
> need for manual length checks before every write. If the table still
> overflows PAGE_SIZE, truncate the output to PAGE_SIZE - 1, NUL-terminate
> it, and log a rate-limited warning rather than failing the read outright,
> so the attribute still returns a usable (if truncated) table instead of
> nothing.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c

> @@ -1661,9 +1662,10 @@ static ssize_t trans_stat_show(struct device *dev,

> +       /*
> +        * If an overflow occurs, seq_buf_used() can return a value greater
> +        * than PAGE_SIZE. Clamp the return length to PAGE_SIZE - 1 and
> +        * ensure a null-terminator is written to prevent the sysfs
> +        * "bad count" or out-of-bounds warning.
> +        */
> +       if (seq_buf_has_overflowed(&s)) {
> +               pr_warn_ratelimited("devfreq transition table truncated due to PAGE_SIZE limit\n");
> +               len = PAGE_SIZE - 1;
> +               buf[len] = '\0';

So shouldn't you use seq_file instead of seq_buf, to lift this limitation?
devfreq_summary_show() already uses that.

>         }
>
>         return len;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
