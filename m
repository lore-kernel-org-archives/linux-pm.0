From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 17:00:33 +0530
Message-ID: <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:48098 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaJJLae (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 07:30:34 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so6422117oig.6
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 04:30:33 -0700 (PDT)
In-Reply-To: <5437C12D.1070803@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 16:51, Prarit Bhargava <prarit@redhat.com> wrote:
> Yep, I get that panic doing a very simple
>
> #!/bin/bash
>
> i=0
> while [ True ]; do
>         i=$((i+1))
>         echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
>         echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
>         echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
>         echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
>         if [ $((i % 100)) = 0 ]; then
>                 echo $i
>         fi
> done
>
> The blocking issue that I have (soon to be resolved I hope) is
>
> http://marc.info/?l=linux-kernel&m=141286895623716&w=2
>
> which is preventing me from doing any LOCKDEP analysis on this system.
>
> I'm working on all of the above right now ...

I have updated my patchset a bit now, the new branch is:
cpufreq/governor-fixes-v2.
But have you tried this on 3.17 without my patches?

--
viresh
