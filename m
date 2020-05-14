Return-Path: <SRS0=/aHr=64=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30EC433DF
	for <linux-pm@archiver.kernel.org>; Thu, 14 May 2020 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A67E206A5
	for <linux-pm@archiver.kernel.org>; Thu, 14 May 2020 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589455266;
	bh=eWBgO47lnG713+uOJyYwph49VutX66y/dqfc4fFqRL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZEbcVZmqJPnZUL+1RXCzZEXamelYS0CranFcR4wjPsKyRiNRTPGmq+F1WdAlfi3jW
	 iloQy7B4hlOC4trBA7+/ZOmqFMztmAepYqcFpDQOuAjNiQu9ir5I7xSvGnLrvnAfWz
	 GxOPMYO8uqAy76OWC/tAQfDg7iRE8yX56NxRQWZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENLVF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 14 May 2020 07:21:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37575 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENLVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 07:21:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so2036064oto.4;
        Thu, 14 May 2020 04:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjaEhAMukt4Q737HPM6C7TaDlquG096H0lSzCeaiEoc=;
        b=VGMfZMnKMmRN0cmSILvH0P4ao1gR1iQgt3cfzoBTCo29kKZA1Bo3Uisa8WNIMuD7gT
         qIbA3qiidb1vjWKCAlirii9q8W0nfFogmp/fr3j1dSu2mpVVcRDMg7N+5+g6jUn0ijYm
         YJoPHhFOYhonTtEBbBVzJysvcy9EPEIxluC4JgLfo1lm3LxB/eRda3cyJ6MGl0kr+3+H
         cm0jimxmbJRUj0NgJLcFGs4aehzAXD96Huh3905dRQe5p6cYAQsyCvWlEsjf2TM3HCNu
         GoGAQcavk/wM3wYb9sAQvyKF6W/OuVenXNGOJ6KO7B1DVCdDQWSkol+WiMCvLEZ+gixi
         FemQ==
X-Gm-Message-State: AOAM531/QTpQ34AAhyy/lGM20zp4x/hjVFsPxeoVw9ekjbUZwy0Qk3Rp
        MKzJXBuXKAJl9F2ylttfEhuCs7j7ikyYeLq+yYY=
X-Google-Smtp-Source: ABdhPJyTpBVQvJyPeh8jlL2d0XL6Aye1NJbTU0L7nP/qUpDkvDYChurJ2m7cErQetQ0NI1Dhki2u1VhMPXPI4JktJ7I=
X-Received: by 2002:a9d:6356:: with SMTP id y22mr2944323otk.167.1589455262888;
 Thu, 14 May 2020 04:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com> <20200513214351.2138580-10-emil.l.velikov@gmail.com>
In-Reply-To: <20200513214351.2138580-10-emil.l.velikov@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 13:20:51 +0200
Message-ID: <CAJZ5v0iM5H03=RTtk2sZtUzaW0XJ+AaX1M00C8QjvaNz0ZE3bQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] kernel/power: constify sysrq_key_op
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 11:46 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that this is going to be applied along with the rest
of the series.

> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
>
> IMHO it would be better if this gets merged this via the tty tree.
> ---
>  kernel/power/poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
> index 6d475281c730..562aa0e450ed 100644
> --- a/kernel/power/poweroff.c
> +++ b/kernel/power/poweroff.c
> @@ -29,7 +29,7 @@ static void handle_poweroff(int key)
>         schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
>  }
>
> -static struct sysrq_key_op     sysrq_poweroff_op = {
> +static const struct sysrq_key_op       sysrq_poweroff_op = {
>         .handler        = handle_poweroff,
>         .help_msg       = "poweroff(o)",
>         .action_msg     = "Power Off",
> --
> 2.25.1
>
