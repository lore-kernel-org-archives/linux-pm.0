From: Adam Ford <aford173@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Wed, 26 Apr 2017 21:01:10 -0500
Message-ID: <CAHCN7xJ70S49E9w+jEzBUhgiyakLvVyMkRzPaULxRLVwjN3+cg@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7> <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7> <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
 <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com>
 <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com>
 <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
 <CAHCN7xKNdTGArENnSJ0yHM2qLFMjuySTxHhjkaOK_T5AKJ761A@mail.gmail.com> <CAOMZO5B95OEhUgBtV+S3q5rMVJ89zDYB5wMJs=vUaZF28Wivjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35131 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938091AbdD0CBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 22:01:11 -0400
Received: by mail-pf0-f179.google.com with SMTP id v14so11076396pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 19:01:11 -0700 (PDT)
In-Reply-To: <CAOMZO5B95OEhUgBtV+S3q5rMVJ89zDYB5wMJs=vUaZF28Wivjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 26, 2017 at 8:50 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Apr 26, 2017 at 9:57 PM, Adam Ford <aford173@gmail.com> wrote:
>
>> Using my board set to ondemand (and I verified frequency)
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
>> 396000
>>
>> I ran it for 3 hours and it and continued to show results.
>
> Thanks for testing.
>
> Does evtest still work if you keep constantly touching the screen
> after one or two minutes?

I held it for nearly six minutes while checking out facebook (I am not
sure why I did that part).  After 6 minutes it was still operational.

I should note that I am running 4.9.23

# evtest /dev/input/event0
Input driver version is 1.0.1
Input device ID: bus 0x18 vendor 0x0 product 0x7d4 version 0x0

Input device name: "TSC200X touchscreen"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value   2331
      Min        0
      Max     4095
      Fuzz       4
    Event code 1 (ABS_Y)
      Value   1540
      Min        0
      Max     4095
      Fuzz       7
    Event code 24 (ABS_PRESSURE)
      Value      0
      Min        0
      Max     2048
      Fuzz       2
