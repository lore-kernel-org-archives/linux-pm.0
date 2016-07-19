From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: Sequence of suspend/resume calls
Date: Tue, 19 Jul 2016 16:12:36 +0800
Message-ID: <CAN2waFu+U_yvDDwkE6Nq3U4TCm+NLg9o6f+18vGi5Nw4P=6ynw@mail.gmail.com>
References: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35920 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcGSIMh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 04:12:37 -0400
Received: by mail-yw0-f170.google.com with SMTP id u134so8811885ywg.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2016 01:12:37 -0700 (PDT)
In-Reply-To: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

platform devices are suspended according to the sequences on the chain
list. you can try to xxx_get_device which you want to suspend first in
your probe function and return EPROBE_DEFER if xxx_get_device failed.

On 19 July 2016 at 09:34, Ryan <ryanphilips19@googlemail.com> wrote:
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
