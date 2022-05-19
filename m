Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C7C433FE
	for <linux-pm@archiver.kernel.org>; Thu, 19 May 2022 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbiESRv0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 May 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbiESRuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 13:50:10 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E503CEBAAC;
        Thu, 19 May 2022 10:49:33 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ff53d86abbso45358577b3.8;
        Thu, 19 May 2022 10:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX+badLi7qx6lRSHCK1/33oE5/AYvYHWEehVljXyvsk=;
        b=6Gy/D+KP2Wb3kkNT9BOWsWAnwdu1xInuc5DK5zkp3LZB1Z10SVj8AJh3pWf1Y2XFDo
         v6zn7RjRg6nvjlFMYKQJ83C//6PCKDuqM0jadCZLDgf4tQxZQSCBc9wvMR1k7+pFuMgQ
         tMUUYDA2kxCYgOvkC0sfM4tcTr66PBBsxrO+RX6bocAmHrd4eDN5wkkpJitCUCGuMqL2
         N7894QnySrCdYz+HchxofbJPNC6TuNyHuIOLb3y7LaHiCtbGPvYwaMDQUI9OtFKGHnTn
         ayqX19M8pQO00ZnU0vClHhjT3r9rYvWZC75zKeKi09g9sidf77ZsAoDW83eDna5jUiZw
         MgAg==
X-Gm-Message-State: AOAM532cqtIqwrCvSv5YiYsRTFq2JDEvlfCeHzoU1pvVc2YDUTzl6jtd
        fnXZVcV8l1QBakrhmVcsE7hD7qoXmIRHxKDmook=
X-Google-Smtp-Source: ABdhPJxYaasrq1E+VvRksv4sPkVJnJRsukLKV9yMoT8yVJhv3kTUKh59QRR/CEDvkY439wQmeqE3d42FxG0MzNuL5iY=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr5769634ywb.326.1652982573217; Thu, 19
 May 2022 10:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518084536.508514-1-colin.i.king@gmail.com>
In-Reply-To: <20220518084536.508514-1-colin.i.king@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:49:22 +0200
Message-ID: <CAJZ5v0jTXo7fhBVhYiE8SceHqbT4U6b26ku8p+BKHBWTEmb6wA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: remove redundant store to value
 after multiply
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 18, 2022 at 10:45 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is no need to store the result of the multiply back to variable value
> after the multiplication. The store is redundant, replace *= with just *.
>
> Cleans up clang scan build warning:
> warning: Although the value stored to 'value' is used in the enclosing
> expression, the value is never actually read from 'value'
> [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 83da499dd6ec..70e38278986d 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1010,7 +1010,7 @@ static u64 rapl_compute_time_window_atom(struct rapl_package *rp, u64 value,
>          * where time_unit is default to 1 sec. Never 0.
>          */
>         if (!to_raw)
> -               return (value) ? value *= rp->time_unit : rp->time_unit;
> +               return (value) ? value * rp->time_unit : rp->time_unit;
>
>         value = div64_u64(value, rp->time_unit);
>
> --

Applied as 5.19 material, thanks!
