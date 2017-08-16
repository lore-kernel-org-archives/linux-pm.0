From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPU frequency governor problem
Date: Wed, 16 Aug 2017 08:48:52 +0530
Message-ID: <CAOh2x==Wtv2o2cVST2hRMqXn76NC+P3hN0HnYKukHLiLPVws5w@mail.gmail.com>
References: <CAMn+H1sk267Er5zS2jRmDUE_s+f8Fguq8K40ZpDQG656LcLnBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:37939 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbdHPDSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2017 23:18:53 -0400
Received: by mail-io0-f180.google.com with SMTP id g71so9257839ioe.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2017 20:18:53 -0700 (PDT)
In-Reply-To: <CAMn+H1sk267Er5zS2jRmDUE_s+f8Fguq8K40ZpDQG656LcLnBg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Edward Statham <edward.statham@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Adding PM list instead.

On Tue, Aug 15, 2017 at 8:17 AM, Edward Statham
<edward.statham@gmail.com> wrote:
> Hi, sorry for the direct email but I=E2=80=99ve been unable to find a res=
olution
> to this in forums etc.  I have a laptop with a Intel i7-7700HQ CPU and am
> running Linux Mint 18.  The frequency governor is set to performance but
> it keeps on throttling down to 70% or even 50% and getting stuck there,
> for example:
>
> cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 70
>
> I can=E2=80=99t find a way to get it to throttle sensibly i.e. lower the =
max
> when required but revert to full speed when other conditions allow. I=E2=
=80=99ve
> tried the ondemand and performance governors.
>
> Any suggestions would be much appreciated.
>
> thanks,
> Ed
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
