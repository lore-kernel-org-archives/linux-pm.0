Return-Path: <SRS0=XwW7=AU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDEC433E0
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1151220786
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594298499;
	bh=YDfnHxmxX2ZnKqo+g2iR1kn0sdSgWsutTPlc4r8g9Jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y3/zB4voH6dgGzjuL56cCvtdy9bjipybphpm+5JqhtmqJU2mYjFKQ0Kj0s/OUAayM
	 lWuHVeXUKC1TBhUkEBI6kZc87jps9STYc4e55EV48MOhJNS/D00y4PR0KTnS3+ljmC
	 y+ExX9VG5ZVrH2o5LWQSXSlu+KJLOrGFPcIaUn5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGIMli (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:41:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45614 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGIMli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 08:41:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id h1so1547178otq.12;
        Thu, 09 Jul 2020 05:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8jb0JqZ2fbNLw6qgLSGteFTs0rB7XJKAye1/RQtfeA=;
        b=JDsZrs2NgBwyXzWnUbSNfVPhsWIE/073XzDhPY4nOuWxNKa2Z4IpXNPh4DwwQ6K3xa
         rakCoaFZ2bho2Rkjy2AVogHkF+UMGvNgI6xbe9iS4BtSt9/Iv9rlLCsvAeONxSf4PyiU
         y5WqfgnQDF5kE6LOZ/QajGiScj4XvEFyFBHIkaFm8MsUOTNF+cDFsqWduByHm5eJkEmR
         FcnwDLxAqfvXSsUgzePWY0rrBcBVBTTyMDgmuT+QlEc9F6aKAaxKVcv90hSu5TiX8pJW
         UDuiCFngh28ydwLQ8u0nC5dB12h8LW6EsXHdxdWswV1jyymAxP8m/KVTKc4kuO9d6VVI
         8Hwg==
X-Gm-Message-State: AOAM532VUeNqREexG0U91Jawq5nhqOyI6y55AjbmQ1rOoK/GBGzcHEAm
        1b4MSBlVloePUVmg7l85qU9Z0qZbekqoBOXxfjk=
X-Google-Smtp-Source: ABdhPJwz9YAYOGBpXrjCafpFG74aY6wc7aLPgEwXSqlxhxqgQt2yFP9++GjNTXrsfnTHybAi5zcJ8ZLHndaD/G8t28I=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr35282668ota.167.1594298497317;
 Thu, 09 Jul 2020 05:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200621080412.28388-1-frank@allwinnertech.com>
In-Reply-To: <20200621080412.28388-1-frank@allwinnertech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:41:26 +0200
Message-ID: <CAJZ5v0hFT0x1NTspkrrr+Dcia5p22UHMsgFHYFxHVCOgDo=Mnw@mail.gmail.com>
Subject: Re: [PATCH] powercap: idle_inject: Fix the comment about play_idle
To:     Frank Lee <frank@allwinnertech.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 21, 2020 at 10:04 AM Frank Lee <frank@allwinnertech.com> wrote:
>
> From: Yangtao Li <tiny.windzz@gmail.com>
>
> After commit 333cff6c963fbc ("powercap/drivers/idle_inject: Specify
> idle state max latency"), we convert to use play_idle_precise() with
> max allowed latency to specify the idle state.
>
> Some function comments still use play_idle(), let's update it to
> play_idle_precise().
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Frank Lee <frank@allwinnertech.com>

Applied as 5.9 material under the "powercap: idle_inject: Replace
play_idle() with play_idle_precise() in comments" subject, thanks!

> ---
>  drivers/powercap/idle_inject.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index c90f0990968b..597733ed86e9 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -19,8 +19,8 @@
>   * The idle + run duration is specified via separate helpers and that allows
>   * idle injection to be started.
>   *
> - * The idle injection kthreads will call play_idle() with the idle duration
> - * specified as per the above.
> + * The idle injection kthreads will call play_idle_precise() with the idle
> + * duration and max allowed latency specified as per the above.
>   *
>   * After all of them have been woken up, a timer is set to start the next idle
>   * injection cycle.
> @@ -100,7 +100,7 @@ static void idle_inject_wakeup(struct idle_inject_device *ii_dev)
>   *
>   * This function is called when the idle injection timer expires.  It wakes up
>   * idle injection tasks associated with the timer and they, in turn, invoke
> - * play_idle() to inject a specified amount of CPU idle time.
> + * play_idle_precise() to inject a specified amount of CPU idle time.
>   *
>   * Return: HRTIMER_RESTART.
>   */
> @@ -124,8 +124,8 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
>   * idle_inject_fn - idle injection work function
>   * @cpu: the CPU owning the task
>   *
> - * This function calls play_idle() to inject a specified amount of CPU idle
> - * time.
> + * This function calls play_idle_precise() to inject a specified amount of CPU
> + * idle time.
>   */
>  static void idle_inject_fn(unsigned int cpu)
>  {
> --
> 2.24.0
>
