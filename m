Return-Path: <SRS0=XwW7=AU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF1C433DF
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A9B2076A
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594298219;
	bh=juintRHkYXpd/+lkHDs0phQcvx5og1UFB2dojEzco/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=09CzE265n71JxLEY0yxwK2shG5awdmE5XjjYjxubeB4NCr39Sc/4dlQmDz+y8BEV0
	 HC4p7Cx805Lw6CWjecuE0lIewbcikjNRjneXiYPWrAxPWjY2lYWZhT2yiiKnZCQv5m
	 vW4cXrt1oRsh5A4dQjpBBERbwRMzyNlUHqbsH+O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIMg6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:36:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIMg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 08:36:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id t18so1570555otq.5
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 05:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ti1AaMN6WLR4uXzFLSZ/jWWp7rPFc91ra1G2H9Ykk2Y=;
        b=ddWBeVgq8OZrGr2R48u7Bv02hffET0lnGxoEXTkyGRshKjJMLAkNBh1tnwerpr34t2
         +YOwN3AOkphF5EJqI4xvUAFJ9FJp5Ct2ueu4XkPcyprnVYBVpcgc9KMKpIlo52XjujRD
         PHiwKPyM85NRNjcxMZPBPVC1m/nB1t3Y6C/InvKxIpG31muP+NrzE4c6rzTZ0kftq8d6
         /RsYGKCpAxOmaCcCgEARxdbi3xHJrfbNEIFmiGw8GsUFcW6N02HmVyvpS8fa3aDeTDzI
         W3aEhu1hTNH6xLytPuLpYurs7IS7sPRyDVePDjLaVrh39W4+Zj7xP4W3KO68B60nmUVU
         HPDA==
X-Gm-Message-State: AOAM533Dou89vpmrPFYffYtRwHU8Y+JTu4Tio/Cy4VDh+do0HyIVegBY
        Is7V7NRUXJQjjbVwk0jRtyeathHjb9gS5f9km6k=
X-Google-Smtp-Source: ABdhPJx8+NsjZOQa1HqL7omcCBmQ+MAc2WqLB5ME504T9eh8hD8oBzemSM+Iu3ODFVhyTPsA7F54yt+zZ+ncs6Wr81o=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr31528997ots.118.1594298215105;
 Thu, 09 Jul 2020 05:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <1592816953-204427-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1592816953-204427-1-git-send-email-chenxiang66@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:36:44 +0200
Message-ID: <CAJZ5v0i01e1OUZHEohyMio-u0rEicMC2sxTvKUyGtn3XWNBfKA@mail.gmail.com>
Subject: Re: [PATCH] hibernate: fix some format issues
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        John Garry <john.garry@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 11:13 AM chenxiang <chenxiang66@hisilicon.com> wrote:
>
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> In hibernate.c, some places lack of spaces while some places have
> redundant spaces. So fix them.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>

Applied as 5.9 material under the "PM: hibernate: fix white space in a
few places" subject, thanks!

> ---
>  kernel/power/hibernate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 02ec716..5714f51 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1062,7 +1062,7 @@ power_attr(disk);
>  static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
>                            char *buf)
>  {
> -       return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
> +       return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
>                        MINOR(swsusp_resume_device));
>  }
>
> @@ -1162,7 +1162,7 @@ static ssize_t reserved_size_store(struct kobject *kobj,
>
>  power_attr(reserved_size);
>
> -static struct attribute * g[] = {
> +static struct attribute *g[] = {
>         &disk_attr.attr,
>         &resume_offset_attr.attr,
>         &resume_attr.attr,
> @@ -1190,7 +1190,7 @@ static int __init resume_setup(char *str)
>         if (noresume)
>                 return 1;
>
> -       strncpy( resume_file, str, 255 );
> +       strncpy(resume_file, str, 255);
>         return 1;
>  }
>
> --
> 2.8.1
>
