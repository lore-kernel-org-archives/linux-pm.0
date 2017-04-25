From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Tue, 25 Apr 2017 10:43:09 -0300
Message-ID: <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7> <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7> <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33047 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944432AbdDYNnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 09:43:15 -0400
Received: by mail-oi0-f51.google.com with SMTP id y11so139469703oie.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 06:43:15 -0700 (PDT)
In-Reply-To: <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Adam,

On Tue, Apr 25, 2017 at 9:41 AM, Adam Ford <aford173@gmail.com> wrote:

> I don't have that board, so I can't test, but I have seen other issues on my
> imx6 board where operating at 'performance' instead of on-demand worked
> better for me as well in different areas.   I was assuming it was something

What are the issues you observed with 'on-demand' on your mx6 board?

> regarding the voltage levels of various regulators for my board, and I am
> going to run tests on my board by playing with regulators on my device tree
> to make sure they are properly regulating to the right voltages.  Since
> 'performance' runs the processor at both a higher speed and higher voltage,
> it's conceivable to me that something is just below some limit/level and
> needs some minor adjustment. At least that is my theory with my board
> issues.  Have you looked considered that possibility?

One test I have already tried was to run all other cpufreq operating
points with the same ARM and SOC-PU voltages as the 996MHz.

Still in this case I do see touchscreen failure.
