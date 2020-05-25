Return-Path: <SRS0=vmax=7H=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96369C433DF
	for <linux-pm@archiver.kernel.org>; Mon, 25 May 2020 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631E620723
	for <linux-pm@archiver.kernel.org>; Mon, 25 May 2020 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590404953;
	bh=QSyGnIZ3nH6dpAORXOAp4hYrx8E8B/v1KFcV5ROzcMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oLtzbNzFn+uMHCgo435HBHqPolJQGEUHIsNnDZxdwr8kj0mgeDe4eEWZQU3fd2M3/
	 s5LA2KdfnFVN7rOFao92A0o7IkfRU6RRuRqJ1ZpDKuKQxDrQ9lJ7pg6Ort+tzOuZ3u
	 M4M3MdSYbjMQkv1F3wxa2w2UytDYVMXQF6/u5oIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgEYLJM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 25 May 2020 07:09:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45209 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbgEYLJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 07:09:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so13518843otr.12;
        Mon, 25 May 2020 04:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB0wil5McK190NuQj9OZqwjEId4UBlaUoJWnHA0mJ7Y=;
        b=tJZkYuy/83pyaG94T2GyhpZfTr/essjsHtK6rPaZ9eS87JXvjzDUfCRI98tA6odFCt
         F5wCr6J1rqLutKnPeqSq/kFDD8c0MXxPUZU1MGiI3PoCiYXQXlRLym/NmbuuVQ9lU92B
         ovGkXCounnw910c0l7JpSqZGPGvMLYlVCLJe2YUdbJfyfz5MBze7cChTHyxplDg70qxy
         nhmOO0oX2wJ+NkvbCGleXFSYnZP9jpoiVrpQFDHA/wyd9zldOloFGAvrG2Dx7BV64PZu
         m23VWjPGoaSHLecrCWHncjpPETYZ1rv1JhahvWQ45nAXBAKXkei5XS7tgWWnh90rAgH+
         bPRg==
X-Gm-Message-State: AOAM531OZ9Vr3Ux9zUNMuOUfkz4BQ+kTvmf693TrdcXkhOhs8/GZBFgC
        ouiXp5Nva4V/yuuYwfW3OEwyVdSOUyDXXJ5r12EAOA==
X-Google-Smtp-Source: ABdhPJzrnyOd62zbBJsrbKsaVS2KQXryawISoD+ng7KNkAatkOYfv5p1N8glpoiD0mjKlyRE6+1P7B4oWAeXdua48Ps=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr1428590otf.167.1590404950954;
 Mon, 25 May 2020 04:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200525110540.6949-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200525110540.6949-1-dinghao.liu@zju.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 13:09:00 +0200
Message-ID: <CAJZ5v0j7cy1qZ5q3jWjJ77zJrVp+Kt2-4sWN3KF0jBgV9FOQew@mail.gmail.com>
Subject: Re: [PATCH] [v2] power: supply: bq24190_charger: Fix runtime PM
 imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 25, 2020 at 1:05 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Better now:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> Changelog:
>
> v2: - Use pm_runtime_put_noidle() rather than
>       pm_runtime_put_autosuspend().
> ---
>  drivers/power/supply/bq24190_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 453d6332d43a..7b24c41a2137 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -481,8 +481,10 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
>                 return ret;
>
>         ret = pm_runtime_get_sync(bdi->dev);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               pm_runtime_put_noidle(bdi->dev);
>                 return ret;
> +       }
>
>         ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
>         if (ret)
> --
> 2.17.1
>
