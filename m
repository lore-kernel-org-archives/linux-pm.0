Return-Path: <SRS0=jn4m=UE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8EC28CC5
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D144206BB
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYVj0gk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFEVqm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:46:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39703 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 17:46:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so339660qta.6
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2019 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TuQOj8PJpScwkp59lds+TtpAN3l9kJREHmjHPijWw8=;
        b=SYVj0gk5V2YwPtjjKsT+UscxAc9OOx6tMILjxGTbzWVGk8VozqKTdAuIRhCOcx7pLe
         jBDoI6q77+E8mMKeBzMM4z5dmPRJTlUiA4juFs9/WzVDo4VKLULBEM0ItUd1DIq1rZJS
         ILslylEXBlAMmL7TXsiYYHEht8+J3lEt1tqAQqwPQpZss0RrqeWeBp5gjCii8PAyFfBV
         pMF6n05WR2hTbcFJnu6/8plCSU2MOP9wzmfsSBLWKqtmIlqwZzcq3Ni9K3ZMHojqDIO2
         uR3wpzifCx7VobUXXm1ZA2hdjcToVm28dDmOovl6VOPJTKIsw87gD6QRpucyljc0aSsv
         wHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TuQOj8PJpScwkp59lds+TtpAN3l9kJREHmjHPijWw8=;
        b=pSYrM2duhgUM/4+eABdVhK5urTBGAidaNqsukcNvPSnZleR8Ircl/yAxTPpDij40wS
         +ZSi5ZwgyVWQfPogzMobq56BWMsXA9aj1fzEzNdGZCqnP2QpuQEc6XC5ILzQUB+wFWnK
         kyVr2ArxK/9EmdOWr3LBuuh5zIdXK4O231EcvvWSj0gOaU/kdWsU6nSH+8PeDNS+batK
         ibLIFEgdQ8Vn7ozcxQGEZ9Fqwk3YwIiSxbeLPBnD/cKZx5ltxPU7VfK6joYNBxmAduZy
         3fQ6gVolAaQYOCDYmUmvETBRwPdR+YBYjJQKalx1YzISGJ1pQBcmjPeatglaNfTQfdPW
         6Gng==
X-Gm-Message-State: APjAAAUgkDh1BVDvbTV94vHKyVsvSGhS7iWbSsh6MeSmtDB0h1ihA9xG
        5ugIFGGrkL3ndZ54CyZ6sy3glc1ZQZ3NQ3bbJUk=
X-Google-Smtp-Source: APXvYqxTPR7S44nT7dKf3plBe+zMrddrOmZlAf7eamPC8lJjWjDvl2VF6ni/QA8/4NIOKlXf6J89vLsMj+LEDP6dgo4=
X-Received: by 2002:ac8:2cd1:: with SMTP id 17mr35889958qtx.356.1559771201425;
 Wed, 05 Jun 2019 14:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190605190053.19177-1-ezequiel@collabora.com>
In-Reply-To: <20190605190053.19177-1-ezequiel@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 5 Jun 2019 23:46:30 +0200
Message-ID: <CAFqH_52c42_SD9VLwnGXtP2V0ZCpmynTMqgHgA2JUmK_jdMcVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: Fix governor module load failure
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, kernel@collabora.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ezequiel,

Missatge de Ezequiel Garcia <ezequiel@collabora.com> del dia dc., 5 de
juny 2019 a les 21:06:
>
> A bit unexpectedly (but still documented), request_module may
> return a positive value, in case of a modprobe error.
> This is currently causing issues in the devfreq framework.
>
> When a request_module exits with a positive value, we currently
> return that via ERR_PTR. However, because the value is positive,
> it's not a ERR_VALUE proper, and is therefore treated as a
> valid struct devfreq_governor pointer, leading to a kernel oops.
>
> The right way to fix this is hinted in __request_module documentation:
>
> """
> [snip] The function returns
> zero on success or a negative errno code or positive exit code from
> "modprobe" on failure. Note that a successful module load does not mean
> the module did not then unload and exit on an error of its own. Callers
> must check that the service they requested is now available not blindly
> invoke it.
> """
>
> Therefore, drop the return value check, which is not useful, and instead
> just re-try to find the (hopefully now loaded) governor.
>
> Fixes: 23c7b54ca1cd1 ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")

I think that what you really fixed is a bug introduced by:

b53b0128052ff ("PM / devfreq: Fix static checker warning in
try_then_request_governor")

not the above commit.

> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6b6991f0e873..8868ad9472d2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -236,7 +236,6 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  static struct devfreq_governor *try_then_request_governor(const char *name)
>  {
>         struct devfreq_governor *governor;
> -       int err = 0;
>
>         if (IS_ERR_OR_NULL(name)) {
>                 pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
> @@ -251,13 +250,10 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>
>                 if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>                              DEVFREQ_NAME_LEN))
> -                       err = request_module("governor_%s", "simpleondemand");
> +                       request_module("governor_%s", "simpleondemand");
>                 else
> -                       err = request_module("governor_%s", name);
> -               /* Restore previous state before return */
> +                       request_module("governor_%s", name);
>                 mutex_lock(&devfreq_list_lock);
> -               if (err)

If you remove this check you'll iterate always over the full devfreq
list of governors, I know should be quick and is not too long but ...

> -                       return ERR_PTR(err);

The fix can be simply:

return ERR_PTR(-EINVAL);

I don't think overlap the real error is a problem here.

Thanks,
 Enric

>
>                 governor = find_devfreq_governor(name);
>         }
> --
> 2.20.1
>
