From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Tue, 25 Apr 2017 12:24:05 -0300
Message-ID: <CAOMZO5AJQ2TJvyuiBLLeS9zZMufMxyuNw+MA+NtZPCzzWJ0NXA@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7> <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
 <20170425111301.GC1928@vireshk-i7> <CAHCN7xJVicKuAc0dDbzBg4h2d1UUP66iKkSsWN_f=rPd4mOZSw@mail.gmail.com>
 <CAOMZO5CPtKAh6wMJ06BO4YFLPmOTvrpv5Q_3RJoj9dup46ukTQ@mail.gmail.com> <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32782 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949343AbdDYPYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 11:24:12 -0400
Received: by mail-oi0-f52.google.com with SMTP id y11so143376762oie.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 08:24:12 -0700 (PDT)
In-Reply-To: <CAHCN7x+6KwOZdC1MaNQGdXWFjJ18hYp3kc73JADDMC4DOFn+yQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 25, 2017 at 11:35 AM, Adam Ford <aford173@gmail.com> wrote:

> I have a touch screen (using tsc2004 touch controller) on my board.  I
> can run some tests if you tell me how you're able to reproduce your
> issue.  I can at least confirm whether or not I see it too.  I won't
> be able to do it until later tonight or tomorrow however.

Just run:

evtest /dev/input/eventX to capture the touchscreen events and keep
touching the screen.

After some random time (1-2 minutes) evtest will stop capturing the events.

Thanks
