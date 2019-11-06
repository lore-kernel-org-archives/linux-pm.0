Return-Path: <SRS0=tRrS=Y6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735AC5DF62
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A09218AE
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573043537;
	bh=wSigpIcsnv/HBAcpwL8IbhbgAE3kmnu2T2+yNIIN2AI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E87rORSkTZLIUp/UQVkWJFsVt0XVoa1plfD2R5i5xs3M/5S84HoXKeaC39f4Sx4U3
	 f/0sdLIKWHFZn4ecjJIlOoNUD0co633p5HEAGYuakgIzYp8Nk8XpD0mMkZwJBHu7sU
	 ciPqQRTHA+kgcNxBkQORWmdhBIg71sB7eTh1P7Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfKFMcQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:32:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35312 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731055AbfKFMcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 07:32:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so20794235oig.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 04:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxMiecJXI2G4Dv4929CSvdZSpwrjHBHOvMuihDhu9Vk=;
        b=gnWRgORntp8IPkOS14BHabiTJL6tPUF1Bilyu5J7SqNdtBiFSKPBAjYVorlIC+Vyc7
         2ZJsHv+inrHkZY3Pccklc0gDjqy2b37n+9YpIOEzNE8uoGgERc3PnVxfgASaNfvDOIDD
         GgbCAuN7qelPkOGzJpN0cAYKvXF1V60qCUvI5XWJFnQw0qUC+Mh9lBvo6V3JI1rHYU9g
         FwLUQNnNyFDHW4WW5JcqrNdpr0loNjdHVUjtjAVaUHWtNigf+6/BHiHl9YLXL7O8ofdB
         YXofl2lALxzWrvtvs6Gh1pafThCm87cTAFVy145tIk2FkpjezOIIJJOQofSD2XRnHlxj
         +Mrg==
X-Gm-Message-State: APjAAAUK9F5FW2iSD+2NZ47wVo4sjxBQmIBoEWv0G2lblfGPCKCgFGNw
        IRwZSUKK0D8gmOVh6urPOq7atecMxOxfB3WddvM=
X-Google-Smtp-Source: APXvYqyuuvYZY4B9YPN60odYfVbGfCXlsEd6r04ZlhLckXhLUQQzZ4b+Ifti9T0ZsGUpj/4d5vHn0xrcSByRlDDiUwU=
X-Received: by 2002:aca:fdd8:: with SMTP id b207mr2106316oii.57.1573043533368;
 Wed, 06 Nov 2019 04:32:13 -0800 (PST)
MIME-Version: 1.0
References: <1573026402-21032-1-git-send-email-shenkai8@huawei.com>
In-Reply-To: <1573026402-21032-1-git-send-email-shenkai8@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Nov 2019 13:32:02 +0100
Message-ID: <CAJZ5v0h5t2Hv60Y77HaM6DgTS3-m2moNu3DOX4zp8S4YgpS_ag@mail.gmail.com>
Subject: Re: [PATCH]cpufreq: add NULL check to the store method of cpufreq
To:     Shen Kai <shenkai8@huawei.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, hushiyuan@huawei.com,
        linfeilong@huawei.com, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 6, 2019 at 8:47 AM Shen Kai <shenkai8@huawei.com> wrote:
>
> From: shenkai <shenkai8@huawei.com>

Can you please use the proper spelling of your name here?

>
> Add NULL check in the store function here to avoid NULL callback invoking.
> Though some interfaces of cpufreq are set as read-only, user can still get
> write permission using chmod which can lead to a kernel crash.
>
> The following operations can lead to a kernel crash.
>
> chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
>
> This bug was found on linux 4.19
>
> Signed-off-by: shenkai <shenkai8@huawei.com>

And here?

> Reported-by: linfeilong <linfeilong@huawei.com>
> Reviewed-by: linfeilong <linfeilong@huawei.com>

And the proper spelling of the reporter/reviewer name here too?

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index bffc11b..4ccaa96 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>         struct freq_attr *fattr = to_attr(attr);
>         ssize_t ret = -EINVAL;
>
> +       if (!fattr->store)
> +               return ret;
> +
>         /*
>          * cpus_read_trylock() is used here to work around a circular lock
>          * dependency problem with respect to the cpufreq_register_driver().
> --
> 2.6.4.windows.1
>
>
