From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq-dt: check CPU clock/power domain during initializing
Date: Tue, 20 Jan 2015 16:47:59 +0800
Message-ID: <CALx668WCTPZDWigcDyWKy__Lh+LQrEX9fVnqmfWcjZnJWnBiMw@mail.gmail.com>
References: <1420797291-15972-1-git-send-email-pi-cheng.chen@linaro.org>
	<1420797291-15972-2-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpok7Q3CpMospA=3PAqiLtEERfkAJdHkcH+9GKvYBsof0UQ@mail.gmail.com>
	<CALx668V5TKkx-qGnMjFAspTQ5pu3XsM1012wXsBHvR3CNsuCew@mail.gmail.com>
	<CAKohponUfB-RJTwPDMPCGogng8nzc=kwTF56GjGfDSD7MLQuAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46829 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbATIsB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 03:48:01 -0500
Received: by mail-la0-f46.google.com with SMTP id s18so12068432lam.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 00:48:00 -0800 (PST)
In-Reply-To: <CAKohponUfB-RJTwPDMPCGogng8nzc=kwTF56GjGfDSD7MLQuAg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>

On 20 January 2015 at 15:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20 January 2015 at 13:03, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> I will also try to add intermediate frequency support in next version.
>
> Sure
>
>> BTW, do you think it's a good idea to add a new device tree binding like
>> intermediate_clock = <&clksys MAINPLL>
>> and so that cpufreq-dt could get the intermediate clock?
>
> Yeah, we need that. I am trying to implement new opp bindings and will
> take care of that. Until that time, use platform data to do that.
>

Got it.
Thanks.

Best Regards,
Pi-Cheng

> --
> viresh
