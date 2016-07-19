From: Chenhui Zhao <z.chenhui@gmail.com>
Subject: Re: Sequence of suspend/resume calls
Date: Tue, 19 Jul 2016 19:57:51 +0800
Message-ID: <CAHwnS+V9KiDe-ZKC2OsPfG80BkySaYF3e=1TzaV6fhaQ+uCNNg@mail.gmail.com>
References: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34993 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcGSL6M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 07:58:12 -0400
Received: by mail-vk0-f54.google.com with SMTP id w127so20905990vkh.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2016 04:58:11 -0700 (PDT)
In-Reply-To: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

I don't know your case in detail. However, you may try to register a
syscore ops.
Please refer to drivers/base/syscore.c.

These callbacks will run when suspend_enter() calls syscore_suspend() and
syscore_resume() in kernel/power/suspend.c.

Chenhui
Thanks

On Tue, Jul 19, 2016 at 9:34 AM, Ryan <ryanphilips19@googlemail.com> wrote:
>
> Hello,
>
>
> Is it possible for the resume function of a particular driver to be
> called before resume function of others are being called?
>
> Suppose, I have a driver - example_suspend, example_resume - Is it
> possible for example_suspend to be called last
> and example_resume to be called first thing as soon as cpu is woken up?
>
> If so, how can i do that?
>
> Thanks,
> ryan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
