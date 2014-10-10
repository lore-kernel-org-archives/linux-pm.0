From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 16:44:53 +0530
Message-ID: <CAKohpo=zKW=F4stNhO5oSrX1tyQ6jJZOjLeTqmmkTi56aM1fog@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<1412937689.13463.21.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:51106 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbaJJLOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 07:14:54 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so6306977oib.22
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 04:14:53 -0700 (PDT)
In-Reply-To: <1412937689.13463.21.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 16:11, Robert Sch=C3=B6ne <robert.schoene@tu-dresden=
=2Ede> wrote:
> This patch makes it worse. Even when changing the governors sequentia=
lly
> for all CPUs, it fails. Here is what happens:
>
> 1. I boot the system. (performance)
> 2. An Ubuntu service enables ondemand sequentially for all cpus (onde=
mand)
> 3. I enable performance sequentially (performance)
> 4. I enable ondemand sequentially (broken)
> In the last step, ondemand can only be enabled at a single CPU. All o=
thers return -EBUSY.
>
>
> More about step 3/4:
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> performance
> performance
> performance
> performance
> performance
> performance
> performance
> performance
> $ echo ondemand | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scali=
ng_governor
> ondemand
> $ echo ondemand | sudo tee /sys/devices/system/cpu/cpu1/cpufreq/scali=
ng_governor
> ondemand
> tee: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor: Device or=
 resource busy

Getting -EBUSY here isn't a problem if the governor is currently
changing. But I see
that I have over-engineered some part of my patches.

Can you please try: cpufreq/governor-fixes-v2 instaed and let me know
how does that
behave ?

Sorry for the trouble.
