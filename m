From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v2] drivers: cpuidle: assign enter_freeze to same as enter
 callback function
Date: Thu, 10 Nov 2016 12:18:43 -0600
Message-ID: <CAPBZ5Qc+JPPdamROi-x9ocrGgAJrLF=Nf2-odqzDg0ZHPAtqww@mail.gmail.com>
References: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com> <1478787873-18180-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33880 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbcKJSSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 13:18:45 -0500
Received: by mail-ua0-f173.google.com with SMTP id 51so208006560uai.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 10:18:44 -0800 (PST)
In-Reply-To: <1478787873-18180-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On 10 November 2016 at 08:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> enter_freeze() callback is expected atleast to do the same as enter()
> but it has to guarantee that interrupts aren't enabled at any point
> in its execution, as the tick is frozen.
>
> CPUs execute ->enter_freeze with the local tick or entire timekeeping
> suspended, so it must not re-enable interrupts at any point (even
> temporarily) or attempt to change states of clock event devices.
>
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs
> (i.e. woken up only on IRQs from "wakeup sources")
>
> We can reuse the same code for both the enter() and enter_freeze()
> callbacks as along as they don't re-enable interrupts. Only "coupled"
> cpuidle mechanism enables interrupts and doing that with timekeeping
> suspended is generally not safe.
>
> Since this generic DT based idle driver doesn't support "coupled"
> states, it is safe to assume that the interrupts are not re-enabled.
>
> This patch assign enter_freeze to same as enter callback function which
> helps to save power without any intermittent spurious wakeups from
> suspend-to-idle.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested this on a Qualcomm 410c dragonboard.  Worked great.  Thanks for
the patch!


Tested-by: Andy Gross <andy.gross@linaro.org>
