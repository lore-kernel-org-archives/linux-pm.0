Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28317C55179
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 17:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D492A2242E
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603820795;
	bh=EC/G4f5JZOlYFc3CxRFXz7jO0N5nWlUXhZFQqDdPzQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PvlV8YRo2Y7GK1+wcGx06wwrUeysjSA74jD6GAVfUElMDpfplx+qHZ3HXEBImasiQ
	 g/trlNTbKbR2xAxgv2rdLq9uQkBiqftaZuiVgLUZGmrgSVab9W6fulYTyVqQ9EbPej
	 NJJ2b1vX0sQ+h5C3oULpfhi0ftar9Haf/qk2ooxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822039AbgJ0RqZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:46:25 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41185 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1821553AbgJ0Rot (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 13:44:49 -0400
Received: by mail-oi1-f180.google.com with SMTP id k65so2139900oih.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 10:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTIPfAhQR43VxRnebATKiQrNFNptd9cdQn+WfEQpf6w=;
        b=KgXjlTeuz8/yzMym1Pn/PZE0l3uMZtc70AgE9GTN0PzlDAlVO+XRmzkhGAi1+dMUml
         /kgB3ZINZxj0K0cwACHJw1zJnC8jp5P7DTOv+oZEQBW6LPAAvqcMyTt/LmwOR62KcKMn
         jih+ov3bm5XtunkSGw1YQWRVLKmu15/9AFa6PmlzsZIhh9Ky7ZW8A7CIyG4Gurssk9Vj
         rOhtEiWRGv/J01yVNRf0K3D6+0YU4zGpoMKgO2QbbAqLnrpS6lEckz8YwZcMFF7ZwaF5
         gaTM4p66Cc3vtBxLBstt+pwYV9S8V6Lyfmc+6uOCj49OxV2efn64gNhV2RurI4JOTBhS
         P3/A==
X-Gm-Message-State: AOAM533sDwivdQm1jF77G8+hYxQFwSPA8fidmyTNhiOrW1bR0aER8zMx
        /jpD/ojbIDSMdXSBFCYcPKMJ5Th+tmbNM8AbtAWnulAH
X-Google-Smtp-Source: ABdhPJxWHXxQLE17iLWrTQ1XYlW/j7ZFNWS9aSBl0IjXJutYPBc8Y7pScKJ1ZCeVqNVzV8snE1d0y397GY8zy/Bpqt0=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr2295352oiw.69.1603820688296;
 Tue, 27 Oct 2020 10:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201023095839.32218-1-zhangqilong3@huawei.com>
In-Reply-To: <20201023095839.32218-1-zhangqilong3@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 18:44:35 +0100
Message-ID: <CAJZ5v0ghz+f5-DKd6-X7OuaCoADmD58ufO3T2ZpXftu4ShuZ9Q@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: remove unnecessary break
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 11:48 AM Zhang Qilong <zhangqilong3@huawei.com> wrote:
>
> A 'break' is not needed because of previous 'return'
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/cpufreq/e_powersaver.c | 1 -
>  drivers/cpufreq/longhaul.c     | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> index 776a58bab0ff..ab93bce8ae77 100644
> --- a/drivers/cpufreq/e_powersaver.c
> +++ b/drivers/cpufreq/e_powersaver.c
> @@ -223,7 +223,6 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>         case EPS_BRAND_C3:
>                 pr_cont("C3\n");
>                 return -ENODEV;
> -               break;
>         }
>         /* Enable Enhanced PowerSaver */
>         rdmsrl(MSR_IA32_MISC_ENABLE, val);
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 123fb006810d..182a4dbca095 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -593,7 +593,6 @@ static void longhaul_setup_voltagescaling(void)
>                 break;
>         default:
>                 return;
> -               break;
>         }
>         if (min_vid_speed >= highest_speed)
>                 return;
> --

Applied as 5.10-rc material with some subject and changelog edits, thanks!
