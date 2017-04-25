From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Tue, 25 Apr 2017 10:36:33 +0530
Message-ID: <20170425050633.GV26900@vireshk-i7>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
 <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7>
 <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7>
 <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33170 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975080AbdDYFGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 01:06:37 -0400
Received: by mail-pf0-f169.google.com with SMTP id a188so21467544pfa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 22:06:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24-04-17, 08:51, Fabio Estevam wrote:
> On Mon, Apr 24, 2017 at 8:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > 110 ms is your sampling rate right now. Looks too high.
> >
> > Try doing this:
> >
> > echo 10000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
> >
> > and retry your tests.
> 
> Tried 10ms and also 1ms, but touchscreen also failed in both cases.

Honestly, I don't have a clue on how can we fix it for you now :)

@Rafael: Any idea apart from running at max all the time?

what touchscreen driver are you using btw? Just curious to see if there is any
bug in there. Handling touchscreen events shouldn't require us to run at max
freq.

@shawn: Saw something similar ever ?

-- 
viresh
