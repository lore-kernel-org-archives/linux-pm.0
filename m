From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Mon, 24 Apr 2017 08:51:41 -0300
Message-ID: <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7> <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7> <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37860 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168807AbdDXLvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 07:51:42 -0400
Received: by mail-it0-f50.google.com with SMTP id x188so51752846itb.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 04:51:42 -0700 (PDT)
In-Reply-To: <20170424114343.GS26900@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 24, 2017 at 8:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> 110 ms is your sampling rate right now. Looks too high.
>
> Try doing this:
>
> echo 10000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
>
> and retry your tests.

Tried 10ms and also 1ms, but touchscreen also failed in both cases.
