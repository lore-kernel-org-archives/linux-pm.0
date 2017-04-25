From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Tue, 25 Apr 2017 08:09:22 -0300
Message-ID: <CAOMZO5BgjgxGhJ7zGV-gjs0QHmJMgkNryFqTYA=vGPz8KWDijg@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7> <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
 <20170425050633.GV26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36306 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944236AbdDYLJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 07:09:23 -0400
Received: by mail-oi0-f53.google.com with SMTP id w12so55092058oiw.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 04:09:23 -0700 (PDT)
In-Reply-To: <20170425050633.GV26900@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Viresh,

On Tue, Apr 25, 2017 at 2:06 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Honestly, I don't have a clue on how can we fix it for you now :)
>
> @Rafael: Any idea apart from running at max all the time?
>
> what touchscreen driver are you using btw? Just curious to see if there is any
> bug in there. Handling touchscreen events shouldn't require us to run at max
> freq.

imx6q-sabresd board uses a drivers/input/touchscreen/egalax_ts.c touchscreen.

>
> @shawn: Saw something similar ever ?

I do not see the problem with the NXP kernel, but was not able to
identify what makes the touchscreen not to fail at 396MHz in their
kernel.

Thanks
