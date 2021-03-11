Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FAC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 11 Mar 2021 23:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE68664F8D
	for <linux-pm@archiver.kernel.org>; Thu, 11 Mar 2021 23:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhCKXTW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Mar 2021 18:19:22 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:37307 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhCKXTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:19:06 -0500
Received: by mail-ej1-f54.google.com with SMTP id bm21so49729332ejb.4;
        Thu, 11 Mar 2021 15:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkuYEZAqpGMgAIDilawAHyGPAX0UYKuPxCa5VG+IXVI=;
        b=PoYQGyGdES6lKcVYMsG+9i3VFGHvA98/GdXdWmMYOX+Q7uOngt++NSBoltJ6fWXoRJ
         rDjPtMs/6q3AhZDtSglbq4G3e/Kvqw/X3sIh3m97SAeX7sjvof3v+qLQiPxK8OD+bCOO
         B6fzFs3y/b/8iw28wJjKfN1ghOQSElSAtrlDimPBKHn0jJrJmpXVVvkPUUi9xXM4rTv2
         JUFO7ZisR2F+Icr53XDsviPWQN0F/91bHE0iSv+mq93mjP/wkJ+yj6TOeiWLxUz/+4g1
         HhfaqJG7I0bFhWhPAU5WMgDihVx+vtFfmBktJVV58u4gQR0rzD8bAAQoWr/4Drw0y0fT
         4Rcw==
X-Gm-Message-State: AOAM530AiWoL97GXWbKskvfruhwKJMnAU9ByMXuSXnqdrxyNIgPmyWC/
        nY09P7qI9wT0tl7jnmPPL9MO1P144dsaZdKfqt8=
X-Google-Smtp-Source: ABdhPJyetu1/Jo62K0jNGbmTdegVwelG65nNocUvIIAfozT303QgCVvPsBm0j348+GIxpmMaZaw8eEEsPKdnsW2n9J4=
X-Received: by 2002:a17:906:5918:: with SMTP id h24mr5546144ejq.501.1615504744807;
 Thu, 11 Mar 2021 15:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20210116170725.5245-1-dsmythies@telus.net>
In-Reply-To: <20210116170725.5245-1-dsmythies@telus.net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 11 Mar 2021 18:18:53 -0500
Message-ID: <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the close read, Doug.

This field size actually varies from system to system,
but the reality is that the offset is never that big, and so the
smaller mask is sufficient.

Finally, this may all be moot, because there is discussion that using
the offset this way is simply erroneous.  stay tuned.

-Len


On Sat, Jan 16, 2021 at 12:07 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> The TCC offset mask is incorrect, resulting in
> incorrect target temperature calculations, if
> the offset is big enough to exceed the mask size.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 389ea5209a83..d7acdd4d16c4 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
>
>         target_c = (msr >> 16) & 0xFF;
>
> -       offset_c = (msr >> 24) & 0xF;
> +       offset_c = (msr >> 24) & 0x3F;
>
>         tcc = target_c - offset_c;
>
> --
> 2.25.1
>


-- 
Len Brown, Intel Open Source Technology Center
