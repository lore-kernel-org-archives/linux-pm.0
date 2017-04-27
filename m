From: Adam Ford <aford173@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Wed, 26 Apr 2017 19:57:46 -0500
Message-ID: <CAHCN7xKNdTGArENnSJ0yHM2qLFMjuySTxHhjkaOK_T5AKJ761A@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7> <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7> <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
 <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com>
 <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com> <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33345 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967853AbdD0A5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 20:57:48 -0400
Received: by mail-pf0-f175.google.com with SMTP id a188so9828155pfa.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 17:57:47 -0700 (PDT)
In-Reply-To: <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 25, 2017 at 10:24 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Apr 25, 2017 at 11:35 AM, Adam Ford <aford173@gmail.com> wrote:
>
>> I have a touch screen (using tsc2004 touch controller) on my board.  I
>> can run some tests if you tell me how you're able to reproduce your
>> issue.  I can at least confirm whether or not I see it too.  I won't
>> be able to do it until later tonight or tomorrow however.
>
> Just run:
>
> evtest /dev/input/eventX to capture the touchscreen events and keep
> touching the screen.
>

Using my board set to ondemand (and I verified frequency)
# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
396000

I ran it for 3 hours and it and continued to show results.

Event: time 71379.065289, type 1 (EV_KEY), code 330 (BTN_TOUCH), value
1
Event: time 71379.065289, -------------- SYN_REPORT ------------
Event: time 71379.117399, type 3 (EV_ABS), code 24 (ABS_PRESSURE),
value 0
Event: time 71379.117399, type 1 (EV_KEY), code 330 (BTN_TOUCH), value
0
Event: time 71379.117399, -------------- SYN_REPORT ------------
Event: time 83122.438637, type 3 (EV_ABS), code 0 (ABS_X), value 2144
Event: time 83122.438637, type 3 (EV_ABS), code 1 (ABS_Y), value 1186
Event: time 83122.438637, type 3 (EV_ABS), code 24 (ABS_PRESSURE),
value 567
Event: time 83122.438637, type 1 (EV_KEY), code 330 (BTN_TOUCH), value
1
Event: time 83122.438637, -------------- SYN_REPORT ------------


adam

> After some random time (1-2 minutes) evtest will stop capturing the events.
>
> Thanks
