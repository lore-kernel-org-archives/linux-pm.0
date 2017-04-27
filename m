From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Wed, 26 Apr 2017 22:50:10 -0300
Message-ID: <CAOMZO5B95OEhUgBtV+S3q5rMVJ89zDYB5wMJs=vUaZF28Wivjg@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7> <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7> <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
 <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com>
 <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com>
 <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com> <CAHCN7xKNdTGArENnSJ0yHM2qLFMjuySTxHhjkaOK_T5AKJ761A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35108 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935160AbdD0BuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 21:50:12 -0400
Received: by mail-oi0-f46.google.com with SMTP id j201so22018508oih.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 18:50:11 -0700 (PDT)
In-Reply-To: <CAHCN7xKNdTGArENnSJ0yHM2qLFMjuySTxHhjkaOK_T5AKJ761A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 26, 2017 at 9:57 PM, Adam Ford <aford173@gmail.com> wrote:

> Using my board set to ondemand (and I verified frequency)
> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
> 396000
>
> I ran it for 3 hours and it and continued to show results.

Thanks for testing.

Does evtest still work if you keep constantly touching the screen
after one or two minutes?
