From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] allow cpufreq drivers to export flags
Date: Wed, 8 Oct 2014 13:24:30 +0530
Message-ID: <CAKohpo=9XG7XiLxBf=yo7=QCruawYxqPctC6kqB+syERFCoT6Q@mail.gmail.com>
References: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
	<1412754534-14068-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:53485 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbaJHHyc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 03:54:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so3898378oib.22
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 00:54:31 -0700 (PDT)
In-Reply-To: <1412754534-14068-1-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tuu

On 8 October 2014 13:18, Mike Turquette <mturquette@linaro.org> wrote:
> This series is partially in response to a discussion around DT bindings
> for CPUfreq drivers [0], but it is also needed for on-going work to
> integrate CPUfreq with the scheduler. In particular a scheduler-driven
> cpu frequency scaling policy would be well served to know if the
> underlying CPUfreq driver .target callback might sleep or block for a
> long time.
>
> [0] http://lkml.kernel.org/r/<fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>

Firstly this link is broken and then the last comment I gave in Thomas's
thread was that he doesn't need this routine anymore. And so your scheduler
work is the only user of it.. And so probably we should get this included with
the scheduler patches only, isn't it? Just including them without any user
wouldn't benefit..

Or am I missing something ?
