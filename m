Return-Path: <SRS0=sttx=DX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F151C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13DC206DD
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602861859;
	bh=U8mxFWtJGaIICGMUiodxWdW45DCt3M1LEqeUpQUZBxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vl2dCUGoUzWtpmUMOLvBWzJRxcaGiDeCvlOyEnGlgybctKy0Cp1ArNzKUld7Nab+7
	 qPXs3uGCEuGV/U+ASjZw8KsahiwH1CTN8/HTp8VysGwLYTt3B+zCgsx8BlQJMxUgeq
	 ursR0y5QJLsO3LQ4s7iWXkCwsLNvHXlIa3VP+SIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409816AbgJPPYT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:24:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409697AbgJPPYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:24:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id f22so155178ots.2;
        Fri, 16 Oct 2020 08:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7YLYYBQoD8rhTwOOAN1f5RmnpkZCSwIfFP5ut0coWg=;
        b=lJLwMyAYeWIzgY34BImFmM6cybdu+9DUP9PfKJ2ffhsO49zAJcelRevhVu9vHTHRyc
         dWyE7bGHIFG+GoIJDbhirhCgpMQiiGYmxMey/q1kR77dLPbTnk7yvFeXQ5QXhb4Uw2sY
         NoPZabcz2DkoxSX/rtc1OyRosmtuj8Zad6UoM8Qnnh2s1wIeGeDGFvpFstaFOh7v7rma
         u3JGbKFNZhI6qVkzJVqxXpqUc19IiLfejvMWUmPwjYCp76zQKxV8bR7cpvFrvD6LElRB
         6i/ynent+OT6NCycRzHofDQjud+o3c0A5AlWYqQzABoAYSxC43vI/BO1j8xkv3VpBxUV
         nZSA==
X-Gm-Message-State: AOAM532wLIHvCt4bI0zofwv5YASXbJBBayDw/nPasobuGwMe3uN8vIRq
        YaD1xvKkaI1J5Fj5mC+307xslMTGbMQb6HgGPcObImMa
X-Google-Smtp-Source: ABdhPJwftTVoGpQ5g7N4ScQoOabWrtA01QrTvqvxy5MVQYXlZKnCfSUStuWLrR9Vu2Utes9aTOMdrUiIzVXHrZHcSZ0=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3174478otk.260.1602861857973;
 Fri, 16 Oct 2020 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:24:07 +0200
Message-ID: <CAJZ5v0gPYXhqP4CF+ep3tE7ov5zza0FW9_9cuDsiqznUX8CTCQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] cpuidle: Remove pointless stub
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 15, 2020 at 4:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The cpuidle.h header is declaring functions with an empty stub when
> cpuidle is not enabled. However these functions are only called from
> the governors which depends on cpuidle. In other words, when the
> function is called it is when cpuidle is enabled, there is no
> situation when it is called with cpuidle disabled.
>
> Remove the pointless stub.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/cpuidle.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 6175c77bf25e..74fdcc6106b1 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -270,13 +270,8 @@ struct cpuidle_governor {
>         void (*reflect)         (struct cpuidle_device *dev, int index);
>  };
>
> -#ifdef CONFIG_CPU_IDLE
>  extern int cpuidle_register_governor(struct cpuidle_governor *gov);
>  extern s64 cpuidle_governor_latency_req(unsigned int cpu);
> -#else
> -static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
> -{return 0;}
> -#endif
>
>  #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,                  \
>                                 idx,                                    \
> --

Applied (this patch alone) as 5.10-rc material with some minor edits
in the changelog, thanks!
